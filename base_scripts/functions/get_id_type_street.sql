--   функция которая принимает улицу и возвращает айдишник типа улицы
CREATE OR REPLACE FUNCTION get_id_type_street(street varchar(250))
RETURNS smallint
AS $$
DECLARE
    type RECORD;
BEGIN

    FOR type IN
        SELECT
            link   AS id,
            c_name AS name,
            short_name AS s_name
        FROM fs_street_type
    LOOP
        IF POSITION(type.name in street) > 0 OR POSITION(type.s_name in street) > 0 THEN
            RETURN type.id;
        END IF;
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql