CREATE OR REPLACE PROCEDURE Trans_Temp_To_Const() AS $$
-- CREATE DATE 2022-08-12
-- Процедура для перемещения данных квартир с временного буфера и сортировкой адреса


DECLARE
    time_Start timestamp := current_timestamp;
    id int;

BEGIN

    INSERT INTO LG_Procedure_Session (F_Session, D_Date_Start)
    VALUES (1, time_Start)
    RETURNING link INTO id;

INSERT INTO bf_apartments_ads (
		link,
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
WITH street (link, s_str)
AS (
SELECT
	link,
	ltrim(replace(format_street(split_part(s_full_street, ',', 1)), 'Б.', ''))

FROM bf_temp_apartments_ads
WHERE array_length(string_to_array(s_full_street, ','), 1) = 2
)

SELECT
		link,
		s_city,
		ltrim(split_part(split_part(s_full_street, ',', 2), 'р-н', 2))   as s_district,
		left(s_str, position(' ' in s_str))                              as s_type_street,
		replace(s_str, left(s_str, position(' ' in s_str)), '') as s_street,
		ltrim(split_part(split_part(s_full_street, ',', 2), 'р-н', 1))    as n_street,
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
		d_date,
		id AS f_procedure_session

FROM BF_Temp_Apartments_Ads
INNER JOIN street USING(link);

INSERT INTO bf_apartments_ads (
		link,
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

SELECT
		link,
		s_city,
		split_part(replace(split_part(s_full_street, s_city, 3), ', ', ''), 'р-н', 2)   as s_district,
		split_part((replace(format_street(split_part(s_full_street, ',', 3)), 'Б.', '')), ' ', 2)                             as s_type_street,
		SUBSTRING(ltrim(replace(format_street(split_part(s_full_street, ',', 3)), 'Б.', '')), length(split_part((replace(format_street(split_part(s_full_street, ',', 3)), 'Б.', '')), ' ', 2))+1, 100) as s_street,
		SUBSTRING(split_part(replace(split_part(s_full_street, s_city, 3), ', ', ''), 'р-н', 1), length(split_part(s_full_street, ',', 3)), 10)    as n_street,
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
		d_date,
		id AS f_procedure_session

FROM bf_temp_apartments_ads
WHERE array_length(string_to_array(s_full_street, ','), 1) = 4
    AND ltrim(rtrim(split_part(s_full_street, ',', 2))) = s_city;


INSERT INTO bf_apartments_ads (
		link,
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

WITH street (link, s_district, s_street, n_house)
AS (
	SELECT
		link
		,split_part(s_full_street, 'р-н', 2) as district
		,format_street(split_part(substring(split_part(s_full_street, 'р-н', 1)
					,position(',' in split_part(s_full_street, 'р-н', 1) )+ 2, 120), ', ', 3)) as s_street
		,split_part(substring(split_part(s_full_street, 'р-н', 1)
					,position(',' in split_part(s_full_street, 'р-н', 1) )+ 2, 120), ', ', 4) as n_street

	FROM BF_Temp_Apartments_Ads
	WHERE array_length(string_to_array(s_full_street, ','), 1) = 5
		AND split_part(substring(split_part(s_full_street, 'р-н', 1),
			position(',' in split_part(s_full_street, 'р-н', 1) )+ 2, 120), ', ', 3) ~ '[0-9]' = false
		AND split_part(substring(split_part(s_full_street, 'р-н', 1),
			position(',' in split_part(s_full_street, 'р-н', 1) )+ 2, 120), ', ', 4) ~ '[0-9]'
)
SELECT
	link
	,s_city
	,s.s_district
	,split_part(s_street, ' ', 1) as s_type_street
	,split_part(s_street, ' ', 2) as s_street
	,s.n_house
	,s_qty_room,
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
	d_date,
	id AS f_procedure_session

FROM bf_temp_apartments_ads b
    INNER JOIN street s USING(link)
;
UPDATE LG_Procedure_Session
SET D_Date_End = current_timestamp
WHERE id = link;

DELETE FROM BF_Temp_Apartments_Ads
WHERE LINK IN (
	select link from BF_Apartments_Ads
	WHERE F_Procedure_session = id
);

END;
$$

LANGUAGE plpgsql;
