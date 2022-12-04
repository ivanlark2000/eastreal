from def_list import *
from avito_pars import parsAvitoFlat
from load_to_base import load_to_base


def main():
    for url in getting_url():
        print(url)
        html = getting_html(url)  # Получаем html стартовой страницы
        list_links = getting_links(html)  # получаем список ссылок квартир
        links = getting_rendom_link(list_links)  # извлекаем рандомную ссылку
        for link in next(links):
            print(link)
            html_flat = getting_html(link)
            flat_in_avito = parsAvitoFlat(html_flat, url=link)
            load_to_base(flat_in_avito)


if __name__ == "__main__":
    main()
