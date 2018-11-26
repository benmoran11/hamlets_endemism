#!/bin/bash
clear
# starter script to rewrite and submit the 1.4.markDupl_temp.sh script once per sample
cd $WORK/1_output/1.4_dedup

for i in $( ls ../1.3_mappedBAM/); do
    if [[ $i =~ ^(.*)(.bam)$ ]];
    then
	FULL=${i%%.bam};

	echo 'sampleID='$FULL
	echo "O=$WORK/1_output/1.4_dedup/"$FULL'-dedup.bam';
	echo "----------------";
	sed "s/XXnameXX/$FULL/" $WORK/1_genotyping-scripts/0_templates/1.4_markDuplicates_temp.sh > $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "java -Xmx30G -jar $PICARD MarkDuplicates \\" >>  $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "I=$WORK/1_output/1.3_mappedBM/$i \\" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "O=$WORK/1_output/1.4_dedup/$FULL-dedup.bam \\" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "M=$WORK/1_output/1.4_dedup/$FULL-dedup_metrics.txt MAX_FILE_HANDLES=1000 \\" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "TMP_DIR=$WORK/temp" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "java -Xmx30G -jar $PICARD BuildBamIndex \\" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "I=$WORK/1_output/1.4_dedup/$FULL-dedup.bam" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;
	echo "echo done" >> $WORK/1_genotyping-scripts/1-4_dedup/$FULL-dedup.sh;

	cd $WORK/1_genotyping-scripts/1-4_dedup;
	qsub $FULL-dedup.sh

	cd $WORK/1_output/1.4_dedup
	echo '-------------------';
    fi
done

    
