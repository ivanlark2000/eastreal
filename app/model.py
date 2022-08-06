from app.config import config
from sqlalchemy import create_engine
from sqlalchemy import BIGINT, DECIMAL
from sqlalchemy import Column, Integer, String, Sequence, TIMESTAMP, VARCHAR, ForeignKey, Text, Numeric, Boolean
from sqlalchemy.orm import relation

Base = config.Base


class Flat(Base):
    __tablename__ = "flat"

    id = Column(Integer, primary_key=True, autoincrement=True)
    id_avito = Column(BIGINT)
    number_of_tel = Column(String(120))
    price = Column(BIGINT, nullable=False)
    qty_of_rooms = Column(Integer, nullable=False)
    total_space = Column(Numeric(4, 1), nullable=False)
    square_of_kitchen = Column(Numeric(4, 1), nullable=False)
    living_space = Column(Numeric(4, 1), nullable=False)
    floor = Column(Integer, nullable=False)
    furniture = Column(String(200))
    technics = Column(String(200))
    balcony_or_loggia = Column(String(120))
    room_type = Column(String(120))
    ceiling_height = Column(Numeric(4, 1))
    bathroom = Column(String(120))
    window = Column(String(120))
    repair = Column(String(120))
    seilling_method = Column(String(120))
    transaction_type = Column(String(120))
    decorating = Column(String(120))
    warm_floor = Column(Boolean)
    description = Column(Text)
    time_of_add = Column(TIMESTAMP, nullable=False)
    house_id = Column(Integer, ForeignKey('house.id'), nullable=False)


class Author(Base):
    __tablename__ = 'author'

    id = Column(Integer, primary_key=True, autoincrement=True)
    seller = Column(String(120))
    type_seller = Column(String(200))


class Relations(Base):
    __tablename__ = 'relations'

    id = Column(Integer, primary_key=True, autoincrement=True)
    obl_id = Column(Integer, ForeignKey('obl.id'))
    city_id = Column(Integer, ForeignKey('city.id'))
    district_id = Column(Integer, ForeignKey('district.id'))
    street_id = Column(Integer, ForeignKey('street.id'), nullable=False)
    house_id = Column(Integer, ForeignKey('house.id'), nullable=False)
    flat_id = Column(Integer, ForeignKey('flat.id'), nullable=False)
    author_id = Column(Integer, ForeignKey('author.id'), nullable=False)
    status_id = Column(Integer, ForeignKey('sailing_status.id'), nullable=False)
    site_id = Column(Integer, ForeignKey('sailing_status.id'), nullable=False)


class House(Base):
    __tablename__ = 'house'

    id = Column(Integer, primary_key=True, autoincrement=True)
    new_building_name = Column(String(200))
    offical_builder = Column(String(200))
    year_of_construction = Column(Integer)
    floors_in_the_house = Column(Integer)
    type_of_home = Column(String(150))
    passenger_bodice = Column(String(100), nullable=False)
    service_lift = Column(String(100), nullable=False)
    in_home = Column(String(200))
    yard = Column(Text)
    parking = Column(Text)
    deadline = Column(String(150))
    street_id = Column(Integer, ForeignKey('street.id'), nullable=False)


class Street(Base):
    __tablename__ = 'street'

    id = Column(Integer, primary_key=True, autoincrement=True)
    street = Column(String(155), nullable=False)
    number_of_house = Column(String(100), nullable=False)


class District(Base):
    __tablename__ = 'district'

    id = Column(Integer, primary_key=True, autoincrement=True)
    district = Column(String(255), nullable=False)


class City(Base):
    __tablename__ = 'city'

    id = Column(Integer, primary_key=True, autoincrement=True)
    city = Column(String(155), nullable=False)


class Obl(Base):
    __tablename__ = 'obl'

    id = Column(Integer, primary_key=True, autoincrement=True)
    obl = Column(String(155), nullable=False)


class Active_flat(Base):
    __tablename__ = 'active_flat'

    id = Column(Integer, primary_key=True, autoincrement=True)
    id_rel = Column(Integer, ForeignKey('relations.id'), nullable=False)
    site_id = Column(Integer, ForeignKey('where_download.id'), nullable=False)


class Site(Base):
    __tablename__ = 'where_download'

    id = Column(Integer, primary_key=True, autoincrement=True)
    site = Column(String(100), nullable=False)


class Status(Base):
    __tablename__ = 'sailing_status'

    id = Column(Integer, primary_key=True, autoincrement=True)
    status = Column(String(100), nullable=False)

