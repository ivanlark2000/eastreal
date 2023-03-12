------------------------------------------------------------------------
--Функция которая вернет вес по расстояниям по заданому объекту и квартире 
--CREATE DATE 2023.02.09
--2023.02.11 редактировали формулу 
--2023.03.12 редактировали формклу 

CREATE OR REPLACE FUNCTION get_house_weigth(
    city_id smallint,
    flat_id integer,
    type_object_id smallint
)
RETURNS numeric
AS 
$BODY$

DECLARE 
    weigth numeric;

BEGIN

    SELECT 
        --50 * (0.5 / ( AVG(n_short_dist) / COUNT(*)))
		(0.5 - 0.5 / COUNT(n_foot_dist)) + 50 * (0.5 / (SUM(n_foot_dist) / COUNT(n_foot_dist)))
    INTO weigth
    FROM ps_dist_house_to_object
    WHERE 1=1
        AND f_city = city_id 
        AND f_house = flat_id 
        AND f_type_object = type_object_id
		AND n_foot_dist < 1000
    GROUP BY f_house;

    IF weigth > 1 THEN
        weigth = 1;
    END IF;

    RETURN weigth;

END;

$BODY$

LANGUAGE plpgsql
