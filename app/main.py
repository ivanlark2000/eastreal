from app.def_list import *
from app.avito_pars import parsAvitoFlat, parsAvitoHouse
from app.load_in_base import load_in_base, clear_tab_active_flat


def main():
    clear_tab_active_flat(flag='avito')
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
                load_in_base(
                            flat=flat_in_avito,
                            house=house_in_avito
                        )
            except Exception as e:
                print('Не получилось загрузить данные со страницы ' + str(e))
                continue


if __name__ == "__main__":
    main()
