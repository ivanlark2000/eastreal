--Процедура загрузки файла гис жкх
--CREATE DATE 2023.01.21

CREATE OR REPLACE PROCEDURE load_gis_ghk(path varchar(400))
AS
$BODY$    

BEGIN

    DROP TABLE IF EXISTS gis_ghk_temp;

    CREATE TEMPORARY TABLE gis_ghk_temp (
        addres varchar(1000),
        id_gis char(36),
        gl_id_fias char(36),
        oktmo varchar(250),
        control_method varchar(200),
        ogrn varchar(200),
        kpp varchar(200),
        org_control_house varchar(1000),
        type_house varchar(200),
        condition varchar(200),
        total_area varchar(200),
        living_area varchar(200),
        some_col  varchar(500),
        some_col1 varchar(500),
        some_col2 varchar(500),
        type_block varchar(500),
        some_col4 varchar(500),
        some_col5 varchar(500),
        some_col8 varchar(500),
        kadastr_number varchar(250),
        global_id_house char(36),
        global_id_pom char(36),
        some_col7 varchar(500)
    );

    RAISE NOTICE 'Созданна временная таблица';
    
    EXECUTE 'COPY gis_ghk_temp FROM '''||path||''' DELIMITER '';'' CSV HEADER;';   
    
    RAISE NOTICE 'Загруженны данные с .csv файла';

    ALTER TABLE gis_ghk_temp DROP COLUMN some_col;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col1;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col2;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col4;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col5;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col8;
    ALTER TABLE gis_ghk_temp DROP COLUMN some_col7;
    ALTER TABLE gis_ghk_temp DROP COLUMN kadastr_number;
    ALTER TABLE gis_ghk_temp DROP COLUMN ogrn;
    ALTER TABLE gis_ghk_temp DROP COLUMN kpp;
    ALTER TABLE gis_ghk_temp DROP COLUMN org_control_house;
    ALTER TABLE gis_ghk_temp DROP COLUMN condition;
    ALTER TABLE gis_ghk_temp DROP COLUMN oktmo;
    ALTER TABLE gis_ghk_temp DROP COLUMN control_method;

    UPDATE gis_ghk_temp
    SET total_area = REPLACE(total_area, ',', '.'),
        living_area = REPLACE(living_area, ',', '.');

    DELETE FROM gis_ghk_temp
    WHERE type_house <> 'Многоквартирный' OR type_block <> 'Жилое';
    
    ALTER TABLE gis_ghk_temp ALTER COLUMN total_area TYPE numeric USING total_area::numeric;
    ALTER TABLE gis_ghk_temp ALTER COLUMN living_area TYPE numeric USING living_area::numeric;
    ALTER TABLE gis_ghk_temp ADD COLUMN post_index integer;
    ALTER TABLE gis_ghk_temp ADD COLUMN f_city integer;
    

    UPDATE gis_ghk_temp 
    SET post_index = CAST(SPLIT_PART(addres, ',', 1) AS integer)  
    WHERE SPLIT_PART(addres, ',', 1) ~ '[0-9]';
    
    RAISE NOTICE 'Создали почтовые индексы';
    
    DELETE FROM  gis_ghk_temp
    WHERE post_index IS NULL;

    DROP TABLE IF EXISTS gis_ghk_temp2;
    CREATE TEMPORARY TABLE gis_ghk_temp2 (
        f_city smallint,
        post_index integer,
        addres varchar(1000),
        id_gis char(36),
        gl_id_fias char(36),
        total_area varchar(200),
        living_area varchar(200),
        N_flat_house smallint
);

    INSERT INTO gis_ghk_temp2
    SELECT 
        i.f_city
        ,CAST(SPLIT_PART(addres, ',', 1) AS integer)
        ,addres
        ,id_gis
        ,gl_id_fias
        ,MAX(total_area) as total_area
        ,MAX(living_area) as living_area
        ,COUNT(global_id_pom)
    FROM gis_ghk_temp g
        INNER JOIN fs_post_index i
            ON i.n_index = g.post_index 
    GROUP BY 1, 3, 4, 5;
            

    INSERT INTO inf_gis_ghk (f_city, post_index, addres, id_gis, id_fias, total_area, living_area, n_flat_house) 
    SELECT f_city, post_index, addres, id_gis, gl_id_fias
        ,CAST(total_area AS numeric)
        ,CAST(living_area AS numeric)
        ,n_flat_house

    FROM gis_ghk_temp2;
    
    RAISE NOTICE 'Процедура выполнена';

END;
$BODY$
LANGUAGE plpgsql
