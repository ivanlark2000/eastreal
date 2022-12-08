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

CREATE OR REPLACE FUNCTION Add_Create_Date() RETURNS trigger AS $ads_create_date$

BEGIN

	IF NEW.D_Date IS NULL
		THEN NEW.D_Create_Date  := current_timestamp;
	END IF;

	RETURN NEW;

END;

$ads_create_date$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cor_street_tr() RETURNS trigger AS $street$

BEGIN

    NEW.S_Type_Street := cor_street(NEW.S_Type_Street);

	RETURN NEW;

END;

$street$
LANGUAGE plpgsql;

