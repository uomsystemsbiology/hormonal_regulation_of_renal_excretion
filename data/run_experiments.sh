#!/bin/sh

# Set up logfile
log=/vagrant/temp/install_gawcurcra15.log

# Change to project directory
cd /home/sbl/gawcurcra15/Examples

echo Setting up makefile | tee -a $log

echo Giving rwx permissions to everything | tee -a $log
sudo chmod -R 777 /home/sbl/gawcurcra15/Examples

echo Setting the default graphics toolkit for Octave to gnuplot
printf "graphics_toolkit gnuplot" >> /home/sbl/.octaverc

echo Executing makefile | tee -a $log
sleep 2
./Make 2>&1 | tee -a $log

echo Opening PDF output | tee -a $log
if [ ! -s $DISPLAY ]; then evince paper_notext.pdf
else echo 'PDF generated at /home/sbl/gawcurcra15/Examples/paper_notext.pdf'
fi;

echo Completed analysis | tee -a $log