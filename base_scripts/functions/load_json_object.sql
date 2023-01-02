--DROP FUNCTION load_json_object(f_city integer, city varchar(150), f_object integer, tags text[])
CREATE OR REPLACE FUNCTION load_json_object(f_city integer, city varchar(150), f_object integer, tags text[])
RETURNS boolean
AS
$BODY$

import requests
import json

overpass_url = "http://overpass-api.de/api/interpreter"

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
            plpy.execute(f'''INSERT INTO mn_json_object (f_city, f_object, json)
                        VALUES ({f_city}, {f_object}, '{i}'::jsonb)''')
        except:
            continue

return 1

END;
$BODY$ LANGUAGE 'plpython3u'
