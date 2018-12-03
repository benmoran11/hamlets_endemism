#!/bin/bash
# Calculate individual inbreeding coefficients & expected/observed number of homozygous sites using vcftools

vcftools --vcf $WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf --het --out $WORK/2_output/bi-allelic_snps

echo done
