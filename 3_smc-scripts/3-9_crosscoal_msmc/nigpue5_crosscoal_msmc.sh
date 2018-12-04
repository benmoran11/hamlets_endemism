#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nigpue5                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.1.crosscoal_msmc_nigpue5.stdout
#PBS -e 3.9.1.crosscoal_msmc_nigpue5.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/nigpue

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/nigpue5_nig.msmc -I 8,9,12,13 \
    $INDIR/LG01.nigpue.multihetsep.txt \
    $INDIR/LG02.nigpue.multihetsep.txt \
    $INDIR/LG03.nigpue.multihetsep.txt \
    $INDIR/LG04.nigpue.multihetsep.txt \
    $INDIR/LG05.nigpue.multihetsep.txt \
    $INDIR/LG06.nigpue.multihetsep.txt \
    $INDIR/LG07.nigpue.multihetsep.txt \
    $INDIR/LG08.nigpue.multihetsep.txt \
    $INDIR/LG09.nigpue.multihetsep.txt \
    $INDIR/LG10.nigpue.multihetsep.txt \
    $INDIR/LG11.nigpue.multihetsep.txt \
    $INDIR/LG12.nigpue.multihetsep.txt \
    $INDIR/LG13.nigpue.multihetsep.txt \
    $INDIR/LG14.nigpue.multihetsep.txt \
    $INDIR/LG15.nigpue.multihetsep.txt \
    $INDIR/LG16.nigpue.multihetsep.txt \
    $INDIR/LG17.nigpue.multihetsep.txt \
    $INDIR/LG18.nigpue.multihetsep.txt \
    $INDIR/LG19.nigpue.multihetsep.txt \
    $INDIR/LG20.nigpue.multihetsep.txt \
    $INDIR/LG21.nigpue.multihetsep.txt \
    $INDIR/LG22.nigpue.multihetsep.txt \
    $INDIR/LG23.nigpue.multihetsep.txt \
    $INDIR/LG24.nigpue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/nigpue5_pue.msmc -I 24,25,44,45 \
    $INDIR/LG01.nigpue.multihetsep.txt \
    $INDIR/LG02.nigpue.multihetsep.txt \
    $INDIR/LG03.nigpue.multihetsep.txt \
    $INDIR/LG04.nigpue.multihetsep.txt \
    $INDIR/LG05.nigpue.multihetsep.txt \
    $INDIR/LG06.nigpue.multihetsep.txt \
    $INDIR/LG07.nigpue.multihetsep.txt \
    $INDIR/LG08.nigpue.multihetsep.txt \
    $INDIR/LG09.nigpue.multihetsep.txt \
    $INDIR/LG10.nigpue.multihetsep.txt \
    $INDIR/LG11.nigpue.multihetsep.txt \
    $INDIR/LG12.nigpue.multihetsep.txt \
    $INDIR/LG13.nigpue.multihetsep.txt \
    $INDIR/LG14.nigpue.multihetsep.txt \
    $INDIR/LG15.nigpue.multihetsep.txt \
    $INDIR/LG16.nigpue.multihetsep.txt \
    $INDIR/LG17.nigpue.multihetsep.txt \
    $INDIR/LG18.nigpue.multihetsep.txt \
    $INDIR/LG19.nigpue.multihetsep.txt \
    $INDIR/LG20.nigpue.multihetsep.txt \
    $INDIR/LG21.nigpue.multihetsep.txt \
    $INDIR/LG22.nigpue.multihetsep.txt \
    $INDIR/LG23.nigpue.multihetsep.txt \
    $INDIR/LG24.nigpue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/nigpue5_cross.msmc -I 8,9,12,13,24,25,44,45 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.nigpue.multihetsep.txt \
    $INDIR/LG02.nigpue.multihetsep.txt \
    $INDIR/LG03.nigpue.multihetsep.txt \
    $INDIR/LG04.nigpue.multihetsep.txt \
    $INDIR/LG05.nigpue.multihetsep.txt \
    $INDIR/LG06.nigpue.multihetsep.txt \
    $INDIR/LG07.nigpue.multihetsep.txt \
    $INDIR/LG08.nigpue.multihetsep.txt \
    $INDIR/LG09.nigpue.multihetsep.txt \
    $INDIR/LG10.nigpue.multihetsep.txt \
    $INDIR/LG11.nigpue.multihetsep.txt \
    $INDIR/LG12.nigpue.multihetsep.txt \
    $INDIR/LG13.nigpue.multihetsep.txt \
    $INDIR/LG14.nigpue.multihetsep.txt \
    $INDIR/LG15.nigpue.multihetsep.txt \
    $INDIR/LG16.nigpue.multihetsep.txt \
    $INDIR/LG17.nigpue.multihetsep.txt \
    $INDIR/LG18.nigpue.multihetsep.txt \
    $INDIR/LG19.nigpue.multihetsep.txt \
    $INDIR/LG20.nigpue.multihetsep.txt \
    $INDIR/LG21.nigpue.multihetsep.txt \
    $INDIR/LG22.nigpue.multihetsep.txt \
    $INDIR/LG23.nigpue.multihetsep.txt \
    $INDIR/LG24.nigpue.multihetsep.txt
echo done

combineCrossCoal.py nigpue5_cross.msmc.final.txt nigpue5_nig.msmc.final.txt nigpue5_pue.msmc.final.txt > combined_nigpue5_msmc.final.txt
