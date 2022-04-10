# coding=utf-8
import time
import random
import psycopg2
from bs4 import BeautifulSoup
from psycopg2 import Error
from config import user_DB, password_DB, host, port, db
from selenium import webdriver
from urllib import request




def getting_url():
    """Генератор стартовых ссылок"""
    list120 = list(range(1, 21))
    list2140 = list(range(21, 41))
    list4160 = list(range(41, 61))
    list6180 = list(range(61, 81))
    list8199 = list(range(81, 100))
    list_gen = [list120, list2140, list4160, list6180, list8199]
    for list_ in list_gen:
        random.shuffle(list_)
        for number in list_:
            start_site = f'https://www.avito.ru/kaliningrad/kvartiry/prodam-ASgBAgICAUSSA8YQ?cd=1&p={number}'
            print(start_site)
            yield start_site


def getting_total_html(url):
    """Получим стартовый HTML"""
    try:
        while True:
            driver = webdriver.Chrome()
            time.sleep(3)
            driver.get(url)
            time.sleep(3)
            driver.execute_script("window.scrollTo(0, 2080)")  # прокрутка
            # прокручиваем вниз страницы
            driver.refresh()
            html = driver.page_source  # получаем html страницы
            if len(html) == 0:
                continue
            driver.quit()
            return html
    except (Exception, Error) as error:
        print('Ошибка при работе с Селениумом', error)


def getting_links(html):
    """Получаем список ссылок на квартиры"""
    list_of_links = []
    soup = BeautifulSoup(html, 'html.parser')
    links = soup.find_all('a', class_="iva-item-sliderLink-uLz1v")
    for link in links:
        list_of_links.append('https://' + 'www.avito.ru' + link.get('href'))
    return list_of_links


def getting_rendom_link(list_links):
    """Получаем рандомную ссылку и фильтруем список"""
    link = random.choice(list_links)
    list_links.remove(link)  # Удаляем из списка выбраную ссылку.
    time.sleep(5)
    yield list_links


def getting_html_flat(url):
    """Получем суп для дома и квартиры квартиры"""
    response = request.urlopen(url)
    html_flat = response.read().decode("utf-8")
    time.sleep(5)
    return html_flat


def checking_flat(id):
    """Проверяем есть ли обьявление по квартире в базе"""
    try:
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        cursor.execute(f'SELECT flat_id FROM flats WHERE flat_id = {id};')
        result = cursor.fetchone()
        return result
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)


def sanding_add_in_base(
        id, address, price, distr, number, square, space, floor, fur, tech, balc, room, ceil, bath, win,
        repair, seil, trans, dec, total
):
    """Отправляем данные в базу"""
    try:
        # Подключиться к существующей базе данных
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        # Выполнение SQL-запроса для вставки данных в таблицу
        cursor.execute(
            f"INSERT INTO flats (flat_id, address, price, district, number_of_rooms, square_of_kitchen, "
            f"living_space, floor, furniture, technics, balcony_or_loggia, room_type, ceiling_height, bathroom,"
            f"widow, repair,  seilling_method, transaction_type, decorating, total_space) "
            f"VALUES ('{id}', '{address}', '{price}', '{distr}', '{number}', '{square}', '{space}', '{floor}', '{fur}',"
            f"' {tech}', '{balc}', '{room}', '{ceil}', '{bath}', '{win}', '{repair}', '{seil}', '{trans}', '{dec}', "
            f"'{total}');"
        )
        connection.commit()
        print(f'Объявление № {id} успешно вставлено')
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)


def checking_build(addr):
    """Проверяем есть ли обьявление дома в базе"""
    try:
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        cursor.execute(f"SELECT address FROM buildings WHERE address = '{addr}';")
        result = cursor.fetchone()
        return result
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)


def sending_build(
        new, addr, stract, off, year, floor, pas, serv, in_, pemo, type, yard, par, deadline, parc
):
    """Отправляем данные в базу"""
    try:
        # Подключиться к существующей базе данных
        connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
        cursor = connection.cursor()
        # Выполнение SQL-запроса для вставки данных в таблицу
        cursor.execute(
            f"INSERT INTO buildings (new_building_name, address, structure, offical_builder, year_of_construction, "
            f"floors_in_the_hourse, passenger_bodice, service_lift, in_home, pemolition_planned, type_of_bilding, "
            f" yard, participation_type, deadline, parking) "
            f"VALUES ('{new}', '{addr}', '{stract}', '{off}', '{year}', '{floor}', '{pas}', '{floor}', '{serv}'"
            f"'{in_}', '{pemo}', '{type}', '{yard}', '{par}', '{deadline}', '{parc}');"
        )
        connection.commit()
        print(f'Дом на {addr} улице успешно вставлен')
    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)
