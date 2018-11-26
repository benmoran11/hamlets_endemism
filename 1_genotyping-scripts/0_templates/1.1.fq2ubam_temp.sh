#PBS -l elapstim_req=04:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=16gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=1           	# Anzahl benoetigter CPUs pro Knoten
#PBS -N XXnameXX           	      	# Name des Batch-Jobs
#PBS -q clmedium               	# [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 1.1.fq2ubam_XXnameXX.stdout
#PBS -e 1.1.fq2ubam_XXnameXX.stderr

module load java1.8.0

