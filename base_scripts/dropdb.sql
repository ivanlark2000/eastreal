
-- views
DROP VIEW VW_Commercial_Real_Estate;

DROP VIEW VW_Ads_Houses;

DROP VIEW VW_Apatments_Ads;

-- foreign keys
ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Category_Ground;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Kinde_Of_Repaire;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Materrial_Of_Walls;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Parking;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Qty_Room;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Sourse;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Transport_Accessibility;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_FS_Type_Of_Seller;

ALTER TABLE BF_Ads_Houses
    DROP CONSTRAINT BF_Ads_Houses_LG_Procedure_Session;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Floor;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Kinde_Of_Repaire;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Method_Of_Sale;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Qty_Room;

ALTER TABLE BF_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Sourse;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Type_Bathroom;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Room;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Seller;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Type_Of_Transaction;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_FS_Window;

ALTER TABLE BF_Apatments_Ads
    DROP CONSTRAINT BF_Apatments_Ads_LG_Procedure_Session;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Distance_From_Road;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Floor;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Kinde_Of_Repaire;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Power_Grid_Capacity;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Readings;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Sourse;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Type_Of_Seller;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_FS_Type_Of_Transaction;

ALTER TABLE BF_Commercial_Real_Estate
    DROP CONSTRAINT BF_Commercial_Real_Estate_LG_Procedure_Session;

ALTER TABLE BF_Temp_Ads_Houses
    DROP CONSTRAINT BF_Temp_Ads_Houses_FS_Sourse;

ALTER TABLE BF_Temp_Apatments_Ads
    DROP CONSTRAINT BF_Temp_Apatments_Ads_FS_Sourse;

ALTER TABLE BF_Temp_Commercial_Real_Estate
    DROP CONSTRAINT BF_Temp_Commercial_Real_Estate_FS_Sourse;

ALTER TABLE FS_City
    DROP CONSTRAINT FS_City_FS_Area;

ALTER TABLE FS_District
    DROP CONSTRAINT FS_District_FS_City;

ALTER TABLE FS_Power_Grid_Capacity
    DROP CONSTRAINT FS_Power_Grid_Capacity_FS_Unit;

ALTER TABLE FS_Street
    DROP CONSTRAINT FS_Street_FS_District;

ALTER TABLE FS_Street
    DROP CONSTRAINT FS_Street_FS_Type_Street;

ALTER TABLE INF_Descriptions
    DROP CONSTRAINT INF_Descriptions_MN_Ads_Houses;

ALTER TABLE INF_Descriptions
    DROP CONSTRAINT INF_Descriptions_MN_Apatments_Ads;

ALTER TABLE INF_Descriptions
    DROP CONSTRAINT INF_Descriptions_MN_Commercial_Real_Estate;

ALTER TABLE INF_Index_Of_Live
    DROP CONSTRAINT INF_Index_Of_Live_FS_City;

ALTER TABLE INF_Links_Of_Site
    DROP CONSTRAINT INF_Links_Of_Site_MN_Ads_Houses;

ALTER TABLE INF_Links_Of_Site
    DROP CONSTRAINT INF_Links_Of_Site_MN_Apatments_Ads;

ALTER TABLE INF_Links_Of_Site
    DROP CONSTRAINT INF_Links_Of_Site_MN_Commercial_Real_Estate;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Ads_Object;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Area;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_City;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Decorating_Type;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_District;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Furniture;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Status_Of_Ads;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Street;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Tehnics;

ALTER TABLE MN_Ads_Houses
    DROP CONSTRAINT MN_Ads_Houses_FS_Yard;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_FS_Ads_Object;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_FS_Decorating_Type;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_FS_Furniture;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_FS_Status_Of_Ads;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_FS_Tehnics;

ALTER TABLE MN_Apatments_Ads
    DROP CONSTRAINT MN_Apatments_Ads_MN_House;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT MN_Commercial_Real_Estate_FS_Status_Of_Ads;

ALTER TABLE MN_Commercial_Real_Estate
    DROP CONSTRAINT MN_Commercial_Real_Estate_MN_House;

ALTER TABLE MN_History_Of_Price
    DROP CONSTRAINT MN_History_Of_Price_MN_Ads_Houses;

ALTER TABLE MN_History_Of_Price
    DROP CONSTRAINT MN_History_Of_Price_MN_Apatments_Ads;

ALTER TABLE MN_History_Of_Price
    DROP CONSTRAINT MN_History_Of_Price_MN_Commercial_Real_Estate;

ALTER TABLE MN_History_Of_Status
    DROP CONSTRAINT MN_History_Of_Status_MN_Ads_Houses;

ALTER TABLE MN_History_Of_Status
    DROP CONSTRAINT MN_History_Of_Status_MN_Apatments_Ads;

ALTER TABLE MN_History_Of_Status
    DROP CONSTRAINT MN_History_Of_Status_MN_Commercial_Real_Estate;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_Area;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_City;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_District;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_Parking;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_Street;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_Type_House;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_FS_Yard;

ALTER TABLE MN_House
    DROP CONSTRAINT MN_House_MN_Oficial_Builder;

ALTER TABLE PS_Ads_Position
    DROP CONSTRAINT PS_Ads_Position_FS_City;

ALTER TABLE PS_Ads_Position
    DROP CONSTRAINT PS_Ads_Position_MN_Ads_Houses;

ALTER TABLE PS_Ads_Position
    DROP CONSTRAINT PS_Ads_Position_MN_Apatments_Ads;

ALTER TABLE PS_Ads_Position
    DROP CONSTRAINT PS_Ads_Position_MN_Commercial_Real_Estate;

ALTER TABLE PS_Distance_Ads_To_Objects
    DROP CONSTRAINT PS_Distance_Ads_To_Objects_FS_City;

ALTER TABLE PS_Distance_Ads_To_Objects
    DROP CONSTRAINT PS_Distance_Ads_To_Objects_MN_Ads_Houses;

ALTER TABLE PS_Distance_Ads_To_Objects
    DROP CONSTRAINT PS_Distance_Ads_To_Objects_MN_Apatments_Ads;

ALTER TABLE PS_Distance_Ads_To_Objects
    DROP CONSTRAINT PS_Distance_Ads_To_Objects_MN_Commercial_Real_Estate;

ALTER TABLE PS_Distance_Ads_To_Objects
    DROP CONSTRAINT PS_Distance_Ads_To_Objects_PS_Object_Position;

ALTER TABLE PS_Object_Position
    DROP CONSTRAINT PS_Object_Position_FS_City;

ALTER TABLE PS_Object_Position
    DROP CONSTRAINT PS_Object_Position_FS_Objects;

ALTER TABLE PS_Object_Position
    DROP CONSTRAINT PS_Object_Position_FS_Street;

ALTER TABLE LG_Procedure_Session
    DROP CONSTRAINT Table_71_FS_Session;

ALTER TABLE LG_Session_LOG
    DROP CONSTRAINT Table_74_LG_Session_Time;

ALTER TABLE INF_Air_Polition
    DROP CONSTRAINT WT_Air_Polition_FS_City;

ALTER TABLE INF_Air_Polition
    DROP CONSTRAINT WT_Air_Polition_FS_Index_Polution;

-- tables
DROP TABLE BF_Ads_Houses;

DROP TABLE BF_Apatments_Ads;

DROP TABLE BF_Avito;

DROP TABLE BF_Commercial_Real_Estate;

DROP TABLE BF_Temp_Ads_Houses;

DROP TABLE BF_Temp_Apatments_Ads;

DROP TABLE BF_Temp_Commercial_Real_Estate;

DROP TABLE FS_Ads_Object;

DROP TABLE FS_Announcement;

DROP TABLE FS_Area;

DROP TABLE FS_Category_Ground;

DROP TABLE FS_City;

DROP TABLE FS_Decorating_Type;

DROP TABLE FS_Distance_From_Road;

DROP TABLE FS_District;

DROP TABLE FS_Floor;

DROP TABLE FS_Furniture;

DROP TABLE FS_Index_Polution;

DROP TABLE FS_Materrial_Of_Walls;

DROP TABLE FS_Method_Of_Sale;

DROP TABLE FS_Objects_Type;

DROP TABLE FS_Optional_Field;

DROP TABLE FS_Options;

DROP TABLE FS_Parking;

DROP TABLE FS_Parking_Space;

DROP TABLE FS_Power_Grid_Capacity;

DROP TABLE FS_Qty_Room;

DROP TABLE FS_Readings;

DROP TABLE FS_Session;

DROP TABLE FS_Source;

DROP TABLE FS_Status_Of_Ads;

DROP TABLE FS_Street;

DROP TABLE FS_Streets_Type;

DROP TABLE FS_Tehnics;

DROP TABLE FS_Transport_Accessibility;

DROP TABLE FS_Type_Bathroom;

DROP TABLE FS_Type_House;

DROP TABLE FS_Type_Of_Estate;

DROP TABLE FS_Type_Of_Living;

DROP TABLE FS_Type_Of_Room;

DROP TABLE FS_Type_Of_Seller;

DROP TABLE FS_Type_Of_Transaction;

DROP TABLE FS_Unit;

DROP TABLE FS_Window;

DROP TABLE FS_Yard;

DROP TABLE INF_Air_Polition;

DROP TABLE INF_Descriptions;

DROP TABLE INF_Index_Of_Live;

DROP TABLE INF_Links_Of_Site;

DROP TABLE LG_Procedure_Session;

DROP TABLE LG_Session_LOG;

DROP TABLE MN_Ads_Houses;

DROP TABLE MN_Apatments_Ads;

DROP TABLE MN_Commercial_Real_Estate;

DROP TABLE MN_History_Of_Price;

DROP TABLE MN_History_Of_Status;

DROP TABLE MN_House;

DROP TABLE MN_Oficial_Builder;

DROP TABLE PS_Ads_Position;

DROP TABLE PS_Distance_Ads_To_Objects;

DROP TABLE PS_Object_Position;

DROP TABLE S_Kind_Of_Repair;

-- sequences
DROP SEQUENCE IF EXISTS BF_Avito_seq;

DROP SEQUENCE IF EXISTS FS_Type_Of_Estate_seq;

-- End of file.

