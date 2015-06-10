#!/bin/sh
#
# Regenerate Figure 5 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF1=${HOME}/Desktop/Figure5.pdf
# Note: this second figure does not appear in the original manuscript.
# It will be deleted once the plotting script has finished.
PDF2=${HOME}/Desktop/.Figure5a.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

MDIR=${DIR}/models/adh
for LVL in 0 25 30 35 40 45 50 100; do
    BASENAME=${MDIR}/adh_${LVL}
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
        echo Run the model simulation with ADH at ${LVL}%
        ${DIR}/bin/run_model.sh -q ${MODEL}
    fi
done

echo Create and open Figure 5
echo Note: ignore the spurious \"Skipping missing input file\" messages
${DIR}/figures/adh_excr.R ${MDIR} ${PDF1} ${PDF2} && rm ${PDF2} && exec evince ${PDF1}
