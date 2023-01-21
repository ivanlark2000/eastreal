CREATE PROCEDURE Load_Ads_Bf_To_MN()
AS $$

DECLARE
    D_Date_Start timestamp := current_timestamp;
    D_Date_End timestamp;
    F_Procedure_Session smallint;

BEGIN
    INSERT INTO LG_Procedure_Session (F_Session, D_Date_Start)
    VALUES (2, D_Date_Start)
    RETURNING LINK F_Procedure_Session INTO F_Procedure_Session;
    )


	DELETE FROM BF_apartments_ads
    WHERE s_type_street ~ '[0-9]' OR s_type_street LIKE 'СНТ';

    UPDATE bf_apartments_ads
    SET s_type_street = rtrim(ltrim(s_type_street));

    UPDATE bf_apartments_ads
    SET s_type_street =
	    (CASE
	    WHEN position('пp.'in s_type_street) > 0 THEN 'пр-д'
		WHEN position('переулок'in s_type_street) > 0 THEN 'пер.'
		WHEN position('проспект'in s_type_street) > 0 THEN 'пр-т'
		ELSE s_type_street
		END);


	DROP TABLE IF EXISTS Ads;
    CREATE TEMPORARY TABLE Ads (
        LINK int,
        S_Area varchar(150),
        S_City varchar(150),
        S_District varchar(150),
        S_Street_Type varchar(150),
        S_Street varchar(150),
        N_Street varchar(20),
        F_Qty_Room varchar(15),
        N_Qty_Total_Space decimal(6,2),
        N_Qty_Living_Space decimal(6,2),
        N_Qty_Kitchen_Space decimal(6,2),
        M_Price money,
        N_Floor smallint,
        B_Balcony boolean,
        B_Loggia boolean,
        S_Type_Of_Room Varchar(150),
        S_Ads_Type varchar(20),
        N_Ceiling_Height decimal(4,2),
        S_Type_Bathroom Varchar(150),
        S_Window varchar(150),
        S_Kind_Of_Repair Varchar(150),
        B_Heating boolean,
        S_Furniture varchar(500),
        S_Technics varchar(500),
        S_Decorating varchar(150),
        S_Method_Of_Sale Varchar(150),
        S_Type_Of_Transaction Varchar(150),
        S_Description varchar,
        S_Type_House Varchar(150),
        N_Year_Building smallint,
        N_Floor_In_House smallint,
        B_Passenger_Elevator boolean,
        B_Freight_Elevator boolean,
        S_Yard varchar(500),
        S_Parking varchar(500),
        S_Name_New_Building varchar(150),
        S_Official_Builder Varchar(150),
        S_Type_of_Participation varchar(200),
        D_Deadline_for_Delivery varchar(150),
        S_Name_Company Varchar(150),
        S_Name_Seller Varchar(150),
        S_Type_Of_Seller varchar(150),
        S_Site_Links varchar,
        F_Source smallint,
        D_Date timestamp,
        F_Procedure_Session int
    );

    INSERT INTO Ads
    SELECT * FROM BF_Apartments_Ads;

    UPDATE ads
    SET s_street = rtrim(replace(s_street, s_street_type, ''));

    UPDATE ads a
    SET s_city = c.link
    FROM fs_city c
    WHERE  c.c_name = a.s_city;

    ALTER TABLE ads ALTER COLUMN s_city TYPE int USING s_city::int;

    UPDATE ads a
    SET s_area = d.f_area
    FROM FS_City d
    WHERE d.link = a.s_city;

    UPDATE ads a
    SET s_district = d.link
    FROM FS_District d
    WHERE d.C_name = a.s_district;

    UPDATE Ads a
    SET S_Street_Type = d.LINK
    FROM FS_Street_Type d
    WHERE a.S_Street_Type = d.Short_Name;

    ALTER TABLE ads ALTER COLUMN S_District TYPE int USING S_District::int;
    ALTER TABLE ads ALTER COLUMN S_Street_Type TYPE int USING S_Street_Type::int;
    --SELECT * FROM ads
    INSERT INTO FS_Street (F_District, F_Type_Street, C_Name, f_city)
    SELECT S_District, S_Street_Type, S_Street, s_City
    FROM Ads
    WHERE S_Street||' '||s_city  NOT IN (
             SELECT C_Name||' '||f_city
             FROM FS_Street
            )
    GROUP BY S_City, S_District, S_Street_Type, S_Street;

	UPDATE ads a
	SET s_street = s.link
	FROM fs_street s
	WHERE s.f_city = a.s_city AND a.s_street = s.c_name;

    INSERT INTO FS_Type_House (C_Name)
    SELECT S_Type_House FROM Ads
    WHERE S_Type_House NOT IN (
        SELECT C_Name FROM FS_Type_House
    )
    GROUP BY S_Type_House;

	UPDATE Ads
    SET S_Type_House = t.LINK
    FROM FS_Type_House t
	WHERE t.C_Name = ads.S_Type_House;

    ALTER TABLE ads ALTER COLUMN S_Street TYPE int USING S_Street::int;

	DROP TABLE IF EXISTS House;
    CREATE TEMPORARY TABLE House (
       link int,
       F_Street smallint,
       N_Qty_Floor varchar(10),
       S_Number varchar(20),
       N_Year_Building smallint,
       B_Passenger_Elevator boolean,
       B_Freight_Elevator boolean,
       F_Parking varchar(500),
       F_Yard varchar(500),
       F_Type_House varchar(50),
       F_Official_Builder varchar(150),
       S_Name_New_Building varchar(150),
       D_Deadline_for_Delivery varchar(150)
    );

    INSERT INTO House
    SELECT
       link
       ,S_Street
       ,N_Floor_in_House
       ,N_Street
       ,N_Year_Building
       ,B_Passenger_Elevator
       ,B_Freight_Elevator
       ,S_Parking
       ,S_Yard
       ,S_Type_House
       ,S_Official_Builder
       ,S_Name_New_Building
       ,D_Deadline_for_Delivery
    FROM ads;


    INSERT INTO FS_Parking (c_name)
    SELECT DISTINCT House.F_Parking
	FROM House
    WHERE F_Parking IS NOT NULL AND F_Parking NOT IN (
        SELECT C_Name FROM FS_Parking
    );

	INSERT INTO FS_Yard (c_name)
    SELECT DISTINCT F_Yard FROM House
    WHERE F_Yard IS NOT NULL AND F_Yard NOT IN (
        SELECT C_Name FROM FS_Yard
    );

    INSERT INTO MN_Official_Builder (C_Name)
    SELECT DISTINCT F_Official_Builder FROM House
    WHERE F_Official_Builder NOT IN (
        SELECT C_Name FROM MN_Official_Builder
        ) AND F_Official_Builder IS NOT NULL;

    UPDATE House h
    SET F_Official_Builder = m.link
    FROM MN_Official_Builder m
    WHERE m.C_Name = h.F_Official_Builder;

    ALTER TABLE House ALTER COLUMN F_Official_Builder TYPE smallint USING F_Official_Builder::smallint;

	UPDATE house h
	SET F_Parking = p.LINK
	FROM FS_Parking p
	WHERE p.c_name = h.F_Parking;

	UPDATE house h
	SET F_Yard = y.link
	FROM FS_Yard y
	WHERE y.c_name = h.F_Yard;

	ALTER TABLE house ALTER COLUMN F_Parking TYPE int USING F_Parking::int;
	ALTER TABLE house ALTER COLUMN F_Yard TYPE int USING F_Yard::int;
	ALTER TABLE house ALTER COLUMN F_Type_House TYPE int USING F_Type_House::int;

    UPDATE MN_House mh
    SET
        N_Year_Building = CASE
                            WHEN h.N_Year_Building IS NOT  NULL THEN h.N_Year_Building
                            ELSE mh.N_Year_Building END
        ,B_Passenger_Elevator = h.B_Passenger_Elevator
        ,B_Freight_Elevator = h.B_Freight_Elevator
        ,F_Parking = CASE
                            WHEN h.F_Parking IS NOT NULL THEN h.F_Parking
                            ELSE mh.F_Parking END
        ,F_Yard = CASE
                            WHEN h.F_Yard IS NOT NULL THEN h.F_Yard
                            ELSE mh.F_Yard END
        ,F_Type_House = CASE
                            WHEN h.F_Type_House IS NOT NULL THEN h.F_Type_House
                            ELSE mh.F_Type_House END
        ,F_Official_Builder = CASE
                            WHEN h.F_Official_Builder IS NOT NULL THEN h.F_Official_Builder
                            ELSE mh.F_Official_Builder END
        ,S_Name_New_Building = CASE
                            WHEN h.S_Name_New_Building IS NOT NULL THEN h.S_Name_New_Building
                            ELSE mh.S_Name_New_Building END
    FROM House h
    WHERE mh.F_Street = h.F_Street AND mh.S_Number = h.S_Number AND mh.N_Qty_Floor = h.N_Qty_Floor;

    INSERT INTO MN_House (
		 F_Street
       ,N_Qty_Floor
       ,S_Number
       ,N_Year_Building
       ,B_Passenger_Elevator
       ,B_Freight_Elevator
       ,F_Parking
       ,F_Yard
       ,F_Type_House
       ,F_Official_Builder
       ,S_Name_New_Building
	)
	WITH h (
			n_n
		   ,F_Street
		   ,N_Qty_Floor
		   ,S_Number
		   ,N_Year_Building
		   ,B_Passenger_Elevator
		   ,B_Freight_Elevator
		   ,F_Parking
		   ,F_Yard
		   ,F_Type_House
		   ,F_Official_Builder
		   ,S_Name_New_Building
		)
	AS (
		SELECT
			ROW_NUMBER() OVER (PARTITION BY F_Street, S_Number ORDER BY N_Year_Building DESC)
		   ,F_Street
		   ,N_Qty_Floor
		   ,S_Number
		   ,N_Year_Building
		   ,B_Passenger_Elevator
		   ,B_Freight_Elevator
		   ,F_Parking
		   ,F_Yard
		   ,F_Type_House
		   ,F_Official_Builder
		   ,S_Name_New_Building
		FROM House
    )
	SELECT
		   F_Street
		   ,N_Qty_Floor
		   ,S_Number
		   ,N_Year_Building
		   ,B_Passenger_Elevator
		   ,B_Freight_Elevator
		   ,F_Parking
		   ,F_Yard
		   ,F_Type_House
		   ,F_Official_Builder
		   ,S_Name_New_Building
	FROM h
    WHERE F_Street||' '||S_Number NOT IN (
        SELECT F_Street||' '||S_Number
		FROM MN_House
   		) AND n_n = 1;

    ALTER TABLE ads ADD COLUMN F_House int;

	ALTER TABLE Ads ALTER COLUMN n_floor_in_house TYPE varchar(10) USING n_floor_in_house::varchar;

    UPDATE ads a
    SET F_House = m.link
    FROM MN_House m
    WHERE a.s_Street =  m.F_Street AND a.n_street = m.S_Number;

    INSERT INTO FS_Qty_room (c_name)
    SELECT F_Qty_room
    FROM ads
    WHERE F_Qty_room NOT IN (
        SELECT C_Name FROM FS_Qty_room
    )
    GROUP BY 1;

    UPDATE ads
    SET F_Qty_room = m.LINK
    FROM FS_Qty_room m
    WHERE m.C_Name = ads.F_Qty_Room;

    ALTER TABLE ads ALTER COLUMN F_Qty_room TYPE smallint USING F_Qty_room::smallint;
	ALTER TABLE ads ALTER COLUMN n_floor TYPE varchar(10) USING n_floor::varchar(10);

    INSERT INTO FS_Floor (c_name)
    SELECT n_Floor
    FROM ads
    WHERE n_Floor NOT IN (
        SELECT C_Name FROM FS_Floor
    )
    GROUP BY 1;

    UPDATE ads a
    SET n_Floor = m.LINK
    FROM FS_Floor m
    WHERE m.C_Name = a.n_Floor;

    ALTER TABLE ads ALTER COLUMN n_Floor TYPE smallint USING n_Floor::smallint;

    SELECT date_deadline(F_House, D_Deadline_for_Delivery)
    FROM Ads WHERE date_deadline(F_House, D_Deadline_for_Delivery) IS NOT NULL;

	DROP TABLE IF EXISTS apartments;
	CREATE TEMPORARY TABLE apartments (
		link integer,
		f_house integer,
		f_qty_room smallint,
		n_qty_total_space numeric(6,2),
		n_qty_living_space numeric(6,2),
		n_qty_kitchen_space numeric(6,2),
		m_price money,
		f_floor smallint,
		f_technics varchar(500),
		f_furniture varchar(500),
		f_decorating varchar(250),
		b_loggia boolean,
		b_balcony boolean,
		f_type_of_room varchar(150),
		f_ads_type varchar(100),
		n_ceiling_height numeric(4,2),
		f_type_bathroom varchar(150),
		f_window varchar(150),
		f_kind_of_repaire varchar(150),
		b_heating boolean,
		f_method_of_sale varchar(150),
		f_type_of_transaction varchar(150),
		s_description character varying,
		f_seller character varying(150),
		f_type_of_seller varchar(150),
		f_link_site varchar(300),
		f_procedure_session smallint,
		f_sourse smallint,
		d_date timestamp
	);

	INSERT INTO apartments
	SELECT
		link,
		f_house,
		f_qty_room,
		n_qty_total_space,
		n_qty_living_space,
		n_qty_kitchen_space,
		m_price,
		n_floor,
		s_technics,
		s_furniture,
		s_decorating,
		b_loggia,
		b_balcony,
		s_type_of_room,
		s_ads_type,
		n_ceiling_height,
		s_type_bathroom,
		s_window ,
		s_kind_of_repair,
		b_heating,
		s_method_of_sale,
		s_type_of_transaction,
		s_description,
		s_name_seller,
		s_type_of_seller,
		s_site_links,
		f_procedure_session,
		f_source,
		d_date
	FROM ads;

	INSERT INTO FS_Decorating_Type (C_Name)
	SELECT f_decorating
	FROM apartments
	WHERE f_decorating NOT IN (
		SELECT C_Name FROM FS_Decorating_Type
	) AND f_decorating IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_decorating = d.link
	FROM FS_Decorating_Type d
	WHERE d.C_Name = a.f_decorating;

	ALTER TABLE apartments ALTER COLUMN F_Decorating TYPE smallint USING F_Decorating::smallint;

	INSERT INTO FS_Ads_Type (C_Name)
	SELECT f_ads_type
	FROM apartments
	WHERE f_ads_type NOT IN (
		SELECT C_Name FROM FS_Ads_Type
	) AND f_ads_type IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_ads_type = d.link
	FROM FS_Ads_Type d
	WHERE d.C_Name = a.f_ads_type;

	ALTER TABLE apartments ALTER COLUMN F_Ads_Type TYPE smallint USING F_Ads_Type::smallint;

	INSERT INTO FS_Type_of_Room (C_Name)
	SELECT f_type_of_room
	FROM apartments
	WHERE f_type_of_room NOT IN (
		SELECT C_Name FROM FS_Type_Of_Room
	) AND f_type_of_room IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_type_of_room = d.link
	FROM FS_Type_of_Room d
	WHERE d.C_Name = a.f_type_of_room;

	ALTER TABLE apartments ALTER COLUMN F_Type_Of_Room TYPE smallint USING F_Type_Of_Room::smallint;

	INSERT INTO FS_Type_Bathroom (C_Name)
	SELECT f_type_bathroom
	FROM apartments
	WHERE f_type_bathroom NOT IN (
		SELECT C_Name FROM FS_Type_Bathroom
	) AND f_type_bathroom IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_type_bathroom = d.link
	FROM FS_Type_Bathroom d
	WHERE d.C_Name = a.f_type_Bathroom;

	ALTER TABLE apartments ALTER COLUMN F_Type_Bathroom TYPE smallint USING F_Type_Bathroom::smallint;

	INSERT INTO FS_Type_of_Transaction (C_Name)
	SELECT f_type_of_transaction
	FROM apartments
	WHERE f_type_of_transaction NOT IN (
		SELECT C_Name FROM FS_Type_OF_Transaction
	) AND f_type_of_transaction IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_type_of_transaction = d.link
	FROM FS_Type_Of_Transaction d
	WHERE d.C_Name = a.f_type_of_transaction;

	ALTER TABLE apartments ALTER COLUMN F_Type_Of_Transaction TYPE smallint USING F_Type_Of_Transaction::smallint;

	INSERT INTO FS_Kind_Of_Repaire (C_Name)
	SELECT f_kind_of_repaire
	FROM apartments
	WHERE f_kind_of_repaire NOT IN (
		SELECT C_Name FROM FS_Kind_Of_Repaire
	) AND f_kind_of_repaire IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_kind_of_repaire = d.link
	FROM FS_Kind_Of_Repaire d
	WHERE d.C_Name = a.f_kind_of_repaire;

	ALTER TABLE apartments ALTER COLUMN F_Kind_of_repaire TYPE smallint USING F_Kind_of_Repaire::smallint;

	INSERT INTO FS_Method_of_Sale (C_Name)
	SELECT f_method_of_sale
	FROM apartments
	WHERE f_method_of_sale NOT IN (
		SELECT C_Name FROM FS_Method_of_sale
	) AND f_method_of_sale IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_method_of_sale = d.link
	FROM FS_Method_of_sale d
	WHERE d.C_Name = a.f_method_of_sale;

	ALTER TABLE apartments ALTER COLUMN F_Method_Of_Sale TYPE smallint USING F_Method_Of_Sale::smallint;

	UPDATE apartments a
	SET f_type_of_seller = NULL
	WHERE f_type_of_seller ~ '[0-9]';

	INSERT INTO FS_Type_Of_Seller (C_Name)
	SELECT f_type_of_seller
	FROM apartments
	WHERE f_type_of_seller NOT IN (
		SELECT C_Name FROM FS_TYpe_Of_Seller
	) AND f_type_of_seller IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_type_of_seller = d.link
	FROM FS_Type_of_Seller d
	WHERE d.C_Name = a.f_type_of_seller;

	ALTER TABLE apartments ALTER COLUMN F_Type_Of_Seller TYPE smallint USING F_Type_Of_Seller::smallint;

	INSERT INTO FS_Window (C_Name)
	SELECT f_window
	FROM apartments
	WHERE f_window NOT IN (
		SELECT C_Name FROM FS_Window
	) AND f_window IS NOT NULL
	GROUP BY 1;

	UPDATE apartments a
	SET f_window = d.link
	FROM FS_Window d
	WHERE d.C_Name = a.f_window;

	ALTER TABLE apartments ALTER COLUMN F_Window TYPE smallint USING F_window::smallint;

	INSERT INTO MN_Seller (f_type_of_seller, C_Full_Name)
	SELECT f_type_of_seller, f_seller
	FROM apartments
	WHERE f_seller||' '||f_type_of_Seller NOT IN (
		SELECT C_Full_Name||' '||f_type_of_seller FROM MN_Seller
	) AND f_seller IS NOT NULL
	GROUP BY 1, 2;

	UPDATE apartments a
	SET f_seller = s.link
	FROM MN_Seller s
	WHERE s.C_Full_name = a.f_seller;

	ALTER TABLE apartments ALTER COLUMN F_Seller TYPE smallint USING F_Seller::smallint;

	DROP TABLE IF EXISTS templ_flat;
	CREATE TEMPORARY TABLE templ_flat (
				f_house int
				,f_qty_room smallint
				,n_qty_total_space numeric(6,2)
				,n_qty_living_space numeric(6,2)
				,n_qty_kitchen_space numeric(6,2)
				,f_floor smallint
				,f_decorating smallint
				,b_loggia boolean
				,b_balcony boolean
				,f_ads_type smallint
				,f_type_of_room smallint
				,n_ceiling_height numeric(4,2)
				,f_type_bathroom smallint
				,f_window smallint
				,f_kind_of_repaire smallint
				,b_heating boolean
				,m_price money
				,f_method_of_sale smallint
				,f_type_of_transaction smallint
				,f_seller int
				,d_date timestamp
				);
	WITH templ (
					n_n
					,f_house
					,f_qty_room
					,n_qty_total_space
					,n_qty_living_space
					,n_qty_kitchen_space
					,f_floor
					,f_decorating
					,b_loggia
					,b_balcony
					,f_ads_type
					,f_type_of_room
					,n_ceiling_height
					,f_type_bathroom
					,f_window
					,f_kind_of_repaire
					,b_heating
					,m_price
					,f_method_of_sale
					,f_type_of_transaction
					,f_seller
					,d_date
					)
				AS (
				SELECT
						ROW_NUMBER() OVER (PARTITION BY f_house, f_qty_room, n_qty_total_space)
						,f_house
						,f_qty_room
						,n_qty_total_space
						,n_qty_living_space
						,n_qty_kitchen_space
						,f_floor
						,f_decorating
						,b_loggia
						,b_balcony
						,f_ads_type
						,f_type_of_room
						,n_ceiling_height
						,f_type_bathroom
						,f_window
						,f_kind_of_repaire
						,b_heating
						,m_price
						,f_method_of_sale
						,f_type_of_transaction
						,f_seller
						,d_date
				FROM apartments
				)
			INSERT INTO templ_flat (
					f_house
					,f_qty_room
					,n_qty_total_space
					,n_qty_living_space
					,n_qty_kitchen_space
					,f_floor
					,f_decorating
					,b_loggia
					,b_balcony
					,f_ads_type
					,f_type_of_room
					,n_ceiling_height
					,f_type_bathroom
					,f_window
					,f_kind_of_repaire
					,b_heating
					,m_price
					,f_method_of_sale
					,f_type_of_transaction
					,f_seller
					,d_date
					)
			SELECT
					f_house
					,f_qty_room
					,n_qty_total_space
					,n_qty_living_space
					,n_qty_kitchen_space
					,f_floor
					,f_decorating
					,b_loggia
					,b_balcony
					,f_ads_type
					,f_type_of_room
					,n_ceiling_height
					,f_type_bathroom
					,f_window
					,f_kind_of_repaire
					,b_heating
					,m_price
					,f_method_of_sale
					,f_type_of_transaction
					,f_seller
					,d_date
			FROM templ
			WHERE n_n = 1;

	INSERT INTO MN_Apartments_Ads (
		f_house
		,f_qty_room
		,n_qty_total_space
		,n_qty_living_space
		,n_qty_kitchen_space
		,f_floor
		,f_decorating
		,b_loggia
		,b_balcony
		,f_ads_type
		,f_type_of_room
		,n_ceiling_height
		,f_type_bathroom
		,f_window
		,f_kind_of_repaire
		,b_heating
		,f_method_of_sale
		,f_type_of_transaction
		,f_seller
		,d_date
	)
	SELECT
		f_house
		,f_qty_room
		,n_qty_total_space
		,n_qty_living_space
		,n_qty_kitchen_space
		,f_floor
		,f_decorating
		,b_loggia
		,b_balcony
		,f_ads_type
		,f_type_of_room
		,n_ceiling_height
		,f_type_bathroom
		,f_window
		,f_kind_of_repaire
		,b_heating
		,f_method_of_sale
		,f_type_of_transaction
		,f_seller
		,d_date
	FROM templ_flat
	WHERE f_house||' '||f_floor||' '||n_qty_total_space||' '||f_qty_room NOT IN (
		SELECT link||' '||f_floor||' '||n_qty_total_space||' '||f_qty_room
		FROM MN_Apartments_Ads
	);

	ALTER TABLE apartments ADD COLUMN f_flat int;

	UPDATE apartments a
	SET f_flat = m.link
	FROM MN_Apartments_Ads m
	WHERE  a.f_floor = m.f_floor AND a.n_qty_total_space = m.n_qty_total_space
		AND a.f_qty_room = m.f_qty_room AND m.f_house = a.f_house;

	DELETE FROM apartments WHERE f_flat IS NULL;

	SELECT
		add_technics(f_flat, f_technics, 2)
		,add_technics(f_flat, f_furniture, 1)
	FROM apartments;

	INSERT INTO INF_Descriptions (f_apatments_ads, s_descriptions)
	SELECT f_flat, s_description
	FROM apartments a
	WHERE f_flat||' '||s_description NOT IN (
		SELECT f_apatments_ads||' '||S_Descriptions FROM INF_Descriptions
	);

	INSERT INTO mn_ads_price (f_flat, n_price)
	WITH current_price (n_n, f_flat, n_price) AS
	(
		SELECT
			row_number() OVER (PARTITION BY f_flat ORDER BY d_date DESC)
			,f_flat
			,n_price
		FROM mn_ads_price
		)
	SELECT a.f_flat, a.m_price
	FROM apartments a
		INNER JOIN current_price p
			USING(f_flat)
	WHERE n_n = 1 AND a.m_price <> p.n_price;

	INSERT INTO mn_ads_price (f_flat, n_price)
	SELECT f_flat, m_price
	FROM apartments
	WHERE f_flat NOT IN (
		SELECT F_flat FROM mn_ads_price
		);







END; $$;
LANGUAGE plpgsql