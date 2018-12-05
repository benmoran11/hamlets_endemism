#PBS -l elapstim_req=01:00:00
#PBS -l memsz_job=16gb
#PBS -b 1
#PBS -l cpunum_job=1
#PBS -N BWAindex
#PBS -q clexpress
#PBS -o 1.0.0.BWAindex.stdout
#PBS -e 1.0.0.BWAindex.stderr

cd $WORK/0_data/0_resources/

bwa index HP_genome_unmasked_01.fa
