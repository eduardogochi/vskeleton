#install nodejs and npm through NVM
echo "configuring nodejs"
## Clean up this mess
sudo rm -rf /usr/local/nvm /usr/local/node /opt/nvm 
## Install build utils : )
sudo yum install gcc gcc-c++ -y
# remove CRLF lines from windows 
dos2unix /vagrant/vm/*.sh
# copy the nvm and tmpnpm scripts to the vm
sudo cp /vagrant/vm/nvm.sh /etc/profile.d/
sudo cp /vagrant/vm/tmpnpm.sh /usr/local/bin/tmpnpm 
chmod 777 /usr/local/bin/tmpnpm 
sudo chown root:root /etc/profile.d/nvm.sh
sudo chmod 644 /etc/profile.d/nvm.sh
# Clone the nvm 
sudo git clone https://github.com/creationix/nvm.git /opt/nvm
sudo mkdir -m 777 /usr/local/nvm
sudo mkdir -m 777 /usr/local/node
echo "nvm use stable " >> /home/vagrant/.bashrc