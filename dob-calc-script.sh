#!/bin/bash

# installing nginx and PHP-FPM
apt update -y
apt install -y nginx
apt install -y php-fpm
apt install -y php-mysqli

# Copying configuration files
cd /tmp
git clone https://github.com/nithinmohanlive/DOB-Calc-LEMP.git
cp -f /tmp/DOB-Calc-LEMP/etc/nginx/nginx.conf /etc/nginx/nginx.conf
cp -f /tmp/DOB-Calc-LEMP/etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf
cp -f /tmp/DOB-Calc-LEMP/etc/nginx/sites-enabled/dob-calc /etc/nginx/sites-enabled/default
cp -f /tmp/DOB-Calc-LEMP/var/www/html/index.php /var/www/html/index.php
chown -R ubuntu:ubuntu /var/www/html
chown ubuntu:ubuntu /run/php/php8.1-fpm.sock

# restarting nginx and PHP-FPM
systemctl restart nginx
systemctl restart php8.1-fpm

# Mysql db configuration
apt install -y mysql-server
mysql -u root <<EOF
CREATE DATABASE dob_db;
USE dob_db;
CREATE TABLE dob_table (name VARCHAR(20), dob DATE, age INT);
CREATE USER 'ubuntu'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
QUIT;
EOF

systemctl restart nginx