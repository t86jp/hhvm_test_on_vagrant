#!/bin/sh

PHP_VERSION=5.4.34
MYSQL_VERSION=5.5.30-1
SMARTY_VERSION=3.1.13

#wget http://downloads.mysql.com/archives/get/file/MySQL-server-${MYSQL_VERSION}.el6.x86_64.rpm
#wget http://downloads.mysql.com/archives/get/file/MySQL-client-${MYSQL_VERSION}.el6.x86_64.rpm
#sudo yum localinstall -y MySQL-server-${MYSQL_VERSION}.el6.x86_64.rpm MySQL-client-${MYSQL_VERSION}.el6.x86_64.rpm
sudo yum install -y mysql-server
sudo cp /app/config/etc/my.cnf /etc/


sudo yum install -y httpd httpd-devel libxml2 libxml2-devel pcre pcre-devel bzip2 bzip2-devel bzip2-libs curl curl-devel libjpeg-devel libpng-devel freetype-devel gmp gmp-devel libmcrypt-devel libmcrypt-devel aspell-devel net-snmp-devel libtidy-devel libxslt-devel libyaml libyaml-devel memcached unzip autoconf
wget http://museum.php.net/php5/php-${PHP_VERSION}.tar.gz -O- | tar zxvf -
#wget http://jp1.php.net/get/php-${PHP_VERSION}.tar.gz/from/this/mirror -O- | tar zxvf -
cd php-${PHP_VERSION}/ && ./configure '--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr' '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc' '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib64' '--libexecdir=/usr/libexec' '--localstatedir=/var' '--sharedstatedir=/usr/com' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--cache-file=../config.cache' '--with-libdir=lib64' '--with-config-file-path=/etc' '--with-config-file-scan-dir=/etc/php.d' '--disable-debug' '--with-apxs2=/usr/sbin/apxs' '--with-pic' '--disable-rpath' '--with-bz2' '--with-curl' '--with-exec-dir=/usr/bin' '--with-freetype-dir=/usr' '--with-png-dir=/usr' '--enable-gd-native-ttf' '--without-gdbm' '--with-gettext' '--with-gmp' '--with-iconv' '--with-jpeg-dir=/usr' '--with-openssl' '--with-pspell' '--with-pcre-regex=/usr' '--with-zlib' '--with-layout=GNU' '--enable-exif' '--enable-ftp' '--enable-magic-quotes' '--enable-sockets' '--enable-sysvsem' '--enable-sysvshm' '--enable-sysvmsg' '--enable-wddx' '--with-kerberos' '--enable-ucd-snmp-hack' '--enable-shmop' '--enable-calendar' '--without-sqlite' '--with-libxml-dir=/usr' '--enable-pcntl' '--enable-mbstring=shared' '--enable-mbregex' '--with-gd=shared' '--enable-bcmath=shared' '--enable-dba=shared' '--with-db4=/usr' '--with-xmlrpc=shared' '--with-ldap=shared' '--with-ldap-sasl' '--with-mysql=mysqlnd' '--with-mysqli=mysqlnd' '--enable-dom=shared' '--with-snmp=shared,/usr' '--enable-soap=shared' '--with-xsl=shared,/usr' '--enable-xmlreader=shared' '--enable-xmlwriter=shared' '--enable-pdo' '--with-pdo-mysql=mysqlnd' '--with-pdo-sqlite=shared,/usr' '--enable-json=shared' '--enable-zip=shared' '--with-readline' '--with-mcrypt=shared,/usr' '--with-mhash=shared,/usr' '--with-tidy=shared,/usr' '--with-mhash'
#make && make test && sudo make install
make && sudo make install

sudo cp /app/config/etc/php.ini /etc/
sudo mkdir -p /etc/php.d/
sudo perl -i.bak -pe 's!^\s*;?\s*date\.timezone\s*=*$!date.timezone = Asia/Tokyo!' /etc/php.ini

printf "\n" | sudo pecl install xdebug
sudo cp /app/config/etc/php.d/xdebug.ini /etc/php.d/

printf "\n" | sudo pecl install memcache
sudo cp /app/config/etc/php.d/memcache.ini /etc/php.d/

printf "\n" | sudo pecl install apc
sudo cp /app/config/etc/php.d/apc.ini /etc/php.d/

printf "\n" | sudo pecl install yaml
sudo cp /app/config/etc/php.d/yaml.ini /etc/php.d/

printf "\n" | sudo pecl install json
sudo cp /app/config/etc/php.d/json.ini /etc/php.d/

wget http://www.smarty.net/files/Smarty-${SMARTY_VERSION}.tar.gz -O- | tar zxvf -
sudo mv Smarty-${SMARTY_VERSION}/libs /usr/share/pear/Smarty

wget https://github.com/hnw/php-timecop/archive/master.zip -O php-timecop.zip && unzip php-timecop.zip
cd php-timecop-master && phpize && ./configure && make && sudo make install
sudo cp /app/config/etc/php.d/timecop.ini /etc/php.d/

sudo cp /app/config/etc/php.d/mbstring.ini /etc/php.d/
sudo cp /app/config/etc/php.d/gd.ini /etc/php.d/

pecl install channel://pecl.php.net/msgpack-0.5.5
sudo cp /app/config/etc/php.d/msgpack.ini /etc/php.d/


sudo perl -i.bak -pe 's!^\s*#\s*(NameVirtualHost.*)!$1!' /etc/httpd/conf/httpd.conf
sudo perl -pe 's!^\s*Listen\s+\d+!Listen 8000!' /etc/httpd/conf/httpd.conf
sudo sh -c 'echo "Include sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf'
sudo mkdir /etc/httpd/sites-enabled
sudo cp /app/config/etc/httpd/site.conf /etc/httpd/sites-enabled/app.conf

sudo mkdir -m 777 -p /db/lib/mysql /var/log/mysql

sudo chkconfig memcached on
sudo service memcached restart
sudo chkconfig mysqld on
sudo service mysqld restart
sudo chkconfig httpd on
sudo service httpd restart

sudo chmod 666 /var/log/mysql/*
sudo chmod 777 /var/log/httpd/
#mysql -u root < /app/provisioners/app.sql
