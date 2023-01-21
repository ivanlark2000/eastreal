--  Функция возвращает json с индексами загрязнение воздуха
CREATE OR REPLACE FUNCTION get_json_air_polution(lat numeric, lon numeric)
RETURNS json
AS
$BODY$

import requests
import json

API = '93b8d924fc1e41a8990ef37df207753e'
url = f"http://api.openweathermap.org/data/2.5/air_pollution?"


param = {
    'lat': lat,
    'lon': lon,
    'appid': API
}


r = requests.get(url, params=param)
rez = json.dumps(r.json()['list'][0])
return rez


$BODY$
LANGUAGE 'plpython3u'
