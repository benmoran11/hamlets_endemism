#!/bin/bash
clear

### NOTE: This step introduces new read files to the pipeline, which were pre-stored in $WORK/1_output/1.4_dedup/. 
###       These are BAM files for H. puella, nigricans, and unicolor from Belize, which were created in Hench et al. 2019.
###       See documentation for this publication for scripts to recreate these files

cd $WORK/1_output/1.4_dedup

for i in $( ls | grep ".bam"); do
    FULL=${i%%-dedup.bam};

    echo 'sampleID='$FULL
    echo 'O='$WORK'/1_output/1.6_gVCFs/'$FULL'-output.raw.snps';
    echo "----------------";

    sed "s/XXnameXX/$FULL/" $WORK/1_genotyping-scripts/0_templates/1.6.genotype_temp.sh > $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "java -Xmx50G -jar $GATK \\" >>  $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "	-R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \\" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "	-T HaplotypeCaller \\" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "	-I $WORK/1_output/1.4_dedup/$FULL-dedup.bam \\" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "	--emitRefConfidence GVCF -nct 10 \\" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "	-o $WORK/1_output/1.6_gVCFs/$FULL.output.raw.snps.indels.g.vcf" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;
    echo "echo done" >> $WORK/1_genotyping-scripts/1-6_genotype/1.6.genotype_$FULL.sh;

    cd $WORK/1_genotyping-scripts/1-6_genotype/;
    qsub 1.6.genotype_$FULL.sh;

    cd $WORK/1_output/1.4_dedup

    echo '-------------------';
done

    
