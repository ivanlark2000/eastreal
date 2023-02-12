------------------------------------------------------------------------
--Функция которая вернет вес по расстояниям по заданому объекту и квартире 
--CREATE DATE 2023.02.09
--2023.02.11 редактировали формулу 

CREATE OR REPLACE FUNCTION get_house_weigth(
    city_id smallint,
    flat_id integer,
    type_object_id smallint
)
RETURNS numeric(3,2)
AS 
$BODY$

DECLARE 
    weigth numeric(3,2);

BEGIN

    SELECT 
        50 * (0.5 / ( AVG(n_short_dist) / COUNT(*)))
    INTO weigth
    FROM ps_dist_house_to_object
    WHERE 1=1
        AND f_city = city_id 
        AND f_house = flat_id 
        AND f_type_object = type_object_id 
    GROUP BY f_house;

    IF weigth > 1 THEN 
        weigth = 1;
    END IF;

    RETURN weigth;

END;

$BODY$

LANGUAGE plpgsql
