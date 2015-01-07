#!/usr/bin/env bash

apt-get update

sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password_again password root'
sudo apt-get install -y php5-mysql mysql-server

cat << EOF | sudo tee -a /etc/mysql/conf.d/default_engine.cnf
[mysqld]
default-storage-engine = MyISAM
EOF

sudo service mysql restart

sudo apt-get install -y apache2 libapache2-mod-php5
sudo a2enmod rewrite
sudo service apache2 restart

rm -rf /var/www
ln -fs /vagrant /var/www
