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
	FROM mn_json_biulding b
	WHERE 1=1  
		AND f_city = NEW.f_city
		AND update_openstreet_objects(NEW.lat, NEW.lon, b.latitude, b.longitude) < 200;
	
	NEW.N_Count_House = N_House;

	RETURN NEW;
END;
$BODY$;


CREATE OR REPLACE TRIGGER del_whitespace_mn_house
    BEFORE INSERT
    ON public.mn_house
    FOR EACH ROW
    EXECUTE FUNCTION public.del_whitespace_mn_house();

---
CREATE OR REPLACE FUNCTION public.add_house_metrics()
RETURNS TRIGGER
AS
$BODY$
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
	
    UPDATE mn_metrics
    SET factory = weight
    WHERE f_house = NEW.link;
	
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER add_house_metrics
    AFTER UPDATE
    ON public.mn_house
    FOR EACH ROW
    WHEN (NEW.lat IS NOT NULL AND NEW.lon IS NOT NULL)
    EXECUTE FUNCTION add_house_metrics();