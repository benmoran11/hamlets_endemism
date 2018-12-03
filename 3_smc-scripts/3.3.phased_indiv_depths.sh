#!/bin/bash

# calculate mean coverage depth for each individual in the phased bi-allelic SNP dataset. Needed for MSMC input file generation

vcftools --gzvcf $WORK/1_output/1.11_phased_variants/5_phased.vcf.gz --depth --out $WORK/3_output/3.3_phased_indiv_depths/phased_snps
