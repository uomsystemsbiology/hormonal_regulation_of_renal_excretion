log=/vagrant/temp/install_budden2015treeome.log

echo Installing packages required for budden2015treeome | tee -a $log

#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu precise-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

echo Adding keys and the Rstudio CRAN details for latest packages | tee -a $log
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list.d/getdeb.list'

sudo apt-get -y update 
sudo apt-get -y install r-base r-base-dev evince 
sudo apt-get -y autoremove

echo Installing R packages | tee -a $log
sudo chmod -R 777 /usr/local/lib/R
Rscript /home/sbl/budden2015treeome/scripts/common/install_packages.R

echo Completed package installation | tee -a $log
