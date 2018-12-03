#PBS -l elapstim_req=100:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=192gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=8            # Anzahl benoetigter CPUs pro Knoten
#PBS -N XXrunXX                    # Name des Batch-Jobs
#PBS -q cllong                # [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 3.7.2.msmc_noFstPeaks_XXrunXX.stdout
#PBS -e 3.7.2.msmc_noFstPeaks_XXrunXX.stderr
module load java1.8.0
module load python3.6.2


OUTDIR=$WORK/3_output/3.7_msmc
INDIR=$WORK/3_output/3.6_multiHetSep/XXrunXX

msmc_2.0.0_linux64bit -m 0.00254966 -t 8 -p 1*2+25*1+1*2+1*3 -o $OUTDIR/XXrunXX.noFstPeaks.msmc2 -I 0,1,2,3,4,5,6,7 \
    $INDIR/LG01.XXrunXX.multihetsep.txt \
    $INDIR/LG02.XXrunXX.multihetsep.txt \
    $INDIR/LG03.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG04.XXrunXX.noFstPeaks.multihetsep.txt \
    $INDIR/LG05.XXrunXX.multihetsep.txt \
    $INDIR/LG06.XXrunXX.multihetsep.txt \
    $INDIR/LG07.XXrunXX.multihetsep.txt \
    $INDIR/LG08.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG09.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG10.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG11.XXrunXX.multihetsep.txt \
    $INDIR/LG12.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG13.XXrunXX.multihetsep.txt \
    $INDIR/LG14.XXrunXX.multihetsep.txt \
    $INDIR/LG15.XXrunXX.multihetsep.txt \
    $INDIR/LG16.XXrunXX.multihetsep.txt \
    $INDIR/LG17.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG18.XXrunXX.multihetsep.txt \
    $INDIR/LG19.XXrunXX.multihetsep.txt \
    $INDIR/LG20.XXrunXX.multihetsep.txt \
    $INDIR/LG21.XXrunXX.multihetsep.txt \
    $INDIR/LG22.XXrunXX.multihetsep.txt \
    $INDIR/LG23.XXrunXX.NoFstPeaks.multihetsep.txt \
    $INDIR/LG24.XXrunXX.multihetsep.txt
echo done
