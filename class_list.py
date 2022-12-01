# coding=utf-8
import os
import re
import psycopg2
from bs4 import BeautifulSoup
from psycopg2 import Error
from dotenv import load_dotenv

load_dotenv(override=True)
user_DB = os.environ.get('user_DB')
password_DB = os.environ.get('password_DB')
port = os.environ.get('port')
host = os.environ.get('host')
db = os.environ.get('db')


class Flats:
    """Создается объект класса квартира"""

    def __init__(self, html_f):
        self.s_flat = BeautifulSoup(html_f, 'html.parser')
        self.flat_id = self.flat_id()
        self.address = self.address()
        self.price = self.price()
        self.district = self.district()
        self.number_of_rooms = self.number_of_rooms()
        self.total_space = self.total_space()
        self.square_of_kitchen = self.square_of_kitchen()
        self.living_space = self.living_space()
        self.floor = self.floor()
        self.furniture = self.furniture()
        self.technics = self.technics()
        self.balcony_or_loggia = self.balcony_or_loggia()
        self.room_type = self.room_type()
        self.ceiling_height = self.ceiling_height()
        self.bathroom = self.bathroom()
        self.widow = self.widow()
        self.repair = self.repair()
        self.seilling_method = self.seilling_method()
        self.transaction_type = self.transaction_type()
        self.decorating = self.decorating()

    def flat_id(self):
        flat_id = self.s_flat.find('span', attrs={'data-marker': 'item-view/item-id'})
        if flat_id is None:
            res = 0
            return res
        return [int(res) for res in re.findall(r'-?\d+\.?\d*', flat_id.text)][0]  # выбираем только

    def address(self):
        address = self.s_flat.find('div', itemprop="address")
        address = address.contents[0].text.replace('Калининградская область, Калининград, ', '')
        return address.strip()

    def price(self):
        price = self.s_flat.find('span', itemprop="price")
        return int(price['content'])

    def district(self):
        district = self.s_flat.find('div', itemprop="address")
        if district is None:
            return
        return district.contents[1].text

    def number_of_rooms(self):
        try:
            data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
            for room in data:
                res = room.text.strip()
                if res.startswith('Количество комнат:'):
                    return int(res.replace('Количество комнат:', ''))
            return 0
        except Exception:
            return 0

    def total_space(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for number in data:
            res = number.text.strip()
            if res.startswith('Общая площадь:'):
                return [float(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
        return 0

    def square_of_kitchen(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for number in data:
            res = number.text.strip()
            if res.startswith('Площадь кухни:'):
                return [float(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
        return 0

    def living_space(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for number in data:
            res = number.text.strip()
            if res.startswith('Жилая площадь:'):
                return [float(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
        return 0

    def floor(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for number in data:
            res = number.text.strip()
            if res.startswith('Этаж:'):
                return [int(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
        return 0

    def furniture(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Мебель:'):
                return res.replace('Мебель:', '').strip()
        return 'Not info'

    def technics(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Техника:'):
                return res.replace('Техника:', '').strip()
        return 'Not info'

    def balcony_or_loggia(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Балкон или лоджия:'):
                return res.replace('Балкон или лоджия:', '').strip()
        return 'Not info'

    def room_type(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Тип комнат:'):
                return res.replace('Тип комнат:', '').strip()
        return 'Not info'

    def ceiling_height(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for res in data:
            res = res.text.strip()
            if res.startswith('Высота потолков:'):
                res = [float(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
                if res < 10:
                    return res
                elif 100 < res < 999:
                    return res / 100
                else:
                    pass
        return 0

    def bathroom(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Санузел:'):
                return res.replace('Санузел:', '').strip()
        return 'Not info'

    def widow(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Окна:'):
                return res.replace('Окна:', '').strip()
        return 'Not info'

    def repair(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Ремонт:'):
                return res.replace('Ремонт:', '').strip()
        return 'Not info'

    def seilling_method(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Вид сделки:'):
                return res.replace('Вид сделки:', '').strip()
        return 'Not info'

    def transaction_type(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Способ продажи:'):
                return res.replace('Способ продажи:', '').strip()
        return 'Not info'

    def decorating(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Отделка:'):
                return res.replace('Отделка:', '').strip()
        return 'Not info'

    def checking(self):
        """Проверяем есть ли объявление по квартире в базе"""
        try:
            connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
            cursor = connection.cursor()
            cursor.execute(f'SELECT flat_id FROM flats WHERE flat_id = {self.flat_id};')
            result = cursor.fetchone()
            return result
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgresSQL", error)

    def save(self, page=1):
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
                f"VALUES ('{self.flat_id}', '{self.address}', '{self.price}', '{self.district}', "
                f"'{self.number_of_rooms}', '{self.square_of_kitchen}', '{self.living_space}', '{self.floor}',"
                f"'{self.furniture}', '{self.technics}', '{self.balcony_or_loggia}', '{self.room_type}',"
                f"'{self.ceiling_height}', '{self.bathroom}', '{self.widow}', '{self.repair}',"
                f"'{self.seilling_method}', '{self.transaction_type}', '{self.decorating}', '{self.total_space}');"
            )
            connection.commit()
            print(f'Запись № {page} c объявлением {self.flat_id} успешно вставлена.')
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgresSQL", error)
        finally:
            page += 1
            return page

    def adding_price(self):
        """Вносим историю цен"""
        try:
            connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
            cursor = connection.cursor()
            cursor.execute(f"INSERT INTO public.history_of_price (id_flat, price)"
                           f"VALUES ({self.flat_id}, {self.price});")
            cursor.execute(f"UPDATE flats SET status = 'active' WHERE flat_id = '{self.flat_id}'")
            connection.commit()
            print(f'В объявление № {self.flat_id} вставили цену {self.price} руб. установили статус "active"')
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgresSQL", error)


class Buildings:
    """Создается объект класса здание"""

    def __init__(self, html_f):
        self.s_flat = BeautifulSoup(html_f, 'html.parser')
        self.new_building_name = self.new_building_name()
        self.address = self.address()
        self.structure = self.structure()
        self.offical_builder = self.offical_builder()
        self.year_of_construction = self.year_of_construction()
        self.floors_in_the_hourse = self.floors_in_the_hourse()
        self.passenger_bodice = self.passenger_bodice()
        self.service_lift = self.service_lift()
        self.in_home = self.in_home()
        self.pemolition_planned = self.pemolition_planned()
        self.type_of_bilding = self.type_of_bilding()
        self.yard = self.yard()
        self.participation_type = self.participation_type()
        self.parking = self.parking()
        self.deadline = self.deadline()

    def new_building_name(self):
        new_building_name = self.s_flat.find('a', class_="item-params-link js-nd-house-complex-link")
        if new_building_name is None:
            return
        return new_building_name.text.strip()

    def address(self):
        try:
            address = self.s_flat.find('div', itemprop="address")
            address = address.contents[0].text.replace('Калининградская область, Калининград, ', '')
            return address.strip()
        except:
            return 'No address'

    def structure(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Корпус, строение:'):
                return res.replace('Корпус, строение:', '').strip()
        return 'Not info'

    def offical_builder(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Официальный застройщик:'):
                return res.replace('Официальный застройщик:', '').strip()
        return 'Not info'

    def year_of_construction(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Год постройки:'):
                return [int(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]
        return 0

    def floors_in_the_hourse(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Этажей в доме:'):
                return [int(res) for res in re.findall(r'-?\d+\.?\d*', res)][0]  # выбираем только числа
        return 0

    def passenger_bodice(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Пассажирский лифт:'):
                return res.replace('Пассажирский лифт:', '').strip()
        return 'Not info'

    def service_lift(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Грузовой лифт:'):
                return res.replace('Грузовой лифт:', '').strip()
        return 'Not info'

    def in_home(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('В доме:'):
                return res.replace('В доме:', '').strip()
        return 'Not info'

    def pemolition_planned(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Планируется снос:'):
                return res.replace('Планируется снос:', '').strip()
        return 'Not info'

    def type_of_bilding(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Тип дома:'):
                return res.replace('Тип дома:', '').strip()
        return 'Not info'

    def yard(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Год постройки:'):
                return res.replace('Год постройки:', '').strip()
        return 'Not info'

    def participation_type(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Тип участия:'):
                return res.replace('Тип участия:', '').strip()
        return 'Not info'

    def parking(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Парковка:'):
                return res.replace('Парковка:', '').strip()
        return 'Not info'

    def deadline(self):
        data = self.s_flat.find_all('li', attrs={'class': ['item-params-list-item']})
        for dat in data:
            res = dat.text.strip()
            if res.startswith('Срок сдачи:'):
                return res.replace('Срок сдачи:', '').strip()
        return 'Not info'

    def checking(self):
        """Проверяем есть ли объявление дома в базе"""
        try:
            connection = psycopg2.connect(user=user_DB, password=password_DB, host=host, port=port, database=db)
            cursor = connection.cursor()
            cursor.execute(f"SELECT address FROM buildings WHERE address = '{self.address}';")
            result = cursor.fetchone()
            return result
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgresSQL", error)

    def save(self):
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
                f"VALUES ('{self.new_building_name}', '{self.address}', '{self.structure}', '{self.offical_builder}',"
                f"'{self.year_of_construction}', '{self.floors_in_the_hourse}', '{self.passenger_bodice}',"
                f"'{self.service_lift}', '{self.in_home}', '{self.pemolition_planned}', '{self.type_of_bilding}',"
                f"'{self.yard}', '{self.participation_type}', '{self.deadline}', '{self.parking}');"
            )
            connection.commit()
            print(f'Дом на {self.address} улице успешно вставлен')
        except (Exception, Error) as error:
            print("Ошибка при работе с PostgresSQL", error)
