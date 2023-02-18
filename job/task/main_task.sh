#!/bin/zsh
#Джоб по запуску основного скрипта 
#CREATE DATE 2023.02.1

PATH_DIR=/home/lark/project/eastreal

PATH_ENV=$PATH_DIR/settings/.env
PATH_PYTHON_INTERPRETATOR=/home/lark/.local/share/virtualenvs/pars_script-cKLZXQeP/bin/python
PATH_SCRIPT=$PATH_DIR/pars_script/main.py
LOG_DIR=$PATH_DIR/job/log/main_script.log

. $PATH_ENV

echo '-------------------------------------------------' >> $LOG_DIR
echo 'Активация скрипта - '`date` >> $LOG_DIR

$PATH_PYTHON_INTERPRETATOR $PATH_SCRIPT

echo 'Скрипт закончил выполнение - '`date` >> $LOG_DIR
   
echo '-------------------------------------------------' >> $LOG_DIR
