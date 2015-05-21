#!/bin/sh

# Copy in the solutions JSON file for testModel
# This is a workaround until we have recomputed solutions
cp /vagrant/temp/data/solutions.json /home/sbl/kidney_2013-10-09/models/testModel/solutions.json

# Make the binaries and scripts executable
chmod u+x kidney_2013-10-09/bin/*.* kidney_2013-10-09/figures/*.R

# Execute the test model
./kidney_2013-10-09/bin/run_model.sh kidney_2013-10-09/models/testModel.json

# Open an output PDF to verify things worked
evince kidney_2013-10-09/models/testModel/output.pdf

/bin/sh
