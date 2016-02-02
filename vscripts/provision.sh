#!/usr/bin/env bash
# if [ -f "/var/vagrant_provision" ]; then 
#     echo "This machine has been already configured, if you want to run this again please remove the file /var/vagrant_provision from this VM."
#     exit 0
# fi

sudo echo "192.30.252.131	github.com" >> /etc/hosts
sudo yum install -y vim-enhanced yum-utils git telnet
#Epel repo for php-mcrypt and php-tidy
sudo yum install epel-release -y
sudo yum-config-manager --add-repo http://yum.mariadb.org/10.0/centos7-amd64 
sudo rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl restart httpd

# install memcached
sudo yum install memcached memcached-devel libmemcached10-devel -y
sudo systemctl start memcached
sudo systemctl enable memcached
# install php and all other goodies 
sudo yum install php -y
sudo yum -y install php-devel php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel
sudo yum -y install php-pecl-apc php-pdo php-pecl-memcached
# # Enable Mod rewrite on all hosts and add index.php as directory index
#    AllowOverride All
sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.php/g' /etc/httpd/conf/httpd.conf
sudo sed -i 's/    AllowOverride None/    AllowOverride All/g' /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
# # Because F* you iptables
sudo iptables -F
# sudo service iptables save
sudo systemctl disable iptables
sudo systemctl stop iptables
# # front end stuff like sass
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin
sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer
# Lets disable the firewall 
sudo systemctl stop firewalld
sudo systemctl disable firewalld
# # apache stuff
sudo cp -f /vagrant/vm/*.conf /etc/httpd/conf.d/
sudo chmod ugo-x /etc/httpd/conf.d/*
# # Configurations for Xdebug
echo "Updating pecl channel..."
sudo pecl channel-update pecl.php.net
echo "Installing Xdebug..."
sudo pecl install Xdebug
echo "Adding Xdebug configuration"
sudo cp -f /vagrant/vm/*.ini /etc/php.d/
sudo chmod ugo-x /etc/php.d/*
sudo systemctl restart httpd
touch /var/vagrant_provision
