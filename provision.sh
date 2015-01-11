#!/usr/bin/env bash

apt-get update

sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password_again password root'
sudo apt-get install -y lamp-server^
# sudo apt-get install -y php5-mysql mysql-server

cat << EOF | sudo tee -a /etc/mysql/conf.d/default_engine.cnf
[mysqld]
default-storage-engine = MyISAM
EOF

sudo service mysql restart

sudo apt-get install -y apache2 libapache2-mod-php5
sudo a2enmod rewrite
sudo service apache2 restart

sudo rm -rf /var/www/html
sudo mkdir -p /vagrant/files/www/html
sudo ln -fs /vagrant/files/www/html /var/www/html

sudo apt-get install -y git unzip

# pull down Vanilla 2.1
wget -N http://vanillaforums.org/get/vanilla-core-2.1.7.zip -P /vagrant/files/www/html/source/
unzip -o /vagrant/files/www/html/source/vanilla-core-2.1.7.zip -d /vagrant/files/www/html/
# git clone https://github.com/vanilla/vanilla.git -b 2.1 /vagrant/files/www/html

#create the database
/vagrant/files/createdb.sh vanillaforum brandx password root

# Install extras
# Add-ons
# YAGA
wget -N http://vanillaforums.org/get/yaga-application-1.0.3.zip -P /vagrant/files/www/html/source/
unzip -o /vagrant/files/www/html/source/yaga-application-1.0.3.zip -d /vagrant/files/www/html/applications/