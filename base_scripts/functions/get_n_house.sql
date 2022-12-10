CREATE OR REPLACE FUNCTION get_n_street(street varchar(250)) RETURNS varchar(20)
--функция в которой получаем с улицы номер дома 
--CREATE DATE 10.12.2022
AS
$BODY$
	DECLARE
	      	total text array := string_to_array(street, NULL);
		i varchar(1);
		n_house varchar(10);
	
	BEGIN
	       	foreach i in array total
		LOOP
			IF i ~ '^[0-9]' = true
			THEN EXIT;
			END IF;
																																			
		END LOOP;
		IF i ~ '^[0-9]' = false
			THEN n_house = LTRIM(REVERSE(SPLIT_PART(REVERSE(street), ',', 1)));
		ELSE n_house = SUBSTRING(street, position(i in street), 10);
		END IF;
	RETURN n_house;
	END;	
$BODY$
LANGUAGE plpgsql;
