--DROP FUNCTION load_json_object(f_city integer, f_object integer, table_name varchar(150))
--ALTER DATE 2023.24.01 добавили функцию по обработке ошибки декодирования
CREATE OR REPLACE FUNCTION load_json_object(f_city integer, f_object integer, table_name varchar(150))
RETURNS void
AS
$BODY$

import requests
import json
import time 

overpass_url = "http://overpass-api.de/api/interpreter"


def get_json(qvr: str):
    while True:
        response = requests.get(overpass_url, params={'data': qvr})
        try:
            return response.json()
        except:
            time.sleep(5)
            plpy.notice('Ошибка в обрабоке Json')
            continue


city = plpy.execute(f'SELECT c_name FROM fs_city WHERE link = {f_city}')[0]['c_name']

tags = plpy.execute(f'SELECT tags FROM fs_objects_type WHERE link = {f_object}')[0]['tags']

for tag in tags:
    overpass_query = f"""
                    [out:json];
                    area[name="{city}"];
                    nwr{tag}(area);
                    out center;
                    """
    
    j = get_json(overpass_query)
    for i in j['elements']:
        i = json.dumps(i)
        try:
            plpy.execute(f'''INSERT INTO {table_name} (f_city, f_objects_type, json)
                        VALUES ({f_city}, {f_object}, '{i}'::jsonb)''')

        except Exception as e:
            plpy.notice(f'Ошибка при загрузке данных в БД с ОСМ {e}')
            continue


$BODY$ LANGUAGE 'plpython3u'
