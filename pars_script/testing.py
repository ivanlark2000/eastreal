from main import CITY_ID, CITY
from def_list import *
from avito_pars import parsAvitoFlat
from urllib.error import HTTPError
from transliterate import translit
from load_to_base import load_to_base, get_id_in_base, load_price_to_base, logger, update_sell_status


def load_test_file(city=CITY) -> None:
    url = getting_url(CITY)
    html = getting_html(next(url))
    save_html(html, 'test_main.html')
    links = getting_links(html)
    save_html(getting_html(links[2][2]), 'test_one_ads.html')
    print('Сохранены тустовые страницы')


def test_update_sell_status():
    lst = [i[0] for i in get_id_in_base(CITY_ID)]
    lst = getting_rendom_link(lst)
    l = next(lst)
    l = l[0:int(len(l)/2)]
    update_sell_status(city_id=CITY_ID, siteids=l)


if __name__ == "__main__":
    test_update_sell_status()
