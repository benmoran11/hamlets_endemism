#PBS -l elapstim_req=10:30:00
#PBS -l memsz_job=65gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N SNPs
#PBS -q clmedium
#PBS -o 2.1.8.extract_and_filterSNPs.stdout
#PBS -e 2.1.8.extract_and_filterSNPs.stderr

module load java1.8.0

cd $WORK/1_output/1.7_raw_variants

# extract SNPs
java -Xmx53G -jar $GATK \
   -T SelectVariants \
   -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
   -V $WORK/1_output/1.7_raw_variants/0_rawVariants.vcf \
   -selectType SNP \
   -o $WORK/1_output/1.7_raw_variants/1_rawVariants_snps.vcf

# hard filter by quality thresholds (fails are only flagged)
java -Xmx63G -jar $GATK \
   -T VariantFiltration \
   -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
   -V $WORK/1_output/1.7_raw_variants/1_rawVariants_snps.vcf \
   --filterExpression "QD < 2.5" \
   --filterName "filter_QD" \
   --filterExpression "FS > 25.0" \
   --filterName "filter_FS" \
   --filterExpression "SOR > 3.0" \
   --filterName "filter_SOR" \
   --filterExpression "MQ < 58.0 || MQ > 62.0" \
   --filterName "filter_MQ" \
   --filterExpression "MQRankSum < -2.5 || MQRankSum > 2.5" \
   --filterName "filter_MQRankSum" \
   --filterExpression "ReadPosRankSum < -2.5 || ReadPosRankSum > 2.5 " \
   --filterName "filter_ReadPosRankSum" \
   -o $WORK/1_output/1.8_filtered_variants/2_filtered_snps.vcf

# remove filtered variants, and totally missing sites
java -Xmx42G -jar $GATK \
     -T SelectVariants \
     -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
     -V $WORK/1_output/1.8_filtered_variants/2_filtered_snps.vcf \
     -o $WORK/1_output/1.8_filtered_variants/3_clean_snps.vcf \
     --excludeFiltered \
     --maxNOCALLfraction 0.99

# remove multiallelic sites
java -Xmx42G -jar $GATK \
     -T SelectVariants \
     -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
     -V $WORK/1_output/1.8_filtered_variants/3_clean_snps.vcf \
     -o $WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf \
     --restrictAllelesTo BIALLELIC

