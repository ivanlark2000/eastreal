import sys
import psycopg2


sys.path.insert(1, '/home/lark/project/eastreal/settings')

from config import Config

config = Config()
logger = config.logger


lst_arg = [
    'site_id',
    'S_City',
    'S_District',
    'S_Street',
    'S_Qty_Room',
    'N_Qty_Total_Space',
    'N_Qty_Living_Space',
    'N_Qty_Kitchen_Space',
    'N_Price',
    'N_Floor',
    'B_Balcony',
    'B_Loggia',
    'S_Type_Room',
    'S_Ads_Type',
    'N_Ceiling_Height',
    'S_Bathroom_Type',
    'S_Window',
    'S_Repair_Type',
    'B_Heating',
    'S_Furniture',
    'S_Technics',   
    'S_decoration',
    'S_Method_Of_Sale',
    'S_Type_Of_Transaction',
    'S_Description',
    'S_Type_House',
    'N_Year_Building',
    'S_Qty_floor',
    'B_Passenger_Elevator',
    'B_Freight_Elevator',
    'S_Yard',
    'S_Parking',
    'S_Name_New_Building',
    'S_Official_Builder',
    'S_Participation_Type',
    'D_Deadline_for_Delivery',
    'S_Site_Links', 
    'F_Source',
    'S_Seller',
    'S_Seller_Type',
    'G_Sess'
]


def get_id_in_base(city_id: int) -> tuple[tuple[str, int]]:
    # функция возвращает список айдишников квартир и цен на текущий момент
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"SELECT * FROM get_siteid_price('{city_id}', '1');")
            logger.info('Получили айдишники квартир сайта с БД')
            rez = cursor.fetchall()
            return tuple([tuple([i[0], i[1], (i[2])]) for i in rez])
    except Exception as e:
        msg = 'Не удалось получить айдишники кватир сайта с бд' + str(e)
        logger.critical(msg, exc_info=True)
    finally:
        conn.close()


def arg_value(arg: list, dct: dict) -> tuple[str, str]:
    lst_column = []
    lst_data = []
    lst_data_out = []
    for a in arg:
        for key in dct:
            if dct[key] and a == key:
                lst_column.append(a)
                lst_data.append(dct[key])
    for i in [str(s) for s in lst_data]:
        if not i.isdigit():
            i = f"'{i}'"
        lst_data_out.append(i)
    return ', '.join(lst_column), ', '.join(str(x) for x in lst_data_out)


def err_to_base(dct: dict, city_id: str) -> None:
    from main import logger 
    msg = f"квартира с айдишником {dct['site_id']} c адресом {dct['S_Street']} не была закачена"
    logger.critical(msg)
    load_miss_number(site_id=dct['site_id'], city_id=city_id, guid=dct['G_Sess'])


def load_to_base(dct: dict, count_new: int, count_miss: int) -> tuple[int, int]:
    from main import CITY_ID
    conn = config.make_con()
    atr = arg_value(lst_arg, dct)
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""INSERT INTO BF_Temp_Apartments_Ads ({atr[0]})
                   VALUES ({atr[1]})""")
            msg = f"В базу закачалось {count_new + 1} квартира с айдишником {dct['site_id']} c адресом {dct['S_Street']}"
            conn.commit()
            logger.info(msg)
            count_new += 1
    except psycopg2.errors.CheckViolation:
        err_to_base(dct, CITY_ID)
        count_miss += 1
    except psycopg2.errors.SyntaxError:
        err_to_base(dct, CITY_ID)
        count_miss += 1
    except psycopg2.errors.NotNullViolation:
        err_to_base(dct, CITY_ID)
        count_miss += 1
    finally:
        conn.close()
        return count_new, count_miss


def load_price_to_base(f_flat: int, n_price: int) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                INSERT INTO mn_ads_price (f_flat, n_price)
                VALUES ({f_flat}, {n_price});
                """)
            conn.commit()
    except Exception as e:
        logger.warning('Ошибка в загрузке данных по цене')
    finally:
        conn.close()


def update_sold_id(siteid: str) -> None:
    """Функция для апдэйта айдишника сайта из историчности в активный"""
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                UPDATE inf_miss_ads
                SET f_sell_status = 1
                WHERE site_id = {siteid}
                    """)
            conn.commit()
            logger.info(f'Перевели айдишник объявления {siteid} из историчности в опять активные')
    except Exception as e:
        logger.info(f'Не удалось перевести объявление {siteid} из историчности', exc_info=True)
    finally:
        conn.close()


def load_miss_number(guid: str, site_id: str, city_id: int) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                        INSERT INTO inf_miss_ads (f_city, site_id, f_source, f_sell_status, g_sess_create)
                        VALUES ({city_id}, {int(site_id)}, 1, 1, '{guid}');
                           """)
            conn.commit()
            logger.info(f'Добавили в БД айдишник {site_id} ошибочного объявления')
    except psycopg2.errors.UniqueViolation as e:
        logger.warning(f'Был обнаружен активный айдишники в историчности {site_id}')
        update_sold_id(site_id)
    finally:
        conn.close()


def update_sell_status(sessid: str, city_id: int, siteids:list) -> None:
    conn = config.make_con()
    print('активных объявлений - ', len(siteids))
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"SELECT update_sell_status('{sessid}', '{city_id}',VARIADIC ARRAY{siteids});")
            conn.commit()
            logger.info('Айдишники проданных квартир успешно переведены в статус проданы')
    except Exception as e:
        logger.warning('Статусы проданыных квартир не были переведены в историчность ', exc_info=True)
    finally:
        conn.close()
    

def get_all_street_without_coord():
    conn = config.make_con()
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
        with conn.cursor() as cursor:
            cursor.execute(sql)
            return cursor.fetchall()
    except Exception:
        logger.warning('''Не удалось получить список домов без координат с БД''', exc_info=True)
    finally:
        conn.close()


def add_coord_to_base(id: int, lat: float, lon: float):
    conn = config.make_con()
    sql = f"""UPDATE mn_house 
            SET lat = {lat}, lon = {lon}
            WHERE link = {id}"""
    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
            conn.commit()
            logger.info(f'Координаты по id_house {id} успешно загруженны')
    except Exception:
        logger.warning(f'''Не удалось добавить координаты в БД
                            id_house = {id}
                            coord = {lat}, {lon}''',
                            exc_info=True)
    finally:
        conn.close()


def add_full_address(streetid: int, full_address: str):
    conn = config.make_con()
    sql = f"""
            UPDATE fs_street 
            SET full_address = '{full_address}'
            WHERE link = {streetid}"""
    try:
        with conn.cursor() as cursor:
            cursor.execute(sql)
    except Exception:
        logger.warning(f'''Не удалось загрузить в БД название полной улицы
                           streetid     = {streetid},
                           full_address = {full_address}''',
                       exc_info=True)
    finally:
        conn.close()


def mark_start_sess(g_sess: str, d_date_start: object) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                INSERT INTO log_session_pars (g_sess, d_date_start)
                VALUES ('{g_sess}', '{d_date_start}')             
    """)
            conn.commit()
            logger.info(f'Добавили запись в БД о начале сессии {g_sess}')
    except Exception as e:
        logger.critica(f'Не удалось отправить данные в БД о начале сессии {g_sess}')
    finally:
        conn.close()


def update_end_sess(g_sess: str, n_total_count: int, n_miss: int, n_new: int, d_date_end: object) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                UPDATE log_session_pars
                SET 
                    n_total_count = {n_total_count}
                    ,n_miss = {n_miss}
                    ,n_new = {n_new}
                    ,d_date_end = '{d_date_end}'
                WHERE g_sess = '{g_sess}'             
            """)
            conn.commit()
            logger.info(f'Добавили запись об окончании работы сессии {g_sess}')
    except Exception as e:
        logger.critica(f'Не удалось обновить даные об окончании сессии {g_sess}')
    finally:
        conn.close()


def load_buildings_to_base(guid: str, f_city: int, address: str, n_year_build: str, flat: int,
                           floor: int, square: float, lat: float, lon: float) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
     INSERT INTO minghk.mn_buildings (link, f_city, c_address, n_year_build, n_floor, n_square, lat, lon, q_flat)
     VALUES ('{guid}', '{f_city}', '{address}', '{n_year_build}', '{floor}', '{square}', '{lat}', '{lon}', {flat})            
    """)
            conn.commit()
            logger.info(f'добавили данные о доме {address} в табл. minghk.mn_buildings')
    except Exception as e:
        logger.warning(f'Не удалось данные о доме {address} в табл. minghk.mn_buildings', exc_info=True)
    finally:
        conn.close()


def load_area(lst):
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f'''
                INSERT INTO minghk.fs_area (c_name, t_href)
                VALUES {', '.join([str(i) for i in lst])};
            ''')
            conn.commit()
    except Exception as e:
        logger.warning(f'Не удалось загрузить в БД города {e}')
    finally:
        conn.close()


def load_city(lst):
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f'''
                INSERT INTO minghk.fs_city (f_area, c_name, t_href)
                VALUES {', '.join([str(i) for i in lst])};
            ''')
            conn.commit()
    except Exception as e:
        logger.warning(f'Не удалось загрузить в БД города {e}')
    finally:
        conn.close()


def get_links_area() -> list[tuple[int, str]]:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute("""
                SELECT link, t_href
                FROM minghk.fs_area
            """)
            resp = cursor.fetchall()
            return resp
    except Exception as e:
        logger.warning(f'Не удалось получить данные с БД по поводу районов {e}')
    finally:
        conn.close()



def get_city_url(city: str) -> str:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                SELECT link, t_href
                FROM minghk.fs_city
                WHERE c_name LIKE '{city}'
            """)
            return cursor.fetchall()[0]
    except Exception as e:
        logger.warning(f'Не удалось получить данные с БД по ссылки по городу  {e}')
    finally:
        conn.close()
