#!/bin/bash

# Creating chrloc & .map files, which group SNPs by physical location. This is necessary for the interchromosomal option in NeEstimator v2.1

module load java1.8.0

cd $WORK/4_output/4.2_split_SNPs

for f in $(ls *.vcf); do
    SAMP=$(basename ./$f .vcf);

    grep -v '#' $SAMP.vcf | awk '{print $1 " " $1 "_" $2}' > ../4.3_chrloc/$SAMP.vcf.chrloc.txt
    cp ../4.3_chrloc/$SAMP.vcf.chrloc.txt ../4.4_LDNe_input/$SAMP.map

done
