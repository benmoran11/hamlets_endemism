#PBS -l elapstim_req=20:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ccgnFnigpue                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.7.1.crosscoal_genHetSep_noFstPeaks_nigpue.stdout
#PBS -e 3.7.1.crosscoal_genHetSep_noFstPeaks_nigpue.stderr
module load java1.8.0
module load python3.6.2

IN1DIR=$WORK/3_output/3.5_vcfParser_out/nigbel
IN2DIR=$WORK/3_output/3.5_vcfParser_out/puebel
OUTDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/nigpue
COV1DIR=$WORK/3_output/3.4_bamCaller_out/nigbel
COV2DIR=$WORK/3_output/3.4_bamCaller_out/puebel

for k in {01..24}; do
        L="LG"$k;
	
	if [ -a $WORK/0_data/0_resources/Fst_masks/pFst_lrt_q0.999_peaks_$L.bed.txt.gz ]; then
            echo $OUTDIR', '$L;
        
            generate_multihetsep.py --mask=$COV1DIR/18151nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18153nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18155nigbel2_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18156nigbel2_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18157nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18158nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18159nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18162nigbel2_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18165nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18171nigbel2_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18185nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV1DIR/18187nigbel1_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18152puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18154puebel5_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18161puebel5_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18166puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18169puebel5_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18172puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18174puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18175puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18176puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18178puebel4_${L}_coverage.mask.bed.gz \
		--mask=$COV2DIR/18179puebel4_${L}_coverage.mask.bed.gz \
		--mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
		--negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
		--negative_mask=$WORK/0_data/0_resources/Fst_masks/pFst_lrt_q0.999_peaks_$L.bed.txt.gz \
		$IN1DIR/segsites_18151_${L}.vcf.gz $IN1DIR/segsites_18153_${L}.vcf.gz \
		$IN1DIR/segsites_18155_${L}.vcf.gz $IN1DIR/segsites_18156_${L}.vcf.gz \
		$IN1DIR/segsites_18157_${L}.vcf.gz $IN1DIR/segsites_18158_${L}.vcf.gz \
		$IN1DIR/segsites_18159_${L}.vcf.gz $IN1DIR/segsites_18162_${L}.vcf.gz \
		$IN1DIR/segsites_18165_${L}.vcf.gz $IN1DIR/segsites_18171_${L}.vcf.gz \
		$IN1DIR/segsites_18185_${L}.vcf.gz $IN1DIR/segsites_18187_${L}.vcf.gz \
		$IN2DIR/segsites_18152_${L}.vcf.gz $IN2DIR/segsites_18154_${L}.vcf.gz \
		$IN2DIR/segsites_18161_${L}.vcf.gz $IN2DIR/segsites_18166_${L}.vcf.gz \
		$IN2DIR/segsites_18169_${L}.vcf.gz $IN2DIR/segsites_18172_${L}.vcf.gz \
		$IN2DIR/segsites_18174_${L}.vcf.gz $IN2DIR/segsites_18175_${L}.vcf.gz \
		$IN2DIR/segsites_18176_${L}.vcf.gz $IN2DIR/segsites_18178_${L}.vcf.gz \
		$IN2DIR/segsites_18179_${L}.vcf.gz $IN2DIR/segsites_18180_${L}.vcf.gz \
		> $OUTDIR/$L.nigpue.noFstPeaks.multihetsep.txt
            echo done
            echo '-----------------------';
	fi
done
