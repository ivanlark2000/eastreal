CREATE OR REPLACE FUNCTION pars_json() RETURNS trigger
AS
$$
BEGIN
    NEW.object_id := NEW.json::json ->> 'id';
    NEW.latitude := NEW.json::json #> '{center, lat}';
    NEW.longitude := NEW.json::json #> '{center, lon}';
    NEW.name_obj := NEW.json::json #> '{tags, name}';
    NEW.operator_obj := NEW.json::json #> '{tags, operator}';
    NEW.street := NEW.json::json #> '{tags, addr:street}';
    NEW.street = replace(NEW.street, '"', '');
    NEW.n_house := NEW.json::json #> '{tags, addr:housenumber}';
    NEW.n_house = replace(NEW.n_house, '"', '');
    NEW.D_Date := NOW();
    NEW.f_type_street := get_id_type_street(NEW.street);
    NEW.street = del_type_street(NEW.street);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;