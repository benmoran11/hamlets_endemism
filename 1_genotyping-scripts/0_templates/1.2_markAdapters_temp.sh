#PBS -l elapstim_req=12:00:00
#PBS -l memsz_job=20gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N XXnameXX
#PBS -q clmedium
#PBS -o 1.2.markAdapters_XXnameXX.stdout
#PBS -e 1.2.markAdapters_XXnameXX.stderr

module load java1.8.0
