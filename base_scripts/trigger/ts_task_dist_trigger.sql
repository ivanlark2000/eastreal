--Триггер к таблице с запланированым заданиям по дистанции ts_dist_task
--CREATE DATE 2023.01.26

CREATE OR REPLACE FUNCTION task_dist_time()
RETURNS trigger 
AS
$BODY$
BEGIN
    NEW.d_date_add = NOW();

    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER task_add_time_add
    BEFORE INSERT ON ts_dist_task
    FOR EACH ROW
    EXECUTE PROCEDURE task_dist_time();

CREATE OR REPLACE FUNCTION task_dist_compl()
RETURNS trigger 
AS
$BODY$

BEGIN 
    NEW.d_date_compl = NOW();
    RETURN NEW;
END;

$BODY$
LANGUAGE plpgsql;


CREATE  OR REPLACE TRIGGER task_dist_compl
    BEFORE UPDATE ON ts_dist_task
    FOR EACH ROW
    WHEN (NEW.f_status = 2)
    EXECUTE PROCEDURE task_dist_compl();
