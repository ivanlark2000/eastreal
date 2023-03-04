import uuid
from def_list import *
from datetime import datetime
from urllib.error import HTTPError
from transliterate import translit
from avito_pars import parsAvitoFlat
from load_to_base import load_to_base, get_id_in_base
from load_to_base import mark_start_sess, update_end_sess
from load_to_base import load_price_to_base, update_sell_status, logger


CITY_ID = 24741 
CITY_RUS = 'Калининград'
CITY = translit(CITY_RUS.lower(), language_code='ru', reversed=True)
AKTIVE_SITE_ID = []


def sess_uuid() -> None:
    G_SESS = uuid.uuid4()
    time_start = datetime.now()
    mark_start_sess(G_SESS, time_start)
    total_ads, new_load, miss_load = pars(G_SESS)
    time_end = datetime.now()
    update_end_sess(
            g_sess=G_SESS, d_date_end=time_end,
            n_total_count=total_ads, n_miss=miss_load, n_new=new_load
            )


def pars(g_sess: str) -> tuple[int, int, int]:
    count_new = 0
    count_miss = 0
    lst_id_in_base = get_id_in_base(CITY_ID)
    for url in getting_url(city=CITY):
        try:
            html = getting_html_sel(url)  # Получаем html стартовой страницы
        except HTTPError as e:
            logger.warning(f'{url} \n ', exc_info=True)
            continue
        lst_links = getting_links(html) # получаем список ссылок квартир
        if not len(lst_links):
            continue
        rendom_link = getting_rendom_link(lst_links)
        for ids_site in next(rendom_link):       # проверяем есть ли квартира в базе
            AKTIVE_SITE_ID.append(int(ids_site[0]))
            for ids_base in lst_id_in_base:
                if int(ids_site[0]) == ids_base[0]:
                    if int(ids_site[1]) == ids_base[1]:
                        logger.info(f'В БД есть квартира № {ids_site[0]} с такой же ценой')
                    elif ids_base[2] is not None and ids_base[1] is None:
                        load_price_to_base(f_flat=ids_base[2], n_price=ids_site[1])
                        logger.info(f'У квартиры с ID {ids_site[0]} отсутствовала цена')
                    elif ids_base[1]:
                        if int(ids_site[1]) > ids_base[1]:
                            logger.info(f'''Квартира с айдишником {ids_site[0]} \
                                    подорожала на {int(ids_site[1]) - int(ids_base[1])}''')
                            load_price_to_base(f_flat=ids_base[2], n_price=ids_site[1])

                        else:
                            logger.info(f'''Квартира с айди {ids_site[0]} \
                                    подешевела на {int(ids_base[1]) - int(ids_site[1])}''')
                            load_price_to_base(f_flat=ids_base[2], n_price=ids_site[1])

                    break

            else:
                url = ids_site[2]
                try:
                    html_flat = getting_html_sel(url)
                except HTTPError as e:
                    logger.warning(f'{url} \nОшибка в скачке данных с Авито', exc_info=True)
                    continue
                try:
                    flat_in_avito = parsAvitoFlat(html_flat, url=url, city=CITY_RUS)
                    count_new, count_miss = load_to_base(
                            dct=flat_in_avito, count_new=count_new, count_miss=count_miss
                            )
                except Exception as e:
                    logger.warning(f'{url} \nNot correct data from site', exc_info=True)
    
                logger.debug(f'count_new = {count_new}, count_miss = {count_miss}')
    update_sell_status(city_id=CITY_ID, siteids=AKTIVE_SITE_ID)
    return len(AKTIVE_SITE_ID), count_new,  count_miss


def main():
    from config import args
    if args.coord:
        add_coord()
    else:
        sess_uuid()

if __name__ == "__main__":
    main()
