#!/bin/sh

# Change to project directory
cd /home/sbl/budden2015treeome/scripts/data_integration

# Back up published results
cp -ar ../../results ../../results_as_published

# Delete all results from output folder
rm -f ../../results/*/*/*

# Delete all figures from output folder
rm -f ../../results/figures/*

# Run all experiments
Rscript data.integration1.R
Rscript data.integration2.R
Rscript data.integration3.R
Rscript data.integration4.R
Rscript data.integration5.R

/bin/sh
