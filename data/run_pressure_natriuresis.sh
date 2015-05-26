#!/bin/sh
#
# Regenerate the pressure-natriuresis curves from the manuscript (Figure 12).
#

DIR=${HOME}/kidney_2013-10-09
OUT=${HOME}/Desktop/pressure-natriuresis.pdf

echo Make the binaries and scripts executable
chmod u+x ${DIR}/bin/*.* ${DIR}/figures/*.R

SSV=""
MDIR1=${DIR}/models/hormones_tgf
MDIR2=${DIR}/models/hormones_pct

for LVL in 000 050 100; do
    echo Execute the model with hormone levels at $(expr ${LVL} '*' 1)%

    for MDIR in ${MDIR1} ${MDIR2}; do
        BASENAME=${MDIR}/adh${LVL}_ald${LVL}_ang${LVL}
        MODEL=${BASENAME}.json
        SSV="${SSV} ${BASENAME}/output.ssv"
        if [ ! -r ${BASENAME}/output.ssv ]; then
            ${DIR}/bin/run_model.sh -q ${MODEL}
        fi
    done
done

echo Plot the pressure-natriuresis curves
${DIR}/figures/hormone_excr.R ${SSV} ${OUT}

echo Open the output PDF
exec evince ${OUT}
