#PBS -l elapstim_req=45:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=51gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=10                   # Anzahl benoetigter CPUs pro Knoten
#PBS -N maya_select                     # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 4.1.select_maya_sites.stdout
#PBS -e 4.1.select_maya_sites.stderr

# Filtering the bi-allelic SNP dataset for no missing individuals and minor allele count greater than 2, following best practices for LD-based Ne estimation
module load java1.8.0

java -Xmx50G -jar $GATK \
                -T SelectVariants \
                -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
                -V $WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf \
                -L $WORK/0_data/0_resources/chromosomes.intervals \
                -sn PL17_89 \
                -sn PL17_95 \
                -sn PL17_101 \
                -sn PL17_119 \
                -sn PL17_120 \
                -sn PL17_121 \
                -sn PL17_122 \
                -sn PL17_123 \
                -sn PL17_124 \
                -sn PL17_126 \
                --excludeNonVariants \
                --maxNOCALLfraction 0.0 \
                --restrictAllelesTo BIALLELIC \
                --selectexpressions "AC > 2 && AF < 0.9" \
                --excludeFiltered \
                -o $WORK/4_output/4.1_filtered_SNPs/maybel_LDNe_SNPs.vcf
echo done
