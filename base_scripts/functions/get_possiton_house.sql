CREATE OR REPLACE FUNCTION get_position_house(city varchar(150), street varchar(200), n_house varchar(30))
RETURNS varchar[]
AS
$BODY$

from dadata import Dadata

LST_KEY = ('postal_code', 'city_district_with_type', 'city_district_type_full', 'city_district', 'street_fias_id',
    'street_type', 'street_type_full', 'street', 'house_fias_id', 'house_type', 'house_type_full', 'geo_lat', 'geo_lon')

lst_rez = []

token = "7d7733cbeba5c329d4917d96f5e11b9c83254182"
secret = "14a01cfb738a67787f176342817c8c6aabbeda77"

dadata = Dadata(token, secret)
result = dadata.clean("address", f"{city} {street} {n_house}")

for i in result:
    for key in LST_KEY:
        if i == key:
            lst_rez.append(result[i])
            break

return lst_rez

$BODY$
LANGUAGE plpython3u;