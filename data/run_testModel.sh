#!/bin/sh

echo Make the binaries and scripts executable
chmod u+x ~/kidney_2013-10-09/bin/*.* ~/kidney_2013-10-09/figures/*.R

echo Execute the test model
~/kidney_2013-10-09/bin/run_model.sh ~/kidney_2013-10-09/models/testModel.json

echo Open an output PDF to verify things worked
evince ~/kidney_2013-10-09/models/testModel/output.pdf

