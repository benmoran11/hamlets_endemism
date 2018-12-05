#!/bin/bash
# starter script to rewrite and submit the 1.10.1.extractPIRS_temp.sh script once per LG
clear
cd $WORK/1_genotyping-scripts/


for k in {01..24}; do
    i="LG"$k;

        echo "   sample=$i";
        echo "----------------";

	sed "s/XXlgXX/$i/g" 0_data/0_resources/bamlist_temp.txt > $WORK/1_output/10_PIRs/bamlist-$i.txt;

	sed "s/XXnameXX/$i/" $WORK/1_genotyping-scripts/0_templates/1.10.extractPIRS_temp.sh > $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "cd $WORK/1_output/1.10_PIRs/" >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "extractPIRs --bam bamlist-$i.txt \\" >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "            --vcf ../1.8_filtered_variants/4_bi-allelic_snps.$i.vcf.gz \\" >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "            --out PIRsList-$i.txt \\" >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "            --base-quality 20 \\" >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;
	echo "            --read-quality 15 " >> $WORK/1_genotyping-scripts/1-10_extract_PIRs/1.10.extractPIRS_$i.sh;

	cd 1-10_extract_PIRs
        qsub 1.10.extractPIRS_$i.sh;
  cd ..
done
