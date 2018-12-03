#!/bin/bash

# set up five different scripts, one for each species. Each runs the vcfParser.py script for each individual and LG, generating MSMC input files

cd $WORK/3_smc-scripts/

sed 's/XXspeciesXX/maybel/g' 0_templates/3.5.vcfParser_temp.sh > 3-5_vcfParser/3.5.vcfParser_maybel.sh
cd 3-5_vcfParser
qsub 3.5.vcfParser_maybel.sh
cd ..

sed 's/XXspeciesXX/puebel/g' 0_templates/3.5.vcfParser_temp.sh > 3-5_vcfParser/3.5.vcfParser_puebel.sh
cd 3-5_vcfParser
qsub 3.5.vcfParser_puebel.sh
cd ..

sed 's/XXspeciesXX/nigbel/g' 0_templates/3.5.vcfParser_temp.sh > 3-5_vcfParser/3.5.vcfParser_nigbel.sh
cd 3-5_vcfParser
qsub 3.5.vcfParser_nigbel.sh
cd ..

sed 's/XXspeciesXX/unibel/g' 0_templates/3.5.vcfParser_temp.sh > 3-5_vcfParser/3.5.vcfParser_unibel.sh
cd 3-5_vcfParser
qsub 3.5.vcfParser_unibel.sh
cd ..

sed 's/XXspeciesXX/gemflo/g' 0_templates/3.5.vcfParser_temp.sh > 3-5_vcfParser/3.5.vcfParser_gemflo.sh
cd 3-5_vcfParser
qsub 3.5.vcfParser_gemflo.sh
cd ..
