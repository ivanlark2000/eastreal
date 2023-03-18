#coding=utf-8
import time
import uuid
import requests
import psycopg2
from bs4 import BeautifulSoup as bs
from load_to_base import load_buildings_to_base, get_city_url
from load_to_base import load_area, load_city, get_links_area
from def_list import get_position_ya, getting_html, save_html, load_html
    

MAIN_URL = 'https://dom.mingkh.ru'


def load_area_gis():
    html = load_html()
    soup = bs(html, 'lxml')
    tags = soup.find('ul', {'class':'list-unstyled list-columns'})
    lst_city = [(tag.text, tag['href']) for tag in tags.findAll('a')]
    load_area(lst_city)


def get_city_and_load_to_base() -> None:
    for i in get_links_area():
        url = MAIN_URL + i[1]
        html = getting_html(url)
        if html:
            soup = bs(html, 'lxml')
            tags = soup.find('ul', {'class':'list-unstyled list-columns'})
            lst_city = [(i[0], tag.text, tag['href']) for tag in tags.findAll('a')]
            load_city(lst_city)
            print(url)
            time.sleep(10)


def get_flat(url: str) -> str:
    try:
        html = getting_html(MAIN_URL + url)
        soup = bs(html, 'lxml')
        return (soup.find(string='Жилых помещений').next.next).text
    except:
        return 


def get_lst_load_to_base(soup: object, city_id: int) -> None:
    table = soup.find('table', {'class': 'table table-bordered table-striped table-hover'})
    lst = [row for row in table.findAll('tr')][1:]
    for row in lst:
        lst_row = str(row).replace('<tr> <td>', '').replace('</td> </tr>', '').split('</td> <td>')
        address = bs(lst_row[2], 'lxml').find('a').text
        n_flat = get_flat(bs(lst_row[2], 'lxml').find('a').get('href'))
        if n_flat:
            if n_flat.isdigit():
                n_flat = int(n_flat)
        square, year, floor = lst_row[3:6]
        if  not floor.isdigit():
            floor = 0
        guid = uuid.uuid3(uuid.NAMESPACE_DNS, lst_row[1] + address)
        position = get_position_ya(lst_row[1] + ' ' + address)
        if position:
            lat, lon = position
        else:
            continue
        load_buildings_to_base(
                guid=guid, f_city=city_id, address=address, n_year_build=year,
                floor=floor, square=square, lat=lat, lon=lon, flat=n_flat
                ) 


def get_and_load_houses(city: str) -> None:
    f_city, url = get_city_url('%' + city[1:])
    url = MAIN_URL + url + 'houses'
    html = getting_html(url)
    if html:
        soup = bs(html, 'lxml')
        page_end = soup.find('ul', {'class':'pagination'}).find_all('a')[-1].get('data-ci-pagination-page')
        get_lst_load_to_base(soup=soup, city_id=f_city)
        for p in range(2, int(page_end) + 1):
            url_page = url + f'?page={p}'
            html = getting_html(url_page)
            if html:
                soup = bs(html, 'lxml')
                get_lst_load_to_base(soup=soup, city_id=f_city)



if __name__ == "__main__":
    get_and_load_houses('Калининград')
