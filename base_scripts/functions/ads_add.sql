CREATE OR REPLACE FUNCTION Add_Buff_Value() RETURNS trigger AS $ads_add$

BEGIN

	IF NEW.D_Date IS NULL
		THEN NEW.D_Date  := current_timestamp;
	END IF;

	IF NEW.B_Balcony IS NULL
		THEN NEW.B_Balcony = False;
	END IF;

	IF NEW.B_loggia IS NULL
		THEN NEW.B_Loggia = False;
	END IF;

	IF NEW.B_Heating IS NULL
		THEN NEW.B_Heating = False;
	END IF;

	IF NEW.B_Passenger_Elevator IS NULL
		THEN NEW.B_Passenger_Elevator = False;
	END IF;

	IF NEW.B_Freight_elevator IS NULL
		THEN NEW.B_Freight_elevator = False;
	END IF;

	RETURN NEW;

END;

$ads_add$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION Add_Date() RETURNS trigger AS $ads_date$

BEGIN

	IF NEW.D_Date IS NULL
		THEN NEW.D_Date  := current_timestamp;
	END IF;

	RETURN NEW;

END;

$ads_date$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION public.add_create_date()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

BEGIN

	IF NEW.D_Date_Create IS NULL
		THEN NEW.D_Date_Create  := current_timestamp;
	END IF;

	RETURN NEW;

END;

$BODY$;

ALTER FUNCTION public.add_create_date()
    OWNER TO ivan;

