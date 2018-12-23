#PBS -l elapstim_req=99:50:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N winpi
#PBS -q cllong
#PBS -o 2.2.windowed_pi.stdout
#PBS -e 2.2.windowed_pi.stderr

mkdir $WORK/2_output/2.2_pi
cd $WORK/2_output/2.2_pi

vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz \
    --keep $WORK/0_data/0_resources/maybel.txt \
    --window-pi 10000 \
    --out pi.maybel-10kb
gzip pi.maybel-10kb.windowed.pi


vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz \
    --keep $WORK/0_data/0_resources/puebel.txt \
    --window-pi 10000 \
    --out pi.puebel-10kb
gzip pi.puebel-10kb.windowed.pi


vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz \
    --keep $WORK/0_data/0_resources/nigbel.txt \
    --window-pi 10000 \
    --out pi.nigbel-10kb
gzip pi.nigbel-10kb.windowed.pi


vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz \
    --keep $WORK/0_data/0_resources/unibel.txt \
    --window-pi 10000 \
    --out pi.unibel-10kb
gzip pi.unibel-10kb.windowed.pi


vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz \
    --keep $WORK/0_data/0_resources/gemflo.txt \
    --window-pi 10000 \
    --out pi.gemflo-10kb
gzip pi.gemflo-10kb.windowed.pi



