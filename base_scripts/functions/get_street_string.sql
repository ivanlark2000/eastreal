--функция для получения номера дома
CREATE OR REPLACE FUNCTION get_string_number_street(full_street varchar(250))
RETURNS varchar(200)
AS
$$
DECLARE
    street varchar(200);
    count smallint := 0;
    rez varchar := '';
BEGIN
    FOREACH street IN ARRAY string_to_array(full_street, ',')
    LOOP
        IF POSITION('оч.' IN street) > 0 OR POSITION('стр. ' IN street) > 0 OR
            POSITION('жилой дом' IN street) > 0 OR POSITION('этап' IN street) > 0 OR
            POSITION('жилые дома' IN street) > 0 OR POSITION('подъезд' IN street) > 0
            THEN
            street = '';
            END IF;
        IF length(street) > 1 THEN
            count = count + 1;
            IF count > 1 THEN
                rez = rez||street;
                END IF;
        END IF;
    END LOOP;

    IF SPLIT_PART(rez, 'к', 2) = '' THEN
            rez = SPLIT_PART(rez, 'к', 1);
    ELSE
        rez = SPLIT_PART(rez, 'к', 1)||' к'||SPLIT_PART(rez, 'к', 2);
    END IF;

    RETURN rez;
END;
$$ LANGUAGE plpgsql