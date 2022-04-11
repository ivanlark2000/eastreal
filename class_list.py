# coding=utf-8
import re
from bs4 import BeautifulSoup


def pars_flat(html_f):
    s_flat = BeautifulSoup(html_f, 'html.parser')
    return s_flat


class Flats:
    """Создается объект класса квартира"""

    def __init__(self, html_flat):
        self.s_flat = pars_flat(html_flat)
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
        more_addr = self.s_flat.find_all('span', class_="item-address__string")
        for addr in more_addr:
            if len(addr) > 0:
                return addr.text.strip()  # Удаляем ненужные пробелы от с начала и конца

    def price(self):
        price = self.s_flat.find('span', class_="js-item-price")
        price = price.contents[0].text
        return int(re.sub(r'\s+', '', price))  # C помошью регулярного выражения убираем все пробелы из строки

    def district(self):
        district = self.s_flat.find('span', class_="item-address-georeferences-item__content")
        if district is None:
            return
        return district.text.strip()

    def number_of_rooms(self):
        number_of_rooms = self.s_flat.find_all('span', class_="item-params-label")
        for number in number_of_rooms:
            if number.text.strip() == 'Количество комнат:':
                for text in number.find_next_siblings(text=True):
                    res = [int(res) for res in re.findall(r'-?\d+\.?\d*', text.text)]
                    if len(res) == 0:
                        res = 1
                        return res
                    else:
                        return res[0]
        res = 1
        return res

    def total_space(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Общая площадь:':
                for text in line.find_next_siblings(text=True):
                    return [float(res) for res in re.findall(r'-?\d+\.?\d*', text.text)][0]  # выбираем только числа
        res = 0
        return res

    def square_of_kitchen(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Площадь кухни:':
                for text in line.find_next_siblings(text=True):
                    return [float(res) for res in re.findall(r'-?\d+\.?\d*', text.text)][0]  # выбираем только числа
        res = 0
        return res

    def living_space(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Жилая площадь:':
                for text in line.find_next_siblings(text=True):
                    text = text + text.text
                if text is None:
                    text = 0
                    return text
                return [float(res) for res in re.findall(r'-?\d+\.?\d*', text)][0]  # выбираем только числа
        text = 0
        return text
    
    def floor(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Этаж:':
                for text in line.find_next_siblings(text=True):
                    text = re.sub(r'\s+', '', text.text)  # C помошью регулярного выражения убираем все пробeлы
                    if not text[1].isdigit():
                        return int(text[0])
                    return int(text[0] + text[1])
        text = 0
        return text

    def furniture(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Мебель:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def technics(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Техника:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def balcony_or_loggia(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Балкон или лоджия:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def room_type(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Тип комнат:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def ceiling_height(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Высота потолков:':
                for text in line.find_next_siblings(text=True):
                    res = [float(res) for res in re.findall(r'-?\d+\.?\d*', text.text)][0]
                    if res is None:
                        res = 0
                        return res
                    else:
                        return res
        res = 0
        return res

    def bathroom(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Санузел:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def widow(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Окна:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def repair(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Ремонт:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def seilling_method(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Вид сделки:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def transaction_type(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Способ продажи:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def decorating(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Отделка:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()


class Buildings:
    """Создается объект класса здание"""
    def __init__(self, html_flat):
        self.s_flat = pars_flat(html_flat)
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
        addr = self.s_flat.find('span', class_="item-address__string")
        if addr is None:
            return
        return addr.text.strip()  # Удаляем ненужные пробелы от с начала и конца

    def structure(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Корпус, строение:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def offical_builder(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Официальный застройщик:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def year_of_construction(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Год постройки:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()
        text = 0
        return text

    def floors_in_the_hourse(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Этажей в доме:':
                for text in line.find_next_siblings(text=True):
                    return [int(res) for res in re.findall(r'-?\d+\.?\d*', text.text)][0]  # выбираем только числа
        res = 0
        return res

    def passenger_bodice(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Пассажирский лифт:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def service_lift(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Грузовой лифт:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def in_home(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'В доме:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def pemolition_planned(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Планируется снос:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def type_of_bilding(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Тип дома:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def yard(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Год постройки:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def participation_type(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Тип участия:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def parking(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Парковка:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()

    def deadline(self):
        data = self.s_flat.find_all('span', class_="item-params-label")
        for line in data:
            if line.text.strip() == 'Срок сдачи:':
                for text in line.find_next_siblings(text=True):
                    return text.text.strip()


