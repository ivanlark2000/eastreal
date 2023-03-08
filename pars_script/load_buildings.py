#coding=utf-8
import time
import uuid
import requests
import psycopg2
from bs4 import BeautifulSoup as bs
from def_list import get_position_ya 
from load_to_base import load_buildings_to_base


MAIN_URL = 'https://dom.mingkh.ru'


def load_area(lst):
    conn = make_conn()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f'''
                INSERT INTO minghk.fs_area (c_name, t_href)
                VALUES {', '.join([str(i) for i in lst])};
            ''')
            conn.commit()
    except Exception as e:
        print(f'Не удалось загрузить в БД города {e}')
    finally:
        conn.close()


def load_city(lst):
    conn = make_conn()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f'''
                INSERT INTO minghk.fs_city (f_area, c_name, t_href)
                VALUES {', '.join([str(i) for i in lst])};
            ''')
            conn.commit()
    except Exception as e:
        print(f'Не удалось загрузить в БД города {e}')
    finally:
        conn.close()


def get_links_area() -> list[tuple[int, str]]:
    conn = make_conn()
    try:
        with conn.cursor() as cursor:
            cursor.execute("""
                SELECT link, t_href
                FROM minghk.fs_area
            """)
            resp = cursor.fetchall()
            return resp
    except Exception as e:
        print(f'Не удалось получить данные с БД по поводу районов {e}')
    finally:
        conn.close()


def load_area_gis():
    html = load_html()
    soup = bs(html, 'lxml')
    tags = soup.find('ul', {'class':'list-unstyled list-columns'})
    lst_city = [(tag.text, tag['href']) for tag in tags.findAll('a')]
    load_area(lst_city)


def get_city_and_load_to_base() -> None:
    for i in get_links_area():
        url = MAIN_URL + i[1]
        soup = bs(get_gis_html(url), 'lxml')
        tags = soup.find('ul', {'class':'list-unstyled list-columns'})
        lst_city = [(i[0], tag.text, tag['href']) for tag in tags.findAll('a')]
        load_city(lst_city)
        print(url)
        time.sleep(10)


def get_city_url(city: str) -> str:
    conn = make_conn()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""
                SELECT t_href
                FROM minghk.fs_city
                WHERE c_name LIKE '{city}'
            """)
            resp = cursor.fetchall()[0][0]
            return MAIN_URL + resp
    except Exception as e:
        print(f'Не удалось получить данные с БД по ссылки по городу  {e}')
    finally:
        conn.close()


def get_lst_load_to_base(soup):
    table = soup.find('table', {'class': 'table table-bordered table-striped table-hover'})
    lst = [row for row in table.findAll('tr')][1:]
    for row in lst:
        lst_row = str(row).replace('<tr> <td>', '').replace('</td> </tr>', '').split('</td> <td>')
        address = bs(lst_row[2], 'lxml').find('a').text
        square, year, floor = lst_row[3:6]
        guid = uuid.uuid3(uuid.NAMESPACE_DNS, lst_row[1] + address)
        lat, lon = get_position_ya(lst_row[1] + ' ' + address)
        load_buildings_to_base(
                guid=guid, f_city=24741, address=address, n_year_build=year,
                floor=int(floor), square=square, lat=lat, lon=lon
                )


def get_and_load_houses(city: str) -> None:
    url = get_city_url('%' + city[1:]) + 'houses'
    soup = bs(get_gis_html(url), 'lxml')
    page_end = soup.find('ul', {'class':'pagination'}).find_all('a')[-1].get('data-ci-pagination-page')
    get_lst_load_to_base(soup)
    for p in range(2, page_end + 1):
        url_page = url + f'={p}'
        soup = bs(get_gis_html(url_page), 'lxml')
        get_lst_load_to_base(soup)



if __name__ == "__main__":
    get_and_load_houses('Калининград')

