#!/bin/sh
#
# Regenerate Figures 9 and 10 from the manuscript.
#

DIR=${HOME}/kidney_2013-10-09
PDFS="${HOME}/Desktop/Figure9.pdf ${HOME}/Desktop/Figure10.pdf"

# Ensure the user is aware that this script can take a long time to run.
echo "\033[1;31mWARNING:\033[0m this script will run up to 125 simulations"
echo "         It may take \033[1;31ma very long time\033[0m to complete"
echo -n "         Do you wish to proceed [y/n]: "
read RESPONSE
while [ "$RESPONSE" != "y" -a "$RESPONSE" != "n" ]; do
    echo "  \033[1;31mERROR:\033[0m invalid response"
    echo -n "         Do you wish to proceed [y/n]: "
    read RESPONSE
done

if [ "${RESPONSE}" != "y" ]; then
    exit
fi

echo Ensure scripts are executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

# Note: ${DIR}/models/hormones_tgf is also a valid candidate.
MDIR=${DIR}/models/hormones_pct
RANGE="000 025 050 075 100"

for ADH in ${RANGE}; do
    for ALD in ${RANGE}; do
        for ANG in ${RANGE}; do
            BASENAME=${MDIR}/adh${ADH}_ald${ALD}_ang${ANG}
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
                CONDS="ADH at ${ADH}%, ALD at ${ALD}%, ANG at ${ANG}%"
                echo Run the model with ${CONDS}
                ${DIR}/bin/run_model.sh -q ${MODEL}
            fi
        done
    done
done

echo Create and open Figures 9 and 10
${DIR}/figures/hormones.R ${MDIR} ${PDFS} && exec evince ${PDFS}
