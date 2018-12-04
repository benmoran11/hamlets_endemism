#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ghsgemflo1                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.6.1.loop_genHetSep_gemflo1.stdout
#PBS -e 3.6.1.loop_genHetSep_gemflo1.stderr

module load java1.8.0
module load python3.6.2

INDIR=$WORK/3_output/3.5_vcfParser_out/gemflo
OUTDIR=$WORK/3_output/3.6_multiHetSep/gemflo1
COVDIR=$WORK/3_output/3.4_bamCaller_out/gemflo


for k in {01..24}; do
        L="LG"$k;
        echo $L;

        generate_multihetsep.py --mask=$COVDIR/PL17_142_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/PL17_144_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/PL17_145_${L}_coverage.mask.bed.gz \
	    --mask=$COVDIR/PL17_153_${L}_coverage.mask.bed.gz \
            --mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
            --negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
	    $INDIR/segsites_PL17_142_$L.vcf.gz $INDIR/segsites_PL17_144_$L.vcf.gz \
	    $INDIR/segsites_PL17_145_$L.vcf.gz $INDIR/segsites_PL17_153_$L.vcf.gz \
		> $OUTDIR/$L.gemflo1.multihetsep.txt
	    echo done
        echo '-----------------------';

done
