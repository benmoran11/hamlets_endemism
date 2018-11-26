#!/bin/bash
# starter script to rewrite and submit the 1.3.mapBAM_temp_bh.sh script once per sample
clear

cd $WORK/1_output/1.2_markAdapters

for i in $( ls ); do
    if [[ $i =~ ^(.*)(_markedAdapters.bam)$ ]];
    then
	FULL=${i%%-markadapters.bam};

	echo 'sampleID='$FULL
	echo "O=$WORK/1_output/1.3_mappedBAM/"$FULL'.bam';
	echo "----------------";
	sed "s/XXnameXX/$FULL/" $WORK/1_genotyping/0_templates/1.3_mapBAM_temp.sh > $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "set -o pipefail" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "java -Xmx15G -jar $PICARD SamToFastq \\" >>  $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "I=$WORK/1_output/1.2_markAdapters/$i \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "FASTQ=/dev/stdout \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "TMP_DIR=$WORK/temp | \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "bwa mem -M -t 31 -p $WORK/0_data/0_resources/HP_genome_unmasked_01.fa /dev/stdin | \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "java -Xmx15G -jar $PICARD MergeBamAlignment \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "ALIGNED_BAM=/dev/stdin \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "UNMAPPED_BAM=$WORK/1_output/1.1_ubams/"$FULL".bam \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "OUTPUT=$WORK/1_output/1.3_mappedBAM"$FULL".bam \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "R=$WORK/0_data/0_resources/HP_genome_unmasked_01.fa CREATE_INDEX=true ADD_MATE_CIGAR=true \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \\" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "TMP_DIR=$WORK/temp" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	echo "echo done" >> $WORK/1_genotyping/1-3_mapBAM/1.3_mapBAM_$FULL.sh;
	
	cd $WORK/1_genotyping/1-3_mapBAM
	
	qsub 1.3_mapBAM_$FULL.sh

	cd cd $WORK/1_output/1.2_markAdapters
    echo '-------------------';
    fi
done

    
