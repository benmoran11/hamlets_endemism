#PBS -l elapstim_req=150:00:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N SNPs
#PBS -q clbigmem
#PBS -o 1.8.2.extract_and_filterSNPs_all.stdout
#PBS -e 1.8.2.extract_and_filterSNPs_all.stderr

module load java1.8.0

cd $WORK/1_output/1.7_raw_variants

# exclude indels
java -Xmx116G -jar $GATK \
   -T SelectVariants \
   -jdk_inflater -jdkdeflater \ # Option to use old JDK inflater/deflater rather than Intel inflater/deflater, which consistently ran into a fatal bug when processing this dataset
   -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
   -V $WORK/1_output/1.7_raw_variants/0_rawVariants_all.vcf.gz \
   --selectTypeToExclude INDEL \
   -o $WORK/1_output/1.7_raw_variants/1_rawVariants_snps_allBP.vcf.gz

# hard filter by quality thresholds (fails are only flagged)
java -Xmx79G -jar $GATK \
   -T VariantFiltration \
   -jdk_inflater -jdk_deflater \
   -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
   -V $WORK/1_output/1.7_raw_variants/1_rawVariants_snps_allBP.vcf.gz \
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
   -o $WORK/1_output/1.8_filtered_variants/2_filtered_allBP.vcf.gz 2> filter_allBP_o_e.txt #stderr is extremely large due to warnings at invariant sites; recommend deleting immediately

# remove filtered variants
java -Xmx42G -jar $GATK \
     -T SelectVariants \
     -jdk_inflater -jdk_deflater \
     -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
     -V $WORK/1_output/1.8_filtered_variants/2_filtered_allBP.vcf.gz \
     -o $WORK/1_output/1.8_filtered_variants/3_clean_allBP.vcf.gz \
     --excludeFiltered

# exclude variants missing in more than 10% of individuals (5)
vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/3_clean_allBP.vcf.gz \
    --max-missing-count 5 \
    --out $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP \
    --recode

gzip $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf
