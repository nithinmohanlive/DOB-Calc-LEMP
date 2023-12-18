apt update -y
apt install -y nginx
apt install -y php-fpm
apt install -y php-mysqli
cd /tmp
git clone https://github.com/nithinmohanlive/DOB-Calc-LEMP.git
cp -f /tmp/DOB-Calc-LEMP/etc/nginx/nginx.conf /etc/nginx/nginx.conf
cp -f /tmp/DOB-Calc-LEMP/etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf
cp -f /tmp/DOB-Calc-LEMP/etc/nginx/sites-enabled/dob-calc /etc/nginx/sites-enabled/default
cp -f /tmp/DOB-Calc-LEMP/var/www/html/index.php /var/www/html/index.php
chown ubuntu:ubuntu /var/www/html/index.php
chown ubuntu:ubuntu /run/php/php8.1-fpm.sock
systemctl start nginx
systemctl start php8.1-fpm

apt install -y mysql-server
mysql -u root
CREATE DATABASE dob_db;
USE dob_db;
CREATE TABLE dob_table (name VARCHAR(20), dob DATE, age INT);
CREATE USER 'ubuntu'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
QUIT
systemctl restart nginx