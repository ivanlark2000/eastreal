CREATE OR REPLACE PROCEDURE Trans_Temp_To_Const() AS $$

DECLARE
    time_Start timestamp := current_timestamp;
    id int;

BEGIN

    INSERT INTO LG_Procedure_Session (F_Session, D_Date_Start)
    VALUES (1, time_Start)
    RETURNING link INTO id;

INSERT INTO bf_apartments_ads (
	    s_area,
		s_city,
		s_district,
		s_type_street,
		s_street,
		n_street,
		s_qty_room,
		n_qty_total_space,
		n_qty_living_space,
		n_qty_kitchen_space,
		n_price,
		n_floor,
		b_balkony,
		b_loggia,
		s_type_of_room,
		s_ads_type,
		n_ceiling_height,
		s_type_bathroom,
		s_window,
		s_kind_of_repair,
		b_heating,
		s_furniture,
		s_tehnics,
		s_decorating,
		s_method_of_sale,
		s_type_of_transaction,
		s_description,
		s_type_house,
		n_year_building,
		n_floor_in_house,
		b_passenger_elevator,
		b_freight_elevator,
		s_yard,
		s_parking,
		s_name_new_building,
		s_official_builder,
		s_type_of_participation,
		d_deadline_for_delivery,
		s_name_company,
		s_name_seller,
		s_type_of_seller,
		s_site_links,
		f_sourse,
		d_date,
		f_procedure_session
)
SELECT s_area,
		s_city,
		s_district,
		s_type_street,
		s_street,
		n_street,
		s_qty_room,
		n_qty_total_space,
		n_qty_living_space,
		n_qty_kitchen_space,
		n_price,
		n_floor,
		b_balcony,
		b_loggia,
		s_type_of_room,
		s_ads_type,
		n_ceiling_height,
		s_type_bathroom,
		s_window,
		s_kind_of_repair,
		b_heating,
		s_furniture,
		s_technics,
		s_decorating,
		s_method_of_sale,
		s_type_of_transaction,
		s_description,
		s_type_house,
		n_year_building,
		n_floor_in_house,
		b_passenger_elevator,
		b_freight_elevator,
		s_yard,
		s_parking,
		s_name_new_building,
		s_official_builder,
		s_type_of_participation,
		d_deadline_for_delivery,
		s_name_company,
		s_name_seller,
		s_type_of_seller,
		s_site_links,
		f_source,
		MIN(d_date) AS D_Date,
		id

FROM BF_Temp_Apartments_Ads

GROUP BY  s_area, s_city, s_district, s_type_street,
		s_street,
		n_street,
		s_qty_room,
		n_qty_total_space,
		n_qty_living_space,
		n_qty_kitchen_space,
		n_price,
		n_floor,
		b_balcony,
		b_loggia,
		s_type_of_room,
		s_ads_type,
		n_ceiling_height,
		s_type_bathroom,
		s_window,
		s_kind_of_repair,
		b_heating,
		s_furniture,
		s_technics,
		s_decorating,
		s_method_of_sale,
		s_type_of_transaction,
		s_description,
		s_type_house,
		n_year_building,
		n_floor_in_house,
		b_passenger_elevator,
		b_freight_elevator,
		s_yard,
		s_parking,
		s_name_new_building,
		s_official_builder,
		s_type_of_participation,
		d_deadline_for_delivery,
		s_name_company,
		s_name_seller,
		s_type_of_seller,
		s_site_links,
		f_source
;
DELETE FROM BF_Temp_Apartments_Ads;

UPDATE LG_Procedure_Session
SET D_Date_End = current_timestamp
WHERE id = link;

END;
$$

LANGUAGE plpgsql;