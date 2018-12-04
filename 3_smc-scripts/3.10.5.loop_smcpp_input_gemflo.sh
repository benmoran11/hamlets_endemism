#PBS -l elapstim_req=10:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=55gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1            # Anzahl benoetigter CPUs pro Knoten
#PBS -N gem_smcppinput                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.10.1.smcpp_input_gemflo.stdout
#PBS -e 3.10.1.smcpp_input_gemflo.stderr
module load java1.8.0
module load python3.6.2

MASKDIR=$WORK/0_data/0_resources
INDIR=$WORK/1_output/1.8_filtered_variants/
OUTDIR=$WORK/3_output/3.10_smcpp_input/gemflo/withpeaks

for i in $(cat $MASKDIR/gemflo.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/masked_n_ranges.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L gemflo:PL17_142,PL17_144,PL17_145,PL17_148,PL17_153
    done
done

OUTDIR=$WORK/3_output/3.10_smcpp_input/gemflo/nopeaks

for i in $(cat $MASKDIR/gemflo.txt); do
    for k in {01..24}; do
        L="LG"$k;
        echo $i, $L;
        smc++ vcf2smc -d $i $i -m $MASKDIR/smcpp_mask_ns_peaks.bed.txt.gz $INDIR/4_bi-allelic_snps.vcf $OUTDIR/dist.$i.$L.txt $L gemflo:PL17_142,PL17_144,PL17_145,PL17_148,PL17_153
    done
done
