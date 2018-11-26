#PBS -l elapstim_req=14:00:00
#PBS -l memsz_job=31gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N XXnameXX
#PBS -q clmedium
#PBS -o 1.4.markDuplicates_XXnameXX.stdout
#PBS -e 1.4.markDuplicates_XXnameXX.stderr
module load java1.8.0

