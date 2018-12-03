#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N vP_maybel                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.5.vcfParser_maybel.stdout
#PBS -e 3.5.vcfParser_maybel.stderr
module load java1.8.0
module load python3.6.2

$INDIR=$WORK/3_output/3.2_split_inds/maybel
$OUTDIR=$WORK/3_output/3.5_vcfParser_out/maybel

for i in $(cat $WORK/0_data/0_resources/maybel.txt); do
    for k in {01..24}; do

        L="LG"$k;

	cat $INDIR/${i}_${L}_phasedSNPs.vcf | vcfAllSiteParser.py $L $OUTDIR/covered_sites_${i}_${L}.bed.txt.gz | gzip -c > $OUTDIR/segsites_${i}_${L}.vcf.gz
	
    done
done

echo done
