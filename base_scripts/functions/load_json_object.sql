CREATE OR REPLACE FUNCTION load_json_object(f_city integer, S_City varchar(150), f_object integer, request text)
RETURNS boolean
AS
$BODY$

import requests
import json
overpass_url = "http://overpass-api.de/api/interpreter"
overpass_query = """
[out:json];
area[name="Калининград"];
nwr[landuse=industrial](area);
out center;
"""
response = requests.get(overpass_url, params={'data': overpass_query})
j = response.json()
for i in j['elements']:
	i = json.dumps(i)
	plpy.notice(i)
	plpy.execute(f'''INSERT INTO mn_json_object (f_city, f_object, json) VALUES ({f_city}, {f_object}, '{i}'::jsonb)''')

return 1

END;
$BODY$ LANGUAGE 'plpython3u'
