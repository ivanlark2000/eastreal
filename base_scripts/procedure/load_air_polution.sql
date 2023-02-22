-- Процедура для загрузки данных с сайта по загрязнению воздуха
-- CREATE DATE 2023.02.22 

CREATE OR REPLACE PROCEDURE load_air_polution(
    city_id integer
)
AS
$BODY$
BEGIN
    INSERT INTO inf_air_pollution (f_city, json)
    SELECT
        link
        ,get_json_air_polution(lat::numeric, lon::numeric)::json
    FROM fs_city
    WHERE link = city_id;

END;
$BODY$
LANGUAGE 'plpgsql'

