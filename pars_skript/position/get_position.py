import json


with open('export .geojson') as json_file:
    data = json.load(json_file)
    count = 0
    for dct in data['features']:
        count += 1
        try:
            if 'Бел' in dct['properties']['addr:street']:
                print(count,dct['properties']["addr:street"], dct['properties']['addr:housenumber'])
        except:
            continue

            
