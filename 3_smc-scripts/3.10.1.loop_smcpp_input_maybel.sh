#PBS -l elapstim_req=10:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N may_smcppinput                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.10.1.smcpp_input_maybel.stdout
#PBS -e 3.10.1.smcpp_input_maybel.stderr
module load java1.8.0
module load python3.6.2

MASKDIR=$WORK/0_data/0_resources
INDIR=$WORK/1_output/1.8_filtered_variants/
OUTDIR=$WORK/3_output/3.10_smcpp_input/maybel/withpeaks

for i in $(cat $MASKDIR/maybel.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/masked_n_ranges.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L maybel:PL17_89,PL17_95,PL17_101,PL17_119,PL17_120,PL17_121,PL17_122,PL17_123,PL17_124,PL17_126
    done
done

OUTDIR=$WORK/3_output/3.10_smcpp_input/maybel/nopeaks

for i in $(cat $MASKDIR/maybel.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/smcpp_mask_ns_peaks.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L maybel:PL17_89,PL17_95,PL17_101,PL17_119,PL17_120,PL17_121,PL17_122,PL17_123,PL17_124,PL17_126
    done
done
