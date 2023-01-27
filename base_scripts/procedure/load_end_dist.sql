--Поцедура которая загружает всю дистанцию в БД
--CREATE DATE 2023.01.27

CREATE OR REPLACE PROCEDURE load_end_dist(
    city_id integer,
    house_id integer,
    object_id integer,
    id_type_object smallint,
    lat1 numeric,
    lon1 numeric,
    lat2 numeric,
    lon2 numeric
)
AS
$BODY$
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
$BODY$
LANGUAGE plpgsql;
