#!/bin/sh

sudo yum install -y hhvm nginx

echo "CREATE USER 'root'@'%';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

sudo cp /app/config/etc/nginx/nginx.conf /etc/nginx/nginx.conf
sudo cp /app/config/etc/nginx/conf.d/* /etc/nginx/conf.d/

sudo service nginx restart

cd /app/www/zencart
hhvm --mode server -vServer.Type=fastcgi -vServer.Port=9000
