#!/bin/bash

# Converting VCF datasets into the GENEPOP format used by NeEstimator. Note the dependency on PGDSpider ($PATH will need to be adjusted).

module load java1.8.0

cd $WORK/4_output/4.2_split_SNPs

for f in $(ls *.vcf); do
    SAMP=$(basename ./$f .vcf);

    java -Xmx1024m -Xms512M -jar PGDSpider2-cli.jar \
        -inputfile $WORK/4_output/4.2_split_SNPs/$SAMP.vcf \
	-inputformat VCF \
	-outputfile $WORK/4_output/temp/$SAMP.pop \
	-outputformat GENEPOP \
	-spid $WORK/0_data/0_resources/vcf2genepop.spid;
    echo $SAMP > $WORK/4_output/4.4_LDNe_input/$SAMP.gen;
    awk '{print $2}' $WORK/4_output/4.3_chrloc/$SAMP.vcf.chrloc.txt >> $WORK/4_output/4.4_LDNe_input/$SAMP.gen;
    grep -v "SNP" $WORK/4_output/temp/$SAMP.pop | awk 'NF' >> $WORK/4_output/4.4_LDNe_input/$SAMP.gen;
    sed -i 's/ ,/,/' $WORK/4_output/4.4_LDNe_input/$SAMP.gen;

done
