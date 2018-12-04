#!/bin/bash

cd $WORK/3_smc-scripts

for i in $(awk '{print $1}' $WORK/0_data/0_resources/msmc_runs_4ind.txt); do
    SPEC=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print substr($1,1,6)}');
    RUN=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $1}');
    IND1=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $2}');
    IND2=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $3}');
    IND3=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $4}');
    IND4=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $5}');
    echo $RUN': '$IND1', '$IND2', '$IND3', '$IND4
    echo '-----------------------------------------------------------------'


    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g; s/XXind1XX/$IND1/g; s/XXind2XX/$IND2/g; s/XXind3XX/$IND3/g; s/XXind4XX/$IND4/g" ./0_templates/3.6.1.genHetSep_4ind_temp.sh > 3-6_genHetSep/${RUN}_loop_genhetsep.sh

    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g; s/XXind1XX/$IND1/g; s/XXind2XX/$IND2/g; s/XXind3XX/$IND3/g; s/XXind4XX/$IND4/g" ./0_templates/3.6.2.genHetSep_4ind_noFstPeaks_temp.sh > 3-6_genHetSep/${RUN}_loop_genhetsep_noFstPeaks.sh

done

for i in $(awk '{print $1}' $WORK/0_data/0_resources/msmc_runs_3ind.txt); do
    SPEC=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print substr($1,1,6)}');
    RUN=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print $1}');
    IND1=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print $2}');
    IND2=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print $3}');
    IND3=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print $4}');
    echo $RUN': '$IND1', '$IND2', '$IND3
    echo '-----------------------------------------------------------------'


    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g; s/XXind1XX/$IND1/g; s/XXind2XX/$IND2/g; s/XXind3XX/$IND3/g" ./0_templates/3.6.3.genHetSep_3ind_temp.sh > 3-6_genHetSep/${RUN}_loop_genhetsep.sh

    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g; s/XXind1XX/$IND1/g; s/XXind2XX/$IND2/g; s/XXind3XX/$IND3/g" ./0_templates/3.6.4.genHetSep_3ind_noFstPeaks_temp.sh > 3-6_genHetSep/${RUN}_loop_genhetsep_noFstPeaks.sh

done
