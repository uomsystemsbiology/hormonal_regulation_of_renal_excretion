log=/vagrant/temp/install_rgm_kidney.log

echo Installing packages required for rgm_kidney | tee -a $log

#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu precise-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

echo Adding keys and the Rstudio CRAN details for latest packages | tee -a $log
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list.d/getdeb.list'

echo Adding keys for the latest OCaml and OPAM package | tee -a $log
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 61707B09
sudo sh -c 'echo "deb http://ppa.launchpad.net/avsm/ppa/ubuntu trusty main" >> /etc/apt/sources.list.d/getdeb.list'
sudo sh -c 'echo "deb-src http://ppa.launchpad.net/avsm/ppa/ubuntu trusty main " >> /etc/apt/sources.list.d/getdeb.list'

echo Updating after adding all those keys | tee -a $log
sudo apt-get -y update

echo Installing Mercurial which should really be in the base | tee -a $log
sudo apt-get install -y mercurial

echo Installing R | tee -a $log
sudo apt-get -y install r-base r-base-dev evince libcairo2-dev libxt-dev

echo Giving everyone all permissions to /usr/local/lib | tee -a $log
#This is a copout to get compilation working
sudo chmod -R 777 /usr/local/lib

echo Installing R packages | tee -a $log
Rscript /vagrant/temp/data/install_packages.R

echo Installing Darcs | tee -a $log
#Installing it quietly to prevent difficult questions about
#postfix setup so I hope this works
sudo apt-get install -qq -y darcs

echo Installing opam | tee -a $log
sudo apt-get -y install opam
opam init -y
opam install -y lacaml batteries atdgen ounit 
eval `opam config env`

echo Installing and setting up the SIunits library | tee -a $log
# download the source for SIunits version 0.1
darcs get http://hub.darcs.net/rgm/SIunits --tag 0.1
# change into the source directory
cd SIunits
# install the SIunits library
make install

sudo apt-get -y autoremove

echo Completed package installation | tee -a $log

cd ~/
darcs get http://hub.darcs.net/rgm/kidney_2013-10-09
cd kidney_2013-10-09
make


