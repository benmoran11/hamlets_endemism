#PBS -l elapstim_req=65:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=51gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=10           	# Anzahl benoetigter CPUs pro Knoten
#PBS -N XXnameXX           	      	# Name des Batch-Jobs
#PBS -q cllong               	# [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 1.6.varCall_XXnameXX.stdout
#PBS -e 1.6.varCall_XXnameXX.stderr

### NOTE: This step introduces new read files to the pipeline, which were pre-stored in $WORK/1_output/1.4_dedup/.
###       These are BAM files for H. puella, nigricans, and unicolor from Belize, which were created in Hench et al. 2018.
###       See documentation for this publication for scripts too recreate these files

module load java1.8.0

