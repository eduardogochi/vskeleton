#vskeleton
#Vagrant skeleton for LAMP-JS projects

1. Clone this skeleton repository, it contains a Vagrantfile, a project folder and a vscripts folder
	Vagrantfile contains the instructions to up your virtual machine
	The project folder will contain your code
	The vscripts folder contains the provisioning scripts for vagrant up
2. cd into the directory which contains your Vagrantfile
3. vagrant up
4. After vagrant is all set up, vagrant ssh and clone your project repository
	4.1 cd into /var/www
	4.2 git clone http://201.163.38.66:5207/appointment-plus/red-carpet.git
	4.3 enter your credentials
	4.4 After cloning your repository, you need to move this into your html folder
		4.4.1 rm -rf html
		4.4.2 mv <<project-name>> html
5. install composer dependencies
		5.1 composer install
		5.2 composer dumpautoload
		5.3 exit the vm
6 install npm dependencies
		6.1 npm install
7 run gulp


This vagrant setup runs under a Centos 7 virtual machine 
with httpd, mariadb, php, memcached, xdebug

The virtual host is already set up to work with code installed in /var/www/html
The server name is localhost:8088