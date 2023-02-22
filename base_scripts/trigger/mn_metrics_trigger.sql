--Триггер к таблице 'mn_metrics'
--CREATE DATE 2023-01-14 
-- 2023-01-15 Добавили общий вес по этажу
-- 2023-01-17 Добавили вес по температуре
-- 2023-02-01 Добавили веса по количеству парков скверов продуктовых магазинов и спортивных обьектов 
--ALTER DATE 2023.02.22 изменили привязку от дома к таблице 'mn_house_metrics'

CREATE OR REPLACE FUNCTION public.tr_metrics()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS
$BODY$
DECLARE
	house_metr record;

BEGIN
    SELECT *
    INTO house_metr
    FROM mn_house_metrics
    WHERE 1=1
        AND f_city = NEW.f_city
        AND f_house = NEW.f_house;

	NEW.w_floor = get_floor_weight(NEW.f_flat);

	IF (NEW.w_floor IS NOT NULL AND house_metr.w_air IS NOT NULL) THEN
		NEW.w_air_floor = NEW.w_floor * house_metr.w_air;
	END IF;

	IF house_metr.w_factory IS NOT NULL THEN
		NEW.w_factory_floor = get_weight_factory_floor(NEW.f_flat, house_metr.w_factory);
	END IF;

	RETURN NEW;

END;
$BODY$;

CREATE OR REPLACE TRIGGER mn_metrics_trigger
	BEFORE INSERT OR UPDATE ON mn_metrics
	FOR EACH ROW
	EXECUTE FUNCTION tr_metrics();
