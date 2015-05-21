log=/vagrant/temp/install_rgm_kidney.log

echo Getting code from the darcs repository and building it | tee -a $log
cd ~/
darcs get http://hub.darcs.net/rgm/kidney_2013-10-09
cd kidney_2013-10-09
make

echo Getting build info | tee -a $log
echo This part is commented out until I figure out how to do it with darcs | tee -a $log
#git --git-dir ~/budden2015treeome/.git log --max-count=1 --format=format:"Last Commit: %h%nAuthor: %an%nCommit Date: %ad%n" > /vagrant/temp/build_info.txt
printf '\nEnvironment built at ' > /vagrant/temp/build_info.txt
date >> /vagrant/temp/build_info.txt

#echo Copying shell script to home directory | tee -a $log
sudo cp /vagrant/temp/data/run_testModel.sh /home/sbl/run_testModel.sh
sudo chmod 777 /home/sbl/run_testModel.sh

#echo Linking the shell script into the root folder | tee -a $log
sudo ln -sv /home/sbl/run_testModel.sh /run_testModel.sh