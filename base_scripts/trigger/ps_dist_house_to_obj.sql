--Тригер к таблице растояний Табл "ps_dist_house_to_object"
--CREATE DATE 2023.01.27

CREATE OR REPLACE FUNCTION add_time_add_dist()
RETURNS trigger
AS 
$BODY$
BEGIN
    NEW.d_date_add:= NOW();
    RETURN NEW;

END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER add_time_add
    BEFORE INSERT ON ps_dist_house_to_object
    FOR EACH ROW 
    EXECUTE PROCEDURE add_time_add_dist();
