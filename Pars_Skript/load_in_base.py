import sqlalchemy
from Pars_Skript.model import *
from datetime import datetime
from app.config import config


def add_and_commit(obj: object) -> None:
    """Функция для добавления и сохранения его в базу"""
    config.session.add(obj)
    config.session.commit()


def clear_tab_active_flat(flag: str) -> None:
    """Функция для очистки активных квартир перед поиском"""
    match flag:
        case 'avito':
            config.session.query(Active_flat).filter(Active_flat.site_id == 1).delete(synchronize_session="fetch")
            # удаляем все записи с сайта в авито с активными квартирами
    config.session.commit()


def add_new_price(price: int, flat_id: int) -> None:
    """Функция, которая проверяет изменилась ли цена если есть то добавляет цену квартиры"""
    flat_info = config.session.query(Flat).get(flat_id)
    if flat_info.price != price:
        flat_info.price = price
        add_new_price = History_of_price(flat_id=flat_id, price=price, time_of_add_price=datetime.now())
        add_and_commit(add_new_price)
        print(f'Цена у квартиры ID {flat_id} обновлена')


def check_obl(house: dict) -> any:
    """Функция проверяет в какой области находится квартира и
    возращает ID области"""
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
        return sqlalchemy.sql.null()


def check_city(house: dict) -> any:
    """Функция, которая возращает ID города
    принимает аргументы args:
                        id - id области
                        house - словарь с данными о доме"""
    seach = house['city']
    if seach:
        while True:
            city = config.session.query(City).filter(City.city.ilike(f'%{seach}')).first()
            if city:
                return city.id
            else:
                city_load = City(city=seach)
                add_and_commit(city_load)
    else:
        return sqlalchemy.sql.null()


def check_district(house: dict) -> any:
    """Функция, которая проверяет район дома если его нет заносит в базу"""
    seach = house['district'].split()
    if seach:
        while True:
            district = config.session.query(District).filter(District.district.ilike(f'%{seach[-1]}')).first()
            if district:
                return district.id
            else:
                district_load = District(district=house['district'])
                add_and_commit(district_load)
    else:
        return sqlalchemy.sql.null()


def check_street(house: dict) -> int:
    street = house['street']
    number_of_house = house['number_of_house']
    if street and number_of_house:
        while True:
            street_in_base = config.session.query(Street).filter(Street.street.like(f'%{street}'),
                                                Street.number_of_house.like(f'%{number_of_house}')).first()
            if street_in_base:
                return street_in_base.id
            else:
                district_load = Street(street=street, number_of_house=number_of_house)
                add_and_commit(district_load)
    else:
        return sqlalchemy.sql.null()


def add_house(house: dict, street_id: int) -> int:
    house_info = config.session.query(House).filter(House.street_id == street_id).first()
    if not house_info:
        del house['district']
        del house['obl']
        del house['street']
        del house['city']
        del house['number_of_house']
        del house['site']
        house_info = House(street_id=street_id, **house)
        add_and_commit(house_info)
    return house_info.id


def add_and_check_flat(flat: dict, house_id) -> int and bool:
    flat_info = config.session.query(Flat).filter(Flat.id_avito == flat['id_avito']).first()
    if not flat_info:
        del flat['seller']
        del flat['type_seller']
        flat_info = Flat(house_id=house_id, time_of_add=datetime.now(), **flat)
        add_and_commit(flat_info)
        return flat_info.id, False
    return flat_info.id, True


def add_author(flat: dict) -> int or None:
    """Функция для проверки автора и добавление его в базу"""
    seller = flat['seller']
    type_seller = flat['type_seller']
    if seller:
        author_info = config.session.query(Author).filter(Author.seller.like(f'{seller}'),
                                                      Author.type_seller.like(f'{type_seller}')).first()
        if not author_info:
            author_info = Author(seller=seller, type_seller=type_seller)
            add_and_commit(author_info)
        return author_info.id
    else:
        return sqlalchemy.sql.null()


def check_site(house: dict) -> int:
    site = house['site']
    site_info = config.session.query(Site).filter(Site.site.like(f'{site}')).first()
    if not site_info:
        site_info = Site(site=site)
        add_and_commit(site_info)
    return site_info.id


def add_flat_in_active(rel_id, site_id) -> None:
    active = Active_flat(id_rel=rel_id, site_id=site_id)
    add_and_commit(active)


def load_in_base(flat: dict, house: dict):
    """Функция для загрузки данных о квартирах в базу"""
    site_id = check_site(house)
    street_id = check_street(house)
    city_id = check_city(house)
    obl_id = check_obl(house)
    district_id = check_district(house)
    author_id = add_author(flat)
    id_house = add_house(house, street_id)
    id_flat = add_and_check_flat(flat, id_house)
    if not id_flat[1]:
        total_info = Relations(obl_id=obl_id, city_id=city_id,
                               district_id=district_id, street_id=street_id,
                               flat_id=id_flat[0], author_id=author_id,
                               status_id=1, house_id=id_house, site_id=site_id)
        add_price = History_of_price(flat_id=id_flat[0], price=flat['price'],
                                     time_of_add_price=datetime.now())
        config.session.add(add_price)
        add_and_commit(total_info)
        print(f'Добавлена новая квартира ID in base - {total_info.flat_id}')
        add_flat_in_active(rel_id=total_info.id, site_id=site_id)
    else:
        total_info = config.session.query(Relations).filter(Relations.flat_id == id_flat[0]).first()
        if total_info:
            total_info.status_id = 1
            add_new_price(price=flat['price'], flat_id=total_info.flat_id)
            print(f"Квартира обновлена ID in base - {total_info.flat_id}")
            add_flat_in_active(rel_id=total_info.id, site_id=site_id)



