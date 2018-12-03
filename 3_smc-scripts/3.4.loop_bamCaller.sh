#!/bin/bash

# set up five different scripts, one for each species. Each runs the bamHamletCaller.py scripts for each individual and LG, generating MSMC input files

cd $WORK/3_smc-scripts/

sed 's/XXspeciesXX/maybel/g' 0_templates/3.4.bamCaller_temp.sh > 3-4_bamCaller/3.4.bamCaller_maybel.sh
cd 3-4_bamCaller
qsub 3.4.bamCaller_maybel.sh
cd ..

sed 's/XXspeciesXX/puebel/g' 0_templates/3.4.bamCaller_temp.sh > 3-4_bamCaller/3.4.bamCaller_puebel.sh
cd 3-4_bamCaller
qsub 3.4.bamCaller_puebel.sh
cd ..

sed 's/XXspeciesXX/nigbel/g' 0_templates/3.4.bamCaller_temp.sh > 3-4_bamCaller/3.4.bamCaller_nigbel.sh
cd 3-4_bamCaller
qsub 3.4.bamCaller_nigbel.sh
cd ..

sed 's/XXspeciesXX/unibel/g' 0_templates/3.4.bamCaller_temp.sh > 3-4_bamCaller/3.4.bamCaller_unibel.sh
cd 3-4_bamCaller
qsub 3.4.bamCaller_unibel.sh
cd ..

sed 's/XXspeciesXX/gemflo/g' 0_templates/3.4.bamCaller_temp.sh > 3-4_bamCaller/3.4.bamCaller_gemflo.sh
cd 3-4_bamCaller
qsub 3.4.bamCaller_gemflo.sh
cd ..
