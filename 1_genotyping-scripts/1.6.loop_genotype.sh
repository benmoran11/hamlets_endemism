#!/bin/bash
clear

cd $WORK/1_output/1.4_dedup

for i in $( ls /sfs/fs2/work-geomar7/smomw335/dedup_bams/run2_phylo/ | grep ".bam"); do
    FULL=${i%%-dedup.bam};

    echo 'sampleID='$FULL
    echo 'O=../../gVCFs/run2_phylo/'$FULL'-output.raw.snps';
    echo "----------------";
    sed "s/XXnameXX/$FULL/" variantCall_temp.sh > variantCall/$FULL-varcall.sh;
    echo "java -Xmx50G -jar $GATK \\" >>  variantCall/$FULL-varcall.sh;
    echo "	-R $WORK/reference/v2_unmasked_01.fa \\" >> variantCall/$FULL-varcall.sh;
    echo "	-T HaplotypeCaller \\" >> variantCall/$FULL-varcall.sh;
    echo "	-I $WORK/dedup_bams/run2_phylo/$i \\" >> variantCall/$FULL-varcall.sh; 
    echo "	--emitRefConfidence GVCF -nct 10 \\" >> variantCall/$FULL-varcall.sh;
    echo "	-o $WORK/gVCFs/run2_phylo/$FULL-output.raw.snps.indels.g.vcf" >> variantCall/$FULL-varcall.sh;
    echo "echo done" >> variantCall/$FULL-varcall.sh;
    cd variantCall;
    qsub $FULL-varcall.sh
    cd /sfs/fs2/work-geomar7/smomw335/scripts/run2_phylo/
    echo '-------------------';
done

    
