#!/bin/bash
clear
cd $WORK/1_output/1.1_ubams

for i in $( ls ); do
    
    if [[ $i =~ ^(.*)(.bam)$ ]];
    then
	FULL=${i%%.bam};

	echo 'sampleID='$FULL
	echo "O=$WORK/1_output/1.2_markAdapters/"$FULL'-markadapters.bam';
	echo "----------------";
	sed "s/XXnameXX/$FULL/" $WORK/1_genotyping-scripts/0_templates/1.2_markAdapters_temp.sh > $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "java -Xmx15G -jar $PICARD MarkIlluminaAdapters \\" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "I=$WORK/1_output/1.1_ubams/$i \\" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "O=$WORK/1_output/1.2_markAdapters/$FULL-markadapters.bam \\" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "M=$WORK/1_output/1.2_markAdapters/$FULL-markadapters_metrics.txt \\" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "TMP_DIR=$WORK/temp;" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	echo "echo done" >> $WORK/1_genotyping-scripts/1-2_markAdapters/1.2.markAdapters_$FULL.sh;
	cd $WORK/1_genotyping-scripts/1-2_markAdapters;

	#qsub 1.2.markAdapters_$FULL.sh

	cd $WORK/1_output/1.1_ubams
    fi

done

    
