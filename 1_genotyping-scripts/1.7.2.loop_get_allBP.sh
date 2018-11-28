#!/bin/bash
# starter script to rewrite and submit the 1.7.all_Variants_temp.sh script once per LG

cd $WORK/1_genotyping-scripts/

for k in {01..24};do

    j="LG"$k
    echo $j
    sed "s/XXnameXX/$j/g" 0_templates/1.7.all_Variants_temp.sh > 1-7_allVariants/1.7.all_Variants.$j.sh;
    
    cd 1-7_allVariants
    qsub 1.7.all_Variants.$j.sh
    cd ..
    
done
