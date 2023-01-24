--Процудура для загрузки данных по объектам с OpenStreetMap
--CREATE DATE 2023-23-01

CREATE OR REPLACE PROCEDURE load_object_from_osm(city_id smallint)
AS
$BODY$
DECLARE
    object record;    
    city_name varchar(150);

BEGIN
    
    SELECT c_name INTO city_name 
    FROM fs_city
    WHERE link = city_id;
    
    DELETE FROM ps_object_position 
    WHERE f_city = city_id;

    RAISE NOTICE 'Произвели очишение старых данных по городу %', city_name;

    FOR object IN 
           SELECT link, c_name, tags
            FROM fs_objects_type
            WHERE  load_dist = true
    LOOP
        PERFORM load_json_object(city_id, object.Link, 'ps_object_position');
        
        RAISE NOTICE 'Произвели загрузку данных тип объекта % город %', object.c_name, city_name;

    END LOOP;

    RAISE NOTICE 'Все обьекты успешно загружены';
        
END;
$BODY$
LANGUAGE plpgsql
