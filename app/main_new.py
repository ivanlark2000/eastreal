from def_list import *
from app.avito_pars import parsAvitoFlat, parsAvitoHouse
from app.load_in_base import load_in_base, clear_tab_active_flat


def test():
    url = "https://www.avito.ru/kaliningrad/kvartiry/1-k._kvartira_425m_725et._2482366056"
    html_flat = getting_html_flat(url)


def main():
    clear_tab_active_flat(flag='avito')
    for url in getting_url():
        print(url)
        html = getting_total_html(url)  # Получаем html стартовой страницы
        list_links = getting_links(html)  # получаем список ссылок квартир
        links = getting_rendom_link(list_links)  # извлекаем рандомную ссылку
        for link in next(links):
            print(link)
            try:
                html_flat = getting_html_flat(link)
                flat_in_avito = parsAvitoFlat(html_flat)
                house_in_avito = parsAvitoHouse(html=html_flat, url=link)
                print(house_in_avito['street'], house_in_avito['number_of_house'],)
                load_in_base(
                        flat=flat_in_avito,
                        house=house_in_avito
                    )
            except Exception as e:
                print('Не получилось загрузить данные со страницы' + str(e))
                continue


if __name__ == "__main__":
    # test()
    main()
