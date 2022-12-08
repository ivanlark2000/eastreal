CREATE OR REPLACE FUNCTION cor_street(street varchar) RETURNS varchar(10)
    AS $$
    BEGIN
        CASE street
            WHEN 'улица' THEN street := 'ул.';
			ELSE
        END CASE;
        RETURN street;
    END;

$$
LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION format_street(street varchar) RETURNS varchar(100)
    AS $$
    DECLARE
        value1 array[] := STRING_TO_ARRAY(street, ' ');


    BEGIN
        CASE street
            WHEN 'улица' THEN street := 'ул.';
			ELSE
        END CASE;
        RETURN street;
    END;

$$
LANGUAGE plpgsql

SELECT
	SPLIT_PART(s_full_street, ',', 1),
	SPLIT_PART(s_full_street, ',', 2),
	SPLIT_PART(s_full_street, ',', 3),
	SPLIT_PART(SPLIT_PART(s_full_street, ',', 4),  'р-н', 1),
	SPLIT_PART(SPLIT_PART(s_full_street, ',', 4),  'р-н', 2)


FROM bf_temp_apartments_ads
WHERE SPLIT_PART(s_full_street, ',', 4) != ''
	AND SPLIT_PART(s_full_street, ',', 4) ~ '[0-9]'
	AND SPLIT_PART(s_full_street, ',', 2) ~ 'улица' = false