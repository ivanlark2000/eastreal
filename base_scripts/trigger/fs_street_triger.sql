-- DROP FUNCTION IF EXISTS public.del_whitespace_fs_street();

CREATE OR REPLACE FUNCTION public.del_whitespace_fs_street()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    NEW.c_name := RTRIM(LTRIM(NEW.c_name));
RETURN NEW;
END;
$BODY$;

CREATE TRIGGER del_whitespace_fs_street
    BEFORE INSERT
    ON public.fs_street
    FOR EACH ROW
    EXECUTE FUNCTION public.del_whitespace_fs_street();