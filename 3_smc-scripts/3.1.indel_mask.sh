#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=51gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=10                   # Anzahl benoetigter CPUs pro Knoten
#PBS -N indelmask                         # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.1.indel_mask.stdout
#PBS -e 3.1.indel_mask.stderr
module load java1.8.0

# select indels from the raw variants output
java -Xmx50G -jar $GATK \
    -T SelectVariants \
    -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
    -V $WORK/hamlets_endemism_Ne/1_output/1.7_raw_variants/0_rawVariants.vcf \
    -selectType INDEL \
    -o $WORK/3_output/3.1_indel_mask/1_rawVariants_indels.vcf

# apply hard filtering to indels (thresholds from results of GATK VariantsToTable
java -Xmx63G -jar $GATK \
        -T VariantFiltration \
        -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
        -V $WORK/3_output/3.1_indel_mask/1_rawVariants_indels.vcf
        --filterExpression "QD < 2.5" \
        --filterName "filter_QD" \
        --filterExpression "FS > 25.0" \
        --filterName "filter_FS" \
        --filterExpression "SOR > 3.0" \
        --filterName "filter_SOR" \
        --filterExpression "InbreedingCoeff < -0.25" \
        --filterName "filter_InbreedingCoeff" \
        --filterExpression "ReadPosRankSum < -2.0" \
        --filterName "filter_ReadPosRankSum" \
        -o $WORK/3_output/3.1_indel_mask/2_filtered_indels.vcf

java -Xmx50G -jar $GATK \
                -T SelectVariants \
                -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
                -V $WORK/3_output/3.1_indel_mask/2_filtered_indels.vcf \
                --excludeFiltered \
                -o $WORK/3_output/3.1_indel_mask/3_clean_indels.vcf


awk '! /\#/' $WORK/3_output/3.1_indel_mask/3_clean_indels.vcf
awk '{if(length($4) > length($5)) print $1"\t"($2-6)"\t"($2+length($4)+4); else print $1"\t"($2-6)"\t"($2+length($5)+4)}' | gzip -c > $WORK/3_output/3.1_indel_mask/4_indel_mask.bed.gz

for k in {01..24}; do
        L="LG"$k;

	gzip -cd $WORK/3_output/3.1_indel_mask/4_indel_mask.bed.gz | grep $L | gzip -c > $WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz 
done

echo done
