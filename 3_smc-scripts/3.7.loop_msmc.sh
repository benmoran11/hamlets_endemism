#!/bin/bash

cd $WORK/3_smc-scripts

for i in $(awk '{print $1}' $WORK/0_data/0_resources/msmc_runs_4ind.txt); do
    SPEC=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print substr($1,1,6)}');
    RUN=$(grep $i $WORK/0_data/0_resources/msmc_runs_4ind.txt | awk '{print $1}');
    echo $RUN
    echo '-----------------------------------------------------------------'

    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g" ./0_templates/3.7.1.msmc_4ind_temp.sh > ./3-7_msmc/${RUN}_msmc.sh

    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g" ./0_templates/3.7.2.msmc_4ind_noFstPeaks_temp.sh > ./3-7_msmc/${RUN}_msmc_noFstPeaks.sh

done

for i in $(awk '{print $1}' $WORK/0_data/0_resources/msmc_runs_3ind.txt); do
    SPEC=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print substr($1,1,6)}');
    RUN=$(grep $i $WORK/0_data/0_resources/msmc_runs_3ind.txt | awk '{print $1}');
    echo $RUN
    echo '-----------------------------------------------------------------'


    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g" ./0_templates/3.7.3.msmc_3ind_temp.sh > ./3-7_msmc/${RUN}_msmc.sh

    sed "s/XXspeciesXX/$SPEC/g; s/XXrunXX/$RUN/g" ./0_templates/3.7.4.msmc_3ind_noFstPeaks_temp.sh > ./3-7_msmc/${RUN}_msmc_noFstPeaks.sh

done
