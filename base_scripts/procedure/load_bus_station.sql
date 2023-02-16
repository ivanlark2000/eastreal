-- Процедура по загрузке автобусов и маршрутов к ним 
-- CREATE DATE 2023.02.15
CREATE OR REPLACE PROCEDURE load_bus_station(
    city_id smallint,
    name_station varchar(150),
    b_lat numeric,
    b_lon numeric,
    VARIADIC route varchar[]
)
AS
$BODY$
DECLARE
    bus_id integer;
	stop_id integer;
	i varchar(150);                       --элемент цикла
	type_bus_id smallint;
    name_type_bus varchar(100);
    name_bus varchar(100);

BEGIN
    SELECT link INTO stop_id
    FROM ps_stop_bus
    WHERE 1=1
        AND f_city = city_id
        AND c_name = name_station;

    IF stop_id IS NOT NULL THEN
        RETURN;
    END IF;

    INSERT INTO ps_stop_bus (f_city, c_name, lat, lon)
    VALUES (city_id, name_station, b_lat, b_lon)
    RETURNING link INTO stop_id;

    FOREACH  i IN ARRAY $5
        LOOP
            name_bus := split_part(i, ' ', 2);
            name_type_bus:= split_part(i, ' ', 1);

            SELECT LINK INTO type_bus_id
            FROM  fs_type_bus
			WHERE c_name = name_type_bus;

            IF type_bus_id IS NULL THEN
                INSERT INTO fs_type_bus (c_name)
                VALUES (name_type_bus)
                RETURNING link INTO type_bus_id;

            END IF;

            SELECT link
            INTO bus_id
            FROM fs_bus
            WHERE f_city = city_id AND c_name = name_bus;

            IF bus_id is NULL THEN
                INSERT INTO fs_bus (f_city, f_type_bus, c_name)
                VALUES (city_id, type_bus_id, name_bus)
                RETURNING link INTO bus_id;
            END IF;
			
			INSERT INTO ref_stop_and_bus (f_stop, f_bus)
			VALUES (stop_id, bus_id);

        END LOOP;
END;
$BODY$
LANGUAGE plpgsql;

COMMENT ON PROCEDURE load_bus_station IS 'Процедура для загрузки остановок и маршрутов';
