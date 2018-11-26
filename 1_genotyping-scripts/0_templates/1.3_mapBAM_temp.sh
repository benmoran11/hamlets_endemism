#PBS -l elapstim_req=16:00:00
#PBS -l memsz_job=51gb
#PBS -b 1
#PBS -l cpunum_job=8
#PBS -N XXnameXX
#PBS -q clmedium
#PBS -o 1.3.mapBAM_XXnameXX.stdout
#PBS -e 1.3.mapBAM_XXnameXX.stderr

module load java1.8.0

