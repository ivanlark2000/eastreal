--ALTER DATE 
    --2023.02.02 добавили закачку данных в таблицу inf_descriotions

CREATE OR REPLACE FUNCTION load_ads_to_base() RETURNS trigger
AS $$
DECLARE
    id_city integer := (SELECT link FROM FS_City WHERE C_Name = NEW.S_City);
    id_street integer;
    street_name varchar(150);
    id_type_street smallint;
    siteid bigint;
    id_house integer;
    id_flat integer;
    n_price money;
    id_parking smallint;
    id_yard smallint;
    id_type_house smallint;
    id_official_builder smallint;
    id_qty_room smallint;
    id_floor smallint;
    id_technics integer;
    id_furniture integer;
    id_decoration smallint;
    id_type_room smallint;
    id_bathroom_type smallint;
    id_window smallint;
    id_repair_type smallint;
    id_method_of_sale smallint;
    id_transaction_type smallint;
    id_seller integer;
    id_seller_type smallint;
    id_ads_type smallint;
    id_apartments_ads integer;

BEGIN

    SELECT inf_sys.site_id INTO siteid FROM INF_Sys
    WHERE inf_sys.site_id = NEW.site_id;

    IF siteid IS NOT NULL
        THEN
        SELECT f_flat INTO id_flat FROM INF_Sys
        WHERE inf_sys.site_id = NEW.site_id;

        SELECT mn_ads_price.n_price INTO n_price
        FROM mn_ads_price
        WHERE f_flat = id_flat
        ORDER BY D_Date DESC LIMIT 1;

        IF n_price <> NEW.n_price
            THEN
            INSERT INTO mn_ads_price (f_flat, n_price)
            VALUES (id_flat, NEW.n_price);
            END IF;

    ELSE
        SELECT link INTO id_street FROM fs_street
        WHERE C_Name = RTRIM(LTRIM(NEW.s_street)) AND f_city = id_city
        LIMIT 1;

        IF id_street IS NULL
            THEN

            INSERT INTO fs_street (C_Name, f_type_street, f_city)
            VALUES (NEW.s_street, NEW.f_type_street, id_city)
            RETURNING link INTO id_street;
            END IF;

        SELECT link INTO id_house FROM MN_House
        WHERE 1=1
            AND s_number = LTRIM(RTRIM(NEW.n_street))
            AND f_street = id_street
        LIMIT 1;

        IF id_house IS NULL THEN

            IF street_name <> NEW.s_street THEN
                UPDATE fs_street
                SET c_name2 = street_name
                WHERE link = id_street;
            END IF;

            IF NEW.s_parking IS NOT NULL
                THEN
                SELECT link INTO id_parking FROM FS_Parking
                WHERE C_Name = NEW.s_parking;

                IF id_parking IS NULL
                    THEN
                    INSERT INTO fs_parking (c_name)
                    VALUES (NEW.s_parking)
                    RETURNING link INTO id_parking;
                    END IF;
                END IF;

            IF NEW.s_yard IS NOT NULL
                THEN
                SELECT link INTO id_yard FROM FS_Yard
                WHERE C_Name = NEW.s_yard;

                IF id_yard IS NULL
                    THEN
                    INSERT INTO fs_yard (C_Name)
                    VALUES (NEW.s_yard)
                    RETURNING link INTO id_yard;
                    END IF;
                END IF;

            IF NEW.s_type_house IS NOT NULL
                THEN
                SELECT link INTO id_type_house
                FROM fs_type_house
                WHERE c_name = NEW.s_type_house;

                IF id_type_house IS NULL
                    THEN
                    INSERT INTO fs_type_house (c_name)
                    VALUES (NEW.s_type_house);
                    END IF;
                END IF;

            IF NEW.s_official_builder IS NOT NULL
                THEN
                SELECT link INTO id_official_builder
                FROM mn_official_builder
                WHERE c_name = NEW.s_official_builder;

                IF id_official_builder IS NULL
                    THEN
                    INSERT INTO mn_official_builder (c_name)
                    VALUES (NEW.s_official_builder)
                    RETURNING link AS id_official_builder;
                    END IF;
                END IF;

            INSERT INTO mn_house (f_street, n_qty_floor, n_year_building, b_passenger_elevator, b_freight_elevator,
                f_parking, f_yard, f_type_house, f_official_builder, s_name_new_building, s_number, f_city)
            VALUES (id_street, NEW.s_qty_floor, NEW.n_year_building, NEW.b_passenger_elevator, NEW.b_freight_elevator,
                id_parking, id_yard, id_type_house, id_official_builder, NEW.s_name_new_building, NEW.n_street, id_city)
            RETURNING link INTO id_house;
            END IF;

        IF NEW.s_qty_room IS NOT NULL
            THEN
            SELECT link INTO id_qty_room
            FROM fs_qty_room
            WHERE C_Name = NEW.s_qty_room;

            IF id_qty_room IS NULL
                THEN
                INSERT INTO fs_qty_room (c_name)
                VALUES (NEW.s_qty_room)
                RETURNING link AS id_qty_room;
                END IF;
            END IF;

        IF NEW.n_floor IS NOT NULL
            THEN
            SELECT link INTO id_floor
            FROM FS_Floor
            WHERE c_name = NEW.n_floor;

            IF id_floor IS NULL
				THEN
                INSERT INTO fs_floor (c_name)
                VALUES (NEW.n_floor)
                RETURNING link AS n_floor;
                END IF;
            END IF;

        IF NEW.s_decoration IS NOT NULL
            THEN
            SELECT link INTO id_decoration
            FROM FS_Decoration_Type
            WHERE c_name = NEW.s_decoration;

            IF id_decoration IS NULL
                THEN
                INSERT INTO fs_decoration_type (c_name)
                VALUES (NEW.s_decoration)
                RETURNING link INTO id_decoration;
                END IF;
            END IF;

        IF NEW.s_type_room IS NOT NULL
            THEN
            SELECT link INTO id_type_room
            FROM fs_type_room
            WHERE c_name = NEW.s_type_room;

            IF id_type_room IS NULL
                THEN
                INSERT INTO fs_type_room (c_name)
                VALUES (NEW.s_type_street)
                RETURNING link INTO id_type_room;
                END IF;
            END IF;

        IF NEW.s_ads_type IS NOT NULL
            THEN
            SELECT link INTO id_ads_type
            FROM FS_ads_type
            WHERE c_name = NEW.s_ads_type;

            IF id_ads_type IS NULL
                THEN
                INSERT INTO fs_ads_type (c_name)
                VALUES (NEW.s_ads_type)
                RETURNING link AS id_ads_type;
                END IF;
            END IF;

        IF NEW.s_bathroom_type IS NOT NULL
            THEN
            SELECT link INTO id_bathroom_type
            FROM fs_bathroom_type
            WHERE c_name = NEW.s_bathroom_type;

            IF id_bathroom_type IS NULL
                THEN
                INSERT INTO fs_bathroom_type (c_name)
                VALUES (NEW.s_bathroom_type)
                RETURNING link INTO id_bathroom_type;
                END IF;
            END IF;

        IF NEW.s_window IS NOT NULL
            THEN
            SELECT link INTO id_window
            FROM fs_window
            WHERE c_name = NEW.s_window;

            IF id_window IS NULL
                THEN
                INSERT INTO fs_window (c_name)
                VALUES (NEW.s_window)
                RETURNING link INTO id_window;
                END IF;
            END IF;

        IF NEW.s_repair_type IS NOT NULL
            THEN
            SELECT link INTO id_repair_type
            FROM fs_repair_type
            WHERE c_name = NEW.s_repair_type;

            IF id_repair_type IS NULL
                THEN
                INSERT INTO fs_repair_type (c_name)
                VALUES (NEW.s_repair_type);
                END IF;
            END IF;

        IF NEW.s_seller IS NOT NULL
            THEN
            SELECT link INTO id_seller
            FROM fs_seller
            WHERE c_full_name = NEW.s_seller;

            IF NEW.s_seller_type IS NOT NULL
                THEN
                SELECT link INTO id_seller_type
                FROM fs_seller_type
                WHERE c_name = NEW.s_seller_type;

                IF id_seller_type IS NULL
                    THEN
                    INSERT INTO fs_seller_type (c_name)
                    VALUES (NEW.s_seller_type)
                    RETURNING link INTO id_seller_type;
                    END IF;
                END IF;

            IF id_seller IS NULL
                THEN
                INSERT INTO FS_Seller (c_full_name, f_seller_type)
                VALUES (NEW.s_seller, id_seller_type)
                RETURNING link INTO id_seller;
                END IF;
            END IF;

        IF NEW.s_method_of_sale IS NOT NULL
            THEN
            SELECT link INTO id_method_of_sale
            FROM fs_method_of_sale
            WHERE c_name = NEW.s_method_of_sale;

            IF id_method_of_sale IS NULL
                THEN
                INSERT INTO fs_method_of_sale (c_name)
                VALUES (NEW.s_method_of_sale)
                RETURNING link INTO id_method_of_sale;
                END IF;
            END IF;

        IF NEW.s_transaction_type IS NOT NULL
            THEN
            SELECT link INTO id_transaction_type
            FROM fs_transaction_type
            WHERE c_name = NEW.s_transaction_type;

            IF id_transaction_type IS NULL
                THEN
                INSERT INTO fs_transaction_type (c_name)
                VALUES (NEW.s_transaction_type)
                RETURNING link INTO id_transaction_type;
                END IF;
            END IF;
        
        INSERT INTO mn_apartments_ads (
            f_house, f_qty_room, f_ads_type, n_qty_total_space, n_qty_living_space, n_qty_kitchen_space,
            f_floor, f_decorating, B_Loggia, B_Balcony, f_room_type, n_ceiling_height, b_heating,
            f_bathroom_type, f_window, f_repair_type, f_seller, f_method_of_sale, f_transaction_type
        )
        VALUES (id_house, id_qty_room, id_ads_type, NEW.n_qty_total_space, NEW.n_qty_living_space,
             NEW.n_qty_kitchen_space, id_floor, id_decoration, NEW.b_loggia, NEW.b_balcony,
             id_type_room, NEW.n_ceiling_height, NEW.b_heating, id_bathroom_type, id_window,
             id_repair_type, id_seller, id_method_of_sale, id_transaction_type)
        RETURNING link INTO id_apartments_ads;

        IF NEW.s_furniture IS NOT NULL THEN
            PERFORM add_technics(id_apartments_ads, NEW.s_furniture, 1);
            END IF;

        IF NEW.s_technics IS NOT NULL THEN
            PERFORM add_technics(id_apartments_ads, NEW.s_technics, 2);
            END IF;

        INSERT INTO mn_ads_price (f_flat, n_price)
        VALUES (id_apartments_ads, NEW.n_price);

        INSERT INTO inf_sys (f_flat, s_site_link, f_source, site_id, f_city)
        VALUES (id_apartments_ads, NEW.s_site_links, NEW.f_source, NEW.site_id, id_city);
        
        INSERT INTO inf_descriptions (f_flat, c_name)
        VALUES (id_apartments_ads, NEW.s_description);

	INSERT INTO mn_metrics (f_house, f_flat, f_city)
	VALUES (id_house, id_apartments_ads, id_city);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER load_ads_temp_to_mn
    BEFORE INSERT OR UPDATE 
    ON BF_Temp_Apartments_Ads 
    FOR EACH ROW
    EXECUTE PROCEDURE load_ads_to_base();

