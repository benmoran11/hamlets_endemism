#!/bin/bash

cd $WORK/3_smc-scripts

for i in $(awk '{print $1}' $WORK/0_data/0_resources/crosscoal_runs.txt); do
    RUN=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $1}');
    SPEC1=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $2}');
    SPEC2=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $3}');
    HAP1=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $4}');
    HAP2=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $5}');
    HAP3=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $6}');
    HAP4=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $7}');
    HAP5=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $8}');
    HAP6=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $9}');
    HAP7=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $10}');
    HAP8=$(grep $i $WORK/0_data/0_resources/crosscoal_runs.txt | awk '{print $11}');

    echo $RUN
    echo '-----------------------------------------------------------------'

    sed "s/XXrunXX/$RUN/g; s/XXspec1XX/$SPEC1/g; s/XXspec2XX/$SPEC2/g; s/XXhap1XX/$HAP1/g; s/XXhap2XX/$HAP2/g; s/XXhap3XX/$HAP3/g; s/XXhap4XX/$HAP4/g; s/XXhap5XX/$HAP5/g; s/XXhap6XX/$HAP6/g; s/XXhap7XX/$HAP7/g; s/XXhap8XX/$HAP8/g" ./0_templates/3.9.1.crosscoal_msmc_temp.sh > 3-9_crosscoal_msmc/${RUN}_crosscoal_msmc.sh

    #qsub 3-8_crosscoal_msmc/${RUN}_crosscoal_msmc.sh
    
    sed "s/XXrunXX/$RUN/g; s/XXspec1XX/$SPEC1/g; s/XXspec2XX/$SPEC2/g; s/XXhap1XX/$HAP1/g; s/XXhap2XX/$HAP2/g; s/XXhap3XX/$HAP3/g; s/XXhap4XX/$HAP4/g; s/XXhap5XX/$HAP5/g; s/XXhap6XX/$HAP6/g; s/XXhap7XX/$HAP7/g; s/XXhap8XX/$HAP8/g" ./0_templates/3.9.2.crosscoal_msmc_noFstPeaks_temp.sh > 3-9_crosscoal_msmc/${RUN}_crosscoal_noFstPeaks_msmc.sh

    #qsub 3-8_crosscoal_msmc/${RUN}_crosscoal_noFstPeaks_msmc.sh

echo done
done
