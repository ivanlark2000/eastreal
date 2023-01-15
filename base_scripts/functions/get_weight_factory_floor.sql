--функция которая расчитывает вес в зависимости от этажа и загрезнения производствт 
--CREATE DATE 2023.01.15
CREATE OR REPLACE FUNCTION get_weight_factory_floor(flat_id integer, weight_total numeric(3,2))
RETURNS numeric(3,2)
AS 
$BODY$
DECLARE 
	n_floor smallint;
BEGIN
	SELECT f.c_name
	INTO n_floor
	FROM fs_floor f, mn_apartments_ads ad
	WHERE ad.f_floor = f.link;

	CASE 
		WHEN (n_floor = 1 OR (n_floor >= 6 AND n_floor <= 12)) THEN 
			RETURN weight_total * 0.9;
		WHEN (n_floor >= 2 AND n_floor <= 5) THEN 
			RETURN weight_total * 1;
		ELSE
			RETURN weight_total * 5;
	END CASE;
END;
$BODY$
LANGUAGE plpgsql
