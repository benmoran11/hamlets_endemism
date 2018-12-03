#PBS -l elapstim_req=45:00:00   # Walltime (Verweilzeit,hier 2 Stdunden)
#PBS -l memsz_job=51gb          # Hauptspeicherbedarf
#PBS -b 1                       # Anzahl der Knoten (hier 2)
#PBS -l cpunum_job=10           	# Anzahl benoetigter CPUs pro Knoten
#PBS -N may_LDNe           	      	# Name des Batch-Jobs
#PBS -q clmedium               	# [(h/GB/nodes):clexpress(2/182/2),clmedium(48/128/78),cllong(100/128/30),clbigmem(100/258/2),clfocean(100/128/4)]
#PBS -o 4.5.maybel-LDNe.stdout
#PBS -e 4.5.maybel-LDNe.stderr
module load java1.8.0

cd $WORK/4_LDNe-scripts

for f in $(ls $WORK/4_output/4.2_split_SNPs/*.vcf); do
    SAMP=$(basename $WORK/4_output/4.2_split_SNPs/$f .vcf);
    sed 's/XXSPLIT_IDXX/'$SAMP'/g' ./0_templates/info_temp > ./4-5_LDNe/info_$SAMP;
    sed 's/XXSPLIT_IDXX/'$SAMP'/g' ./0_templates/option_temp > ./4-5_LDNe/option_$SAMP;
    Ne2-1L i:4-5_LDNe/info_$SAMP o:4-5_LDNe/option_$SAMP
 done
