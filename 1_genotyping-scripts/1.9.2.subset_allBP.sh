#PBS -l elapstim_req=40:00:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N vcfgen
#PBS -q clmedium
#PBS -o 1.9.2.subset_allBP_by_LG.stdout
#PBS -e 1.9.2.subset_allBP_by_LG.stderr

cd $WORK/1_output/1.8_filtered_variants

for k in {01..24};do
    j="LG"$k;
    echo " -- $j --"
    vcftools --gzvcf 4_maxMissing11_allBP.recode.vcf.gz \
	--chr $j \
	--out $WORK/1_output/1.9_split_variants/4_maxMissing5_allBP.recode.$j \
	--recode;
    
    gzip $WORK/1_output/1.9_split_variants/4_maxMissing5_allBP.recode.$j.recode.vcf;
done

echo "-- done --"
