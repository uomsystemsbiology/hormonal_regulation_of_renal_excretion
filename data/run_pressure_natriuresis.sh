#!/bin/sh
#
# Regenerate Figure 12 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF=${HOME}/Desktop/pressure-natriuresis.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

MDIR1=${DIR}/models/hormones_tgf
MDIR2=${DIR}/models/hormones_pct
OUT_DATA=""

for LVL in 000 050 100; do
    for MDIR in ${MDIR1} ${MDIR2}; do
        BASENAME=${MDIR}/adh${LVL}_ald${LVL}_ang${LVL}
        MODEL=${BASENAME}.json
        MODEL_OUT=${BASENAME}/output.ssv
        OUT_DATA="${OUT_DATA} ${MODEL_OUT}"
        # Ensure that the solution file is not modified (e.g., by killing
        # a previous simulation before it could complete).
        MODEL_SOLN=${BASENAME}/solutions.json
        if (cd ${DIR} && darcs wh ${MODEL_SOLN} > /dev/null); then
            (cd ${DIR} && darcs revert -a ${MODEL_SOLN})
            rm -f ${MODEL_OUT}
        fi
        if [ ! -r ${MODEL_OUT} ]; then
            echo Run the ${BASENAME} simulation
            ${DIR}/bin/run_model.sh -q ${MODEL}
        fi
    done
done

echo Create and open Figure 12
${DIR}/figures/hormone_excr.R ${OUT_DATA} ${PDF} && exec evince ${PDF}
