--функция для получения веса этажности
--CREATE DATE 2023.01.15

CREATE OR REPLACE FUNCTION get_floor_weight(flat_id integer)
RETURNS numeric(3,2)
AS
$BODY$
DECLARE 
	floor smallint;
BEGIN 
	SELECT fl.c_name 
	INTO floor
	FROM fs_floor fl, mn_apartments_ads ads
	WHERE ads.link = flat_id AND fl.link = ads.f_floor;

	CASE 
		WHEN floor = 1 THEN 
			RETURN 1.00;
		WHEN floor in (2, 3) THEN 
			RETURN 0.90;
		WHEN floor in (4, 5) THEN
			RETURN 0.80;
		WHEN (floor >= 6 AND floor <= 12) THEN 
			RETURN 0.5;
		ELSE 
			RETURN 0.25;
		END CASE;
END;
$BODY$
LANGUAGE plpgsql
