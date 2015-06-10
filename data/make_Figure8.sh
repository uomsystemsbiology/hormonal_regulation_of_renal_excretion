#!/bin/sh
#
# Regenerate Figure 8 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF=${HOME}/Desktop/Figure8.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

MDIR=${DIR}/models/dct
for SEG in dct edt ldt; do
    BASENAME=${MDIR}/${SEG}_vmax_0
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
        echo Run the model simulation with inhibited transport in the ${SEG}
        ${DIR}/bin/run_model.sh -q ${MODEL}
    fi
done

echo Create and open Figure 8
${DIR}/figures/dct_summary.R ${MDIR} ${PDF} && exec evince ${PDF}
