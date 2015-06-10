#!/bin/sh
#
# Regenerate Figure 4 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF=${HOME}/Desktop/Figure4.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

BASENAME=${DIR}/models/testModel
MODEL=${BASENAME}.json
MODEL_OUT=${BASENAME}/profiles.ssv.xz
# Ensure that the solution file is not modified (e.g., by killing
# a previous simulation before it could complete).
MODEL_SOLN=${BASENAME}/solutions.json
if (cd ${DIR} && darcs wh ${MODEL_SOLN} > /dev/null); then
    (cd ${DIR} && darcs revert -a ${MODEL_SOLN})
    rm -f ${MODEL_OUT}
fi
if [ ! -r ${MODEL_OUT} ]; then
    echo Run the model simulation
    ${DIR}/bin/run_model.sh -q ${MODEL}
fi

echo Create and open Figure 4
${DIR}/figures/osm.R ${MODEL_OUT} ${PDF} && exec evince ${PDF}
