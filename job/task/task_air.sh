#!/bin/zsh
#Джоб по запуску закачки дистанции пешком и на машине 
#CREATE DATE 2023.01.29
dir_project=/home/lark/project/eastreal
name_db=eastreal;

echo '-----------------------------------------'
echo `date`;

if  [ -z "$port" ] ;
    then 

        . $dir_project/settings/.env; 
fi;
psql -c '\x' -c "CALL load_air_polution(24741);" --dbname=$name_db;

echo `date`;

echo '-----------------------------------------'
