-------------------------------------------------------------------
--Функция которая обновляет статусы в историчность в БД
--CREATE DATE 2023.02.08 
--ALTER DATE 2023.02.04 добавли логировавние сессий которые изменяют данные 

CREATE OR REPLACE FUNCTION update_sell_status(
    g_sess uuid,
    city_id smallint,
    VARIADIC sitids bigint[]
)
RETURNS void 
AS
$BODY$

UPDATE inf_sys 
SET f_sell_status = 2, g_sess_modif = g_sess
WHERE f_city = city_id AND f_sell_status = 1 AND site_id NOT IN (
    SELECT * FROM unnest($3)
);

UPDATE inf_miss_ads
SET f_sell_status = 2, g_sess_modif = g_sess
WHERE f_city = city_id AND site_id NOT IN (
    SELECT * FROM unnest($3)
);

$BODY$
LANGUAGE SQL;

