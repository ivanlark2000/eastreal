import os
from datetime import datetime
from app.config import config
from app.model import *
from app.def_list import getting_total_html, getting_links, getting_rendom_link
from app.def_list import getting_url, checking_status, getting_html_flat
from app.avito_pars import parsAvitoFlat, parsAvitoHouse


def add_and_commit(obj: object) -> None:
    config.session.add(obj)
    config.session.commit()


def check_obl(house: dict) -> int:
    """Функция проверяет в какой области находится квартира и
    возрашает ID области"""
    seach = house['obl']
    if seach:
        while True:
            obl = config.session.query(Obl).filter(Obl.obl.like(f'%{seach}')).first()
            if obl:
                return obl.id
            else:
                obl_load = Obl(obl=seach)
                add_and_commit(obl_load)
    else:
        try:
            obl_load = Obl(obl='Район не определен')
            add_and_commit(obl_load)
        except:
            print('Запись попала в неопределенный район')
        finally:
            obl = config.session.query(Obl).filter(Obl.obl.like(f'%неопределенный район')).first()
            return obl.id


def check_city(house: dict) -> int:
    """Функция, которая возращает ID города"""
    seach = house['city']
    while True:
        city = config.session.query(City).filter(City.city.ilike(f'%{seach}')).first()
        if city:
            return city.id
        else:
            city_load = City(city=seach)
            add_and_commit(city_load)


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


def check_house(house: dict, id: int) -> int:
    street = house['street']
    number_of_house = house['number_of_house']
    del house['district']
    while True:
        house_in_base = config.session.query(House).filter(House.street.like(f'%{street}'),
                                            House.number_of_house.like(f'%{number_of_house}')).first()
        if house_in_base:
            return house_in_base.id
        else:
            district_load = House(
                district_id=id, **house
            )
            config.session.add(district_load)
            config.session.commit()


def load_in_base(flat: dict, house: dict):
    """Функция для загрузки данных о квартирах в базу"""
    id_obl = check_obl(house)
    #id_house = check_house(house, check_district(house))

    print(id_obl)