-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-12-04 10:41:12.548

-- tables
-- Table: BF_Ads_Houses
CREATE TABLE BF_Ads_Houses (
    LINK Serial,
    S_Area Varchar(150)  NOT NULL,
    S_City varchar(150)  NOT NULL,
    S_District varchar(200)  NOT NULL,
    S_Street varchar(150)  NOT NULL,
    S_Type_Street varchar(100)  NOT NULL,
    N_Street smallint  NOT NULL,
    F_Qty_Room smallint  NOT NULL,
    N_House_Space smallint  NOT NULL,
    N_Yard_Space smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    S_Decorating int  NOT NULL,
    S_Floor smallint  NOT NULL,
    S_Ads_Type varchar(20)  NOT NULL,
    S_Category_Ground varchar(150)  NOT NULL,
    S_Materrial_Of_Walls varchar(150)  NOT NULL,
    S_Parking varchar(150)  NOT NULL,
    S_Kind_Of_Repair Varchar(150)  NOT NULL,
    S_Transport_Accessibility Varchar(150)  NOT NULL,
    S_Descriptions varchar  NOT NULL,
    S_Type_Of_Seller Varchar(150)  NOT NULL,
    S_Name_Company varchar(150)  NOT NULL,
    S_Name_Seller varchar(150)  NOT NULL,
    D_Date timestamp  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    F_Procedure_Session int  NOT NULL,
    CONSTRAINT BF_Ads_Houses_pk PRIMARY KEY (LINK)
);

-- Table: BF_Apartments_Ads
CREATE TABLE BF_Apartments_Ads (
    LINK Serial,
    S_Area varchar(150)  NOT NULL,
    S_City varchar(150)  NULL,
    S_District varchar(150)  NOT NULL,
    S_Type_Street Varchar(150)  NOT NULL,
    S_Street varchar(150)  NOT NULL,
    N_Street smallint  NOT NULL,
    F_Qty_Room smallint  NOT NULL,
    N_Qty_Total_Space decimal(6,2)  NOT NULL,
    N_Qty_Living_Space decimal(6,2)  NULL,
    N_Qty_Kitchen_Space decimal(6,2)  NOT NULL,
    M_Price money  NULL,
    N_Floor smallint  NULL,
    B_Balkony boolean  NOT NULL,
    B_Loggia boolean  NOT NULL,
    S_Type_Of_Room Varchar(150)  NOT NULL,
    S_Ads_Type varchar(20)  NOT NULL,
    N_Ceiling_Height decimal(4,2)  NOT NULL,
    S_Type_Bathroom Varchar(150)  NOT NULL,
    S_Window varchar(150)  NOT NULL,
    S_Kind_Of_Repair Varchar(150)  NOT NULL,
    B_Heating boolean  NOT NULL,
    S_Furniture varchar(500)  NOT NULL,
    S_Tehnics varchar(500)  NOT NULL,
    S_Decorating varchar(150)  NOT NULL,
    S_Method_Of_Sale Varchar(150)  NOT NULL,
    S_Type_Of_Transaction Varchar(150)  NOT NULL,
    S_Description varchar  NOT NULL,
    S_Type_House Varchar(150)  NOT NULL,
    N_Year_Building smallint  NOT NULL,
    N_Floor_In_House smallint  NOT NULL,
    B_Passenger_Elevator boolean  NOT NULL,
    B_Freight_Elevator boolean  NOT NULL,
    S_Yard varchar(500)  NOT NULL,
    S_Parking varchar(500)  NOT NULL,
    S_Name_New_Building varchar(150)  NOT NULL,
    S_Official_Builder Varchar(150)  NOT NULL,
    S_Type_of_Participation varchar(200)  NOT NULL,
    D_Deadline_for_Delivery varchar(150)  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    S_Type_Of_Seller varchar(150)  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    F_Sourse smallint  NOT NULL,
    D_Date timestamp  NOT NULL,
    F_Procedure_Session int  NOT NULL,
    CONSTRAINT BF_Apartments_Ads_pk PRIMARY KEY (LINK)
);

-- Table: BF_Commercial_Real_Estate
CREATE TABLE BF_Commercial_Real_Estate (
    LINK Serial,
    F_Kinde_Of_Repaire smallint  NOT NULL,
    S_Area Varchar(150)  NOT NULL,
    S_City Varchar(150)  NULL,
    S_District varchar(150)  NOT NULL,
    S_Type_Street smallint  NOT NULL,
    N_Street smallint  NOT NULL,
    F_Floor smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    F_Power_Grid_Capacity smallint  NOT NULL,
    F_Type_Of_Transaction smallint  NOT NULL,
    F_Readings smallint  NOT NULL,
    F_Type_House smallint  NOT NULL,
    F_Distance_From_Road smallint  NOT NULL,
    F_Parking smallint  NOT NULL,
    N_Qty_Parking_Place smallint  NOT NULL,
    F_Type_Of_Seller smallint  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    D_Date timestamp  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    F_Procedure_Session int  NOT NULL,
    CONSTRAINT BF_Commercial_Real_Estate_pk PRIMARY KEY (LINK)
);

-- Table: BF_Temp_Ads_Houses
CREATE TABLE BF_Temp_Ads_Houses (
    LINK Serial,
    S_Area Varchar(150)  NOT NULL,
    S_City varchar(150)  NOT NULL,
    S_Street varchar(150)  NOT NULL,
    S_Type_Street varchar(100)  NOT NULL,
    N_Street smallint  NOT NULL,
    F_Qty_Room smallint  NOT NULL,
    N_House_Space smallint  NOT NULL,
    S_Ads_Type varchar(20)  NOT NULL,
    N_Yard_Space smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    S_Floor smallint  NOT NULL,
    S_Technics varchar(20)  NULL,
    S_Category_Ground varchar(150)  NOT NULL,
    S_Materrial_Of_Walls varchar(150)  NOT NULL,
    S_Parking varchar(150)  NOT NULL,
    S_Kind_Of_Repair Varchar(150)  NOT NULL,
    S_Transport_Accessibility Varchar(150)  NOT NULL,
    S_District varchar(200)  NOT NULL,
    S_Descriptions varchar  NOT NULL,
    S_Type_Of_Seller Varchar(150)  NOT NULL,
    S_Name_Company varchar(150)  NOT NULL,
    S_Name_Seller varchar(150)  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    D_Date timestamp  NULL,
    F_Sourse smallint  NOT NULL,
    S_Decorating int  NOT NULL,
    CONSTRAINT BF_Temp_Ads_Houses_pk PRIMARY KEY (LINK)
);

-- Table: BF_Temp_Apartments_Ads
CREATE TABLE BF_Temp_Apartments_Ads (
    LINK Serial,
    S_Area varchar(150)  NOT NULL,
    S_City varchar(150)  NULL,
    S_District varchar(150)  NOT NULL,
    S_Type_Street Varchar(150)  NOT NULL,
    S_Street varchar(150)  NOT NULL,
    N_Street smallint  NOT NULL,
    S_Qty_Room varchar(20)  NOT NULL,
    N_Qty_Total_Space decimal(6,2)  NOT NULL,
    N_Qty_Living_Space decimal(6,2)  NULL,
    N_Qty_Kitchen_Space decimal(6,2)  NOT NULL,
    M_Price money  NULL,
    N_Floor smallint  NULL,
    B_Balcony boolean  NOT NULL,
    B_Loggia boolean  NOT NULL,
    S_Type_Of_Room Varchar(150)  NOT NULL,
    S_Ads_Type varchar(20)  NOT NULL,
    N_Ceiling_Height decimal(4,2)  NOT NULL,
    S_Type_Bathroom Varchar(150)  NOT NULL,
    S_Window varchar(150)  NOT NULL,
    S_Kind_Of_Repair Varchar(150)  NOT NULL,
    B_Heating boolean  NOT NULL,
    S_Furniture varchar(500)  NOT NULL,
    S_Technics varchar(500)  NOT NULL,
    S_Decorating varchar(150)  NOT NULL,
    S_Method_Of_Sale Varchar(150)  NOT NULL,
    S_Type_Of_Transaction varchar(150)  NOT NULL,
    S_Description varchar  NOT NULL,
    S_Type_House Varchar(150)  NOT NULL,
    N_Year_Building smallint  NOT NULL,
    N_Floor_In_House smallint  NOT NULL,
    B_Passenger_Elevator boolean  NOT NULL,
    B_Freight_Elevator boolean  NOT NULL,
    S_Yard varchar(500)  NOT NULL,
    S_Parking varchar(500)  NOT NULL,
    S_Name_New_Building varchar(150)  NOT NULL,
    S_Official_Builder Varchar(150)  NOT NULL,
    S_Type_of_Participation varchar(200)  NOT NULL,
    D_Deadline_for_Delivery varchar(100)  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    S_Type_Of_Seller varchar(150)  NOT NULL,
    F_Sourse smallint  NOT NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT BF_Temp_Apartments_Ads_pk PRIMARY KEY (LINK)
);

-- Table: BF_Temp_Commercial_Real_Estate
CREATE TABLE BF_Temp_Commercial_Real_Estate (
    LINK Serial,
    F_Kinde_Of_Repaire smallint  NOT NULL,
    S_Area Varchar(150)  NOT NULL,
    S_City Varchar(150)  NULL,
    S_District varchar(150)  NOT NULL,
    S_Type_Street smallint  NOT NULL,
    N_Street smallint  NOT NULL,
    F_Floor smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    F_Power_Grid_Capacity smallint  NOT NULL,
    F_Type_Of_Transaction smallint  NOT NULL,
    F_Readings smallint  NOT NULL,
    F_Type_House smallint  NOT NULL,
    F_Distance_From_Road smallint  NOT NULL,
    F_Parking smallint  NOT NULL,
    N_Qty_Parking_Place smallint  NOT NULL,
    F_Type_Of_Seller smallint  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    D_Date timestamp  NULL,
    F_Sourse smallint  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    CONSTRAINT BF_Temp_Commercial_Real_Estate_pk PRIMARY KEY (LINK)
);

-- Table: FS_Ads_Object
CREATE TABLE FS_Ads_Object (
    LINK smallserial,
    C_Name Varchar(100)  NOT NULL,
    CONSTRAINT FS_Ads_Object_pk PRIMARY KEY (LINK)
);

-- Table: FS_Announcement
CREATE TABLE FS_Announcement (
    LINK smallserial,
    C_Name Varchar(150)  NULL,
    CONSTRAINT FS_Announcement_pk PRIMARY KEY (LINK)
);

-- Table: FS_Area
CREATE TABLE FS_Area (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Area_pk PRIMARY KEY (LINK)
);

-- Table: FS_Category_Ground
CREATE TABLE FS_Category_Ground (
    LINK smallserial,
    C_Name Varchar(100)  NULL,
    CONSTRAINT FS_Category_Ground_pk PRIMARY KEY (LINK)
);

-- Table: FS_City
CREATE TABLE FS_City (
    LINK smallserial,
    N_Code smallint  NOT NULL,
    C_Name varchar(200)  NOT NULL,
    F_Area smallint  NOT NULL,
    CONSTRAINT FS_City_pk PRIMARY KEY (LINK)
);

-- Table: FS_Decorating_Type
CREATE TABLE FS_Decorating_Type (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Decorating_Type_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Decorating_Type IS 'Таблица с видами отделки';

-- Table: FS_Distance_From_Road
CREATE TABLE FS_Distance_From_Road (
    LINK smallserial,
    C_Name varchar(250)  NOT NULL,
    CONSTRAINT FS_Distance_From_Road_pk PRIMARY KEY (LINK)
);

-- Table: FS_District
CREATE TABLE FS_District (
    LINK smallserial,
    N_Code smallint  NOT NULL,
    C_Name Varchar(150)  NOT NULL,
    F_City smallint  NOT NULL,
    CONSTRAINT FS_District_pk PRIMARY KEY (LINK)
);

-- Table: FS_Floor
CREATE TABLE FS_Floor (
    LINK smallserial,
    N_Code int  NOT NULL,
    C_Name varchar(100)  NOT NULL,
    CONSTRAINT FS_Floor_pk PRIMARY KEY (LINK)
);

-- Table: FS_Furniture
CREATE TABLE FS_Furniture (
    LINK smallserial,
    C_Name varchar(400)  NOT NULL,
    CONSTRAINT FS_Furniture_pk PRIMARY KEY (LINK)
);

-- Table: FS_Index_Polution
CREATE TABLE FS_Index_Pollution (
    LINK smallserial,
    C_Name varchar(15)  NOT NULL,
    CONSTRAINT FS_Index_Pollution_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Index_Pollution IS 'Справочная таблица с индексами загрязнения воздуха
';

-- Table: FS_Materrial_Of_Walls
CREATE TABLE FS_Materrial_Of_Walls (
    LINK smallserial,
    C_Name varchar(150)  NULL,
    CONSTRAINT FS_Materrial_Of_Walls_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Materrial_Of_Walls IS 'Справочная таблица о материале стен
';

-- Table: FS_Method_Of_Sale
CREATE TABLE FS_Method_Of_Sale (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Method_Of_Sale_pk PRIMARY KEY (LINK)
);

-- Table: FS_Objects_Type
CREATE TABLE FS_Objects_Type (
    LINK smallserial,
    C_Name varchar(20)  NOT NULL,
    CONSTRAINT FS_Objects_Type_pk PRIMARY KEY (LINK)
);

-- Table: FS_Optional_Field
CREATE TABLE FS_Optional_Field (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Optional_Field_pk PRIMARY KEY (LINK)
);

-- Table: FS_Options
CREATE TABLE FS_Options (
    LINK smallserial,
    C_Name Varchar(100)  NULL,
    CONSTRAINT FS_Options_pk PRIMARY KEY (LINK)
);

-- Table: FS_Parking
CREATE TABLE FS_Parking (
    LINK smallserial,
    C_Name varchar(100)  NOT NULL,
    CONSTRAINT FS_Parking_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Parking IS 'Справочная таблица о видах парковки';

-- Table: FS_Parking_Space
CREATE TABLE FS_Parking_Space (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Parking_Space_pk PRIMARY KEY (LINK)
);

-- Table: FS_Power_Grid_Capacity
CREATE TABLE FS_Power_Grid_Capacity (
    LINK smallserial,
    N_Qty smallint  NOT NULL,
    F_Unit smallint  NOT NULL,
    CONSTRAINT FS_Power_Grid_Capacity_pk PRIMARY KEY (LINK)
);

-- Table: FS_Qty_Room
CREATE TABLE FS_Qty_Room (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Qty_Room_pk PRIMARY KEY (LINK)
);

-- Table: FS_Readings
CREATE TABLE FS_Readings (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Readings_pk PRIMARY KEY (LINK)
);

-- Table: FS_Session
CREATE TABLE FS_Session (
    LINK serial,
    S_SourceName varchar(100)  NOT NULL,
    CONSTRAINT FS_Session_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Session IS 'Таблица с типами сессии';

-- Table: FS_Source
CREATE TABLE FS_Source (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    C_Const varchar(50)  NOT NULL,
    S_Domen varchar(250)  NOT NULL,
    CONSTRAINT FS_Source_pk PRIMARY KEY (LINK)
);

-- Table: FS_Status_Of_Ads
CREATE TABLE FS_Status_Of_Ads (
    LINK smallserial,
    N_Code Varchar(10)  NULL,
    C_Name Varchar(100)  NOT NULL,
    CONSTRAINT FS_Status_Of_Ads_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Status_Of_Ads IS 'Справочная таблица о статусах объявлений';

-- Table: FS_Street
CREATE TABLE FS_Street (
    LINK serial,
    F_District smallint  NOT NULL,
    F_Type_Street smallint  NOT NULL,
    C_Name Varchar(150)  NOT NULL,
    S_Number varchar(10)  NOT NULL,
    S_Index varchar(6)  NOT NULL,
    CONSTRAINT FS_Street_pk PRIMARY KEY (LINK)
);

-- Table: FS_Streets_Type
CREATE TABLE FS_Streets_Type (
    LINK smallserial,
    C_Name Varchar(150)  NOT NULL,
    Short_Name varchar(50)  NOT NULL,
    CONSTRAINT FS_Streets_Type_pk PRIMARY KEY (LINK)
);

-- Table: FS_Tehnics
CREATE TABLE FS_Tehnics (
    LINK smallserial,
    C_Name varchar(500)  NOT NULL,
    CONSTRAINT FS_Tehnics_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Tehnics IS 'Таблица о наличии техники в недвижимости
';

-- Table: FS_Transport_Accessibility
CREATE TABLE FS_Transport_Accessibility (
    LINK smallserial,
    C_Name varchar(250)  NULL,
    CONSTRAINT FS_Transport_Accessibility_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_Bathroom
CREATE TABLE FS_Type_Bathroom (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Type_Bathroom_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_House
CREATE TABLE FS_Type_House (
    LINK smallserial,
    C_Name Varchar(100)  NOT NULL,
    CONSTRAINT FS_Type_House_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE FS_Type_House IS 'Справочная таблица с типами приборов';

-- Table: FS_Type_Of_Estate
CREATE TABLE FS_Type_Of_Estate (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Type_Of_Estate_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_Of_Living
CREATE TABLE FS_Type_Of_Living (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Type_Of_Living_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_Of_Room
CREATE TABLE FS_Type_Of_Room (
    LINK smallserial,
    C_Name varchar(100)  NULL,
    CONSTRAINT FS_Type_Of_Room_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_Of_Seller
CREATE TABLE FS_Type_Of_Seller (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Type_Of_Seller_pk PRIMARY KEY (LINK)
);

-- Table: FS_Type_Of_Transaction
CREATE TABLE FS_Type_Of_Transaction (
    LINK smallserial,
    C_Name varchar(150)  NOT NULL,
    CONSTRAINT FS_Type_Of_Transaction_pk PRIMARY KEY (LINK)
);

-- Table: FS_Unit
CREATE TABLE FS_Unit (
    LINK smallserial,
    C_Name Varchar(100)  NOT NULL,
    CONSTRAINT FS_Unit_pk PRIMARY KEY (LINK)
);

-- Table: FS_Window
CREATE TABLE FS_Window (
    LINK smallserial,
    C_Name varchar(100)  NOT NULL,
    CONSTRAINT FS_Window_pk PRIMARY KEY (LINK)
);

-- Table: FS_Yard
CREATE TABLE FS_Yard (
    LINK smallserial,
    C_Name varchar(500)  NOT NULL,
    CONSTRAINT FS_Yard_pk PRIMARY KEY (LINK)
);

-- Table: INF_Air_Pollution
CREATE TABLE INF_Air_Pollition (
    LINK serial,
    F_City smallint  NOT NULL,
    F_Index smallint  NOT NULL,
    N_CC decimal(6,3)  NOT NULL,
    N_NO decimal(6,3)  NOT NULL,
    N_NO2 decimal(6,3)  NOT NULL,
    N_O3 decimal(6,3)  NOT NULL,
    N_SO2 decimal(6,3)  NOT NULL,
    N_PM2_5 decimal(6,3)  NOT NULL,
    N_PM10 decimal(6,3)  NOT NULL,
    N_NH3 decimal(6,3)  NOT NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT INF_Air_Pollition_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE INF_Air_Pollition IS 'Таблица с информации по общей оценке качества воздуха';

-- Table: INF_Descriptions
CREATE TABLE INF_Descriptions (
    LINK serial,
    F_Apatments_Ads int  NULL,
    F_Ads_Houses int  NULL,
    F_Commercial_Real_Estate int  NULL,
    S_Descriptions varchar  NOT NULL,
    D_Date_Create timestamp  NOT NULL,
    CONSTRAINT INF_Descriptions_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE INF_Descriptions IS 'Таблица которая содержит описание от объявлений ';

-- Table: INF_Index_Of_Live
CREATE TABLE INF_Index_Of_Live (
    LINK serial,
    F_City smallint  NOT NULL,
    N_Year smallint  NOT NULL,
    N_Rate decimal(3,2)  NOT NULL,
    D_Create_Date timestamp  NOT NULL,
    CONSTRAINT INF_Index_Of_Live_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE INF_Index_Of_Live IS 'Таблица с индексами стоимости жизни';

-- Table: INF_Links_Of_Site
CREATE TABLE INF_Links_Of_Site (
    LINK smallserial,
    F_Apatments_Ads int  NULL,
    F_Ads_Houses int  NULL,
    F_Commercial_Real_Estate int  NULL,
    D_Date_Create timestamp  NOT NULL,
    S_Site_Links varchar  NOT NULL,
    CONSTRAINT INF_Links_Of_Site_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE INF_Links_Of_Site IS 'Таблица с сылками от сайтов ';

-- Table: LG_Procedure_Session
CREATE TABLE LG_Procedure_Session (
    LINK serial,
    F_Session int  NOT NULL,
    D_Date_Start timestamp  NOT NULL,
    D_Date_End timestamp  NOT NULL,
    CONSTRAINT LG_Procedure_Session_pk PRIMARY KEY (LINK)
);

-- Table: LG_Session_LOG
CREATE TABLE LG_Session_LOG (
    LINK serial,
    F_Procedure_Session int  NOT NULL,
    S_Description varchar(250)  NOT NULL,
    S_Status Varchar(5)  NOT NULL,
    N_Eroor smallint  NOT NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT LG_Session_LOG_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE LG_Session_LOG IS 'Таблица с детальным логированием ';

-- Table: MN_Ads_Houses
CREATE TABLE MN_Ads_Houses (
    LINK serial,
    F_Area smallint  NOT NULL,
    F_City smallint  NOT NULL,
    F_District smallint  NOT NULL,
    F_Street int  NOT NULL,
    N_Qty_Floor smallint  NOT NULL,
    F_Qty_Room smallint  NULL,
    FS_Ads_Object_LINK smallint  NOT NULL,
    N_House_Space smallint  NOT NULL,
    N_Yard_Space smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    F_Category_Ground smallint  NOT NULL,
    F_Materrial_Of_Walls smallint  NULL,
    F_Parking smallint  NOT NULL,
    F_Yard smallint  NULL,
    F_Tehnics smallint  NULL,
    F_Furniture smallint  NOT NULL,
    F_Kind_Of_Repair smallint  NOT NULL,
    F_Decorating_Type smallint  NULL,
    F_Transport_Accessibility smallint  NOT NULL,
    F_Type_Of_Seller smallint  NOT NULL,
    S_Name_Company varchar(150)  NOT NULL,
    S_Name_Seller varchar(150)  NOT NULL,
    F_Sourse smallint  NOT NULL,
    F_Status_Of_Ads smallint  NOT NULL,
    D_Date timestamp  NULL,
    CONSTRAINT MN_Ads_Houses_pk PRIMARY KEY (LINK)
);

-- Table: MN_Apartments_Ads
CREATE TABLE MN_Apartments_Ads (
    LINK serial,
    F_House int  NOT NULL,
    F_Qty_Room smallint  NOT NULL,
    N_Qty_Total_Space decimal(6,2)  NOT NULL,
    N_Qty_Living_Space decimal(6,2)  NULL,
    N_Qty_Kitchen_Space decimal(6,2)  NOT NULL,
    M_Price money  NULL,
    F_Floor smallint  NOT NULL,
    F_Tehnics smallint  NULL,
    F_Furniture smallint  NOT NULL,
    F_Decorating_Type smallint  NULL,
    B_Loggia boolean  NOT NULL,
    B_Balkony boolean  NOT NULL,
    F_Ads_Object smallint  NOT NULL,
    F_Type_Of_Room smallint  NOT NULL,
    N_Ceiling_Height decimal(4,2)  NOT NULL,
    F_Type_Bathroom smallint  NOT NULL,
    F_Window smallint  NOT NULL,
    F_Kind_Of_Repair smallint  NOT NULL,
    B_Heating boolean  NOT NULL,
    F_Method_Of_Sale smallint  NOT NULL,
    F_Type_Of_Transaction smallint  NOT NULL,
    S_Description varchar  NOT NULL,
    S_Type_of_Participation varchar(200)  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    F_Type_Of_Seller smallint  NOT NULL,
    F_Status_Of_Ads smallint  NOT NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT MN_Apartments_Ads_pk PRIMARY KEY (LINK)
);

-- Table: MN_Commercial_Real_Estate
CREATE TABLE MN_Commercial_Real_Estate (
    LINK SERIAL,
    F_House int  NOT NULL,
    F_Kinde_Of_Repaire smallint  NOT NULL,
    F_Floor smallint  NOT NULL,
    N_Ceiling_Height decimal(6,2)  NOT NULL,
    F_Power_Grid_Capacity smallint  NOT NULL,
    F_Type_Of_Transaction smallint  NOT NULL,
    F_Readings smallint  NOT NULL,
    F_Distance_From_Road smallint  NOT NULL,
    N_Qty_Parking_Place smallint  NOT NULL,
    F_Type_Of_Seller smallint  NOT NULL,
    S_Name_Company Varchar(150)  NOT NULL,
    S_Name_Seller Varchar(150)  NOT NULL,
    F_Sourse smallint  NOT NULL,
    F_Status_Of_Ads smallint  NOT NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT MN_Commercial_Real_Estate_pk PRIMARY KEY (LINK)
);

-- Table: MN_History_Of_Price
CREATE TABLE MN_History_Of_Price (
    LINK SERIAL,
    F_Apatments_Ads int  NULL,
    F_Ads_Houses int  NULL,
    F_Commercial_Real_Estate int  NULL,
    D_Date timestamp  NOT NULL,
    N_Price money  NOT NULL,
    CONSTRAINT MN_History_Of_Price_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE MN_History_Of_Price IS 'Таблица с историей цен ';

-- Table: MN_History_Of_Status
CREATE TABLE MN_History_Of_Status (
    LINK SERIAL,
    F_Apatments_Ads int  NOT NULL,
    F_Ads_Houses int  NULL,
    F_Commercial_Real_Estate int  NULL,
    D_Start_Date timestamp  NOT NULL,
    D_End_Date timestamp  NULL,
    CONSTRAINT MN_History_Of_Status_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE MN_History_Of_Status IS 'Табл с активностью объявления ';

-- Table: MN_House
CREATE TABLE MN_House (
    LINK SERIAL,
    F_Area smallint  NOT NULL,
    F_City smallint  NOT NULL,
    F_District smallint  NULL,
    F_Street int  NOT NULL,
    N_Qty_Floor smallint  NOT NULL,
    N_Year_Bealding int  NOT NULL,
    B_Passenger_Elevator boolean  NULL,
    B_Freight_Elevator int  NULL,
    F_Parking smallint  NULL,
    F_Yard smallint  NULL,
    F_Type_House smallint  NOT NULL,
    F_Official_Builder smallint  NOT NULL,
    S_Name_New_Building varchar(150)  NULL,
    D_Deadline_for_Delivery timestamp  NULL,
    D_Create_Date timestamp  NOT NULL,
    CONSTRAINT MN_House_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE MN_House IS 'Таблица которая содержит информацию о доме ';

-- Table: MN_Official_Builder
CREATE TABLE MN_Official_Builder (
    LINK SERIAL,
    C_Name varchar(150)  NOT NULL,
    S_Contact varchar(150)  NULL,
    D_Date_Create timestamp  NOT NULL,
    CONSTRAINT MN_Official_Builder_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE MN_Official_Builder IS 'Таблица застройщиков ';

-- Table: MN_Period_Deadline
CREATE TABLE MN_Period_Deadline (
    LINK SERIAL,
    F_House int  NOT NULL,
    D_Date_Start timestamp  NOT NULL,
    D_Date_End timestamp  NOT NULL,
    D_Create_Date timestamp  NOT NULL,
    CONSTRAINT MN_Period_Deadline_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE MN_Period_Deadline IS ' Таблица с периодом сдачи дома
';

-- Table: PS_Ads_Position
CREATE TABLE PS_Ads_Position (
    LINK SERIAL,
    F_City smallint  NOT NULL,
    F_Commercial_Real_Estate int  NOT NULL,
    F_Ads_Houses int  NOT NULL,
    F_Apatments_Ads int  NOT NULL,
    N_latitude decimal(7,4)  NULL,
    N_Lontitude decimal(6,4)  NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT PS_Ads_Position_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE PS_Ads_Position IS 'Таблица с координатами недвижимостью';

-- Table: PS_Distance_Ads_To_Objects
CREATE TABLE PS_Distance_Ads_To_Objects (
    LINK SERIAL,
    F_City smallint  NOT NULL,
    F_Commercial_Real_Estate_ int  NOT NULL,
    F_Ads_Houses int  NOT NULL,
    F_Apatments_Ads int  NOT NULL,
    F_Object_Position int  NOT NULL,
    N_Distance int  NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT PS_Distance_Ads_To_Objects_pk PRIMARY KEY (LINK)
);

-- Table: PS_Object_Position
CREATE TABLE PS_Object_Position (
    LINK SERIAL,
    F_City smallint  NOT NULL,
    F_Street int  NOT NULL,
    F_Objects smallint  NOT NULL,
    N_latitude decimal(7,4)  NULL,
    N_Lontitude decimal(6,4)  NULL,
    D_Date timestamp  NOT NULL,
    CONSTRAINT PS_Object_Position_pk PRIMARY KEY (LINK)
);

COMMENT ON TABLE PS_Object_Position IS 'Таблица координат объектов рядом с недвижимостью';

-- Table: S_Kind_Of_Repair
CREATE TABLE S_Kind_Of_Repair (
    LINK SMALLSERIAL,
    C_Name varchar(100)  NULL,
    CONSTRAINT S_Kind_Of_Repair_pk PRIMARY KEY (LINK)
);

-- views
-- View: VW_Apatments_Ads
CREATE VIEW VW_Apartments_Ads AS
SELECT * FROM MN_Apartments_Ads;

COMMENT ON VIEW VW_Apartments_Ads IS 'Вьюха для вывода информацию по квартирам';

-- View: VW_Ads_Houses
CREATE VIEW VW_Ads_Houses AS
SELECT * FROM MN_Ads_Houses;

COMMENT ON VIEW VW_Ads_Houses IS 'Вьха для вывода обьявлений по домам';

-- View: VW_Commercial_Real_Estate
CREATE VIEW VW_Commercial_Real_Estate AS
SELECT * FROM MN_Commercial_Real_Estate;

COMMENT ON VIEW VW_Commercial_Real_Estate IS 'Вьха по объявлению о продаже недвижимости ';

-- foreign keys
-- Reference: BF_Ads_Houses_FS_Category_Ground (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Category_Ground
    FOREIGN KEY (F_Category_Ground)
    REFERENCES FS_Category_Ground (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Kinde_Of_Repaire (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Kinde_Of_Repaire
    FOREIGN KEY (F_Kind_Of_Repair)
    REFERENCES S_Kind_Of_Repair (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Materrial_Of_Walls (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Materrial_Of_Walls
    FOREIGN KEY (F_Materrial_Of_Walls)
    REFERENCES FS_Materrial_Of_Walls (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Parking (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Parking
    FOREIGN KEY (F_Parking)
    REFERENCES FS_Parking (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Qty_Room (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Qty_Room
    FOREIGN KEY (F_Qty_Room)
    REFERENCES FS_Qty_Room (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Sourse (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Transport_Accessibility (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Transport_Accessibility
    FOREIGN KEY (F_Transport_Accessibility)
    REFERENCES FS_Transport_Accessibility (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_FS_Type_Of_Seller (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_FS_Type_Of_Seller
    FOREIGN KEY (F_Type_Of_Seller)
    REFERENCES FS_Type_Of_Seller (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Ads_Houses_LG_Procedure_Session (table: BF_Ads_Houses)
ALTER TABLE BF_Ads_Houses ADD CONSTRAINT BF_Ads_Houses_LG_Procedure_Session
    FOREIGN KEY (F_Procedure_Session)
    REFERENCES LG_Procedure_Session (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Floor (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Floor
    FOREIGN KEY (F_Floor)
    REFERENCES FS_Floor (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Kinde_Of_Repaire (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Kinde_Of_Repaire
    FOREIGN KEY (F_Kind_Of_Repair)
    REFERENCES S_Kind_Of_Repair (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Method_Of_Sale (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Method_Of_Sale
    FOREIGN KEY (F_Method_Of_Sale)
    REFERENCES FS_Method_Of_Sale (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Qty_Room (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Qty_Room
    FOREIGN KEY (F_Qty_Room)
    REFERENCES FS_Qty_Room (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Sourse (table: BF_Apartments_Ads)
ALTER TABLE BF_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Type_Bathroom (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Type_Bathroom
    FOREIGN KEY (F_Type_Bathroom)
    REFERENCES FS_Type_Bathroom (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Type_Of_Room (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Room
    FOREIGN KEY (F_Type_Of_Room)
    REFERENCES FS_Type_Of_Room (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Type_Of_Seller (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Seller
    FOREIGN KEY (F_Type_Of_Seller)
    REFERENCES FS_Type_Of_Seller (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Type_Of_Transaction (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Transaction
    FOREIGN KEY (F_Type_Of_Transaction)
    REFERENCES FS_Type_Of_Transaction (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_FS_Window (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_FS_Window
    FOREIGN KEY (F_Window)
    REFERENCES FS_Window (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Apatments_Ads_LG_Procedure_Session (table: BF_Apartments_Ads)
ALTER TABLE BF_Apartments_Ads ADD CONSTRAINT BF_Apatments_Ads_LG_Procedure_Session
    FOREIGN KEY (F_Procedure_Session)
    REFERENCES LG_Procedure_Session (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Distance_From_Road (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Distance_From_Road
    FOREIGN KEY (F_Distance_From_Road)
    REFERENCES FS_Distance_From_Road (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Floor (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Floor
    FOREIGN KEY (F_Floor)
    REFERENCES FS_Floor (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Kinde_Of_Repaire (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Kinde_Of_Repaire
    FOREIGN KEY (F_Kinde_Of_Repaire)
    REFERENCES S_Kind_Of_Repair (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Power_Grid_Capacity (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Power_Grid_Capacity
    FOREIGN KEY (F_Power_Grid_Capacity)
    REFERENCES FS_Power_Grid_Capacity (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Readings (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Readings
    FOREIGN KEY (F_Readings)
    REFERENCES FS_Readings (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Sourse (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Type_Of_Seller (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Type_Of_Seller
    FOREIGN KEY (F_Type_Of_Seller)
    REFERENCES FS_Type_Of_Seller (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_FS_Type_Of_Transaction (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_FS_Type_Of_Transaction
    FOREIGN KEY (F_Type_Of_Transaction)
    REFERENCES FS_Type_Of_Transaction (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Commercial_Real_Estate_LG_Procedure_Session (table: BF_Commercial_Real_Estate)
ALTER TABLE BF_Commercial_Real_Estate ADD CONSTRAINT BF_Commercial_Real_Estate_LG_Procedure_Session
    FOREIGN KEY (F_Procedure_Session)
    REFERENCES LG_Procedure_Session (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Temp_Ads_Houses_FS_Sourse (table: BF_Temp_Ads_Houses)
ALTER TABLE BF_Temp_Ads_Houses ADD CONSTRAINT BF_Temp_Ads_Houses_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Temp_Apatments_Ads_FS_Sourse (table: BF_Temp_Apartments_Ads)
ALTER TABLE BF_Temp_Apartments_Ads ADD CONSTRAINT BF_Temp_Apatments_Ads_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: BF_Temp_Commercial_Real_Estate_FS_Sourse (table: BF_Temp_Commercial_Real_Estate)
ALTER TABLE BF_Temp_Commercial_Real_Estate ADD CONSTRAINT BF_Temp_Commercial_Real_Estate_FS_Sourse
    FOREIGN KEY (F_Sourse)
    REFERENCES FS_Source (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FS_City_FS_Area (table: FS_City)
ALTER TABLE FS_City ADD CONSTRAINT FS_City_FS_Area
    FOREIGN KEY (F_Area)
    REFERENCES FS_Area (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FS_District_FS_City (table: FS_District)
ALTER TABLE FS_District ADD CONSTRAINT FS_District_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FS_Power_Grid_Capacity_FS_Unit (table: FS_Power_Grid_Capacity)
ALTER TABLE FS_Power_Grid_Capacity ADD CONSTRAINT FS_Power_Grid_Capacity_FS_Unit
    FOREIGN KEY (F_Unit)
    REFERENCES FS_Unit (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FS_Street_FS_District (table: FS_Street)
ALTER TABLE FS_Street ADD CONSTRAINT FS_Street_FS_District
    FOREIGN KEY (F_District)
    REFERENCES FS_District (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FS_Street_FS_Type_Street (table: FS_Street)
ALTER TABLE FS_Street ADD CONSTRAINT FS_Street_FS_Type_Street
    FOREIGN KEY (F_Type_Street)
    REFERENCES FS_Streets_Type (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Descriptions_MN_Ads_Houses (table: INF_Descriptions)
ALTER TABLE INF_Descriptions ADD CONSTRAINT INF_Descriptions_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Descriptions_MN_Apatments_Ads (table: INF_Descriptions)
ALTER TABLE INF_Descriptions ADD CONSTRAINT INF_Descriptions_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Descriptions_MN_Commercial_Real_Estate (table: INF_Descriptions)
ALTER TABLE INF_Descriptions ADD CONSTRAINT INF_Descriptions_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Index_Of_Live_FS_City (table: INF_Index_Of_Live)
ALTER TABLE INF_Index_Of_Live ADD CONSTRAINT INF_Index_Of_Live_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Links_Of_Site_MN_Ads_Houses (table: INF_Links_Of_Site)
ALTER TABLE INF_Links_Of_Site ADD CONSTRAINT INF_Links_Of_Site_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Links_Of_Site_MN_Apatments_Ads (table: INF_Links_Of_Site)
ALTER TABLE INF_Links_Of_Site ADD CONSTRAINT INF_Links_Of_Site_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: INF_Links_Of_Site_MN_Commercial_Real_Estate (table: INF_Links_Of_Site)
ALTER TABLE INF_Links_Of_Site ADD CONSTRAINT INF_Links_Of_Site_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Ads_Object (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Ads_Object
    FOREIGN KEY (FS_Ads_Object_LINK)
    REFERENCES FS_Ads_Object (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Area (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Area
    FOREIGN KEY (F_Area)
    REFERENCES FS_Area (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_City (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Decorating_Type (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Decorating_Type
    FOREIGN KEY (F_Decorating_Type)
    REFERENCES FS_Decorating_Type (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_District (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_District
    FOREIGN KEY (F_District)
    REFERENCES FS_District (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Furniture (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Furniture
    FOREIGN KEY (F_Furniture)
    REFERENCES FS_Furniture (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Status_Of_Ads (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Status_Of_Ads
    FOREIGN KEY (F_Status_Of_Ads)
    REFERENCES FS_Status_Of_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Street (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Street
    FOREIGN KEY (F_Street)
    REFERENCES FS_Street (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Tehnics (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Tehnics
    FOREIGN KEY (F_Tehnics)
    REFERENCES FS_Tehnics (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Ads_Houses_FS_Yard (table: MN_Ads_Houses)
ALTER TABLE MN_Ads_Houses ADD CONSTRAINT MN_Ads_Houses_FS_Yard
    FOREIGN KEY (F_Yard)
    REFERENCES FS_Yard (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_FS_Ads_Object (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_FS_Ads_Object
    FOREIGN KEY (F_Ads_Object)
    REFERENCES FS_Ads_Object (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_FS_Decorating_Type (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_FS_Decorating_Type
    FOREIGN KEY (F_Decorating_Type)
    REFERENCES FS_Decorating_Type (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_FS_Furniture (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_FS_Furniture
    FOREIGN KEY (F_Furniture)
    REFERENCES FS_Furniture (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_FS_Status_Of_Ads (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_FS_Status_Of_Ads
    FOREIGN KEY (F_Status_Of_Ads)
    REFERENCES FS_Status_Of_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_FS_Tehnics (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_FS_Tehnics
    FOREIGN KEY (F_Tehnics)
    REFERENCES FS_Tehnics (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Apatments_Ads_MN_House (table: MN_Apartments_Ads)
ALTER TABLE MN_Apartments_Ads ADD CONSTRAINT MN_Apatments_Ads_MN_House
    FOREIGN KEY (F_House)
    REFERENCES MN_House (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Commercial_Real_Estate_FS_Status_Of_Ads (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT MN_Commercial_Real_Estate_FS_Status_Of_Ads
    FOREIGN KEY (F_Status_Of_Ads)
    REFERENCES FS_Status_Of_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Commercial_Real_Estate_MN_House (table: MN_Commercial_Real_Estate)
ALTER TABLE MN_Commercial_Real_Estate ADD CONSTRAINT MN_Commercial_Real_Estate_MN_House
    FOREIGN KEY (F_House)
    REFERENCES MN_House (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Price_MN_Ads_Houses (table: MN_History_Of_Price)
ALTER TABLE MN_History_Of_Price ADD CONSTRAINT MN_History_Of_Price_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Price_MN_Apatments_Ads (table: MN_History_Of_Price)
ALTER TABLE MN_History_Of_Price ADD CONSTRAINT MN_History_Of_Price_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Price_MN_Commercial_Real_Estate (table: MN_History_Of_Price)
ALTER TABLE MN_History_Of_Price ADD CONSTRAINT MN_History_Of_Price_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Status_MN_Ads_Houses (table: MN_History_Of_Status)
ALTER TABLE MN_History_Of_Status ADD CONSTRAINT MN_History_Of_Status_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Status_MN_Apatments_Ads (table: MN_History_Of_Status)
ALTER TABLE MN_History_Of_Status ADD CONSTRAINT MN_History_Of_Status_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_History_Of_Status_MN_Commercial_Real_Estate (table: MN_History_Of_Status)
ALTER TABLE MN_History_Of_Status ADD CONSTRAINT MN_History_Of_Status_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_Area (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_Area
    FOREIGN KEY (F_Area)
    REFERENCES FS_Area (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_City (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_District (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_District
    FOREIGN KEY (F_District)
    REFERENCES FS_District (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_Parking (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_Parking
    FOREIGN KEY (F_Parking)
    REFERENCES FS_Parking (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_Street (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_Street
    FOREIGN KEY (F_Street)
    REFERENCES FS_Street (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_Type_House (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_Type_House
    FOREIGN KEY (F_Type_House)
    REFERENCES FS_Type_House (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_FS_Yard (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_FS_Yard
    FOREIGN KEY (F_Yard)
    REFERENCES FS_Yard (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_House_MN_Official_Builder (table: MN_House)
ALTER TABLE MN_House ADD CONSTRAINT MN_House_MN_Official_Builder
    FOREIGN KEY (F_Official_Builder)
    REFERENCES MN_Official_Builder (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: MN_Period_Deadline_MN_House (table: MN_Period_Deadline)
ALTER TABLE MN_Period_Deadline ADD CONSTRAINT MN_Period_Deadline_MN_House
    FOREIGN KEY (F_House)
    REFERENCES MN_House (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Ads_Position_FS_City (table: PS_Ads_Position)
ALTER TABLE PS_Ads_Position ADD CONSTRAINT PS_Ads_Position_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Ads_Position_MN_Ads_Houses (table: PS_Ads_Position)
ALTER TABLE PS_Ads_Position ADD CONSTRAINT PS_Ads_Position_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Ads_Position_MN_Apatments_Ads (table: PS_Ads_Position)
ALTER TABLE PS_Ads_Position ADD CONSTRAINT PS_Ads_Position_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Ads_Position_MN_Commercial_Real_Estate (table: PS_Ads_Position)
ALTER TABLE PS_Ads_Position ADD CONSTRAINT PS_Ads_Position_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Distance_Ads_To_Objects_FS_City (table: PS_Distance_Ads_To_Objects)
ALTER TABLE PS_Distance_Ads_To_Objects ADD CONSTRAINT PS_Distance_Ads_To_Objects_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Distance_Ads_To_Objects_MN_Ads_Houses (table: PS_Distance_Ads_To_Objects)
ALTER TABLE PS_Distance_Ads_To_Objects ADD CONSTRAINT PS_Distance_Ads_To_Objects_MN_Ads_Houses
    FOREIGN KEY (F_Ads_Houses)
    REFERENCES MN_Ads_Houses (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Distance_Ads_To_Objects_MN_Apatments_Ads (table: PS_Distance_Ads_To_Objects)
ALTER TABLE PS_Distance_Ads_To_Objects ADD CONSTRAINT PS_Distance_Ads_To_Objects_MN_Apatments_Ads
    FOREIGN KEY (F_Apatments_Ads)
    REFERENCES MN_Apartments_Ads (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Distance_Ads_To_Objects_MN_Commercial_Real_Estate (table: PS_Distance_Ads_To_Objects)
ALTER TABLE PS_Distance_Ads_To_Objects ADD CONSTRAINT PS_Distance_Ads_To_Objects_MN_Commercial_Real_Estate
    FOREIGN KEY (F_Commercial_Real_Estate_)
    REFERENCES MN_Commercial_Real_Estate (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Distance_Ads_To_Objects_PS_Object_Position (table: PS_Distance_Ads_To_Objects)
ALTER TABLE PS_Distance_Ads_To_Objects ADD CONSTRAINT PS_Distance_Ads_To_Objects_PS_Object_Position
    FOREIGN KEY (F_Object_Position)
    REFERENCES PS_Object_Position (LINK)
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Object_Position_FS_City (table: PS_Object_Position)
ALTER TABLE PS_Object_Position ADD CONSTRAINT PS_Object_Position_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Object_Position_FS_Objects (table: PS_Object_Position)
ALTER TABLE PS_Object_Position ADD CONSTRAINT PS_Object_Position_FS_Objects
    FOREIGN KEY (F_Objects)
    REFERENCES FS_Objects_Type (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: PS_Object_Position_FS_Street (table: PS_Object_Position)
ALTER TABLE PS_Object_Position ADD CONSTRAINT PS_Object_Position_FS_Street
    FOREIGN KEY (F_Street)
    REFERENCES FS_Street (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: Table_71_FS_Session (table: LG_Procedure_Session)
ALTER TABLE LG_Procedure_Session ADD CONSTRAINT Table_71_FS_Session
    FOREIGN KEY (F_Session)
    REFERENCES FS_Session (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: Table_74_LG_Session_Time (table: LG_Session_LOG)
ALTER TABLE LG_Session_LOG ADD CONSTRAINT Table_74_LG_Session_Time
    FOREIGN KEY (F_Procedure_Session)
    REFERENCES LG_Procedure_Session (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: WT_Air_Polition_FS_City (table: INF_Air_Polition)
ALTER TABLE INF_Air_Pollition ADD CONSTRAINT WT_Air_Pollition_FS_City
    FOREIGN KEY (F_City)
    REFERENCES FS_City (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: WT_Air_Polition_FS_Index_Polution (table: INF_Air_Pollition)
ALTER TABLE INF_Air_Pollition ADD CONSTRAINT WT_Air_Pollition_FS_Index_Pollution
    FOREIGN KEY (F_Index)
    REFERENCES FS_Index_Pollution (LINK)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- sequences
-- Sequence: BF_Avito_seq
CREATE SEQUENCE BF_Avito_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- Sequence: FS_Type_Of_Estate_seq
CREATE SEQUENCE FS_Type_Of_Estate_seq
      INCREMENT BY 1
      NO MINVALUE
      NO MAXVALUE
      START WITH 1
      NO CYCLE
;

-- End of file.


