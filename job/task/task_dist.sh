#Джоб по запуску закачки дистанции пешком и на машине 
#CREATE DATE 2023.01.29
dir_project=/home/lark/project/eastreal
dir=${dir_project}/job/log/task_dist.log;
name_db=eastreal;

echo `date` >> $dir;

if  [ -z "$port" ] ;
    then 

        . $dir_project/pars_script/settings/.env; 
fi;
psql -c '\x' -c "CALL start_task_dist();" --dbname=$name_db >> $dir 2>&1;

echo `date` >> $dir;
