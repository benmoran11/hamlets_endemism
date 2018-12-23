#!/bin/bash
# Convert the biallelic SNP dataset to PLINK format with rare variants (MAF <0.05) removed, then identify runs of homozygosity longer than 150 kb 

vcftools --gzvcf $WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf --chrom-map $WORK/0_data/0_resources/chr_map_plink.txt --maf 0.05 --plink-tped --out $WORK/2_output/biallelic_maf5pct_filteredSNPs

plink --noweb --tped $WORK/2_output/biallelic_maf5pct_filteredSNPs.tped --tfam $WORK/2_output/biallelic_maf5pct_filteredSNPs.tfam --homozyg-kb 150 --homozyg-window-het 1 --out $WORK/2_output/biallelic_maf5_150kb

mv biallelic_maf5_150kb.hom biallelic_maf5_150kb.txt
