from bs4 import BeautifulSoup as Bs
from transliterate import translit


def parsAvitoFlat(html: str, url: str) -> dict:
    soup = Bs(html, 'html.parser')
    price = soup.find('span', itemprop="price")
    price = int(price['content'])
    flat_id = int(url[url.rfind('_') + 1:])

    def qty_of_rooms(soup):
        try:
            qty_of_rooms = soup.find(text='Количество комнат').next.next.next
        except:
            qty_of_rooms = None
            with open('flat.html', 'w') as file:
                file.write(str(soup))
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
                'S_Name_Seller': seller,
                'S_Type_Of_Seller': type_seller
            }

    def get_city(url: str) -> str:
        city = url.split('/')[3]
        city = translit(city, 'ru')
        return city.capitalize().strip()

    soup = Bs(html, 'html.parser')
    address = soup.find('div', itemprop="address")
    lst = address.next.getText().split(',')
    try:
        lst.remove(get_city(url))
    except:
        pass

    if any(map(str.isdigit, lst[-2])) and len(lst[-2]) < 10:
        street = lst[-3].strip()
        street = " ".join((sorted(street.split()))[::-1])
        number_of_house = " ".join(lst[-2:]).strip()
        try:
            obl = lst[-4].strip()
        except:
            obl = None
    else:
        street = lst[-2].strip()
        street = " ".join((sorted(street.split()))[::-1])
        number_of_house = lst[-1].strip()
        try:
            obl = lst[-3].strip()
        except:
            obl = None

    def district(soup):
        try:
            address = soup.find('div', itemprop="address")
            disrict = address.next.next.next.next.getText()
        except:
            disrict = None
        finally:
            return disrict

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
            if type(parking) == tag:
                parking = soup.find(text='Парковка').next.next.next.next
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
            new_building_name = soup.find(text='Название новостройки').next.next.next.next
            new_building_name = new_building_name.getText()
        except:
            new_building_name = None
        finally:
            return new_building_name

    return {
            'S_Area': obl,
            'S_City': get_city(url),
            'S_Street': street,
            'S_District': district(soup),
            'N_Street': number_of_house,
            'S_Qty_Room': qty_of_rooms(soup),
            'N_Qty_Total_Space': total_space(soup),
            'N_Qty_Living_Space ': living_space(soup),
            'N_Qty_Kitchen_Space': square_of_kitchen(soup),
            'N_Price': price,
            'N_Floor': floor(soup),
            'B_Balcony': balcony_or_loggia(soup),
            'B_Loggia': balcony_or_loggia(soup),
            'S_Type_Of_Room': room_type(soup),
            'S_Ads_Type': '',
            'N_Ceiling_Height': ceiling_height(soup),
            'S_Type_Bathroom': bathroom(soup),
            'S_Window': window(soup),
            'S_Kind_Of_Repair': repair(soup),
            'B_Heating': warm_floor(soup),
            'S_Furniture': furniture(soup),
            'S_Technics': technics(soup),
            'S_Decorating': decorating(soup),
            'S_Method_Of_Sale ': seilling_method(soup),
            'S_Type_Of_Transaction ': transaction_type(soup),
            'S_Description ': description(soup),
            'S_Type_House': type_of_home(soup),
            'N_Year_Building': year_of_construction(soup),
            'N_Floor_In_House': floors_in_the_house(soup),
            'B_Passenger_Elevator': passenger_bodice(soup),
            'B_Freight_Elevator': service_lift(soup),
            'S_Yard': yard(soup),
            'S_Parking': parking(soup),
            'S_Name_New_Building': new_building_name(soup),
            'S_Official_Builder': offical_builder(soup),
            'S_Type_of_Participation': '',
            'D_Deadline_for_Delivery': deadline(soup),
            'S_Site_Links': url,
            'F_Source': 1,
            **seller(soup),
        }


