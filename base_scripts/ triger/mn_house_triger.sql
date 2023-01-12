-- DROP FUNCTION IF EXISTS public.del_whitespace_fs_street();

CREATE OR REPLACE FUNCTION public.del_whitespace_mn_house()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    NEW.s_number := RTRIM(LTRIM(NEW.s_number));
RETURN NEW;
END;
$BODY$;

CREATE TRIGGER del_whitespace_mn_house
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

    SELECT f_house INTO house_id
    FROM mn_house_metrics
    WHERE f_house = NEW.link;

    IF house_id IS NULL THEN
        INSERT INTO mn_house_metrics (f_house)
        VALUES (NEW.link);
    END IF;

    UPDATE mn_house_metrics
    SET factory = weight
    WHERE f_house = NEW.link;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql

CREATE TRIGGER add_house_metrics
    AFTER UPDATE
    ON public.mn_house
    FOR EACH ROW
    WHEN (NEW.lat IS NOT NULL AND NEW.lon IS NOT NULL)
    EXECUTE FUNCTION add_house_metrics();