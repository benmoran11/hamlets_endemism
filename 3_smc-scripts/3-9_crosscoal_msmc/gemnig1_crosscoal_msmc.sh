#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N gemnig1                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.1.crosscoal_msmc_gemnig1.stdout
#PBS -e 3.9.1.crosscoal_msmc_gemnig1.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/gemnig

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemnig1_gem.msmc -I 2,3,4,5 \
    $INDIR/LG01.gemnig.multihetsep.txt \
    $INDIR/LG02.gemnig.multihetsep.txt \
    $INDIR/LG03.gemnig.multihetsep.txt \
    $INDIR/LG04.gemnig.multihetsep.txt \
    $INDIR/LG05.gemnig.multihetsep.txt \
    $INDIR/LG06.gemnig.multihetsep.txt \
    $INDIR/LG07.gemnig.multihetsep.txt \
    $INDIR/LG08.gemnig.multihetsep.txt \
    $INDIR/LG09.gemnig.multihetsep.txt \
    $INDIR/LG10.gemnig.multihetsep.txt \
    $INDIR/LG11.gemnig.multihetsep.txt \
    $INDIR/LG12.gemnig.multihetsep.txt \
    $INDIR/LG13.gemnig.multihetsep.txt \
    $INDIR/LG14.gemnig.multihetsep.txt \
    $INDIR/LG15.gemnig.multihetsep.txt \
    $INDIR/LG16.gemnig.multihetsep.txt \
    $INDIR/LG17.gemnig.multihetsep.txt \
    $INDIR/LG18.gemnig.multihetsep.txt \
    $INDIR/LG19.gemnig.multihetsep.txt \
    $INDIR/LG20.gemnig.multihetsep.txt \
    $INDIR/LG21.gemnig.multihetsep.txt \
    $INDIR/LG22.gemnig.multihetsep.txt \
    $INDIR/LG23.gemnig.multihetsep.txt \
    $INDIR/LG24.gemnig.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemnig1_nig.msmc -I 24,25,28,29 \
    $INDIR/LG01.gemnig.multihetsep.txt \
    $INDIR/LG02.gemnig.multihetsep.txt \
    $INDIR/LG03.gemnig.multihetsep.txt \
    $INDIR/LG04.gemnig.multihetsep.txt \
    $INDIR/LG05.gemnig.multihetsep.txt \
    $INDIR/LG06.gemnig.multihetsep.txt \
    $INDIR/LG07.gemnig.multihetsep.txt \
    $INDIR/LG08.gemnig.multihetsep.txt \
    $INDIR/LG09.gemnig.multihetsep.txt \
    $INDIR/LG10.gemnig.multihetsep.txt \
    $INDIR/LG11.gemnig.multihetsep.txt \
    $INDIR/LG12.gemnig.multihetsep.txt \
    $INDIR/LG13.gemnig.multihetsep.txt \
    $INDIR/LG14.gemnig.multihetsep.txt \
    $INDIR/LG15.gemnig.multihetsep.txt \
    $INDIR/LG16.gemnig.multihetsep.txt \
    $INDIR/LG17.gemnig.multihetsep.txt \
    $INDIR/LG18.gemnig.multihetsep.txt \
    $INDIR/LG19.gemnig.multihetsep.txt \
    $INDIR/LG20.gemnig.multihetsep.txt \
    $INDIR/LG21.gemnig.multihetsep.txt \
    $INDIR/LG22.gemnig.multihetsep.txt \
    $INDIR/LG23.gemnig.multihetsep.txt \
    $INDIR/LG24.gemnig.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemnig1_cross.msmc -I 2,3,4,5,24,25,28,29 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.gemnig.multihetsep.txt \
    $INDIR/LG02.gemnig.multihetsep.txt \
    $INDIR/LG03.gemnig.multihetsep.txt \
    $INDIR/LG04.gemnig.multihetsep.txt \
    $INDIR/LG05.gemnig.multihetsep.txt \
    $INDIR/LG06.gemnig.multihetsep.txt \
    $INDIR/LG07.gemnig.multihetsep.txt \
    $INDIR/LG08.gemnig.multihetsep.txt \
    $INDIR/LG09.gemnig.multihetsep.txt \
    $INDIR/LG10.gemnig.multihetsep.txt \
    $INDIR/LG11.gemnig.multihetsep.txt \
    $INDIR/LG12.gemnig.multihetsep.txt \
    $INDIR/LG13.gemnig.multihetsep.txt \
    $INDIR/LG14.gemnig.multihetsep.txt \
    $INDIR/LG15.gemnig.multihetsep.txt \
    $INDIR/LG16.gemnig.multihetsep.txt \
    $INDIR/LG17.gemnig.multihetsep.txt \
    $INDIR/LG18.gemnig.multihetsep.txt \
    $INDIR/LG19.gemnig.multihetsep.txt \
    $INDIR/LG20.gemnig.multihetsep.txt \
    $INDIR/LG21.gemnig.multihetsep.txt \
    $INDIR/LG22.gemnig.multihetsep.txt \
    $INDIR/LG23.gemnig.multihetsep.txt \
    $INDIR/LG24.gemnig.multihetsep.txt
echo done

combineCrossCoal.py gemnig1_cross.msmc.final.txt gemnig1_gem.msmc.final.txt gemnig1_nig.msmc.final.txt > combined_gemnig1_msmc.final.txt
