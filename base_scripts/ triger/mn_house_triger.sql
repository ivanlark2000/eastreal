-- DROP FUNCTION IF EXISTS public.del_whitespace_fs_street();

CREATE OR REPLACE FUNCTION public.del_whitespace_mn_house()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    NEW.s_number := RTRIM(LTRIM(NEW.s_number));
RETURN NEW;
END;
$BODY$;

CREATE TRIGGER del_whitespace_mn_house
    BEFORE INSERT
    ON public.mn_house
    FOR EACH ROW
    EXECUTE FUNCTION public.del_whitespace_mn_house();
