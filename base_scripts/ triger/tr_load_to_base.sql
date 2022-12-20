CREACREATE FUNCTION load_ads_to_base() RETURNS trigger
AS $$
DECLARE
    id_city integer := (SELECT link FROM FS_City WHERE C_Name = NEW.S_City);
    id_street integer;
    id_cite integer;
    id_house integer;
    id_flat integer;
    n_price numeric;
    id_parking smallint;
    id_yard smallint;
    id_type_house smallint;
    id_official_builder smallint;
    id_qty_room smallint;
    id_floor smallint;
    id_technics integer;
    id_furniture integer;
    id_decoration_type smallint;
    id_type_room smallint;
    id_type_bathroom smallint,
    id_window smallint;
    id_kind_of_repair smallint;
    id_method_of_sale smallint;
    id_type_of_transaction smallint;
    id_seller integer;


BEGIN
     SELECT link INTO id_street FROM Fs_Street
     WHERE C_Name = NEW.s_street AND F_City = id_city;

    SELECT inf_sys.id_site INTO id_city FROM INF_Sys
    WHERE inf_sys.id_site = NEW.id_site;

    IF id_site IS NOT NULL
        THEN
        SELECT f_flat INTO id_flat FROM INF_Sys
        WHERE id_site = NEW.id_site;

        SELECT n_price INTO n_price
        FROM mn_price_ads
        WHERE f_flat = id_flat
        ORDER BY D_Date DESC LIMIT 1;

        IF n_price <> NEW.n_price
            THEN
            INSERT INTO mn_price_ads (f_flat, n_price)
            VALUES (id_flat, NEW.n_price);
            END IF;

    ELSE
        SELECT link INTO id_street FROM FS_Street
        WHERE C_Name = NEW.s_street;

        IF id_street IS NULL
            THEN
            INSERT INTO fs_street (C_Name)
            VALUES (NEW.s_street)
            RETURNING link INTO id_street;
            END IF;

        SELECT link INTO id_house FROM MN_House
        WHERE 1=1
            AND n_house = NEW.n_house
            AND f_street = id_street
            AND N_Qty_Floor = NEW.N_Qty_Floor;

        IF id_house IS NULL
            THEN
            SELECT link.fs_parking INTO id_parking FROM FS_Parking
            WHERE C_Name = NEW.s_parking;

            IF id_parking IS NULL
                THEN
                    INSERT INTO fs_parking (c_name)
                    VALUES (NEW.s_parking)
                    RETURNING link INTO id_parking;
                END IF;

            SELECT link.fs_yard INTO id_yard FROM FS_Yard
            WHERE C_Name = NEW.s_yard;

            IF id_yard IS NULL
                THEN
                INSERT INTO fs_yard (C_Name)
                VALUES (NEW.s_yard)
                RETURNING link INTO id_yard;
                END IF;

            SELECT link.fs_type_house INTO id_type_house
            FROM fs_type_house
            WHERE c_name = NEW.s_type_house;

            IF id_type_house IS NULL
                THEN
                INSERT INTO fs_type_house (c_name)
                VALUES (NEW.s_type_house);
                END IF;

            SELECT link.mn_official_builder INTO id_officially_builder
            FROM mn_official_builder
            WHERE c_name = NEW.s_official_builder

            IF id_official_builder IS NULL
                THEN
                INSERT INTO mn_official_builder (c_name)
                VALUES (NEW.s_official_builder)
                RETURNING link INTO id_official_builder;
                END IF;

            INSERT INTO mn_house (f_street, n_qty_floor, n_year_building, b_passenger_elevator,
                b_freight_elevator, f_parking, f_yard, f_type_house, f_official_builder, s_name_new_building)
            VALUES (id_street, NEW.n_qty_floor, NEW.n_year_building, NEW.b_passenger_elevator,
                NEW.b_freight_elevator, NEW.b_freight_elevator, id_parking, id_yard, id_type_house,
                id_official_builder, NEW.s_name_building)
            RETURNING link INTO id_house;
            END IF;

        SELECT link.FS_Qty_Room INTO id_qty_room
        FROM fs_qty_room
        WHERE C_Name = NEW.s_qty_room;

        IF id_qty_room IS NULL
            WHEN
            INSERT INTO fs_qty_room (c_name)
            VALUES (NEW.s_qty_room)
            RETURNING link INTO id_qty_room;
            END IF;

        SELECT link.fs_floor INTO id_floor
        FROM FS_Floor
        WHERE c_name = NEW.n_floor;

        IF id_floor IS NULL
            INSERT INTO fs_floor (c_name)
            VALUES (NEW.n_floor)
            RETURNING link INTO n_floor;
            END IF;

        --PERFORM add_technics();
        --PERFORM add_technics();
        SELECT link.FS_Decoration_Type INTO id_decoration_type
        FROM FS_Decoration_Type
        WHERE c_name = NEW.s_decoration_type;

        IF id_decoration_type IS NULL
            THEN
            INSERT INTO fs_decoration_type (c_name)
            VALUES (NEW.s_decoration_type)
            RETURNING link INTO id_decoration_type;
            END IF;

        SELECT link.fs_type_room INTO id_type_room
        FROM fs_type_room
        WHERE c_name = NEW.s_type_room;

        IF id_type_room IS NULL
            THEN
            INSERT INTO fs_type_room (c_name)
            VALUES (NEW.s_type_street)
            RETURNING link INTO id_type_room;








END;
$$
LANGUAGE plpgsql

CREATE TRIGGER bf_temp_apartments_ads_trigger BEFORE INSERT ON bf_temp_apartments_ads
    FOR EACH ROW EXECUTE FUNCTION load_ads_to_base();