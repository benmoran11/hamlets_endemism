#PBS -l elapstim_req=47:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ghnFXXrunXX                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.6.4.loop_genHetSep_noFstPeaks_XXrunXX.stdout
#PBS -e 3.6.4.loop_genHetSep_noFstPeaks_XXrunXX.stderr

module load java1.8.0
module load python3.6.2

INDIR=$WORK/3_output/3.5_vcfParser_out/XXspeciesXX
OUTDIR=$WORK/3_output/3.6_multiHetSep/XXrunXX
COVDIR=$WORK/3_output/3.4_bamCaller_out/XXspeciesXX


for k in {01..24}; do
        L="LG"$k;

	if [ -a $WORK/0_data/0_resources/Fst_masks/pFst_lrt_q0.999_peaks_$L.bed.txt.gz ]; then
	    echo $L;
            generate_multihetsep.py --mask=$COVDIR/XXind1XX_${L}_coverage.mask.bed.gz \
		--mask=$COVDIR/XXind2XX_${L}_coverage.mask.bed.gz \
		--mask=$COVDIR/XXind3XX_${L}_coverage.mask.bed.gz \
		--mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
		--negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
		--negative_mask=$WORK/0_data/0_resources/Fst_masks/pFst_lrt_q0.999_peaks_$L.bed.txt.gz \
		$INDIR/segsites_XXind1XX_$L.vcf.gz $INDIR/segsites_XXind2XX_$L.vcf.gz \
		$INDIR/segsites_XXind3XX_$L.vcf.gz \
		> $OUTDIR/$L.XXrunXX.noFstPeaks.multihetsep.txt

	    echo done
        echo '-----------------------';
	fi
done
