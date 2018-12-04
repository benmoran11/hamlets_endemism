#PBS -l elapstim_req=20:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=120gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N ccGHSgemmay                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.7.1.crosscoal_genHetSep_gemmay.stdout
#PBS -e 3.7.1.crosscoal_genHetSep_gemmay.stderr
module load java1.8.0
module load python3.6.2

IN1DIR=$WORK/3_output/3.5_vcfParser_out/gemflo
IN2DIR=$WORK/3_output/3.5_vcfParser_out/maybel
OUTDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/gemmay
COV1DIR=$WORK/3_output/3.4_bamCaller_out/gemflo
COV2DIR=$WORK/3_output/3.4_bamCaller_out/maybel

for k in {01..24}; do
        L="LG"$k;
        echo $OUTDIR', '$L;
        
        generate_multihetsep.py  --mask=$COV1DIR/PL17_142gemflo2_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/PL17_144gemflo2_${L}_coverage.mask.bed.gz \
	    --mask=$COV1DIR/PL17_145gemflo2_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/PL17_148gemflo2_${L}_coverage.mask.bed.gz \
            --mask=$COV1DIR/PL17_153gemflo2_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_89maybel1_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_95maybel1_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_101maybel1_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_119maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_120maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_121maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_122maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_123maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_124maybel8_${L}_coverage.mask.bed.gz \
            --mask=$COV2DIR/PL17_126maybel8_${L}_coverage.mask.bed.gz \
            --mask=$WORK/0_data/0_resources/mappability_masks/v2_01_$L.mapmask.bed.txt.gz \
            --negative_mask=$WORK/3_output/3.1_indel_mask/5_indel_mask_$L.bed.gz \
            $IN1DIR/segsites_PL17_142_$L.vcf.gz $IN1DIR/segsites_PL17_144_$L.vcf.gz \
            $IN1DIR/segsites_PL17_145_$L.vcf.gz $IN1DIR/segsites_PL17_148_$L.vcf.gz \
            $IN1DIR/segsites_PL17_153_$L.vcf.gz \
            $IN2DIR/segsites_PL17_89_$L.vcf.gz $IN2DIR/segsites_PL17_95_$L.vcf.gz \
            $IN2DIR/segsites_PL17_101_$L.vcf.gz $IN2DIR/segsites_PL17_119_$L.vcf.gz \
            $IN2DIR/segsites_PL17_120_$L.vcf.gz $IN2DIR/segsites_PL17_121_$L.vcf.gz \
            $IN2DIR/segsites_PL17_122_$L.vcf.gz $IN2DIR/segsites_PL17_123_$L.vcf.gz \
            $IN2DIR/segsites_PL17_124_$L.vcf.gz $IN2DIR/segsites_PL17_126_$L.vcf.gz \
            > $OUTDIR/$L.gemmay.multihetsep.txt
        echo done
        echo '-----------------------';

done
