#!/bin/bash

touch .env
echo "Введите пользователя базы avito_db:"
read -r user_DB
echo "Введите пароль от базы avito_db:"
read -r password_DB

{
  echo user_DB="$user_DB" "port=5432" "host=127.0.0.1"
  password_DB="$password_DB" "db=avito_db"
} >> .env

source .env

