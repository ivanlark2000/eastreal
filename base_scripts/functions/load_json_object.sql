--DROP FUNCTION load_json_object(f_city integer, f_object integer, table_name varchar(150))
CREATE OR REPLACE FUNCTION load_json_object(f_city integer, f_object integer, table_name varchar(150))
RETURNS void
AS
$BODY$

import requests
import json

overpass_url = "http://overpass-api.de/api/interpreter"

city = plpy.execute(f'SELECT c_name FROM fs_city WHERE link = {f_city}')[0]['c_name']

tags = plpy.execute(f'SELECT tags FROM fs_objects_type WHERE link = {f_object}')[0]['tags']

for tag in tags:
    overpass_query = f"""
                    [out:json];
                    area[name="{city}"];
                    nwr{tag}(area);
                    out center;
                    """

    response = requests.get(overpass_url, params={'data': overpass_query})

    j = response.json()
    for i in j['elements']:
        i = json.dumps(i)
        try:
            plpy.execute(f'''INSERT INTO {table_name} (f_city, f_object, json)
                        VALUES ({f_city}, {f_object}, '{i}'::jsonb)''')
        except:
            continue


$BODY$ LANGUAGE 'plpython3u'
