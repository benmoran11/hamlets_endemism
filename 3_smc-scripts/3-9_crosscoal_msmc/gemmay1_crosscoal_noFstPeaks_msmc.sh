#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFgemmay1                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_gemmay1.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_gemmay1.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/gemmay

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemmay1_gem_noFstPeaks.msmc -I 2,3,4,5 \
    $INDIR/LG01.gemmay.multihetsep.txt \
    $INDIR/LG02.gemmay.multihetsep.txt \
    $INDIR/LG03.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gemmay.multihetsep.txt \
    $INDIR/LG06.gemmay.multihetsep.txt \
    $INDIR/LG07.gemmay.multihetsep.txt \
    $INDIR/LG08.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gemmay.multihetsep.txt \
    $INDIR/LG12.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gemmay.multihetsep.txt \
    $INDIR/LG14.gemmay.multihetsep.txt \
    $INDIR/LG15.gemmay.multihetsep.txt \
    $INDIR/LG16.gemmay.multihetsep.txt \
    $INDIR/LG17.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gemmay.multihetsep.txt \
    $INDIR/LG19.gemmay.multihetsep.txt \
    $INDIR/LG20.gemmay.multihetsep.txt \
    $INDIR/LG21.gemmay.multihetsep.txt \
    $INDIR/LG22.gemmay.multihetsep.txt \
    $INDIR/LG23.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gemmay.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemmay1_may_noFstPeaks.msmc -I 14,15,22,23 \
    $INDIR/LG01.gemmay.multihetsep.txt \
    $INDIR/LG02.gemmay.multihetsep.txt \
    $INDIR/LG03.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gemmay.multihetsep.txt \
    $INDIR/LG06.gemmay.multihetsep.txt \
    $INDIR/LG07.gemmay.multihetsep.txt \
    $INDIR/LG08.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gemmay.multihetsep.txt \
    $INDIR/LG12.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gemmay.multihetsep.txt \
    $INDIR/LG14.gemmay.multihetsep.txt \
    $INDIR/LG15.gemmay.multihetsep.txt \
    $INDIR/LG16.gemmay.multihetsep.txt \
    $INDIR/LG17.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gemmay.multihetsep.txt \
    $INDIR/LG19.gemmay.multihetsep.txt \
    $INDIR/LG20.gemmay.multihetsep.txt \
    $INDIR/LG21.gemmay.multihetsep.txt \
    $INDIR/LG22.gemmay.multihetsep.txt \
    $INDIR/LG23.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gemmay.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gemmay1_cross_noFstPeaks.msmc -I 2,3,4,5,14,15,22,23 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.gemmay.multihetsep.txt \
    $INDIR/LG02.gemmay.multihetsep.txt \
    $INDIR/LG03.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gemmay.multihetsep.txt \
    $INDIR/LG06.gemmay.multihetsep.txt \
    $INDIR/LG07.gemmay.multihetsep.txt \
    $INDIR/LG08.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gemmay.multihetsep.txt \
    $INDIR/LG12.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gemmay.multihetsep.txt \
    $INDIR/LG14.gemmay.multihetsep.txt \
    $INDIR/LG15.gemmay.multihetsep.txt \
    $INDIR/LG16.gemmay.multihetsep.txt \
    $INDIR/LG17.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gemmay.multihetsep.txt \
    $INDIR/LG19.gemmay.multihetsep.txt \
    $INDIR/LG20.gemmay.multihetsep.txt \
    $INDIR/LG21.gemmay.multihetsep.txt \
    $INDIR/LG22.gemmay.multihetsep.txt \
    $INDIR/LG23.gemmay.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gemmay.multihetsep.txt
echo done

combineCrossCoal.py gemmay1_cross_noFstPeaks.msmc.final.txt gemmay1_gem_noFstPeaks.msmc.final.txt gemmay1_may_noFstPeaks.msmc.final.txt > combined_gemmay1_noFstPeaks_msmc.final.txt
