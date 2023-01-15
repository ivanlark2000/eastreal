CREATE OR REPLACE FUNCTION tr_metrics()
RETURNS TRIGGER
AS
$BODY$
DECLARE
	value numeric(3,2);

BEGIN
	SELECT AVG(air) INTO value
	FROM mn_metrics
	WHERE f_city = NEW.f_city;

	NEW.air = value;

	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER mn_metrics_trigger
	BEFORE INSERT ON mn_metrics
	FOR EACH ROW
	EXECUTE FUNCTION tr_metrics();
