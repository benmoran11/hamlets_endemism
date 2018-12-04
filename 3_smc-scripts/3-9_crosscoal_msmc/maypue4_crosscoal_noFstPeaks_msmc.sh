#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFmaypue4                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_maypue4.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_maypue4.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/maypue

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maypue4_may_noFstPeaks.msmc -I 0,1,18,19 \
    $INDIR/LG01.maypue.multihetsep.txt \
    $INDIR/LG02.maypue.multihetsep.txt \
    $INDIR/LG03.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maypue.multihetsep.txt \
    $INDIR/LG06.maypue.multihetsep.txt \
    $INDIR/LG07.maypue.multihetsep.txt \
    $INDIR/LG08.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maypue.multihetsep.txt \
    $INDIR/LG12.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maypue.multihetsep.txt \
    $INDIR/LG14.maypue.multihetsep.txt \
    $INDIR/LG15.maypue.multihetsep.txt \
    $INDIR/LG16.maypue.multihetsep.txt \
    $INDIR/LG17.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maypue.multihetsep.txt \
    $INDIR/LG19.maypue.multihetsep.txt \
    $INDIR/LG20.maypue.multihetsep.txt \
    $INDIR/LG21.maypue.multihetsep.txt \
    $INDIR/LG22.maypue.multihetsep.txt \
    $INDIR/LG23.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maypue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maypue4_pue_noFstPeaks.msmc -I 20,21,36,37 \
    $INDIR/LG01.maypue.multihetsep.txt \
    $INDIR/LG02.maypue.multihetsep.txt \
    $INDIR/LG03.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maypue.multihetsep.txt \
    $INDIR/LG06.maypue.multihetsep.txt \
    $INDIR/LG07.maypue.multihetsep.txt \
    $INDIR/LG08.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maypue.multihetsep.txt \
    $INDIR/LG12.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maypue.multihetsep.txt \
    $INDIR/LG14.maypue.multihetsep.txt \
    $INDIR/LG15.maypue.multihetsep.txt \
    $INDIR/LG16.maypue.multihetsep.txt \
    $INDIR/LG17.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maypue.multihetsep.txt \
    $INDIR/LG19.maypue.multihetsep.txt \
    $INDIR/LG20.maypue.multihetsep.txt \
    $INDIR/LG21.maypue.multihetsep.txt \
    $INDIR/LG22.maypue.multihetsep.txt \
    $INDIR/LG23.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maypue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/maypue4_cross_noFstPeaks.msmc -I 0,1,18,19,20,21,36,37 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.maypue.multihetsep.txt \
    $INDIR/LG02.maypue.multihetsep.txt \
    $INDIR/LG03.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.maypue.multihetsep.txt \
    $INDIR/LG06.maypue.multihetsep.txt \
    $INDIR/LG07.maypue.multihetsep.txt \
    $INDIR/LG08.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.maypue.multihetsep.txt \
    $INDIR/LG12.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.maypue.multihetsep.txt \
    $INDIR/LG14.maypue.multihetsep.txt \
    $INDIR/LG15.maypue.multihetsep.txt \
    $INDIR/LG16.maypue.multihetsep.txt \
    $INDIR/LG17.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.maypue.multihetsep.txt \
    $INDIR/LG19.maypue.multihetsep.txt \
    $INDIR/LG20.maypue.multihetsep.txt \
    $INDIR/LG21.maypue.multihetsep.txt \
    $INDIR/LG22.maypue.multihetsep.txt \
    $INDIR/LG23.maypue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.maypue.multihetsep.txt
echo done

combineCrossCoal.py maypue4_cross_noFstPeaks.msmc.final.txt maypue4_may_noFstPeaks.msmc.final.txt maypue4_pue_noFstPeaks.msmc.final.txt > combined_maypue4_noFstPeaks_msmc.final.txt
