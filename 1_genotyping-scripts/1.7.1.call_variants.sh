#PBS -l elapstim_req=100:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1           	# Anzahl benoetigter CPUs pro Knoten
#PBS -N rawVar           	      	# Name des Batch-Jobs
#PBS -q cllong               	# [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 1.7.1.call_variants.stdout
#PBS -e 1.7.1.call_variants.stderr

module load java1.8.0

java -Xmx118G -jar $GATK \
	-R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
	-T GenotypeGVCFs \
	-V $WORK/0_data/0_resources/gVCFs_all.list \
    	-o $WORK/1_output/1.7_raw_variants/0_rawVariants.vcf

echo done
