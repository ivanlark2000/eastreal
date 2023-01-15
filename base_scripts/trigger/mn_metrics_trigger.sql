-- Триггер к таблце 'mn_metrics'
--CREATE DATE 2023-01-14 
-- 2023-01-15 Добавили общий вес по этажу

CREATE OR REPLACE FUNCTION tr_metrics()
RETURNS TRIGGER
AS
$BODY$
DECLARE
	value numeric(3,2);
	w_factory numeric(3,2);

BEGIN
	WITH fact (distance)
    	AS
    	(
        SELECT calculation_position(h.lat, h.lon, f.latitude, f.longitude)
        FROM inf_factory f, mn_house h
        WHERE h.link = NEW.f_house AND h.f_city = f.f_city  
    	)

    	SELECT
        	get_weight_factory(MIN(distance))
   	INTO w_factory
	FROM fact;
	
	NEW.factory = w_factory;

	SELECT AVG(air) INTO value
	FROM mn_metrics
	WHERE f_city = NEW.f_city;
	
	NEW.air = value;
	
	NEW.w_floor = get_floor_weight(NEW.f_flat);
	
	IF (NEW.w_floor IS NOT NULL AND NEW.air IS NOT NULL) THEN 
		NEW.air_floor = NEW.w_floor * NEW.air;
	END IF;
	
	IF NEW.factory IS NOT NULL THEN
		NEW.factory_floor = get_weight_factory_floor(NEW.f_flat, NEW.factory);
	END IF;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER mn_metrics_trigger
	BEFORE INSERT OR UPDATE ON mn_metrics
	FOR EACH ROW
	EXECUTE FUNCTION tr_metrics();
