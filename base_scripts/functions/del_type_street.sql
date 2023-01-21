--   функция которая удаляет тип улицы
CREATE OR REPLACE FUNCTION del_type_street(street varchar(250))
RETURNS varchar(200)
AS $$
DECLARE
    type RECORD;
    s_street varchar(200);
BEGIN
    FOR type IN
        SELECT
            link   AS id,
            c_name AS name,
            short_name AS s_name
        FROM fs_street_type
    LOOP
        IF POSITION(type.name IN street) > 0 THEN
            s_street = replace(street, type.name, '');
            RETURN s_street;

        ELSEIF POSITION(type.s_name IN street) > 0 THEN
            s_street = replace(street, type.s_name, '');
            RETURN s_street;
        END IF;
    END LOOP;
    RETURN street;
END;
$$ LANGUAGE plpgsql