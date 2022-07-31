from app.def_list import getting_total_html, getting_links, getting_rendom_link
from app.def_list import getting_url, checking_status, getting_html_flat
from bs4 import BeautifulSoup as Bs


def parsAvitoFlat(html):
    soup = Bs(html, 'html.parser')
    flat_id = soup.find('span', attrs={'data-marker': 'item-view/item-id'})
    flat_id = int(flat_id.contents[0][-10:])
    price = soup.find('span', itemprop="price")
    price = float(price['content'])

    def qty_of_rooms(soup):
        try:
            qty_of_rooms = int(soup.find(text='Количество комнат').next.next.next)
        except:
            qty_of_rooms = None
        finally:
            return qty_of_rooms

    def total_space(soup):
        try:
            total_space = soup.find(text='Общая площадь').next.next.next
            total_space = float(total_space[:-3])
        except:
            total_space = None
        finally:
            return total_space

    def square_of_kitchen(soup):
        try:
            square_of_kitchen = soup.find(text='Площадь кухни').next.next.next
            square_of_kitchen = float(square_of_kitchen[:-3])
        except:
            square_of_kitchen = None
        finally:
            return square_of_kitchen

    def living_space(soup):
        try:
            living_space = soup.find(text='Жилая площадь').next.next.next
            living_space = float(living_space[:-3])
        except:
            living_space = None
        finally:
            return living_space

    def floor(soup):
        try:
            floor = soup.find(text='Этаж').next.next.next
            floor = int(floor[:2])
        except:
            floor = None
        finally:
            return floor

    def furniture(soup):
        try:
            furniture = soup.find(text='Мебель').next.next.next
        except:
            furniture =None
        finally:
            return furniture

    def technics(soup):
        try:
            technics = soup.find(text='Техника').next.next.next
        except:
            technics = None
        finally:
            return technics

    def balcony_or_loggia(soup):
        try:
            balcony_or_loggia = soup.find(text='Балкон или лоджия').next.next.next
        except:
            balcony_or_loggia = None
        finally:
            return balcony_or_loggia

    def room_type(soup):
        try:
            room_type = soup.find(text='Тип комнат').next.next.next
        except:
            room_type = None
        finally:
            return room_type

    def ceiling_height(soup):
        try:
            ceiling_height = soup.find(text='Высота потолков').next.next.next
            ceiling_height = float(ceiling_height[:4])
        except:
            ceiling_height = None
        finally:
            return ceiling_height

    def bathroom(soup):
        try:
            bathroom = soup.find(text='Санузел').next.next.next
        except:
            bathroom = None
        finally:
            return bathroom

    def window(soup):
        try:
            widow = soup.find(text='Окна').next.next.next
        except:
            widow = None
        finally:
            return widow

    def repair(soup):
        try:
            repair = soup.find(text='Ремонт').next.next.next
        except:
            repair = None
        finally:
            return repair

    def seilling_method(soup):
        try:
            seilling_method = soup.find(text='Способ продажи').next.next.next
        except:
            seilling_method = None
        finally:
            return seilling_method

    def transaction_type(soup):
        try:
            transaction_type = soup.find(text='Вид сделки').next.next.next
        except:
            transaction_type = None
        finally:
            return transaction_type

    def decorating(soup):
        try:
            decorating = soup.find(text='Отделка').next.next.next
        except:
            decorating = None
        finally:
            return decorating

    def warm_floor(soup):
        try:
            warm_floor = soup.find(text='Тёплый пол').next.next.next
            warm_floor = True
        except:
            warm_floor = False
        finally:
            return warm_floor

    def description(soup):
        try:
            descriptions = soup.find('div', itemprop='description')
            descriptions = descriptions.contents
            lst = [desc.getText() for desc in descriptions]
            description = ' '.join(lst)
        except:
            description = None
        finally:
            return description

    def seller(soup):
        try:
            sell = soup.find('a', attrs={'data-marker': 'seller-link/link'}).next
            seller = sell.getText()
            type_seller = sell.next.next.getText()
        except:
            seller = None
            type_seller = None
        finally:
            return {
                'seller': seller,
                'type_seller': type_seller
            }

    return {
        "id_avito": flat_id,
        'price': price,
        'qty_of_rooms': qty_of_rooms(soup),
        'total_space': total_space(soup),
        'square_of_kitchen': square_of_kitchen(soup),
        'living_space': living_space(soup),
        'floor': floor(soup),
        'furniture': furniture(soup),
        'technics': technics(soup),
        'balcony_or_loggia': balcony_or_loggia(soup),
        'room_type': room_type(soup),
        'ceiling_height': ceiling_height(soup),
        'bathroom': bathroom(soup),
        'window': window(soup),
        'repair': repair(soup),
        'seilling_method': seilling_method(soup),
        'transaction_type': transaction_type(soup),
        'decorating': decorating(soup),
        'warm_floor': warm_floor(soup),
        **seller(soup),
        'description': description(soup),
    }


def parsAvitoHouse(html):
    soup = Bs(html, 'html.parser')
    address = soup.find('div', itemprop="address")
    lst = address.next.getText().split(',')
    if len(lst) == 4:
        number_of_house = lst[-1]
        street = lst[-2]
        city = lst[-3]
        obl = lst[-4]
    elif len(lst) == 5:
        number_of_house = lst[-1]
        street = lst[-2]
        city = lst[2] + ' ' + lst[3]
        obl = lst[1]
    else:
        number_of_house = lst[-1]
        street = lst[-2]
        city = None
        obl = None

    def type_of_home(soup):
        try:
            type_of_home = soup.find(text='Тип дома').next.next.next
        except:
            type_of_home = None
        finally:
            return type_of_home

    def passenger_bodice(soup):
        try:
            passenger_bodice = soup.find(text='Пассажирский лифт').next.next.next
        except:
            passenger_bodice = None
        finally:
            return passenger_bodice

    def service_lift(soup):
        try:
            service_lift = soup.find(text='Грузовой лифт').next.next.next
        except:
            service_lift = None
        finally:
            return service_lift

    def year_of_construction(soup):
        try:
            year_of_construction = soup.find(text='Год постройки').next.next.next
        except:
            year_of_construction = None
        finally:
            return year_of_construction

    def floors_in_the_house(soup):
        try:
            floors_in_the_house = soup.find(text='Этажей в доме').next.next.next
        except:
            floors_in_the_house = None
        finally:
            return floors_in_the_house

    def in_home(soup):
        try:
            in_home = soup.find(text='В доме').next.next.next
        except:
            in_home = None
        finally:
            return in_home

    def yard(soup):
        try:
            yard = soup.find(text='Двор').next.next.next
        except:
            yard = None
        finally:
            return yard

    def parking(soup):
        try:
            parking = soup.find(text='Парковка').next.next.next
        except:
            parking = None
        finally:
            return parking

    def offical_builder(soup):
        try:
            offical_builder = soup.find(text='Официальный застройщик').next.next.next
        except:
            offical_builder = None
        finally:
            return offical_builder

    def deadline(soup):
        try:
            deadline = soup.find(text='Срок сдачи').next.next.next
        except:
            deadline = None
        finally:
            return deadline

    def new_building_name(soup):
        try:
            new_building_name = soup.find(text='Название новостройки').next.next.next
        except:
            new_building_name = None
        finally:
            return new_building_name
    return {
            'obl': obl,
            'street': street,
            'city': city,
            'number_of_house': int(number_of_house),
            'new_building_name': new_building_name(soup),
            'offical_builder': offical_builder(soup),
            'year_of_construction': year_of_construction(soup),
            'floors_in_the_house': floors_in_the_house(soup),
            'type_of_home': type_of_home(soup),
            'passenger_bodice': passenger_bodice(soup),
            'service_lift': service_lift(soup),
            'in_home': in_home(soup),
            'yard': yard(soup),
            'parking': parking(soup),
            'deadline': deadline(soup),
            'district': address.next.next.next.next.getText(),
        }


