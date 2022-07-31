import os
from datetime import datetime
from app.config import config
from app.model import Flat, House, District, Active_flat, Site, Status
from app.def_list import getting_total_html, getting_links, getting_rendom_link
from app.def_list import getting_url, checking_status, getting_html_flat
from app.avito_pars import parsAvitoFlat, parsAvitoHouse


def check_district(house: dict) -> int:
    """Функция, которая проверяет район дома если его нет заносит в базу"""
    seach = house['district'].split()
    while True:
        district = config.session.query(District).filter(District.district.ilike(f'%{seach[-1]}')).first()
        if district:
            return district.id
        else:
            district_load = District(district=house['district'])
            config.session.add(district_load)
            config.session.commit()
    '''info_avito_flat = parsAvitoFlat(html)
    info_avito_house = parsAvitoHouse(html)
    district = info_avito_house['district']
    del info_avito_house['district']
    district_in_base = District(district=district)
    house = House(district_id=4, **info_avito_house)
    flat = Flat(
        site_id=1, house_id=5, district_id=4, status=1, time_of_add=datetime.now(),
        **info_avito_flat
                )
    with config.Session() as session:
        session.add(district_in_base)
        session.commit()
        session.add(house)
        session.commit()
        session.add(flat)
        session.commit()'''


def load_in_base(flat: dict, house: dict):
    """Функция для загрузки данных о квартирах в базу"""
    id_district = check_district(house)
    print(id_district)