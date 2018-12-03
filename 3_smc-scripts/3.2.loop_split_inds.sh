#!/bin/bash

# set up five different scripts, one for each species. Each splits the phased VCFs of that species by individual, for MSMC2 input creation

cd $WORK/3_smc-scripts/

sed 's/XXspeciesXX/maybel/g' 0_templates/3.2.split_indivs_temp.sh > 3-2_split_inds/3.2.split_indivs_maybel.sh
cd 3-2_split_inds
qsub 3.2.split_indivs_maybel.sh
cd ..

sed 's/XXspeciesXX/puebel/g' 0_templates/3.2.split_indivs_temp.sh > 3-2_split_inds/3.2.split_indivs_puebel.sh
cd 3-2_split_inds
qsub 3.2.split_indivs_puebel.sh
cd ..

sed 's/XXspeciesXX/nigbel/g' 0_templates/3.2.split_indivs_temp.sh > 3-2_split_inds/3.2.split_indivs_nigbel.sh
cd 3-2_split_inds
qsub 3.2.split_indivs_nigbel.sh
cd ..

sed 's/XXspeciesXX/unibel/g' 0_templates/3.2.split_indivs_temp.sh > 3-2_split_inds/3.2.split_indivs_unibel.sh
cd 3-2_split_inds
qsub 3.2.split_indivs_unibel.sh
cd ..

sed 's/XXspeciesXX/gemflo/g' 0_templates/3.2.split_indivs_temp.sh > 3-2_split_inds/3.2.split_indivs_gemflo.sh
cd 3-2_split_inds
qsub 3.2.split_indivs_gemflo.sh
cd ..
