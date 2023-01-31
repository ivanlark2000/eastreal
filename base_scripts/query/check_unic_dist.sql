-- Запрос на проыерку унискальных записей в таблице ps_dist_house_to_object

DO $$

DECLARE
    amount integer; -- общее количество записей в таблице
    amount_uniq integer; -- количество уникальных записей
    rez integer;

BEGIN

    SELECT COUNT(*) INTO amount 
    FROM ps_dist_house_to_object;

    WITH t (f_house, object_id)
    AS (
        SELECT  
            DISTINCT f_house, object_id
        FROM ps_dist_house_to_object
    )
    SELECT COUNT(*) INTO amount_uniq
    FROM  ps_dist_house_to_object;

    rez = amount - amount_uniq;

    IF rez = 0 THEN
        RAISE NOTICE 'В таблице все ровно';
    ELSE
        RAISE NOTICE 'В таблице есть баги, выявлено % лишних записей', rez;

    END IF;

END;

$$ LANGUAGE plpgsql 
