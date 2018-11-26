#PBS -l elapstim_req=24:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=16gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1           	# Anzahl benoetigter CPUs pro Knoten
#PBS -N fastqc           	      	# Name des Batch-Jobs
#PBS -q clmedium               	# [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 1.0.fastqc-raw.stdout
#PBS -e 1.0.fastqc-raw.stderr

cd $WORK/1-output

fastqc -outdir=00_fQC/ \
    PL17_89maybel1.bam \
    PL17_95maybel1.bam \
    PL17_101maybel1.bam \
    PL17_119maybel8.bam \
    PL17_121maybel8.bam \
    PL17_120maybel8.bam \
    PL17_122maybel8.bam \
    PL17_123maybel8.bam \
    PL17_124maybel8.bam \
    PL17_126maybel8.bam \
    PL17_142gemflo2.bam \
    PL17_144gemflo2.bam \
    PL17_145gemflo2.bam \
    PL17_148gemflo2.bam \
    PL17_153gemflo2.bam
echo done
