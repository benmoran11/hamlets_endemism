#!/usr/bin/env nextflow
/* This pipelie includes the anlysis run on the
   all callable sites data sheet (dxy).*/

/* open the pipeline with a list of all the species
   comparisons possible within the dataset  */
params.index = 'sample_index.txt'

/* define the genotype file */
Channel
    .fromPath( "$WORK/1_output/1.8_filtered_variants/4_bi-allelic_snps.vcf" )
    .set{ vcf_fis }

 /* split the comparisons spread sheet by row and feed it into a channel */
 Channel
     .fromPath(params.index)
     .splitCsv(header:true, sep:"\t")
     .map{ row -> [ pop:row.pop, samples:row.samples] }
     .set { pops_fis }

/* bind the genotype file to the LG channel*/
pops_vcf = pops_fis.combine( vcf_fis )

/* split the genotypes by LG and reformat the genotypes */
process get_fis {
    label 'L_32g10h_fis'
		publishDir "out/fis/pops", mode: 'symlink'

    input:
    set val( x ), file( vcf ) from pops_vcf

    output:
    file( "${x.pop}.fis.txt" ) into fis_done

    script:
    """
		\$SFTWR/vcflib/bin/popStats --type GT \
				--target ${x.samples} \
				--file ${vcf} | \
				awk -v OFS='\t' -v pop="${x.pop}" 'BEGIN{print "CHROM","POS","AF","He","Ho","Hn","HOnR","HOnA","FIS","He-Ho","He","Fis_by_hand"}
				{if(\$6==0){print \$0,(\$4-\$5),(\$4),1} else { sum_nom += (\$4-\$5);sum_denom += \$4; print \$0,(\$4-\$5),(\$4),(\$4-\$5)/(\$4)}}
				END {print "# Summary:\\n" "# pop\tsum_nom\tsum_denom\twhg_avg_Fis\\n" "# "pop,sum_nom,sum_denom,(sum_nom/sum_denom)}' > ${x.pop}.fis.txt
    """
}

process all_fis {
    label 'L_loc_collect_fis'
		publishDir "out/fis/", mode: 'move'

    input:
    file( txt ) from fis_done.collect()

    output:
    file( "fis_summary.txt" ) into fis_collected

    script:
    """
		echo "pop\tsum_nom\tsum_denom\twhg_avg_Fis" > fis_summary.txt
		for k in ${txt}; do
		tail -n 1 \$k | sed 's/# //g' >> fis_summary.txt
		done
    """
}
