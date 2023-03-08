--Триггер к таблце 'mn_metrics_house'
--CREATE DATE 2023-02-09 
-- ALTER DATE 2023-03-07 добавили новые метрики по остановками и мершрутам

CREATE OR REPLACE FUNCTION public.tr_house_metrics()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
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
    NEW.w_dist_bas = get_house_weigth(NEW.f_city, NEW.f_house, '13');

    NEW.w_amount_ps = get_weight_amount(
        NEW.f_city, NEW.f_house, VARIADIC ARRAY[CAST(29 AS smallint), CAST(30 AS smallint)]
        );

    NEW.w_amount_sport = get_weight_amount(
        NEW.f_city, NEW.f_house, VARIADIC ARRAY[CAST(33 AS smallint)]
        );

    NEW.w_amount_prod = get_weight_amount(
        NEW.f_city, NEW.f_house, VARIADIC ARRAY[CAST(18 AS smallint)]
        );
	
	NEW.w_route_bus = get_weight_route_bus(NEW.f_house, NEW.f_city);
	
	RETURN NEW;

END;
$BODY$;
