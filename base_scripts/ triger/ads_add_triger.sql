CREATE trigger Add_Buff_Value
BEFORE INSERT ON BF_Temp_Apartments_Ads FOR EACH ROW
EXECUTE PROCEDURE Add_Buff_Value();

CREATE trigger LG_Session_Log_add_date
BEFORE INSERT ON LG_Session_LOG FOR EACH ROW
EXECUTE PROCEDURE Add_Date();

CREATE TRIGGER cor_street_trigger
BEFORE INSERT ON BF_Temp_Apartments_Ads FOR EACH ROW
EXECUTE PROCEDURE cor_street_tr();
