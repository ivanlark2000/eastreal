from def_list import *
from avito_pars import parsAvitoFlat, parsAvitoHouse


def main():
    for url in getting_url():
        print(url)
        html = getting_html(url)  # Получаем html стартовой страницы
        list_links = getting_links(html)  # получаем список ссылок квартир
        links = getting_rendom_link(list_links)  # извлекаем рандомную ссылку
        for link in next(links):
            print(link)
            try:
                html_flat = getting_html(link)
                flat_in_avito = parsAvitoFlat(html_flat, url=link)
                house_in_avito = parsAvitoHouse(html=html_flat, url=link)
                print(flat_in_avito)
                print(house_in_avito)
            except Exception as e:
                print('Не получилось загрузить данные со страницы ' + str(e))
                continue


if __name__ == "__main__":
    main()
