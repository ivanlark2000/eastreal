CREATE OR REPLACE FUNCTION pars_obj_json() RETURNS trigger
AS
$$
BEGIN
    NEW.object_id := NEW.json::json ->> 'id';
    NEW.latitude := NEW.json::json #> '{center, lat}';
    NEW.longitude := NEW.json::json #> '{center, lon}';
    NEW.name_obj := NEW.json::json #> '{tags, name}';
    NEW.street := NEW.json::json #> '{tags, addr:street}';
    NEW.D_Date := NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER unpack_obj_json
    BEFORE INSERT ON ps_object_position
    FOR EACH ROW
    EXECUTE PROCEDURE pars_obj_json();
