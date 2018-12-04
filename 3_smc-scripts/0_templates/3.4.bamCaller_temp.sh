#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N bC_XXspeciesXX                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.4.bamCaller_XXspeciesXX.stdout
#PBS -e 3.4.bamCaller_XXspeciesXX.stderr
module load java1.8.0
module load python3.6.2
module load samtools1.5

# Applying the bamHamletCaller.py script, which is modified from the bamCaller.py script of the msmc-tools Github repo. 
# Only the coverage mask output will be used; vcfParser will be used for the segregating sites
# You may need to copy this script into the msmc-tools-master directory (along with the rest of the package) for proper execution,
# and change the path in this template accordingly 

INDIR=$WORK/1_output/1.4_dedup
OUTDIR=$WORK/3_output/3.4_bamCaller_out/XXspeciesXX

cd $WORK/3_smc-scripts

for i in $(cat $WORK/0_data/0_resources/XXspeciesXX.txt); do
    FULL=$(grep $i $WORK/0_data/0_resources/fullnames.txt)
    for k in {01..24}; do

	L="LG"$k;
	DEPTH=$( grep $i $WORK/3_output/3.3_phased_indiv_depths/phased_snps.idepth | awk '{print $3}')
	echo "------------------------------------------"
	echo $i", "$L

	samtools mpileup -q 25 -Q 20 -C 50 -u -r $L -f $WORK/0_data/0_resources/HP_genome_unmasked_01.fa $INDIR/$FULL-dedup.bam | \
	    bcftools call -c -V indels | $WORK/0_data/2_scripts/bamHamletCaller.py $DEPTH $OUTDIR/${FULL}_${L}_coverage.mask.bed.gz | \
	    gzip -c > $OUTDIR/${FULL}_${L}_segsites.vcf.gz

	echo "------------------------------------------"

    done
done


