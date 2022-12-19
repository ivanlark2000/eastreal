import requests
import json
overpass_url = "http://overpass-api.de/api/interpreter"
overpass_query = """
[out:json];
area[name="Калининград"];
nwr[landuse=industrial](area);
out center;
"""
response = requests.get(overpass_url,
                        params={'data': overpass_query})

for i in response.json()['elements']:
    print(json.dumps(i))
    try:
        print(i['tags']['name'], i['tags']['operator'],)
    except:
        continue
    #print(i['id'], i['center']['lat'], i['center']['lon'])