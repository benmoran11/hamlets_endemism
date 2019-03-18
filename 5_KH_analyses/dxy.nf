#!/usr/bin/env nextflow
/* This pipelie includes the anlysis run on the
   all callable sites data sheet (dxy).*/

/* open the pipeline with a list of all the species
   comparisons possible within the dataset  */
params.index = 'comparisons.txt'

/* define the genotype file */
vcf_allBP = Channel
    .fromPath( "\$WORK/1_output/1.8_filtered_variants/4_maxMissing5_allBP.recode.vcf.gz" )
    .into{ vcf_dxy }

 /* split the comparisons spread sheet by row and feed it into a channel */
 Channel
     .fromPath(params.index)
     .splitCsv(header:true, sep:"\t")
     .map{ row -> [ pop1:row.pop1, pop2:row.pop2] }
     .set { comparisons_dxy }

/* generate a LG channel */
LG_ids1 = Channel.from( ('01'..'09') + ('10'..'19') + ('20'..'24') )
/* bind the genotype file to the LG channel*/
LG_vcfs = LG_ids1.combine( vcf_dxy )

/* split the genotypes by LG and reformat the genotypes */
process split_allBP {
    label 'L_32g10h_split_allBP'

    input:
    set val( x ), file( vcf ) from LG_vcfs

    output:
    set val( x ), file( "allBP.LG${x}.geno.gz" ) into LG_geno

    script:
    """
    vcftools --gzvcf ${vcf} \
      --chr LG${x} \
      --recode \
      --stdout | gzip  > allBP.LG${x}.vcf.gz

    python \$SFTWR/genomics_general/VCF_processing/parseVCF.py \
      -i allBP.LG${x}.vcf.gz  | gzip > allBP.LG${x}.geno.gz
    """
}

/* combine the possible comparisons with the genotypes split by LG */
dxy_prep  =  LG_geno.combine( comparisons_dxy )

/* compute the dxy values along non-overlaping 50kb windows */
process dxy_lg {
    label 'L_32g2h5t_dxy_lg'
    /* this process is likely not to finish - somehow the window script
    fails to finish - I still produces the output though */

    input:
    set val( lg ), file( geno ), val( comp ) from dxy_prep

    output:
    set val( comp ), file( "dxy.${comp.pop1}-${comp.pop2}.LG${lg}.50kb-5kb.txt.g" ), val( lg ) into LG_dxy

    script:
    """
    cut -f 1,3,4 \$BASE_DIR/sample_info.txt | grep  'bel\\|flo' | cut -f 1,2 > pop.txt

    python \$SFTWR/genomics_general/popgenWindows.py \
    	-w 50000 -s 50000 \
    	--popsFile pop.txt \
    	-p ${comp.pop1} -p ${comp.pop2} \
    	-g ${geno} \
    	-o dxy.${comp.pop1}-${comp.pop2}.LG${lg}.50kb-5kb.txt.gz \
    	-f phased \
      --writeFailedWindows \
      -T 5
    """
}

/*  --- disclaimer: ---
Unfortunately the process dxy_lg does not finish properly since popgenWindows.py
continues to run after the output has been created.
Therrefore dxy_lg is allways killed due to "overtime".
Below is the originally intended way of merging the dXY output per run.
The makeshift workaround is given in the 'collapse_dxy.sh' which was run after the
nextflow pipeline broke at this point....
-----------------------

LG_dxy
  .groupTuple()
  .set {tubbled_dxy}

process receive_tuple {
    label 'L_36g47h_receive_tuple'
    publishDir "out/dxy/", mode: 'move'

    input:
    set comp, dxy, lg from tubbled_dxy

    output:
    set val( comp ), file( "dxy.${comp.pop1}-${comp.pop2}.50kb-5kb.txt.gz" ) into dxy_genome_wide

    script:
    """
    zcat dxy.${comp.pop1}-${comp.pop2}.LG01.50kb-5kb.txt.gz | \
      head -n 1 > dxy.${comp.pop1}-${comp.pop2}.50kb-5kb.txt;

    for j in {01..24};do
      echo "-> LG\$j"
      zcat dxy.${comp.pop1}-${comp.pop2}.LG\$j.50kb-5kb.txt.gz | \
        awk 'NR>1{print}' >> dxy.${comp.pop1}-${comp.pop2}.50kb-5kb.txt;
    done

    gzip dxy.${comp.pop1}-${comp.pop2}.50kb-5kb.txt
    """
}
*/