--Поцедура которая запускает задачи в таблице ts_dist_task
--CREATE DATE 2023.01.27

CREATE OR REPLACE PROCEDURE start_task_dist()
AS
$BODY$
DECLARE 
    proc record;    

BEGIN 
    FOR proc IN
        SELECT link, query 
        FROM ts_dist_task 
        WHERE f_status = 1
        ORDER BY d_date_add

    LOOP
        EXECUTE(proc.query);
        COMMIT;

        UPDATE ts_dist_task SET f_status = 2 WHERE link = proc.link;
        
        RAISE NOTICE 'Запрос №%I выполнен успешно', proc.link;

    END LOOP;
END;
$BODY$
LANGUAGE plpgsql;
