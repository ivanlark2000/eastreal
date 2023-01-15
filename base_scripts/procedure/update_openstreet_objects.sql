--процудура для обновления данных с openstreetmap
--CREATE DATE 2023.01.15
CREATE OR REPLACE PROCEDURE update_openstreet_objects(city_id integer)
AS 
$BODY$
BEGIN 
	PERFORM load_json_object(city_id, 28, 'mn_json_building');

END;
$BODY$
LANGUAGE plpgsql
