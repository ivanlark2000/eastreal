CREATE OR REPLACE FUNCTION pars_json() RETURNS trigger
AS
$$
BEGIN
    NEW.object_id := NEW.json::json ->> 'id';
    NEW.latitude := NEW.json::json #> '{center, lat}';
    NEW.longitude := NEW.json::json #> '{center, lon}';
    NEW.name_obj := NEW.json::json #> '{tags, name}';
    NEW.operator_obj := NEW.json::json #> '{tags, operator}';
    NEW.D_Date := NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;