#PBS -l elapstim_req=34:00:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N vcGeXXnameXX
#PBS -q clmedium
#PBS -o 1.10.2.vcf2geno.LGXXnameXX.stdout
#PBS -e 1.10.2.vcf2geno.LGXXnameXX.stderr

cd $WORK/1_output/1.8_filtered_variants

python $SFTWR/genomics_general/VCF_processing/parseVCF.py \
    -i 4_maxMissing5_allBP.recode.LGXXnameXX.recode.vcf.gz | gzip > 4_maxMissing5_allBP.LGXXnameXX.geno.gz
