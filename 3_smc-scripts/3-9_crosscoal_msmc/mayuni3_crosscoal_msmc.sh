#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N mayuni3                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.1.crosscoal_msmc_mayuni3.stdout
#PBS -e 3.9.1.crosscoal_msmc_mayuni3.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/mayuni

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/mayuni3_may.msmc -I 8,9,16,17 \
    $INDIR/LG01.mayuni.multihetsep.txt \
    $INDIR/LG02.mayuni.multihetsep.txt \
    $INDIR/LG03.mayuni.multihetsep.txt \
    $INDIR/LG04.mayuni.multihetsep.txt \
    $INDIR/LG05.mayuni.multihetsep.txt \
    $INDIR/LG06.mayuni.multihetsep.txt \
    $INDIR/LG07.mayuni.multihetsep.txt \
    $INDIR/LG08.mayuni.multihetsep.txt \
    $INDIR/LG09.mayuni.multihetsep.txt \
    $INDIR/LG10.mayuni.multihetsep.txt \
    $INDIR/LG11.mayuni.multihetsep.txt \
    $INDIR/LG12.mayuni.multihetsep.txt \
    $INDIR/LG13.mayuni.multihetsep.txt \
    $INDIR/LG14.mayuni.multihetsep.txt \
    $INDIR/LG15.mayuni.multihetsep.txt \
    $INDIR/LG16.mayuni.multihetsep.txt \
    $INDIR/LG17.mayuni.multihetsep.txt \
    $INDIR/LG18.mayuni.multihetsep.txt \
    $INDIR/LG19.mayuni.multihetsep.txt \
    $INDIR/LG20.mayuni.multihetsep.txt \
    $INDIR/LG21.mayuni.multihetsep.txt \
    $INDIR/LG22.mayuni.multihetsep.txt \
    $INDIR/LG23.mayuni.multihetsep.txt \
    $INDIR/LG24.mayuni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/mayuni3_uni.msmc -I 26,27,38,39 \
    $INDIR/LG01.mayuni.multihetsep.txt \
    $INDIR/LG02.mayuni.multihetsep.txt \
    $INDIR/LG03.mayuni.multihetsep.txt \
    $INDIR/LG04.mayuni.multihetsep.txt \
    $INDIR/LG05.mayuni.multihetsep.txt \
    $INDIR/LG06.mayuni.multihetsep.txt \
    $INDIR/LG07.mayuni.multihetsep.txt \
    $INDIR/LG08.mayuni.multihetsep.txt \
    $INDIR/LG09.mayuni.multihetsep.txt \
    $INDIR/LG10.mayuni.multihetsep.txt \
    $INDIR/LG11.mayuni.multihetsep.txt \
    $INDIR/LG12.mayuni.multihetsep.txt \
    $INDIR/LG13.mayuni.multihetsep.txt \
    $INDIR/LG14.mayuni.multihetsep.txt \
    $INDIR/LG15.mayuni.multihetsep.txt \
    $INDIR/LG16.mayuni.multihetsep.txt \
    $INDIR/LG17.mayuni.multihetsep.txt \
    $INDIR/LG18.mayuni.multihetsep.txt \
    $INDIR/LG19.mayuni.multihetsep.txt \
    $INDIR/LG20.mayuni.multihetsep.txt \
    $INDIR/LG21.mayuni.multihetsep.txt \
    $INDIR/LG22.mayuni.multihetsep.txt \
    $INDIR/LG23.mayuni.multihetsep.txt \
    $INDIR/LG24.mayuni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/mayuni3_cross.msmc -I 8,9,16,17,26,27,38,39 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.mayuni.multihetsep.txt \
    $INDIR/LG02.mayuni.multihetsep.txt \
    $INDIR/LG03.mayuni.multihetsep.txt \
    $INDIR/LG04.mayuni.multihetsep.txt \
    $INDIR/LG05.mayuni.multihetsep.txt \
    $INDIR/LG06.mayuni.multihetsep.txt \
    $INDIR/LG07.mayuni.multihetsep.txt \
    $INDIR/LG08.mayuni.multihetsep.txt \
    $INDIR/LG09.mayuni.multihetsep.txt \
    $INDIR/LG10.mayuni.multihetsep.txt \
    $INDIR/LG11.mayuni.multihetsep.txt \
    $INDIR/LG12.mayuni.multihetsep.txt \
    $INDIR/LG13.mayuni.multihetsep.txt \
    $INDIR/LG14.mayuni.multihetsep.txt \
    $INDIR/LG15.mayuni.multihetsep.txt \
    $INDIR/LG16.mayuni.multihetsep.txt \
    $INDIR/LG17.mayuni.multihetsep.txt \
    $INDIR/LG18.mayuni.multihetsep.txt \
    $INDIR/LG19.mayuni.multihetsep.txt \
    $INDIR/LG20.mayuni.multihetsep.txt \
    $INDIR/LG21.mayuni.multihetsep.txt \
    $INDIR/LG22.mayuni.multihetsep.txt \
    $INDIR/LG23.mayuni.multihetsep.txt \
    $INDIR/LG24.mayuni.multihetsep.txt
echo done

combineCrossCoal.py mayuni3_cross.msmc.final.txt mayuni3_may.msmc.final.txt mayuni3_uni.msmc.final.txt > combined_mayuni3_msmc.final.txt
