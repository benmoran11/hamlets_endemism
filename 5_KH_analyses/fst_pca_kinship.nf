#!/usr/bin/env nextflow
/* This pipelie includes the anlysis run on the SNPs
   data sheet (fst, pca, kinship).*/

/* open the pipeline with a list of all the species
  comparisons possible within the dataset  */
params.index = 'comparisons.txt'

/* define the genotype file */
vcf_base = Channel
     .fromPath( "$WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf" )
     .into{ vcf_fst; vcf_pca; vcf_pca_bel; vcf_pca_noLD; vcf_pca_bel_noLD; vcf_kinship }

 /* split the comparisons spread sheet by row and feed it into a channel */
 Channel
     .fromPath(params.index)
     .splitCsv(header:true, sep:"\t")
     .map{ row -> [ pop1:row.pop1, pop2:row.pop2] }
     .set { comparisons_ch }

/* bind the genotype file to the comparisons chanel */
fst_prep  = comparisons_ch.combine( vcf_fst )

 /* for every species comparison compute fst along
    sliding windows (10kb & 50kb) */
 process fst_run {
     label 'L_32g1h_fst_run'
     publishDir "out/fst/", mode: 'symlink'

     input:
     set val( x ), file( vcf ) from fst_prep

     output:
     file( "${x.pop1}-${x.pop2}.50k.windowed.weir.fst" ) into fst_50k_output
     file( "${x.pop1}-${x.pop2}.10k.windowed.weir.fst" ) into fst_10k_output
     file( "${x.pop1}-${x.pop2}.log" ) into fst_logs

     script:
     """
     vcftools --gzvcf ${vcf} \
       --weir-fst-pop \$BASE_DIR/pops/pop.${x.pop1}.txt \
       --weir-fst-pop \$BASE_DIR/pops/pop.${x.pop2}.txt \
       --fst-window-step 5000 \
       --fst-window-size 50000 \
       --out ${x.pop1}-${x.pop2}.50k 2> ${x.pop1}-${x.pop2}.log

     vcftools --gzvcf ${vcf} \
       --weir-fst-pop \$BASE_DIR/pops/pop.${x.pop1}.txt \
       --weir-fst-pop \$BASE_DIR/pops/pop.${x.pop2}.txt \
       --fst-window-size 10000 \
       --fst-window-step 1000 \
       --out ${x.pop1}-${x.pop2}.10k
     """
 }

/* collect the VCFtools logs to crate a table with the
   genome wide fst values */
process fst_globals {
  label 'L_loc_fst_globals'
  publishDir "out/fst/", mode: 'move'

  input:
  file( log ) from fst_logs.collect()

  output:
  file( "fst_globals.txt" ) into fst_glob

  script:
  """
  cat *.log | \
  grep -E 'Weir and Cockerham|--out' | \
  grep -A 3 50k | \
  sed '/^--/d; s/^.*--out //g; s/.50k//g; /^Output/d; s/Weir and Cockerham //g; s/ Fst estimate: /\t/g' | \
  paste - - - | \
  cut -f 1,3,5 > fst_globals.txt
  """
}

/* run the pca for the entire dataset */
process vcf_pca {
   label "L_120g12h_pca"
   publishDir "out/pca/", mode: 'symlink'
   module "R3.4.1"

   input:
   file( vcf ) from vcf_pca

   output:
   set file( "*.exp_var.txt.gz" ), file( "*.scores.txt.gz" ), file( "*.pca.pdf" ), file( "*.snp_loadings.pdf"), file( "*.top_snps.txt.gz" ) into pca_output

   script:
   """
   Rscript --vanilla \$BASE_DIR/R/vcf2pca.R ${vcf} \$BASE_DIR/vcf_samples.txt 8
   """
 }

/* run the pca for the belize samples only */
 process vcf_pca_bel {
   label "L_120g12h_pca_bel"
   publishDir "out/pca/", mode: 'symlink'
   module "R3.4.1"

   input:
   file( vcf ) from vcf_pca_bel

   output:
   set file( "*.exp_var.txt.gz" ), file( "*.scores.txt.gz" ), file( "*.pca.pdf" ), file( "*.snp_loadings.pdf"), file( "*.top_snps.txt.gz" ) into pca_bel_output

   script:
   """
   vcftools --gzvcf ${vcf} \
    --remove \$BASE_DIR/pops/pop.gem.txt \
    --mac 1 \
    --recode \
    --stdout | gzip > belize_only.vcf.gz

   Rscript --vanilla \$BASE_DIR/R/vcf2pca.R belize_only.vcf.gz \$BASE_DIR/vcf_samples.txt 8
   """
 }

 /* run the pca for the entire dataset */
 process vcf_pca_noLD {
    label "L_120g12h_pca"
    publishDir "out/pca/", mode: 'symlink'
    module "R3.4.1"

    input:
    file( vcf ) from vcf_pca_noLD

    output:
    set file( "*.exp_var.txt.gz" ), file( "*.scores.txt.gz" ), file( "*.pca.pdf" ), file( "*.snp_loadings.pdf"), file( "*.top_snps.txt.gz" ) into pca_noLD_output

    script:
    """
	 vcftools --gzvcf ${vcf} \
	  --thin 15000 \
     --recode \
     --stdout | gzip > all_samples_noLD.vcf.gz

    Rscript --vanilla \$BASE_DIR/R/vcf2pca.R all_samples_noLD.vcf.gz \$BASE_DIR/vcf_samples.txt 8
    """
  }

 /* run the pca for the belize samples only */
  process vcf_pca_bel_noLD {
    label "L_120g12h_pca_bel"
    publishDir "out/pca/", mode: 'symlink'
    module "R3.4.1"

    input:
    file( vcf ) from vcf_pca_bel_noLD

    output:
    set file( "*.exp_var.txt.gz" ), file( "*.scores.txt.gz" ), file( "*.pca.pdf" ), file( "*.snp_loadings.pdf"), file( "*.top_snps.txt.gz" ) into pca_bel_noLD_output

    script:
    """
    vcftools --gzvcf ${vcf} \
     --remove \$BASE_DIR/pops/pop.gem.txt \
	  --thin 15000 \
     --recode \
     --stdout | gzip > belize_only_noLD.vcf.gz

    Rscript --vanilla \$BASE_DIR/R/vcf2pca.R belize_only_noLD.vcf.gz \$BASE_DIR/vcf_samples.txt 8
    """
  }


/* compute the pairewise kinship between all samples */
 process vcf_kinship {
   label 'L_32g10h_kinship'
   publishDir "out/relatedness/", mode: 'move'
   module "R3.4.1"

   input:
   file( vcf ) from vcf_kinship

   output:
   set file( "*.kinship.txt.gz" ), file( "*.kinship.pdf" ) into kinship_output

   script:
   """
   vcftools --gzvcf ${vcf} --relatedness --out querry
   vcftools --gzvcf ${vcf} --relatedness2 --out querry

   Rscript --vanilla \$BASE_DIR/R/vcf2relatedness.R ${vcf} \$BASE_DIR/vcf_samples.txt \$BASE_DIR/R/geom_tile_stupid.R
   """
 }