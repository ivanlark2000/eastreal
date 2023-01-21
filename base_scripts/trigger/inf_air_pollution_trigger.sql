CREATE OR REPLACE FUNCTION public.air_pollution()
RETURNS trigger 
AS 
$BODY$
DECLARE 
	value numeric(3,2);
BEGIN
	SELECT weight INTO value
	FROM fs_index_pollution
	WHERE link = NEW.f_index;

	UPDATE mn_metrics
	SET air = value
	WHERE f_city = NEW.f_city;
	
	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER inf_air_pollution
	AFTER INSERT OR UPDATE 
	ON public.inf_air_pollution
	FOR EACH ROW 
	EXECUTE FUNCTION air_pollution();
