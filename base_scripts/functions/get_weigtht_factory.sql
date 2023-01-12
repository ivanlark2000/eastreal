--функция для расчета веса близости производств и котельных
CREATE OR REPLACE FUNCTION get_weight_factory(distance integer, OUT weight numeric)
AS
$BODY$

BEGIN
    CASE
        WHEN distance BETWEEN 0 AND 20 THEN
            weight := 0.7;
        WHEN distance BETWEEN 21 AND 100 THEN
            weight := 0.5;
        WHEN distance BETWEEN 100 AND 299 THEN
            weight := 0.25;
        WHEN distance BETWEEN 300 AND 499 THEN
            weight := 0.10;
        WHEN distance BETWEEN 500 AND 699 THEN
            weight := 0.05;
        WHEN distance BETWEEN 700 AND 999 THEN
            weight := 0.03;
        ELSE
            weight := 0;
    END CASE;
END;
$BODY$
LANGUAGE plpgsql