#!/bin/bash

cd /home/veewee/php-5.6.40/ext/mysql
/usr/local/php5/bin/phpize
./configure --with-php-config=/usr/local/php5/bin/php-config
make && make install

sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /usr/local/php5/etc/php-fpm.conf;
sed -i '/; If you wish to have an extension loaded automatically, use the following/a\extension=pdo_mysql.so' /usr/local/php5/etc/php.ini
sed -i '/extension=pdo_mysql.so/a\extension=mysqli.so' /usr/local/php5/etc/php.ini
sed -i '/extension=mysqli.so/a\extension=mysql.so' /usr/local/php5/etc/php.ini
sed -i 's/;always_populate/always_populate/g' /usr/local/php5/etc/php.ini

echo "
[Zend Guard Loader]
zend_extension=/vagrant/zend/ZendGuardLoader.so
zend_loader.enable=1
zend_loader.disable_licensing=0
zend_loader.obfuscation_level_support=0
zend_loader.license_path=/vagrant/config/developer.zl
" >> /usr/local/php5/etc/php.ini