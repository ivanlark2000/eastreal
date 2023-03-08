-- функция для расчета веса от количество объектов которые в районе 1000 км
-- CREATE DATE 2023.03.07

CREATE OR REPLACE FUNCTION get_weight_amount(
    city_id integer,
    house_id integer,	
    VARIADIC type_object smallint[]
)
RETURNS numeric(3,2)
AS $BODY$
DECLARE
    amount smallint;

BEGIN
    SELECT COUNT(*)
    INTO amount
    FROM ps_dist_house_to_object
    WHERE 1=1
        AND f_type_object = ANY($3)
        AND f_house = house_id
        AND f_city = city_id;

    IF amount = 0 THEN
        RETURN  0;
    ELSE
        RETURN (0.5 - ( 0.5 / amount));
    END IF;

END;
$BODY$ LANGUAGE 'plpgsql';

COMMENT ON FUNCTION get_weight_amount IS 'Расчет веса от количетсва обьектов в радиусе 1000 км';
