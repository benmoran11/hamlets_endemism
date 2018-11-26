#PBS -l elapstim_req=01:40:00
#PBS -l memsz_job=45gb
#PBS -b 1
#PBS -l cpunum_job=4
#PBS -N XXnameXX
#PBS -q clexpress
#PBS -o 1.5.bam_bai_XXnameXX.stdout
#PBS -e 1.5.bam_bai_XXnameXX.stderr

module load java1.8.0

