--Триггер к таблце 'mn_metrics_house'
--CREATE DATE 2023-02-09 

CREATE OR REPLACE FUNCTION tr_house_metrics()
RETURNS TRIGGER
AS
$BODY$
DECLARE
	value numeric(3,2);
	w_fact numeric(3,2);
	temperature numeric(3,2);
    amount_ps smallint;
    amount_prod smallint;
    amount_sport smallint;

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
   	INTO w_fact
	FROM fact;
	
	NEW.w_factory = w_fact;

	SELECT weight INTO value
	FROM fs_index_pollution i
        INNER JOIN inf_air_pollution p
            ON i.link = p.f_index 
	WHERE p.f_city = NEW.f_city
    ORDER BY d_date
    LIMIT 1;
	
	NEW.w_air = value;
	
	SELECT weigth INTO temperature
	FROM inf_temperature
	WHERE f_city = NEW.f_city;

    NEW.w_temp = temperature;
    
    NEW.w_dist_park = get_house_weigth(NEW.f_city, NEW.f_house, '29');
    NEW.w_dist_kinder = get_house_weigth(NEW.f_city, NEW.f_house, '11');
    NEW.w_dist_entertime = get_house_weigth(NEW.f_city, NEW.f_house, '12');
    NEW.w_dist_fuel = get_house_weigth(NEW.f_city, NEW.f_house, '15');
    NEW.w_dist_market = get_house_weigth(NEW.f_city, NEW.f_house, '17');
    NEW.w_dist_garag = get_house_weigth(NEW.f_city, NEW.f_house, '21');
    NEW.w_dist_pipe = get_house_weigth(NEW.f_city, NEW.f_house, '22');
    NEW.w_dist_scool = get_house_weigth(NEW.f_city, NEW.f_house, '25');
    NEW.w_dist_mall = get_house_weigth(NEW.f_city, NEW.f_house, '17');
    NEW.w_dist_farmacy = get_house_weigth(NEW.f_city, NEW.f_house, '16');
    NEW.w_dist_sport = get_house_weigth(NEW.f_city, NEW.f_house, '33');
    
    SELECT COUNT(*) INTO amount_ps
    FROM ps_dist_house_to_object
    WHERE f_type_object IN (29, 30) AND f_house = NEW.f_house;

    IF amount_ps = 0 THEN 
        NEW.w_amount_ps = 0;
    ELSE
        NEW.w_amount_ps = (0.5 - ( 0.5 / amount_ps));
    END IF;

    SELECT COUNT(*) INTO amount_sport
    FROM ps_dist_house_to_object
    WHERE f_type_object = 33 AND f_house = NEW.f_house;

    IF amount_sport = 0 THEN 
        NEW.w_amount_sport = 0;
    ELSE
        NEW.w_amount_sport = (0.5 - ( 0.5 / amount_sport));
    END IF;

    SELECT COUNT(*) INTO amount_prod
    FROM ps_dist_house_to_object
    WHERE f_type_object = 18 AND f_house = NEW.f_house;

    IF amount_prod = 0 THEN 
        NEW.w_amount_prod = 0;
    ELSE
        NEW.w_amount_prod = (0.5 - ( 0.5 / amount_prod));
    END IF;

	RETURN NEW;

END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER mn_metrics_house_trigger
	BEFORE INSERT OR UPDATE ON mn_house_metrics
	FOR EACH ROW
	EXECUTE FUNCTION tr_house_metrics();
