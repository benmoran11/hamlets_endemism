#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFgempue2                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_gempue2.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_gempue2.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/gempue

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gempue2_gem_noFstPeaks.msmc -I 0,1,8,9 \
    $INDIR/LG01.gempue.multihetsep.txt \
    $INDIR/LG02.gempue.multihetsep.txt \
    $INDIR/LG03.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gempue.multihetsep.txt \
    $INDIR/LG06.gempue.multihetsep.txt \
    $INDIR/LG07.gempue.multihetsep.txt \
    $INDIR/LG08.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gempue.multihetsep.txt \
    $INDIR/LG12.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gempue.multihetsep.txt \
    $INDIR/LG14.gempue.multihetsep.txt \
    $INDIR/LG15.gempue.multihetsep.txt \
    $INDIR/LG16.gempue.multihetsep.txt \
    $INDIR/LG17.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gempue.multihetsep.txt \
    $INDIR/LG19.gempue.multihetsep.txt \
    $INDIR/LG20.gempue.multihetsep.txt \
    $INDIR/LG21.gempue.multihetsep.txt \
    $INDIR/LG22.gempue.multihetsep.txt \
    $INDIR/LG23.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gempue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gempue2_pue_noFstPeaks.msmc -I 18,19,22,23 \
    $INDIR/LG01.gempue.multihetsep.txt \
    $INDIR/LG02.gempue.multihetsep.txt \
    $INDIR/LG03.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gempue.multihetsep.txt \
    $INDIR/LG06.gempue.multihetsep.txt \
    $INDIR/LG07.gempue.multihetsep.txt \
    $INDIR/LG08.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gempue.multihetsep.txt \
    $INDIR/LG12.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gempue.multihetsep.txt \
    $INDIR/LG14.gempue.multihetsep.txt \
    $INDIR/LG15.gempue.multihetsep.txt \
    $INDIR/LG16.gempue.multihetsep.txt \
    $INDIR/LG17.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gempue.multihetsep.txt \
    $INDIR/LG19.gempue.multihetsep.txt \
    $INDIR/LG20.gempue.multihetsep.txt \
    $INDIR/LG21.gempue.multihetsep.txt \
    $INDIR/LG22.gempue.multihetsep.txt \
    $INDIR/LG23.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gempue.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/gempue2_cross_noFstPeaks.msmc -I 0,1,8,9,18,19,22,23 -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.gempue.multihetsep.txt \
    $INDIR/LG02.gempue.multihetsep.txt \
    $INDIR/LG03.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.gempue.multihetsep.txt \
    $INDIR/LG06.gempue.multihetsep.txt \
    $INDIR/LG07.gempue.multihetsep.txt \
    $INDIR/LG08.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.gempue.multihetsep.txt \
    $INDIR/LG12.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.gempue.multihetsep.txt \
    $INDIR/LG14.gempue.multihetsep.txt \
    $INDIR/LG15.gempue.multihetsep.txt \
    $INDIR/LG16.gempue.multihetsep.txt \
    $INDIR/LG17.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.gempue.multihetsep.txt \
    $INDIR/LG19.gempue.multihetsep.txt \
    $INDIR/LG20.gempue.multihetsep.txt \
    $INDIR/LG21.gempue.multihetsep.txt \
    $INDIR/LG22.gempue.multihetsep.txt \
    $INDIR/LG23.gempue.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.gempue.multihetsep.txt
echo done

combineCrossCoal.py gempue2_cross_noFstPeaks.msmc.final.txt gempue2_gem_noFstPeaks.msmc.final.txt gempue2_pue_noFstPeaks.msmc.final.txt > combined_gempue2_noFstPeaks_msmc.final.txt
