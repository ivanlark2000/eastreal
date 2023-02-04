-- Триггерa к таблице 'inf_sys'

--триггер на вычисление времени когда была проданна квартра 
--CREATE DATE 2023.02.04
CREATE OR REPLACE FUNCTION add_time_delta() 
RETURNS trigger 
AS 
$BODY$
BEGIN 
    NEW.d_date_sell = clock_timestamp();
    NEW.t_delta = NEW.d_date_sell - NEW.d_date;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER add_delta_time
        BEFORE UPDATE 
        ON public.inf_sys 
        FOR EACH ROW
        WHEN (NEW.f_sell_status = 2)
        EXECUTE FUNCTION add_time_delta();
