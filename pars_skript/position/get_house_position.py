from typing import Any
from geopy.geocoders import Nominatim
from pars_skript.settings.config import config, logger

geolocator = Nominatim(user_agent='Tester')

id_city = 24741


def get_data(id: int) -> list[Any]:
    sql_request = f'''SELECT 
            c.link    	AS id_city
            ,c.C_Name 	AS name_city
            ,s.C_Name	AS name_street
            ,h.link     AS id_house
            ,h.s_number	AS number_house
        FROM FS_City c
            INNER JOIN FS_Street s 
                ON s.f_city = c.link
            INNER JOIN MN_House h
                ON h.f_street = s.link
            LEFT JOIN ps_ads_position p
                ON p.f_house = h.link
        WHERE c.link = {id} AND p.latitude IS NULL
        '''
    try:
        conn = config.make_con()
        logger.info('Connected Base Successful')
        cursor = conn.cursor()
        cursor.execute(sql_request)
        row = cursor.fetchall()
        return row
    except Exception as e:
        logger.critical(e, exc_info=True)
        cursor.close()


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
    count = 0
    for r in get_data(id=id_city):
        print(r)
        position = get_position(city=r[1], street=r[2], house=r[4])
        if not position:
            continue
        lon, lat = position
        load_to_base(city=r[0], house=r[3], lon=lon, lat=lat)
        count += 1
        logger.info(f'Данные по адресу {r[1]} {r[2]} {r[4]} успешно загружены')
        print('Успешно отправлены координаты объекта №' + str(count))


if __name__ == "__main__":
    main()