log=/vagrant/temp/install_budden2015treeome.log

echo Installing packages required for budden2015treeome | tee -a $log

#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu precise-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

sudo apt-get -y update 
sudo apt-get -y install r-base evince 
sudo apt-get -y autoremove

echo Installing R packages | tee -a $log
Rscript /home/sbl/budden2015treeome/scripts/install_packages.R

echo Completed package installation | tee -a $log
