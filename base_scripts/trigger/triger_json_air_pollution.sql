CREATE OR REPLACE FUNCTION pars_json_air_pollution() RETURNS trigger
AS
$$
BEGIN
    NEW.f_index := NEW.json::json #> '{main, aqi}';
    NEW.n_co := NEW.json::json #> '{components, co}';
    NEW.n_no := NEW.json::json #> '{components, no}';
    NEW.n_o3 := NEW.json::json #> '{components, o3}';
    NEW.n_no2 := NEW.json::json #> '{components, no2}';
    NEW.n_so2 := NEW.json::json #> '{components, so2}';
    NEW.n_pm2_5 := NEW.json::json #> '{components, pm2_5}';
    NEW.n_pm10 := NEW.json::json #> '{components, pm10}';
    NEW.n_nh3 := NEW.json::json #> '{components, nh3}';
    NEW.D_Date := NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER unpuck_json_air_pollution
    BEFORE INSERT
    ON public.inf_air_pollution
    FOR EACH ROW
    EXECUTE FUNCTION public.pars_json_air_pollution();