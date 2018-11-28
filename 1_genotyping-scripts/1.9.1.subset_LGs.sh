#PBS -l elapstim_req=25:30:00
#PBS -l memsz_job=65gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N subset
#PBS -q clmedium
#PBS -o 1.9.1.subsetVcf.stdout
#PBS -e 1.9.1.subsetVcf.stderr

cd $WORK/1_output/1.8_filtered_variants

for k in {01..24}; do
    i="LG"$k;
    

    vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf.gz \
	--chr $i \
	--out $WORK/1_output/1.9_split_variants/4_bi-allelic_snps.$i \
	--recode
    
    mv $WORK/1_output/1.9_split_variants/4_bi-allelic_snps.$i.recode.vcf $WORK/1_output/1.9_split_variants/4_bi-allelic_snps.$i.vcf
    gzip $WORK/1_output/1.9_split_variants/4_bi-allelic_snps.$i.vcf
done
