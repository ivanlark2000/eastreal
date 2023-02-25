-- DROP FUNCTION IF EXISTS public.del_whitespace_fs_street();
CREATE OR REPLACE FUNCTION public.del_whitespace_mn_house()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE 
	N_House integer;	

BEGIN
    	NEW.s_number := RTRIM(LTRIM(NEW.s_number));
	
	SELECT COUNT(*)
	INTO N_House
	FROM mn_house b
	WHERE 1=1  
		AND f_city = NEW.f_city
		AND calculation_position(NEW.lat, NEW.lon, b.lat, b.lon) < 200;
	
	NEW.N_Count_House = N_House;

	RETURN NEW;
END;
$BODY$;


CREATE OR REPLACE TRIGGER del_whitespace_mn_house
    BEFORE INSERT OR UPDATE
    ON public.mn_house
    FOR EACH ROW
    EXECUTE FUNCTION public.del_whitespace_mn_house();


--2023.01.30 добавили срабатывание задач по дистанции в триггер 
-- ALTER DATE 2023.02.14 Добавили расчет bus_station

CREATE OR REPLACE FUNCTION public.add_house_metrics()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
    house_id integer;
    weight numeric(4,2);

BEGIN
    WITH fact (distance)
    AS
    (
        SELECT calculation_position(NEW.lat, NEW.lon, f.latitude, f.longitude)
        FROM inf_factory f
        WHERE f_city = NEW.f_city
    )

    SELECT
        get_weight_factory(MIN(distance))
    INTO weight
    FROM fact;
	
    UPDATE mn_house_metrics
    SET w_factory = weight
    WHERE f_house = NEW.link;
	
    PERFORM add_task_distance(NEW.f_city, NEW.link, NEW.lat, NEW.lon);  
	PERFORM add_task_bus(NEW.f_city, NEW.link, NEW.lat, NEW.lon);
	
    RETURN NEW;

END;
$BODY$;


CREATE OR REPLACE TRIGGER add_house_metrics
    AFTER UPDATE
    ON public.mn_house
    FOR EACH ROW
    WHEN (NEW.lat IS NOT NULL AND NEW.lon IS NOT NULL)
    EXECUTE FUNCTION add_house_metrics();
