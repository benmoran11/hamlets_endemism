#PBS -l elapstim_req=26:00:00
#PBS -l memsz_job=60gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N merge
#PBS -q clmedium
#PBS -o 1.7.3.all_Variants_merger.stdout
#PBS -e 1.7.3.all_Variants_merger.stderr

module load java1.8.0

cd $WORK/1_output/1.7_raw_variants

java -Xmx10G -jar $PICARD GatherVcfs \
    I=0_rawVariants_all.LG01.vcf.gz \
    I=0_rawVariants_all.LG02.vcf.gz \
    I=0_rawVariants_all.LG03.vcf.gz \
    I=0_rawVariants_all.LG04.vcf.gz \
    I=0_rawVariants_all.LG05.vcf.gz \
    I=0_rawVariants_all.LG06.vcf.gz \
    I=0_rawVariants_all.LG07.vcf.gz \
    I=0_rawVariants_all.LG08.vcf.gz \
    I=0_rawVariants_all.LG09.vcf.gz \
    I=0_rawVariants_all.LG10.vcf.gz \
    I=0_rawVariants_all.LG11.vcf.gz \
    I=0_rawVariants_all.LG12.vcf.gz \
    I=0_rawVariants_all.LG13.vcf.gz \
    I=0_rawVariants_all.LG14.vcf.gz \
    I=0_rawVariants_all.LG15.vcf.gz \
    I=0_rawVariants_all.LG16.vcf.gz \
    I=0_rawVariants_all.LG17.vcf.gz \
    I=0_rawVariants_all.LG18.vcf.gz \
    I=0_rawVariants_all.LG19.vcf.gz \
    I=0_rawVariants_all.LG20.vcf.gz \
    I=0_rawVariants_all.LG21.vcf.gz \
    I=0_rawVariants_all.LG22.vcf.gz \
    I=0_rawVariants_all.LG23.vcf.gz \
    I=0_rawVariants_all.LG24.vcf.gz \
    O=0_rawVariants_all.vcf.gz

echo "--- done ---";
