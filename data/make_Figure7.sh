#!/bin/sh
#
# Regenerate Figure 7 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF=${HOME}/Desktop/Figure7.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

MDIR=${DIR}/models/eff_dvr
for EFF in 1 2 3 4 5; do
    BASENAME=${MDIR}/${EFF}eff
    MODEL=${BASENAME}.json
    MODEL_OUT=${BASENAME}/output.ssv
    # Ensure that the solution file is not modified (e.g., by killing
    # a previous simulation before it could complete).
    MODEL_SOLN=${BASENAME}/solutions.json
    if (cd ${DIR} && darcs wh ${MODEL_SOLN} > /dev/null); then
        (cd ${DIR} && darcs revert -a ${MODEL_SOLN})
        rm -f ${MODEL_OUT}
    fi
    if [ ! -r ${MODEL_OUT} ]; then
        echo Run the model simulation with ${EFF} arterioles feeding the DVR
        ${DIR}/bin/run_model.sh -q ${MODEL}
    fi
done

echo Create and open Figure 7
${DIR}/figures/eff_dvr.R ${MDIR} ${PDF} && exec evince ${PDF}
