#!/bin/bash
# starter script to rewrite and submit the 1.5.bam_bai_temp.sh script once per sample
clear

cd $WORK/1_output/1.4_dedup

for i in $( ls ); do
    if [[ $i =~ ^(.*)(.bam)$ ]];
    then
	 FULL=${i%%.bam}
        echo "sample="$FULL
        echo "----------------"
        sed "s/XXnameXX/$FULL/" $WORK/1_genotyping-scripts/0_templates/1.5.bam_bai_temp.sh > $WORK/1_genotyping-scripts/1-5_bam_bai/1.5.bam_bai_$FULL.sh
        echo "java -Xmx30G -jar $PICARD BuildBamIndex INPUT=$i " >> $WORK/1_genotyping/1-5_bam_bai/1.5.bam_bai_$FULL.sh
        echo "echo done" >> $WORK/1_genotyping/1-5_bam_bai/1.5.bam_bai_$FULL.sh
        
        cd $WORK/1_genotyping/1-5_bam_bai/

	qsub 1.5.bam_bai_$FULL.sh

        cd $WORK/1_output/04_DeDup_BH
    fi
done
