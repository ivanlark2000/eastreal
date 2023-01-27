-- функция для расчета расстояния между двумя точками на плоскости
-- DROP FUNCTION calculation_position(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric)
CREATE OR REPLACE FUNCTION calculation_position(lat1 numeric, lon1 numeric, lat2 numeric, lon2 numeric)
RETURNS numeric
AS
$BODY$
DECLARE
    fi1 numeric := lat1 * pi() / 180;
    fi2 numeric := lat2 * pi() / 180;
    lam1 numeric := lon1 * pi() / 180;
    lam2 numeric := lon2 * pi() / 180;
    part1 numeric;

BEGIN

    part1 = sqrt(sin((fi1-fi2)/2)^2 + cos(fi1) * cos(fi2) * sin((lam2 - lam1)/2)^2);
    RETURN 2 * asin(part1) * 6372795;
END;
$BODY$
LANGUAGE plpgsql
