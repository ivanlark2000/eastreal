-------------------------------------------------------------------
--Функция которая обновляет статусы в историчность в БД
--CREATE DATE 2023.02.08 

CREATE OR REPLACE FUNCTION update_sell_status(
    city_id smallint,
    VARIADIC sitids bigint[]
)
RETURNS void 
AS
$BODY$

UPDATE inf_sys 
SET f_sell_status = 2
WHERE f_city = city_id AND f_sell_status = 1 AND site_id NOT IN (
    SELECT * FROM unnest($2)
);

UPDATE inf_miss_ads
SET f_sell_status = 2
WHERE f_city = city_id AND site_id NOT IN (
    SELECT * FROM unnest($2)
);

$BODY$
LANGUAGE SQL;

