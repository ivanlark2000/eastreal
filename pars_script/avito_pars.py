from bs4 import BeautifulSoup as Bs
from transliterate import translit


def ads_type(soup) -> str:
    lst = ['Новостройки', 'Вторичка']
    for t in lst:
        try:
            return soup.find(text=t).lower()
        except:
            continue


def qty_of_rooms(soup):
    try:
        qty_of_rooms = soup.find(text='Количество комнат').next.next.next
    except:
        qty_of_rooms = None
    finally:
        return qty_of_rooms


def total_space(soup):
    try:
        total_space = soup.find(text='Общая площадь').next.next.next
        return float(total_space[:-3])
    except:
        return


def square_of_kitchen(soup):
    try:
        square_of_kitchen = soup.find(text='Площадь кухни').next.next.next
        return float(square_of_kitchen[:-3])
    except:
        return


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
        furniture = None
    finally:
        return furniture


def technics(soup):
    try:
        technics = soup.find(text='Техника').next.next.next
    except:
        technics = None
    finally:
        return technics


def loggia(soup):
    try:
        if 'лод' in soup.find(text='Балкон или лоджия').next.next.next:
            return True
    except:
        return False
    return False


def balkon(soup):
    try:
        if 'бал' in soup.find(text='Балкон или лоджия').next.next.next:
            return True
    except:
        return False
    return False


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
        if 100 > ceiling_height > 10:
            ceiling_height = ceiling_height / 10
        elif ceiling_height > 100:
            ceiling_height = ceiling_height / 100
        return ceiling_height
    except:
        return


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


def selling_method(soup):
    try:
        selling_method = soup.find(text='Способ продажи').next.next.next
    except:
        selling_method = None
    finally:
        return selling_method


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
            'S_Seller': seller,
            'S_Seller_Type': type_seller
        }


def get_city(url: str) -> str:
    city = url.split('/')[3]
    city = translit(city, 'ru')
    return city.capitalize().strip()


def district(soup):
    try:
        address = soup.find('div', itemprop="address")
        disrict = address.next.next.next.next.getText()
    except:
        disrict = None
    finally:
        return disrict


def district(soup):
    try:
        address = soup.find('div', itemprop="address")
        disrict = address.next.next.next.next.getText()
    except:
        disrict = None
    finally:
        return disrict


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
        rez = soup.find(text='Пассажирский лифт').next.next.next
        if 'a' in rez:
            return True
        elif '1' in rez:
            return True
    except:
        return False
    return False


def service_lift(soup):
    try:
        service_lift = soup.find(text='Грузовой лифт').next.next.next
        if 'a' in service_lift:
            return True
        elif '1' in service_lift:
            return True
    except:
        return False
    return False


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


def yard(soup):
    try:
        yard = soup.find(text='Двор').next.next.next
    except:
        yard = None
    finally:
        return yard


def in_home(soup):
    try:
        in_home = soup.find(text='В доме').next.next.next
    except:
        in_home = None
    finally:
        return in_home


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


def type_of_participation(soup):
    try:
        return soup.find(text='Тип участия').next.next.next
    except:
        return None


def deadline(soup):
    try:
        deadline = soup.find(text='Срок сдачи').next.next.next
    except:
        deadline = None
    finally:
        return deadline


def second_number_house(soup):
    try:
        number_of_house = soup.find(text='Корпус, строение').next.next.next
        lst = []
        count = 0
        for num in number_of_house:
            if num.isdigit():
                lst.append(num)
                count += 1
                continue
            if count > 0:
                break
            count = 0
        return int(''.join(lst))
    except:
        return 0


def new_building_name(soup):
    try:
        new_building_name = soup.find(text='Название новостройки').next.next.next.next
        new_building_name = new_building_name.getText()
    except:
        new_building_name = None
    finally:
        return new_building_name


def get_full_street(soup, city) -> str:
    lst_keyword = [
        'район', 'округ', 'пос.', 'область', 'микрорайон', 'жилой комплекс', 'г.о.', 'посёлок', 'СНТ'
    ]
    address = soup.find('div', itemprop="address").text
    lst = [i.strip() for i in address.split(',')]
    lst_rez = []
    for i in lst:
        if 'р-н' in i:
            i = i.split('р-н')[0]
        if 'область' in i:
            continue
        if i == city.capitalize():
            continue
        lst_rez.append(i)
    lst.clear()
    for i in lst_rez:
        for n in lst_keyword:
            if n in i:
                i = ''
        lst.append(i)
    return ', '.join(lst)


def parsAvitoFlat(html: str, url: str, city: str, guid: str) -> dict:
    soup = Bs(html, 'html.parser')
    price = soup.find('span', itemprop="price")
    price = int(price['content'])
    site_id = int(url[url.rfind('_') + 1:])
    soup = Bs(html, 'html.parser')

    return {
        'site_id': site_id,
        'S_City': get_city(url),
        'S_Street': get_full_street(soup, city=city),
        'S_District': district(soup),
        'S_Qty_Room': qty_of_rooms(soup),
        'N_Qty_Total_Space': total_space(soup),
        'N_Qty_Living_Space': living_space(soup),
        'N_Qty_Kitchen_Space': square_of_kitchen(soup),
        'N_Price': price,
        'N_Floor': floor(soup),
        'B_Balcony': balkon(soup),
        'B_Loggia': loggia(soup),
        'S_Type_Room': room_type(soup),
        'S_Ads_Type': ads_type(soup),
        'N_Ceiling_Height': ceiling_height(soup),
        'S_Bathroom_Type': bathroom(soup),
        'S_Window': window(soup),
        'S_Repair_Type': repair(soup),
        'B_Heating': warm_floor(soup),
        'S_Furniture': furniture(soup),
        'S_Technics': technics(soup),
        'S_decoration': decorating(soup),
        'S_Method_Of_Sale': selling_method(soup),
        'S_Transaction_Type': transaction_type(soup),
        'S_Description': description(soup),
        'S_Type_House': type_of_home(soup),
        'N_Year_Building': year_of_construction(soup),
        'S_Qty_floor': floors_in_the_house(soup),
        'B_Passenger_Elevator': passenger_bodice(soup),
        'B_Freight_Elevator': service_lift(soup),
        'S_Yard': yard(soup),
        'S_Parking': parking(soup),
        'S_Name_New_Building': new_building_name(soup),
        'S_Official_Builder': offical_builder(soup),
        'S_Type_of_Participation': type_of_participation(soup),
        'D_Deadline_for_Delivery': deadline(soup),
        'S_Site_Links': url,
        'F_Source': 1,
        'G_Sess': guid, 
        **seller(soup),
    }
