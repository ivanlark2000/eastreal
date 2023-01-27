--Функция для вычисления дистанции между домом и объектом на пешко
--CREATE DATE 2023.01.24

CREATE OR REPLACE FUNCTION get_foot_distance(
    lat1 numeric, 
    lon1 numeric, 
    lat2 numeric, 
    lon2 numeric
)

RETURNS integer
AS
$BODY$

import requests

url = f'https://routing.openstreetmap.de/routed-foot/route/v1/driving/{lon1},{lat1};{lon2},{lat2}?'

try:
    response = requests.get(url).json()
    return int(response['routes'][0]['distance'])

except Exception as Error:
    plpy.notice(f'Не уалось получить дистанцию  пешком между домом № {f_house} и объектом № {f_object}\n {Error}')    

$BODY$
LANGUAGE 'plpython3u'
