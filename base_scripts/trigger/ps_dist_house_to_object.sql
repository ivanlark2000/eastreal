--Тригер в таблице конеxныx растояний "ps_dist_hoouse_to_object"
--CREATE DATE 2023.01.29

CREATE OR REPLACE FUNCTION count_weight_dist()
RETURNS trigger
AS
$BODY$
DECLARE
    value record;
    c_name varchar(100);
    result varchar(100);
    query varchar(500);
    avg_weight numeric(3,2);

BEGIN
    SELECT 
        AVG((1000 - n_short_dist)/1000000) as w_short
        ,AVG((1000 - n_foot_dist)/1000000) as w_foot
    INTO value
    FROM ps_dist_house_to_object 
    WHERE f_house = NEW.f_house
    GROUP BY f_type_object;
    
    IF value.w_foot < 0 THEN
        value.w_foot = 0;
    END IF;

    avg_weight = (value.w_short + value.w_foot) / 2;

    SELECT col_name INTO c_name 
    FROM fs_objects_type
    WHERE link = NEW.f_type_object;
    
    IF c_name IS NULL THEN 
        RETURN NEW;
    END IF;

    SELECT column_name INTO result 
    FROM information_schema.columns
    WHERE column_name = c_name AND table_name = 'mn_metrics';

    IF result IS NULL THEN
        EXECUTE format('ALTER TABLE mn_metrics ADD COLUMN %s numeric(3,2)', c_name);
    END IF;
    
    SELECT format('UPDATE mn_metrics SET %s = %s WHERE f_house = %s', c_name, avg_weight, NEW.f_house) INTO query;
    EXECUTE query;

    RETURN NEW;

END;

$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER count_dist
    BEFORE INSERT OR UPDATE 
    ON ps_dist_house_to_object
    FOR EACH ROW
    EXECUTE FUNCTION count_weight_dist();
