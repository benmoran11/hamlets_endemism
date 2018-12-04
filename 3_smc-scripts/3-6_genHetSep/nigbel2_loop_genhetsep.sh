#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ghsnigbel2                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.6.1.loop_genHetSep_nigbel2.stdout
#PBS -e 3.6.1.loop_genHetSep_nigbel2.stderr

module load java1.8.0
module load python3.6.2

INDIR=$WORK/3_output/3.5_vcfParser_out/nigbel
OUTDIR=$WORK/3_output/3.6_multiHetSep/nigbel2
COVDIR=$WORK/3_output/3.4_bamCaller_out/nigbel


for k in {01..24}; do
        L="LG"$k;
        echo $L;

        generate_multihetsep.py --mask=$COVDIR/18151_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/18157_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/18158_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/18185_${L}_coverage.mask.bed.gz \
            --mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
            --negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
	    $INDIR/segsites_18151_$L.vcf.gz $INDIR/segsites_18157_$L.vcf.gz \
	    $INDIR/segsites_18158_$L.vcf.gz $INDIR/segsites_18185_$L.vcf.gz \
		> $OUTDIR/$L.nigbel2.multihetsep.txt
	    echo done
        echo '-----------------------';

done
