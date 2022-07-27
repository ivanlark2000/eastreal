from app.def_list import getting_total_html, getting_links, getting_rendom_link
from app.def_list import getting_url, checking_status, getting_html_flat
from bs4 import BeautifulSoup as Bs

url = 'https://www.avito.ru/kaliningrad/kvartiry/2-k._kvartira_62m_88et._2427036847'

'''for url in getting_url():
    print(url)
    html = getting_total_html(url)  # Получаем html стартовой страницы
    list_links = getting_links(html)  # получаем список ссылок квартир
    print(list_links[1])
    quit()'''

'''html_flat = getting_html_flat(url)
with open('../sys/flat.html', 'w') as file:
    file.write(html_flat)'''


file = open('../sys/flat.html', 'r')
html = file.read()
file.close()


def getInfoFlat(html):
    soup = Bs(html, 'html.parser')
    flat_id = soup.find('span', attrs={'data-marker': 'item-view/item-id'})
    flat_id = int(flat_id.contents[0][-10:])
    price = soup.find('span', itemprop="price")
    price = int(price['content'])

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

    return {
        "flat_id": flat_id,
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
        }


print(getInfoFlat(html))

