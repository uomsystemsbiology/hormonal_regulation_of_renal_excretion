#!/bin/sh
#
# Regenerate Figure 11 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDF=${HOME}/Desktop/Figure11.pdf

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

MDIR=${DIR}/models/hormones_pct
NAMES="adh100_ald100_ang100 adh100_ald025_ang025"
NAMES="${NAMES} adh075_ald075_ang025 adh075_ald050_ang050"
NAMES="${NAMES} adh075_ald025_ang075 adh050_ald100_ang075"
OUT_DATA=""

for NAME in ${NAMES}; do
    BASENAME=${MDIR}/${NAME}
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
        echo Run the ${NAME} simulation
        ${DIR}/bin/run_model.sh -q ${MODEL}
    fi
done

echo Create and open Figure 11
${DIR}/figures/hormone_upi.R ${OUT_DATA} ${PDF} && exec evince ${PDF}
