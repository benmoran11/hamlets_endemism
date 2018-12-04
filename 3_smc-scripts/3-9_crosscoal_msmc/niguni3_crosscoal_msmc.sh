#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N niguni3                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.1.crosscoal_msmc_niguni3.stdout
#PBS -e 3.9.1.crosscoal_msmc_niguni3.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/niguni

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/niguni3_nig.msmc -I 10,11,20,21 \
    $INDIR/LG01.niguni.multihetsep.txt \
    $INDIR/LG02.niguni.multihetsep.txt \
    $INDIR/LG03.niguni.multihetsep.txt \
    $INDIR/LG04.niguni.multihetsep.txt \
    $INDIR/LG05.niguni.multihetsep.txt \
    $INDIR/LG06.niguni.multihetsep.txt \
    $INDIR/LG07.niguni.multihetsep.txt \
    $INDIR/LG08.niguni.multihetsep.txt \
    $INDIR/LG09.niguni.multihetsep.txt \
    $INDIR/LG10.niguni.multihetsep.txt \
    $INDIR/LG11.niguni.multihetsep.txt \
    $INDIR/LG12.niguni.multihetsep.txt \
    $INDIR/LG13.niguni.multihetsep.txt \
    $INDIR/LG14.niguni.multihetsep.txt \
    $INDIR/LG15.niguni.multihetsep.txt \
    $INDIR/LG16.niguni.multihetsep.txt \
    $INDIR/LG17.niguni.multihetsep.txt \
    $INDIR/LG18.niguni.multihetsep.txt \
    $INDIR/LG19.niguni.multihetsep.txt \
    $INDIR/LG20.niguni.multihetsep.txt \
    $INDIR/LG21.niguni.multihetsep.txt \
    $INDIR/LG22.niguni.multihetsep.txt \
    $INDIR/LG23.niguni.multihetsep.txt \
    $INDIR/LG24.niguni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/niguni3_uni.msmc -I 30,31,42,43 \
    $INDIR/LG01.niguni.multihetsep.txt \
    $INDIR/LG02.niguni.multihetsep.txt \
    $INDIR/LG03.niguni.multihetsep.txt \
    $INDIR/LG04.niguni.multihetsep.txt \
    $INDIR/LG05.niguni.multihetsep.txt \
    $INDIR/LG06.niguni.multihetsep.txt \
    $INDIR/LG07.niguni.multihetsep.txt \
    $INDIR/LG08.niguni.multihetsep.txt \
    $INDIR/LG09.niguni.multihetsep.txt \
    $INDIR/LG10.niguni.multihetsep.txt \
    $INDIR/LG11.niguni.multihetsep.txt \
    $INDIR/LG12.niguni.multihetsep.txt \
    $INDIR/LG13.niguni.multihetsep.txt \
    $INDIR/LG14.niguni.multihetsep.txt \
    $INDIR/LG15.niguni.multihetsep.txt \
    $INDIR/LG16.niguni.multihetsep.txt \
    $INDIR/LG17.niguni.multihetsep.txt \
    $INDIR/LG18.niguni.multihetsep.txt \
    $INDIR/LG19.niguni.multihetsep.txt \
    $INDIR/LG20.niguni.multihetsep.txt \
    $INDIR/LG21.niguni.multihetsep.txt \
    $INDIR/LG22.niguni.multihetsep.txt \
    $INDIR/LG23.niguni.multihetsep.txt \
    $INDIR/LG24.niguni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/niguni3_cross.msmc -I 10,11,20,21,30,31,42,43 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.niguni.multihetsep.txt \
    $INDIR/LG02.niguni.multihetsep.txt \
    $INDIR/LG03.niguni.multihetsep.txt \
    $INDIR/LG04.niguni.multihetsep.txt \
    $INDIR/LG05.niguni.multihetsep.txt \
    $INDIR/LG06.niguni.multihetsep.txt \
    $INDIR/LG07.niguni.multihetsep.txt \
    $INDIR/LG08.niguni.multihetsep.txt \
    $INDIR/LG09.niguni.multihetsep.txt \
    $INDIR/LG10.niguni.multihetsep.txt \
    $INDIR/LG11.niguni.multihetsep.txt \
    $INDIR/LG12.niguni.multihetsep.txt \
    $INDIR/LG13.niguni.multihetsep.txt \
    $INDIR/LG14.niguni.multihetsep.txt \
    $INDIR/LG15.niguni.multihetsep.txt \
    $INDIR/LG16.niguni.multihetsep.txt \
    $INDIR/LG17.niguni.multihetsep.txt \
    $INDIR/LG18.niguni.multihetsep.txt \
    $INDIR/LG19.niguni.multihetsep.txt \
    $INDIR/LG20.niguni.multihetsep.txt \
    $INDIR/LG21.niguni.multihetsep.txt \
    $INDIR/LG22.niguni.multihetsep.txt \
    $INDIR/LG23.niguni.multihetsep.txt \
    $INDIR/LG24.niguni.multihetsep.txt
echo done

combineCrossCoal.py niguni3_cross.msmc.final.txt niguni3_nig.msmc.final.txt niguni3_uni.msmc.final.txt > combined_niguni3_msmc.final.txt
