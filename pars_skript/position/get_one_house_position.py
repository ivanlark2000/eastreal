import sys
from sys import argv
from geopy.geocoders import Nominatim
from config import logger, config

sys.path.append('/pars_skript/settings')
geolocator = Nominatim(user_agent='Tester')

id_city = argv[1]
name_city = argv[2]
name_street = argv[3]
id_house = argv[4]
n_house = argv[5]


def get_position(city: str, street: str, house: str):
    address = city + street + ' ' + house
    try:
        location = geolocator.geocode(address)
        return location.longitude, location.latitude
    except Exception as e:
        logger.warning('Not position for this house', e)


def load_to_base(city: str, house: str, lon: str, lat: str) -> None:
    try:
        conn = config.make_con()
        cursor = conn.cursor()
        cursor.execute(f"""INSERT INTO ps_ads_position (f_city, f_house, longitude, latitude)
                            VALUES ({city}, {house}, {lon}, {lat})""")
        conn.commit()
    except Exception as e:
        logger.warning('Не удалось отправить координаты в базу', e)


def main():
    position = get_position(city=id_city, street=name_street, house=n_house)
    if not position:
        return
    lon, lat = position
    load_to_base(city=id_city, house=id_house, lon=lon, lat=lat)
    logger.info(f'Данные по адресу {name_city} {name_street} {n_house} успешно загружены')
    print('Успешно отправлены координаты объекта')


if __name__ == "__main__":
    main()