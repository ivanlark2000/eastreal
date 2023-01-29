#Джоб по запуску закачки дистанции пешко и на машине 
#CREATE DATE 2023.01.29
dir_project=/home/lark/PROJECT/RealEstate
dir=${dir_project}/base_scripts/job/log/task.txt;
name_db=eastreal;

echo `date` >> $dir;

if  [ -z "$port" ] ;
    then 

        source $dir_project/pars_script/settings/.env; 
fi;
psql -c '\x' -c "CALL start_task_dist();" --dbname=$name_db >> $dir 2>&1;
