#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFmaynig5                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_maynig5.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_maynig5.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/maynig

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maynig5_may_noFstPeaks.msmc -I 6,7,14,15 \
    $INDIR/LG01.maynig.multihetsep.txt \
    $INDIR/LG02.maynig.multihetsep.txt \
    $INDIR/LG03.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maynig.multihetsep.txt \
    $INDIR/LG06.maynig.multihetsep.txt \
    $INDIR/LG07.maynig.multihetsep.txt \
    $INDIR/LG08.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maynig.multihetsep.txt \
    $INDIR/LG12.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maynig.multihetsep.txt \
    $INDIR/LG14.maynig.multihetsep.txt \
    $INDIR/LG15.maynig.multihetsep.txt \
    $INDIR/LG16.maynig.multihetsep.txt \
    $INDIR/LG17.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maynig.multihetsep.txt \
    $INDIR/LG19.maynig.multihetsep.txt \
    $INDIR/LG20.maynig.multihetsep.txt \
    $INDIR/LG21.maynig.multihetsep.txt \
    $INDIR/LG22.maynig.multihetsep.txt \
    $INDIR/LG23.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maynig.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maynig5_nig_noFstPeaks.msmc -I 28,29,32,33 \
    $INDIR/LG01.maynig.multihetsep.txt \
    $INDIR/LG02.maynig.multihetsep.txt \
    $INDIR/LG03.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maynig.multihetsep.txt \
    $INDIR/LG06.maynig.multihetsep.txt \
    $INDIR/LG07.maynig.multihetsep.txt \
    $INDIR/LG08.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maynig.multihetsep.txt \
    $INDIR/LG12.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maynig.multihetsep.txt \
    $INDIR/LG14.maynig.multihetsep.txt \
    $INDIR/LG15.maynig.multihetsep.txt \
    $INDIR/LG16.maynig.multihetsep.txt \
    $INDIR/LG17.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maynig.multihetsep.txt \
    $INDIR/LG19.maynig.multihetsep.txt \
    $INDIR/LG20.maynig.multihetsep.txt \
    $INDIR/LG21.maynig.multihetsep.txt \
    $INDIR/LG22.maynig.multihetsep.txt \
    $INDIR/LG23.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maynig.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maynig5_cross_noFstPeaks.msmc -I 6,7,14,15,28,29,32,33 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.maynig.multihetsep.txt \
    $INDIR/LG02.maynig.multihetsep.txt \
    $INDIR/LG03.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maynig.multihetsep.txt \
    $INDIR/LG06.maynig.multihetsep.txt \
    $INDIR/LG07.maynig.multihetsep.txt \
    $INDIR/LG08.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maynig.multihetsep.txt \
    $INDIR/LG12.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maynig.multihetsep.txt \
    $INDIR/LG14.maynig.multihetsep.txt \
    $INDIR/LG15.maynig.multihetsep.txt \
    $INDIR/LG16.maynig.multihetsep.txt \
    $INDIR/LG17.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maynig.multihetsep.txt \
    $INDIR/LG19.maynig.multihetsep.txt \
    $INDIR/LG20.maynig.multihetsep.txt \
    $INDIR/LG21.maynig.multihetsep.txt \
    $INDIR/LG22.maynig.multihetsep.txt \
    $INDIR/LG23.maynig.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maynig.multihetsep.txt
echo done

combineCrossCoal.py maynig5_cross_noFstPeaks.msmc.final.txt maynig5_may_noFstPeaks.msmc.final.txt maynig5_nig_noFstPeaks.msmc.final.txt > combined_maynig5_noFstPeaks_msmc.final.txt
