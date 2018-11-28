#!/bin/bash
# starter script to rewrite and submit the 1.11.shapeit_temp.sh script once per LG
clear
cd $WORK/1_genotyping-scripts/

for k in {01..24}; do
    i="LG"$k;

        echo "   sample=$i";
        echo "----------------";

        sed "s/XXnameXX/$i/" $WORK/1_genotyping-scripts/0_templates/1.11.shapeit_temp.sh > $WORK/1_genotyping-scripts/1-11_shapeit/1.11.shapeit_$i.sh;

	echo "cd $WORK/1_output/1.11_phased_variants" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "shapeit -assemble \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          --input-vcf ../1.9_split_variants/4_bi-allelic_snps.$i.vcf.gz \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          --input-pir ../1.10_PIRs/PIRsList-$i.txt \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          --thread 8 \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          -O 5_phased-$i \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          --seed 15 \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "          --output-log $WORK/1_genotyping-scripts/1-11_shapeit/"$i"_shapeit.phased.log" >> 1-11_shapeit/1.11.shapeit_$i.sh;
	echo "echo '---- shapeit done ----' " >> 1-11_shapeit/1.11.shapeit_$i.sh;

	echo "shapeit -convert \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  --input-haps 5_phased-$i \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  --output-vcf 5_onlyphased-$i.vcf \\" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  --output-log $WORK/1_genotyping-scripts/1-11_shapeit/"$i"_convert.phased.log" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "bcftools view -O z  5_onlyphased-$i.vcf > 5_onlyphased-$i.vcf.gz" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        #echo "bcftools view -O z ../1.9_split_variants/4_bi-allelic_snps.$i.vcf > ../1.9_split_variants/4_bi-allelic_snps.$i.vcf.gz" >> 1-11_shapeit/1.11.shapeit_$i.sh; 
        echo "bcftools index --tbi -f 5_onlyphased-$i.vcf.gz" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "bcftools index --tbi -f ../1.9_split_variants/4_bi-allelic_snps.$i.vcf.gz" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "bcftools merge --force-samples ../1.9_split_variants/4_bi-allelic_snps.$i.vcf.gz 5_onlyphased-$i.vcf.gz | awk '" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  BEGIN {OFS=\"\t\"}" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  \$0 ~ /^##/ {print}" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  \$0 ~ /^#CHROM/ {for(i=1; i<=60; i++) printf \"%s\",\$i ((i+51)==NF?ORS:OFS) }" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  \$0 !~ /^#/ {" >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "          if(substr(\$61, 1, 3) != \"./.\")"  >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "                  for(i=10; i<=60; i++) \$i = substr(\$(i+51),1,3) substr(\$i, 4)"  >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "                  for(i=1; i<=60; i++) printf \"%s\",\$i ((i+51)==NF?ORS:OFS)"  >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "  }' | bcftools view -O z > 5_phased-$i.vcf.gz"  >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "bcftools index --tbi -f 5_phased-$i.vcf.gz"  >> 1-11_shapeit/1.11.shapeit_$i.sh;
        echo "echo '---- conversion done ----'"  >> 1-11_shapeit/1.11.shapeit_$i.sh;

	cd 1-11_shapeit
	qsub 1.11.shapeit_$i.sh;
    cd ..
done
