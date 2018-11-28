#PBS -l elapstim_req=20:00:00
#PBS -l memsz_job=120gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N mergeLG
#PBS -q clmedium
#PBS -o 1.12.merge_phased_vcfs.stdout
#PBS -e 1.12.merge_phased_vcfs.stderr

module load java1.8.0
cd $WORK/1_output/1.11_phased_variants

# merge phased vcfs
java -cp $GATK org.broadinstitute.gatk.tools.CatVariants \
        -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
        -V 5_phased-LG01.vcf.gz \
        -V 5_phased-LG02.vcf.gz \
        -V 5_phased-LG03.vcf.gz \
        -V 5_phased-LG04.vcf.gz \
        -V 5_phased-LG05.vcf.gz \
        -V 5_phased-LG06.vcf.gz \
        -V 5_phased-LG07.vcf.gz \
        -V 5_phased-LG08.vcf.gz \
        -V 5_phased-LG09.vcf.gz \
        -V 5_phased-LG10.vcf.gz \
        -V 5_phased-LG11.vcf.gz \
        -V 5_phased-LG12.vcf.gz \
        -V 5_phased-LG13.vcf.gz \
        -V 5_phased-LG14.vcf.gz \
        -V 5_phased-LG15.vcf.gz \
        -V 5_phased-LG16.vcf.gz \
        -V 5_phased-LG17.vcf.gz \
        -V 5_phased-LG18.vcf.gz \
        -V 5_phased-LG19.vcf.gz \
        -V 5_phased-LG20.vcf.gz \
        -V 5_phased-LG21.vcf.gz \
        -V 5_phased-LG22.vcf.gz \
        -V 5_phased-LG23.vcf.gz \
        -V 5_phased-LG24.vcf.gz \
        -out 5_phased.vcf.gz \
        --assumeSorted
echo done
