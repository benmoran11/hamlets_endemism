#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N si_XXspeciesXX                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.2.split_indivs_XXspeciesXX.stdout
#PBS -e 3.2.split_indivs_XXspeciesXX.stderr
module load java1.8.0

for i in $(cat $WORK/0_data/0_resources/XXspeciesXX.txt); do
    for k in {01..24}; do
	L="LG"$k;

	echo "------------------------------------------"
	echo $i", "$L
	
	java -Xmx50G -jar $GATK \
	    -T SelectVariants \
	    -R $WORK/0_data/0_resources/HP_genome_unmasked_01.fa \
	    -V 1_output/1.11_phased_variants/5_phased-$L.vcf.gz \
	    -sn $i \
	    -o $WORK/3_output/3.2_split_inds/XXspeciesXX/${i}_${L}_phasedSNPs.vcf

	echo "------------------------------------------"

    done
done

echo done
