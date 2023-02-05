import logging
from def_list import *
from avito_pars import parsAvitoFlat
from urllib.error import HTTPError
from transliterate import translit
from load_to_base import load_to_base, get_id_in_base, load_price_to_base

logger = logging.getLogger('PARSER')
logger.setLevel(logging.INFO)

handler = logging.FileHandler('log/pars_avito.log', 'w')
formatter = logging.Formatter("%(name)s %(asctime)s %(levelname)s %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)

CITY_ID = 24741 
CITY_RUS = 'Калининград'
CITY = translit(CITY_RUS.lower(), language_code='ru', reversed=True)
AKTIVE_CITE_ID = []


def load_test_file(city=CITY) -> None:
    url = getting_url(CITY)
    html = getting_html(next(url))
    save_html(html, 'test_main.html')
    links = getting_links(html)
    save_html(getting_html(links[2][2]), 'test_one_ads.html')
    print('Сохранены тустовые страницы')


def test_total_html() -> None:
    count = 1
    html = load_html('test_main.html')
    lst_links = getting_links(html)
    ids_in_base = get_id_in_base(CITY_ID)
    for ids_site in lst_links:
        AKTIVE_CITE_ID.append(ids_site[0])
        for ids_base in ids_in_base:
            if int(ids_site[0]) == ids_base[1]:
                if int(ids_site[1]) == ids_base[2]:
                    break

                else:
                    load_price_to_base(f_flat=ids_base[0], n_price=ids_in_base[1])
                    
        else:
            print(ids_site)
            html_flat = getting_html(ids_site[2])
            flat_in_avito = parsAvitoFlat(html_flat, url=ids_site[2], city=CITY_RUS)
            load_to_base(flat_in_avito, count)
            count += 1 
    print(len(AKTIVE_CITE_ID), AKTIVE_CITE_ID)
    

def pars():
    count = 1
    for url in getting_url(city=CITY):
        try:
            html = getting_html(url)  # Получаем html стартовой страницы
        except HTTPError as e:
            logger.warning(f'{url} \n ', exc_info=True)
        lst_links = getting_links(html)  # получаем список ссылок квартир
        lst_id_in_base = get_id_in_base(CITY_ID)
        rendom_link = getting_rendom_link(lst_links)
        for ids_site in next(rendom_link):       # проверяем есть ли квартира в базе
            for ids_base in lst_id_in_base:
                if int(ids_site[0]) == ids_base[1]:
                    if int(ids_site[1]) == ids_base[2]:
                        print(f'В БД есть квартра № {ids_site[0]} с такой же ценой')
                        break
                    else:
                        load_price_to_base(f_flat=ids_base[0], n_price=ids_site[1])
                        if int(ids_site[1]) > ids_base[2]:
                            print(f'Квартира с айдишником {ids_site[0]} \
                                    подорожала на {int(ids_site[1]) - int(ids_base[2])}')
                        else:
                            print(f'Квартра рс айди {ids_site[0]} подешевела на \
                                    {int(ids_base[2]) - int(ids_site[1])}')

            else:
                url = ids_site[2]
                try:
                    html_flat = getting_html(url)
                except HTTPError as e:
                    logger.warning(f'{url} \nОшибка в скачке данных с Авито', exc_info=True)
                    continue
                try:
                    flat_in_avito = parsAvitoFlat(html_flat, url=url, city=CITY_RUS)
                    load_to_base(flat_in_avito, count)
                    count += 1
                except Exception as e: 
                    logger.warning(f'{url} \nNot correct data from site', exc_info=True)


def main():
    pars()
    #load_test_file()
    #test_total_html()
    


if __name__ == "__main__":
    main()
