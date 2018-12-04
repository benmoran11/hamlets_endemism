#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFpueuni3                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_pueuni3.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_pueuni3.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/pueuni

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/pueuni3_pue_noFstPeaks.msmc -I 2,3,22,23 \
    $INDIR/LG01.pueuni.multihetsep.txt \
    $INDIR/LG02.pueuni.multihetsep.txt \
    $INDIR/LG03.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.pueuni.multihetsep.txt \
    $INDIR/LG06.pueuni.multihetsep.txt \
    $INDIR/LG07.pueuni.multihetsep.txt \
    $INDIR/LG08.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.pueuni.multihetsep.txt \
    $INDIR/LG12.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.pueuni.multihetsep.txt \
    $INDIR/LG14.pueuni.multihetsep.txt \
    $INDIR/LG15.pueuni.multihetsep.txt \
    $INDIR/LG16.pueuni.multihetsep.txt \
    $INDIR/LG17.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.pueuni.multihetsep.txt \
    $INDIR/LG19.pueuni.multihetsep.txt \
    $INDIR/LG20.pueuni.multihetsep.txt \
    $INDIR/LG21.pueuni.multihetsep.txt \
    $INDIR/LG22.pueuni.multihetsep.txt \
    $INDIR/LG23.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.pueuni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/pueuni3_uni_noFstPeaks.msmc -I 30,31,42,43 \
    $INDIR/LG01.pueuni.multihetsep.txt \
    $INDIR/LG02.pueuni.multihetsep.txt \
    $INDIR/LG03.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.pueuni.multihetsep.txt \
    $INDIR/LG06.pueuni.multihetsep.txt \
    $INDIR/LG07.pueuni.multihetsep.txt \
    $INDIR/LG08.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.pueuni.multihetsep.txt \
    $INDIR/LG12.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.pueuni.multihetsep.txt \
    $INDIR/LG14.pueuni.multihetsep.txt \
    $INDIR/LG15.pueuni.multihetsep.txt \
    $INDIR/LG16.pueuni.multihetsep.txt \
    $INDIR/LG17.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.pueuni.multihetsep.txt \
    $INDIR/LG19.pueuni.multihetsep.txt \
    $INDIR/LG20.pueuni.multihetsep.txt \
    $INDIR/LG21.pueuni.multihetsep.txt \
    $INDIR/LG22.pueuni.multihetsep.txt \
    $INDIR/LG23.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.pueuni.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/pueuni3_cross_noFstPeaks.msmc -I 2,3,22,23,30,31,42,43 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.pueuni.multihetsep.txt \
    $INDIR/LG02.pueuni.multihetsep.txt \
    $INDIR/LG03.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.pueuni.multihetsep.txt \
    $INDIR/LG06.pueuni.multihetsep.txt \
    $INDIR/LG07.pueuni.multihetsep.txt \
    $INDIR/LG08.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.pueuni.multihetsep.txt \
    $INDIR/LG12.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.pueuni.multihetsep.txt \
    $INDIR/LG14.pueuni.multihetsep.txt \
    $INDIR/LG15.pueuni.multihetsep.txt \
    $INDIR/LG16.pueuni.multihetsep.txt \
    $INDIR/LG17.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.pueuni.multihetsep.txt \
    $INDIR/LG19.pueuni.multihetsep.txt \
    $INDIR/LG20.pueuni.multihetsep.txt \
    $INDIR/LG21.pueuni.multihetsep.txt \
    $INDIR/LG22.pueuni.multihetsep.txt \
    $INDIR/LG23.pueuni.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.pueuni.multihetsep.txt
echo done

combineCrossCoal.py pueuni3_cross_noFstPeaks.msmc.final.txt pueuni3_pue_noFstPeaks.msmc.final.txt pueuni3_uni_noFstPeaks.msmc.final.txt > combined_pueuni3_noFstPeaks_msmc.final.txt
