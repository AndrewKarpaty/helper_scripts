#!/bin/bash

db_name="user_data"

check=$(mysqlshow -u root | grep -v Wildcard | grep -o $db_name)
if [[ "$check" != "$db_name" ]]; then
  mysql -u root -e "CREATE DATABASE user_data;"
  mysql -u root -e "USE user_data; CREATE TABLE users(id bigint NOT NULL); CREATE TABLE data(id bigint NOT NULL, name varchar(128));"
fi
