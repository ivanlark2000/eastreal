# coding=utf-8
import re
from bs4 import BeautifulSoup


class Flats:
    """Создается обьект квартира"""
    def __init__(self):
        self.html = s_flat
        self.flat_id = self.flat_id()
        self.address = self.address()
        self.price = self.price()
        self.district = self.district()
        self.number_of_rooms = self.number_of_rooms()
        self.square_of_kitchen = self.square_of_kitchen()
        self.living_space = self.living_space()
        self.floor = self.floor()
        # self.furniture =
        # self.technics =
        # self.balcony_or_loggia =
        # self.room_type =
        # self.ceiling_height =
        # self.bathroom =
        # self.widow =
        # self.repair =
        # self.seilling_method =
        # self.transaction_type =
        # self.decorating =

    def flat_id(self):
        flat_id = s_flat.find('span', attrs={'data-marker':'item-view/item-id'})
        return flat_id.text

    def address(self):
        addr = s_flat.find('span', class_="item-address__string")
        return addr.text.strip()  # Удаляем ненужные пробелы от с начала и конца

    def price(self):
        price = s_flat.find('span', class_="js-item-price")
        price = price.contents[0].text
        return int(re.sub(r'\s+', '', price))  # C помошью регулярного выражения убираем все пробелы из строки

    def district(self):
        district = s_flat.find('span', class_="item-address-georeferences-item__content")
        return district.text.strip()

    def number_of_rooms(self):
        number_of_rooms = s_flat.find_all('span', class_="item-params-label")
        for number in number_of_rooms:
            if number.text.strip() == 'Количество комнат:':
                for text in number.find_next_siblings(text=True):
                    return text.text.strip()

    def square_of_kitchen(self):
        number_of_rooms = s_flat.find_all('span', class_="item-params-label")
        for number in number_of_rooms:
            if number.text.strip() == 'Площадь кухни:':
                for text in number.find_next_siblings(text=True):
                    return text.text.strip()

    def living_space(self):
        number_of_rooms = s_flat.find_all('span', class_="item-params-label")
        for number in number_of_rooms:
            if number.text.strip() == 'Жилая площадь:':
                for text in number.find_next_siblings(text=True):
                    return text.text.strip()

    def floor(self):
        number_of_rooms = s_flat.find_all('span', class_="item-params-label")
        for number in number_of_rooms:
            if number.text.strip() == 'Этаж:':
                for text in number.find_next_siblings(text=True):
                    return text.text.strip()




# class Buildings:
#     """Создается обьект сдание"""
#     def __init__(self):
#         # self.new_building_name =
        # self.address =
        # self.structure =
        # self.offical_builder =
        # self.year_of_construction =
        # self.floors_in_the_hourse =
        # self.passenger_bodice =
        # self.service_lift =
        # self.in_home =
        # self.pemolition_planned =
        # self.type_of_bilding =
        # self.yard =
        # self.participation_type =
        # self.yard =


with open('html_flat', 'r') as f_file:
    html = f_file.read()


s_flat = BeautifulSoup(html, 'html.parser')
fl = Flats()
# build = Buildings()
print(fl.floor)