#PBS -l elapstim_req=35:00:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N vXXnameXX
#PBS -q clmedium
#PBS -o 1.7.all_variants.XXnameXX.stdout
#PBS -e 1.7.all_variants.XXnameXX.stderr

module load java1.8.0

cd $WORK/1_output/1.7_raw_variants

java -Xmx118G -jar $GATK -T GenotypeGVCFs --includeNonVariantSites \
    -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
    -L XXnameXX \
    -V $WORK/0_data/0_resources/gVCS_all.list \
    -o $WORK/1_output/1.7_raw_variants/0_rawVariants_all.XXnameXX.vcf

gzip $WORK/1_output/1.7_raw_variants/0_rawVariants_all.XXnameXX.vcf
echo done