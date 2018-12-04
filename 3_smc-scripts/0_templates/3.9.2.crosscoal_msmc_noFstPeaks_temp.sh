#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=24           # Anzahl benoetigter CPUs pro Knoten
#PBS -N nFXXrunXX                    # Name des Batch-Jobs
#PBS -q clmedium                # [(h/GB/nodes):clexpress(2/192/2),clmedium(48/192/120),cllong(100/192/50),clbigmem(200/384/8),clfo2(200/128/18),feque(1/750/1)]
#PBS -o 3.9.2.crosscoal_msmc_noFstPeaks_XXrunXX.stdout
#PBS -e 3.9.2.crosscoal_msmc_noFstPeaks_XXrunXX.stderr
module load java1.8.0
module load python3.6.2

OUTDIR=$WORK/3_output/3.9_crosscoal_msmc/
INDIR=$WORK/3_output/3.8_crosscoal_multiHetSep/XXspec1XXXXspec2XX

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/XXrunXX_XXspec1XX_noFstPeaks.msmc -I XXhap1XX,XXhap2XX,XXhap3XX,XXhap4XX \
    $INDIR/LG01.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG02.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG03.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG06.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG07.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG08.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG12.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG14.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG15.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG16.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG17.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG19.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG20.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG21.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG22.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG23.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.XXspec1XXXXspec2XX.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/XXrunXX_XXspec2XX_noFstPeaks.msmc -I XXhap5XX,XXhap6XX,XXhap7XX,XXhap8XX \
    $INDIR/LG01.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG02.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG03.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG06.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG07.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG08.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG12.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG14.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG15.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG16.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG17.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG19.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG20.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG21.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG22.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG23.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.XXspec1XXXXspec2XX.multihetsep.txt
echo done

msmc_2.0.0_linux64bit -m 0.00255863 -t 24 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/XXrunXX_cross_noFstPeaks.msmc -I XXhap1XX,XXhap2XX,XXhap3XX,XXhap4XX,XXhap5XX,XXhap6XX,XXhap7XX,XXhap8XX -P 0,0,0,0,1,1,1,1 \
    $INDIR/LG01.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG02.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG03.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG04.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG06.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG07.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG08.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG09.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG10.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG11.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG12.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG13.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG14.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG15.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG16.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG17.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG18.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG19.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG20.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG21.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG22.XXspec1XXXXspec2XX.multihetsep.txt \
    $INDIR/LG23.XXspec1XXXXspec2XX.noFstPeaks.multihetsep.txt \
    $INDIR/LG24.XXspec1XXXXspec2XX.multihetsep.txt
echo done

combineCrossCoal.py XXrunXX_cross_noFstPeaks.msmc.final.txt XXrunXX_XXspec1XX_noFstPeaks.msmc.final.txt XXrunXX_XXspec2XX_noFstPeaks.msmc.final.txt > combined_XXrunXX_noFstPeaks_msmc.final.txt
