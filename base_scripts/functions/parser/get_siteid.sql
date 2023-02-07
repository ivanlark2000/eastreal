-- Функция которая возвращает табличное значение акивных айдишников и цен
-- CREATE DATE 2023.02.07
DROP FUNCTION IF EXISTS get_siteid_price(smallint,smallint);
CREATE OR REPLACE FUNCTION get_siteid_price(
    city_id smallint,
    source_id smallint
)
RETURNS TABLE (
    site_id bigint,
    n_price integer,
    f_flat integer
)

AS
$BODY$
SELECT s.site_id, p.n_price::money::numeric, s.f_flat
FROM inf_sys s
    INNER JOIN (
        SELECT f_flat, n_price
        FROM mn_ads_price
        WHERE link IN (
            SElECT MAX(link)
            FROM mn_ads_price
            GROUP BY f_flat
        )
    ) p
        ON s.f_flat = p.f_flat
WHERE s.f_sell_status = 1 AND f_city = city_id AND f_source = source_id

UNION

SELECT site_id, NULL, NULL
FROM inf_miss_ads
WHERE f_sell_status = 1 AND f_city = city_id AND f_source = source_id

$BODY$
LANGUAGE SQl;
