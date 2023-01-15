from def_list import *
from settings.config import logger
from avito_pars import parsAvitoFlat
from load_to_base import load_to_base
from urllib.error import HTTPError
from transliterate import translit

CITY_RUS = 'Калининград'
CITY = translit(CITY_RUS.lower(), language_code='ru', reversed=True)


def main():
    for url in getting_url(city=CITY):
        try:
            html = getting_html(url)  # Получаем html стартовой страницы
        except HTTPError as e:
            logger.warning(f'{url} \n ', exc_info=True)
        list_links = getting_links(html)  # получаем список ссылок квартир
        links = getting_rendom_link(list_links)  # извлекаем рандомную ссылку
        for link in next(links):
            try:
                html_flat = getting_html(link)
            except HTTPError as e:
                logger.warning(f'{url} \nОшибка в скачке данных с Авито', exc_info=True)
                continue
            try:
                flat_in_avito = parsAvitoFlat(html_flat, url=link, city=CITY_RUS)
                load_to_base(flat_in_avito)
            except Exception as e:
                logger.warning(f'{url} \nNot correct data from site' + str(e), exc_info=True)


if __name__ == "__main__":
    main()
