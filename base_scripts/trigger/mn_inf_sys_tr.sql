-- Триггерa к таблице 'inf_sys'

--триггер на вычисление времени когда была продана квартира 
--CREATE DATE 2023.02.04
    -- 2023.02.22 добавили изменение флага активности в таблице метрик 

CREATE OR REPLACE FUNCTION public.add_time_delta()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN 

    CASE NEW.f_sell_status
	
    WHEN 1 THEN 
        NEW.d_date_sell = NULL;
        NEW.t_delta = NULL;
		
		UPDATE mn_metrics
		SET b_active = true
		WHERE f_flat = NEW.f_flat;
		
    WHEN 2 THEN
        NEW.d_date_sell = clock_timestamp();
        NEW.t_delta = NEW.d_date_sell - NEW.d_date_create;
		
		UPDATE mn_metrics
		SET b_active = false
		WHERE f_flat = NEW.f_flat;
		
    END CASE;

    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.add_time_delta()
    OWNER TO lark;

CREATE OR REPLACE TRIGGER add_delta_time
        BEFORE UPDATE 
        ON public.inf_sys 
        FOR EACH ROW
        EXECUTE FUNCTION add_time_delta();
