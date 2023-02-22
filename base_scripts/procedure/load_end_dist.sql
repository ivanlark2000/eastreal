--Процедура которая загружает всю дистанцию в БД
--CREATE DATE 2023.01.27
-- ALTER DATE 2023.02.21 Изменили тип id objecta на строку  
CREATE OR REPLACE PROCEDURE public.load_end_dist(
	IN city_id integer,
	IN house_id integer,
	IN object_id character varying,
	IN id_type_object smallint,
	IN lat1 numeric,
	IN lon1 numeric,
	IN lat2 numeric,
	IN lon2 numeric)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    short_dist integer:= calculation_position(lat1, lon1, lat2, lon2);
    foot_dist integer:= get_foot_distance(lat1, lon1, lat2, lon2);
    car_dist integer;

BEGIN 
    PERFORM pg_sleep(1);

    car_dist = get_car_distance(lat1, lon1, lat2, lon2);

    PERFORM pg_sleep(1);
    
    INSERT INTO ps_dist_house_to_object (f_city, f_house, object_id, f_type_object, n_short_dist, n_car_dist, n_foot_dist)
    VALUES (city_id, house_id, object_id, id_type_object, short_dist, car_dist, foot_dist);
    
    RAISE NOTICE 'Данные по дисатнции от дома №% до обьекта №% успешно загружены', house_id, object_id;
    
END;
$BODY$;
ALTER PROCEDURE public.load_end_dist(integer, integer, character varying, smallint, numeric, numeric, numeric, numeric)
    OWNER TO lark;
