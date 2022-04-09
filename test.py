# coding=utf-8
import psycopg2
from bs4 import BeautifulSoup
from psycopg2 import Error
from config import user_DB, password_DB

with open('html.txt', 'r') as file:
    html = file.read()


def getting_soup(html=html):
    """Получаем площадь и этаж"""
    soup = BeautifulSoup(html, 'html.parser')
    return soup


def getting_sq(soup):
    """Получаем список площади и этажей"""
    list_of_sq = []
    text = soup.find_all('a', class_="link-link-MbQDP link-design-default-_nSbv title-root-zZCwT iva-item-title-py3i_ "
                                     "title-listRedesign-_rejR title-root_maxHeight-X6PsH")
    for t in text:
        list_of_sq.append(t.text)
    return list_of_sq


def getting_price(soup):
    """Получаем цену"""
    list_of_price = []
    list = soup.find_all('span', class_="price-text-_YGDY text-text-LurtD text-size-s-BxGpL")
    for price in list:
        list_of_price.append(price.text)
    return list_of_price


def getting_address(soup):
    """Получаем адреса"""
    list_of_address = []
    list = soup.find_all('span', class_="geo-address-fhHd0 text-text-LurtD text-size-s-BxGpL")
    for address in list:
        list_of_address.append(address.text)
    return list_of_address


def getting_area(soup):
    list_of_area = []
    list = soup.find_all('div', class_="geo-georeferences-SEtee text-text-LurtD text-size-s-BxGpL")
    for area in list:
        list_of_area.append(area.text)
    return list_of_area


soup = getting_soup(html)


def main(address, area, price, sq):
    """Отправляем данные в базу"""
    index = 0
    while len(address) > index:
        index += 1
        try:
            # Подключиться к существующей базе данных
            connection = psycopg2.connect(user=user_DB,
                                          password=password_DB,
                                          host="127.0.0.1",
                                          port="5432",
                                          database="avito_db")
            cursor = connection.cursor()
            # Выполнение SQL-запроса для вставки данных в таблицу
            cursor.execute(
                f"INSERT INTO flats (adress, area, kind_of_flat, price) VALUES ('{address[index]}', '{area[index]}', "
                f"'{sq[index]}', '{price[index]}');")
            connection.commit()
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgreSQL", error)


if '__main__' == '__name__':
    soup = getting_soup(html=html)
    main(getting_address(soup), getting_area(soup), getting_price(soup), getting_sq(soup))
