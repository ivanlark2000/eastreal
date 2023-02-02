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
        (AVG(1000 - n_short_dist)) / 1000 as w_short
        ,(AVG(1000 - n_foot_dist)) / 1000 as w_foot
    INTO value
    FROM ps_dist_house_to_object 
    WHERE f_house = NEW.f_house
    GROUP BY f_type_object;
    
    IF (value.w_short IS NULL OR value.w_short < 0) THEN 
        value.w_short = 0;
    END IF;

    IF (value.w_foot IS NULL OR value.w_foot < 0) THEN
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

--Триггер который подсчитыает вес по количесву парков и скверов
--CREATE DATE 2023.01.31
CREATE OR REPLACE FUNCTION count_object()
RETURNS trigger 
AS 
$BODY$
DECLARE 
    amount integer;       --количество пакров и скверов
    weight numeric(3,2);  -- вес
    col_name varchar(100);

BEGIN

    CASE NEW.f_type_object

        WHEN 33 THEN 
            SELECT COUNT(*) INTO amount
            FROM ps_dist_house_to_object
            WHERE f_type_object = 33 AND f_house = NEW.f_house;
            
            col_name = 'amount_sport';
           
        WHEN 18 THEN 
            SELECT COUNT(*) INTO amount
            FROM ps_dist_house_to_object
            WHERE f_type_object = 18 AND f_house = NEW.f_house;
            
            col_name = 'amount_prod';

        WHEN 29, 30 THEN 
            SELECT COUNT(*) INTO amount
            FROM ps_dist_house_to_object
            WHERE f_type_object IN (29, 30) AND f_house = NEW.f_house;
          
            col_name = 'amount_ps';
            
    END CASE;
    
        weight = 0.5 - ( 0.5 / amount);

    EXECUTE format('update mn_metrics set %s = $1 where f_house = $2;', col_name)
            USING weight, new.f_house;

    RETURN NEW;

    EXCEPTION 
        WHEN division_by_zero THEN 
            RAISE NOTICE 'Перехватли ошибку division_by_zero';

    EXECUTE format('update mn_metrics set %s = 0 where f_house = $1;', col_name)
            USING new.f_house;

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER count_object
    BEFORE INSERT OR UPDATE 
    ON ps_dist_house_to_object
    FOR EACH ROW 
    WHEN (NEW.f_type_object IN (18, 29, 30, 33))
    EXECUTE FUNCTION count_object();
