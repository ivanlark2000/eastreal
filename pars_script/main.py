from def_list import *
from avito_pars import parsAvitoFlat
from urllib.error import HTTPError
from transliterate import translit
from position.get_position import add_coord, get_position_ya
from load_to_base import load_to_base, get_id_in_base, load_price_to_base, logger, update_sell_status


CITY_ID = 24741 
CITY_RUS = 'Калининград'
CITY = translit(CITY_RUS.lower(), language_code='ru', reversed=True)
AKTIVE_SITE_ID = []


def pars():
    count = 1
    lst_id_in_base = get_id_in_base(CITY_ID)
    for url in getting_url(city=CITY):
        try:
            html = getting_html(url)  # Получаем html стартовой страницы
        except HTTPError as e:
            logger.warning(f'{url} \n ', exc_info=True)
            continue
        lst_links = getting_links(html)  # получаем список ссылок квартир
        rendom_link = getting_rendom_link(lst_links)
        for ids_site in next(rendom_link):       # проверяем есть ли квартира в базе
            AKTIVE_SITE_ID.append(int(ids_site[0]))
            for ids_base in lst_id_in_base:
                if int(ids_site[0]) == ids_base[0]:
                    if int(ids_site[1]) == ids_base[1]:
                        print(f'В БД есть квартра № {ids_site[0]} с такой же ценой')
                    elif ids_base[1]:
                        if int(ids_site[1]) > ids_base[1]:
                            print(f'Квартира с айдишником {ids_site[0]} \
                                            подорожала на {int(ids_site[1]) - int(ids_base[1])}')
                            load_price_to_base(f_flat=ids_base[2], n_price=ids_site[1])

                        else:
                            print(f'Квартра с айди {ids_site[0]} подешевела на \
                                    {int(ids_base[1]) - int(ids_site[1])}')
                            load_price_to_base(f_flat=ids_base[2], n_price=ids_site[1])

                    break

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

    update_sell_status(city_id=CITY_ID, siteids=AKTIVE_SITE_ID)


def main():
    pars()
    add_coord()


if __name__ == "__main__":
    main()
