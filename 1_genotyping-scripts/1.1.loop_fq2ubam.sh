#!/bin/bash
clear
# creates fq2ubam shell script files, and submits them for processing,
# for each fastq provided by sequencing of 10 Maya hamlets and 5 blue hamlets
cd $WORK/1_genotyping_scripts

for i in $( cat $WORK/0_data/0_resources/renaming_1st_file.txt); do
	FW=$(grep $i $WORK/0_data/0_resources/renaming.txt |awk '{print $1}');
	RW=$(grep $i $WORK/0_data/0_resources/renaming.txt |awk '{print $2}');
	SAMP=$(grep $i $WORK/0_data/0_resources/renaming.txt |awk '{print $3}');
	LANE=$(grep $i $WORK/0_data/0_resources/renaming.txt |awk '{print $4}');
	NAME=$(grep $SAMP $WORK/0_data/0_resources/flowcells_info.txt |awk '{print $2}');
	FLW=$(grep $SAMP $WORK/0_data/0_resources/flowcells_info.txt |awk '{print $3}');
	CMP=$(grep $SAMP $WORK/0_data/0_resources/flowcells_info.txt |awk '{print $4}');
	FULL=$NAME$LANE;
	
				lib='lib1';
				echo 'sample='$SAMP;
				echo 'sampleID='$FULL;
				echo 'flowcell='$FLW;
				echo 'lane='$LANE;
				echo 'forward='$FW;
				echo 'reverse='$RW;
				echo "O=$WORK/1_output/1.1_ubams/"$FULL'.bam';
				echo "--------------";
				sed "s/XXnameXX/$FULL/" 0_templates/1.1.fq2ubam_temp.sh > 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "java -Xmx15G -jar $PICARD FastqToSam \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	F1=$WORK/$FW \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	F2=$WORK/$RW \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	O=$WORK/1_output/1.1_ubams/$FULL.bam \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	RG=$FULL \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	SM=$SAMP \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	LB=$SAMP$lib \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	PU=$FLW.$LANE \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh; # why no sample barcode?
				echo "	PL=Illumina \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	CN=$CMP \\" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "	TMP_DIR=$WORK/temp;" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;
				echo "echo done" >> 1-1_ubam/1.1.fq2ubam_$FULL.sh;

				cd 1-1_ubam;
						#qsub 1.1.fq2ubam_$FULL.sh
						cd $WORK/1_genotyping_scripts
	echo ' ------------ ';
done
