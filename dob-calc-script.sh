sudo apt update -y
sudo apt install -y nginx
sudo apt install -y php-fpm
sudo apt install -y php-mysqli
cd /tmp
git clone https://github.com/nithinmohanlive/DOB-Calc-LEMP.git
sudo cp -f /tmp/DOB-Calc-LEMP/etc/nginx/nginx.conf /etc/nginx/nginx.conf
sudo cp -f /tmp/DOB-Calc-LEMP/etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf
sudo cp -f /tmp/DOB-Calc-LEMP/etc/nginx/sites-enabled/dob-calc /etc/nginx/sites-enabled/default
sudo cp -f /tmp/DOB-Calc-LEMP/var/www/html/index.php /var/www/html/index.php
chown ubuntu:ubuntu /var/www/html/index.php
sudo chown ubuntu:ubuntu /run/php/php8.1-fpm.sock
sudo systemctl start nginx
sudo systemctl start php8.1-fpm

