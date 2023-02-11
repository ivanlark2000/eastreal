--Тригер в таблице конеxныx растояний "ps_dist_hoouse_to_object"
--CREATE DATE 2023.01.29
--ALTER DATE 2023.02.11 переписали функцию weight_dist по таблицу mn_house_metrics

CREATE OR REPLACE FUNCTION weigth_dist()
RETURNS trigger
AS
$BODY$
DECLARE
    weigth numeric(3,2);
    weigth_ps numeric(3,2);
    c_col_name varchar(100); -- перменная с названием колонки в таблице метрик 

BEGIN

    IF NEW.f_type_object IN (29, 30) THEN 
        weigth_ps = (get_house_weigth(NEW.f_city, NEW.f_house, '29') + get_house_weigth(NEW.f_city, NEW.f_house, '30')) / 2;
        
        UPDATE mn_house_metrics
        SET w_dist_ps = weigth_ps
        WHERE f_house = NEW.f_house;
        
    END IF;

    IF NEW.f_type_object IN (
        SELECT link 
        FROM fs_objects_type
        WHERE col_name IS NOT NULL
        ) THEN 
            weigth:= get_house_weigth(NEW.f_city, NEW.f_house, NEW.f_type_object);
            
        SELECT col_name INTO c_col_name 
        FROM fs_objects_type
        WHERE link = NEW.f_type_object;

        EXECUTE 
        'UPDATE mn_house_metrics SET '||c_col_name||' = $1 WHERE f_house = $2;'
        USING weigth, NEW.f_house;

    END IF;

    RETURN NEW;

END;

$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER w_dist_to_house_metrics
    BEFORE INSERT OR UPDATE 
    ON ps_dist_house_to_object
    FOR EACH ROW
    EXECUTE FUNCTION weigth_dist();



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
            
            col_name = 'w_amount_sport';
           
        WHEN 18 THEN 
            SELECT COUNT(*) INTO amount
            FROM ps_dist_house_to_object
            WHERE f_type_object = 18 AND f_house = NEW.f_house;
            
            col_name = 'w_amount_prod';

        WHEN 29, 30 THEN 
            SELECT COUNT(*) INTO amount
            FROM ps_dist_house_to_object
            WHERE f_type_object IN (29, 30) AND f_house = NEW.f_house;
          
            col_name = 'w_amount_ps';
            
    END CASE;
    
        weight = 0.5 - ( 0.5 / amount);

    EXECUTE format('update mn_house_metrics set %s = $1 where f_house = $2;', col_name)
            USING weight, new.f_house;

    RETURN NEW;

    EXCEPTION 
        WHEN division_by_zero THEN 
            RAISE NOTICE 'Перехватли ошибку division_by_zero';

    EXECUTE format('update mn_house_metrics set %s = 0 where f_house = $1;', col_name)
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
