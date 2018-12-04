#PBS -l elapstim_req=20:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ccGHSpueuni                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.7.1.crosscoal_genHetSep_pueuni.stdout
#PBS -e 3.7.1.crosscoal_genHetSep_pueuni.stderr
module load java1.8.0
module load python3.6.2

IN1DIR=$WORK/3_output/3.5_vcfParser_out/puebel
IN2DIR=$WORK/3_output/3.5_vcfParser_out/unibel
OUTDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/pueuni
COV1DIR=$WORK/3_output/3.4_bamCaller_out/puebel
COV2DIR=$WORK/3_output/3.4_bamCaller_out/unibel

for k in {01..24}; do
        L="LG"$k;
        echo $OUTDIR', '$L;
        
        generate_multihetsep.py --mask=$COV1DIR/18152puebel4_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/18154puebel5_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18161puebel5_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18166puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18169puebel5_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/18172puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18174puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18175puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18176puebel4_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/18178puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18179puebel4_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/18180puebel5_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/18163unibel7_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/18261unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/18267unibel8_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/18274unibel8_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/18276unibel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/19881unibel8_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/20092unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/20120unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/20126unibel7_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/20128unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/20135unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$COV2DIR/20149unibel7_${L}_coverage.mask.bed.gz \
	    --mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
            --negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
	    $IN1DIR/segsites_18152_${L}.vcf.gz $IN1DIR/segsites_18154_${L}.vcf.gz \
	    $IN1DIR/segsites_18161_${L}.vcf.gz $IN1DIR/segsites_18166_${L}.vcf.gz \
	    $IN1DIR/segsites_18169_${L}.vcf.gz $IN1DIR/segsites_18172_${L}.vcf.gz \
	    $IN1DIR/segsites_18174_${L}.vcf.gz $IN1DIR/segsites_18175_${L}.vcf.gz \
	    $IN1DIR/segsites_18176_${L}.vcf.gz $IN1DIR/segsites_18178_${L}.vcf.gz \
	    $IN1DIR/segsites_18179_${L}.vcf.gz $IN1DIR/segsites_18180_${L}.vcf.gz \
	    $IN2DIR/segsites_18163_${L}.vcf.gz $IN2DIR/segsites_18261_${L}.vcf.gz \
	    $IN2DIR/segsites_18267_${L}.vcf.gz $IN2DIR/segsites_18274_${L}.vcf.gz \
	    $IN2DIR/segsites_18276_${L}.vcf.gz $IN2DIR/segsites_19881_${L}.vcf.gz \
	    $IN2DIR/segsites_20092_${L}.vcf.gz $IN2DIR/segsites_20120_${L}.vcf.gz \
	    $IN2DIR/segsites_20126_${L}.vcf.gz $IN2DIR/segsites_20128_${L}.vcf.gz \
	    $IN2DIR/segsites_20135_${L}.vcf.gz $IN2DIR/segsites_20149_${L}.vcf.gz \
	> $OUTDIR/$L.pueuni.multihetsep.txt
        echo done
        echo '-----------------------';

done
