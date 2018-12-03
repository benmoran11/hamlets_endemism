#PBS -l elapstim_req=45:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=51gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=10                   # Anzahl benoetigter CPUs pro Knoten
#PBS -N may_split                       # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 4.2.maybel-splitSNPsets.stdout
#PBS -e 4.2.maybel-splitSNPsets.stderr
module load java1.8.0


# Splitting SNP dataset into 100 subsets for independent Ne calculations
java -Xmx50G -jar $GATK \
                -T RandomlySplitVariants \
                -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
                -V $WORK/4_output/4.1_filtered_SNPs/maybel_LDNe_SNPs.vcf \
                --splitToManyFiles \
                --numOfOutputVCFFiles 100 \
                -baseOutputName $WORK/4_output/4.2_split_SNPs/maybel_LDNe
echo done
