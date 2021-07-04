#!/bin/bash

Host=mysql
User=root
Password=123456

echo 'Execute SQL Script ...'

result_desc=""

qry_result_num=`mysql -h$Host -u$User -p$Password << EOF
CREATE DATABASE flaskapi;
USE flaskapi;
CREATE TABLE users(user_id INT PRIMARY KEY AUTO_INCREMENT, user_name VARCHAR(255), user_email VARCHAR(255), user_password VARCHAR(255));
EOF`

if $qry_result_num == 0
then
	result_desc="No data in result"
else
	result_desc="Finds "$qry_result_num" records"
fi

echo $result_desc

echo 'Done Successfully.'
