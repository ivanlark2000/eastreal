CREATE OR REPLACE FUNCTION public.format_street(
--CREATE DATE 2022-08-12
--функция которая упорядочивает значения в улицах

	street character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

    DECLARE
        value1 varchar(250)[] := STRING_TO_ARRAY(street, ' ');
		rez varchar(250);
		i varchar(30);

    BEGIN
		value1 = array_replace(value1, 'улица', 'ул.');
		value1 = array_replace(value1, 'бульвар', 'б-р.');
		WITH str (street_column)
		AS (
		SELECT UNNEST(value1)
		ORDER BY length(UNNEST(value1))
		)
		SELECT string_agg(ltrim(street_column), ' ') a
		FROM str

		INTO rez;

        RETURN rez;
    END;

$BODY$;

ALTER FUNCTION public.format_street(character varying)
    OWNER TO ivan;

