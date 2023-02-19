# coding=utf-8
import re
import sys
import lxml
import time
import requests
import psycopg2
from transliterate import translit
from bs4 import BeautifulSoup as bs


sys.path.insert(1, '/home/lark/project/eastreal/settings')
from config import Config


config = Config('parsBus.log')
logger = config.logger


def make_city(city: str) -> str:
    return translit(city.lower(), reversed=True)


def get_resp(url: str) -> str:
    try:
        return requests.get(
                url, 
                headers={
                    'accept-language': 'ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7',
                    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36'
                    },
                timeout=10
                ).text
    except Exception:
        logger.warning(f'Слишком долгое время отклика от сервера {url}')
        time.sleep(20)
        get_resp(url)


def get_soup(resp: str) -> object:
    return bs(resp, 'lxml')


def save_test_html(html: str) -> None:
    with open('test.html', 'w') as file:
        file.write(html)


def load_test_file() -> str:
    return open('test.html', 'r').read()


def get_lst_bas(city: str) -> list[tuple]:
    url = f'https://busti.me/{make_city(city)}/stop/'
    lst_stop = []
    rez = get_soup(get_resp(url)).find_all('a', {'class': 'item'})
    for r in rez:
        link = r.get('href')
        name_bus = r.previous_element.text
        if type(name_bus) == str and 'http' in link and len(name_bus) < 500 and 'github' not in link:
            lst_stop.append((name_bus, link))
    return lst_stop


def get_coords(soup: object) -> tuple[float, float]:
    text = soup.find('script',string=re.compile('var astops')).text
    text = text[text.find('{'):text.rfind('}') + 1]
    x = text[text.find('x:') + 2 : ]
    x = x[: x.find(',')]
    y = text[text.find('y:') + 2 : ]
    y = y[: y.find(',')]
    return x, y


def load_to_base(city_id: int, stop_name: str, coord: tuple, marh_list: list) -> None:
    conn = config.make_con()
    print('Попытка загрузки дынных')
    try:
        with conn.cursor() as cursor:
            cursor.execute(f'''CALL load_bus_station(
                '{city_id}', '{stop_name}', '{coord[0]}', '{coord[1]}', VARIADIC ARRAY{marh_list}
                );''')
            conn.commit()
            logger.info(f'Данные по остановке {stop_name} успешно загружены')

    except Exception as e:
        logger.warning(f'Данные по остановке {stop_name} не загрузились \n {e}', exc_info=True)
    finally:
        conn.close()


def main():
    for stop in get_lst_bas(city='Калининград'):
        html = get_resp(stop[1])
        if html:
            soup = get_soup(html)
            marsh = [i.text for i in soup.findAll('a', {"class": "ui basic button"})]
            if len(marsh):
                load_to_base(
                        city_id='24741', stop_name=stop[0], 
                        coord=get_coords(soup),
                        marh_list=marsh
                        )
                time.sleep(3)


if __name__ == "__main__":
    main()

