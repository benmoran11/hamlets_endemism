#PBS -l elapstim_req=10:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N uni_smcppinput                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.10.4.smcpp_input_unibel.stdout
#PBS -e 3.10.4.smcpp_input_unibel.stderr
module load java1.8.0
module load python3.6.2

MASKDIR=$WORK/0_data/0_resources
INDIR=$WORK/1_output/1.8_filtered_variants/
OUTDIR=$WORK/3_output/3.10_smcpp_input/unibel/withpeaks

for i in $(cat $MASKDIR/unibel.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/masked_n_ranges.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L unibel:18163,18261,18267,18274,18276,19881,20092,20120,20126,20128,20135,20149
    done
done

OUTDIR=$WORK/3_output/3.10_smcpp_input/unibel/nopeaks

for i in $(cat $MASKDIR/unibel.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/smcpp_mask_ns_peaks.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L unibel:18163,18261,18267,18274,18276,19881,20092,20120,20126,20128,20135,20149
    done
done
