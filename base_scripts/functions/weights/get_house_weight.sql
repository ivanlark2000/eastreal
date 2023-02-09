------------------------------------------------------------------------
--Функция которая вернет вес по ростояниям по заданому объекту и квартире 
--CREATE DATE 2023.02.09

CREATE OR REPLACE FUNCTION get_house_weight(
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
        AVG(0.5/200*n_foot_dist)
    INTO weigth
    FROM ps_dist_house_to_object
    WHERE 1=1
        AND f_city = city_id 
        AND f_house = flat_id 
        AND f_type_object = type_object_id 
    GROUP BY f_house;

    RETURN weigth;

END;

$BODY$

LANGUAGE plpgsql
