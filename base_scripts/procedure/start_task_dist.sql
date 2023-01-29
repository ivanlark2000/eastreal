--Поцедура которая в таблице ts_dist_task
--CREATE DATE 2023.01.27

CREATE OR REPLACE PROCEDURE start_task_dist()
AS
$BODY$
DECLARE 
    proc record;    
    active_proc integer;

BEGIN

    SELECT COUNT(pid) INTO active_proc
    FROM pg_stat_activity
    WHERE state = 'active' AND query = 'CALL start_task_dist();';

    IF active_proc < 2 THEN 
        FOR proc IN
            SELECT link, query 
            FROM ts_dist_task 
            WHERE f_status = 1
            ORDER BY d_date_add

        LOOP
            EXECUTE(proc.query);

            UPDATE ts_dist_task SET f_status = 2 WHERE link = proc.link;
        
            RAISE NOTICE 'Запрос №%I выполнен успешно', proc.link;
            
            COMMIT;
            
        END LOOP;
    ELSE 
        RAISE NOTICE 'В БД данный запрос уже активирован';
        END IF;

END;
$BODY$
LANGUAGE plpgsql;
