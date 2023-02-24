ALTER TABLE fs_bus ADD COLUMN d_date_create timestamp;
ALTER TABLE ps_stop_bus ADD COLUMN d_date_create timestamp;

CREATE trigger add_create_data
BEFORE INSERT ON public.fs_bus
FOR EACH ROW EXECUTE FUNCTION add_create_date();

CREATE trigger add_create_data
BEFORE INSERT ON public.ps_stop_bus
FOR EACH ROW EXECUTE FUNCTION add_create_date();
