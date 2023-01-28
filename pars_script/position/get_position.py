import sys
import time
import logging
from dadata import Dadata
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

sys.path.extend(['/home/lark/PROJECT/RealEstate'])

from pars_script.settings.config import config

logger = logging.getLogger('PARSER_DIST')
logger.setLevel(logging.INFO)

handler = logging.FileHandler(f'../log/ya_position.log', 'w')
formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)

chrom_option = Options()

api_key = '43b0036c75f55f532a18d6291423bd960c45304b'
secret = '14a01cfb738a67787f176342817c8c6aabbeda77'


def get_right_street(street: str):
    try:
        with Dadata(api_key, secret) as dadata:
            address = dadata.suggest(name='address', query=street)
            if not address:
                return
            dadata.close()
        return address[0]['value']
    except Exception as e:
        logger.warning(f'Не удалось получить данные в Дадата адрес {street} '
                       f'ошибка {e}')


def get_position_ya(adress: str) -> tuple[float, float]:
    url = 'https://yandex.ru/maps'
    chrom_option.add_argument("--headless")
    driver = webdriver.Chrome(options=chrom_option)
    try:
        driver.get(url)
        while True:
            try:
                el = driver.find_element(By.TAG_NAME, 'input')
                el.send_keys(adress, Keys.ENTER)
                time.sleep(3)
                break
            except Exception as e:
                logger.info('Обновления id элемента яндекс')
        lst = driver.find_element(By.CLASS_NAME, 'toponym-card-title-view__coords-badge').text.split(', ')
        return float(lst[0]), float(lst[1])
    except Exception as e:
        logger.warning(f'Не удалось получить координаты с яндекс улица {adress} {e}')


def get_all_street_without_coord(conn):
    sql = """SELECT 
            h.link
            ,s.link
            ,c.c_name
            ,s.c_name
            ,h.s_number
            ,full_address
        FROM mn_house h
            INNER JOIN fs_street s
                ON s.link = h.f_street
            INNER JOIN fs_city c
                ON c.link = s.f_city
        WHERE 1=1
            AND h.lat IS NULL AND h.lon IS NULL
            AND s_number <> ''"""
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        rez = cursor.fetchall()
        cursor.close()
        return rez
    except Exception:
        logger.warning('''Не удалось получить список домов без координат с БД''', exc_info=True)
    finally:
        cursor.close()


def add_coord_to_base(id: int, lat: float, lon: float, conn: object):
    sql = f"""UPDATE mn_house 
            SET lat = {lat}, lon = {lon}
            WHERE link = {id}"""
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        conn.commit()
    except Exception:
        logger.warning(f'''Не удалось добавить координаты в БД
                            id_house = {id}
                            coord = {lat}, {lon}''',
                       exc_info=True)
    finally:
        cursor.close()


def add_full_address(conn: object, streetid: int, full_adress: str):
    sql = f"""
            UPDATE fs_street 
            SET full_address = '{full_adress}'
            WHERE link = {streetid}"""
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
    except Exception:
        logger.warning(f'''Не удалось загрузить в БД название полной улицы
                           streetid     = {streetid},
                           full_address = {full_adress}''',
                       exc_info=True)
    finally:
        cursor.close()


def add_coord():
    conn = config.make_con()
    data = get_all_street_without_coord(conn=conn)
    count = len(data)
    print(f'к обновлению {count} домов')
    for row in data:
        try:
            if not row[5]:
                street = get_right_street(row[2] + " " + row[3].strip())
                if not street:
                    street = row[2] + " " + row[3].strip()
                else:
                    add_full_address(conn, streetid=row[1], full_adress=street)
                street = street + ' ' + row[4].strip()
                lat, lon = get_position_ya(street)
                add_coord_to_base(row[0], lat, lon, conn)
            else:
                street = row[2] + ' ' + row[5] + ' ' + row[4].strip()
                lat, lon = get_position_ya(street)
                add_coord_to_base(row[0], lat, lon, conn)
            logger.info(f'Данные по координатам по адресу {street} получены успешно ')
        except Exception as e:
            logger.info('inf', exc_info=True)
        finally:
            count -= 1


add_coord()
