#!/usr/bin/env nextflow

/* This pipelie includes the anlysis run on phased SNPs
   data sheet (lddecay, xpEHH, iHH12).*/

vcf_base = Channel
	.fromPath( "$WORK/1_output/1.11_phased_variants/5_phased.vcf.gz" )
	.into{ vcf_LD_decay; vcf_ihh12; vcf_xpehh }

Channel
	.fromPath("random_hamlet_windows_30kb.txt")
	.splitCsv(header:true, sep:"\t")
	.map{ row -> [ CHROM:row.CHROM, START:row.START, END:row.END] }
	.combine( vcf_LD_decay )
	.set { vcf_LD_decay_windows }

process ld_decay {
	label "L_10g30m_ld_decay"
	publishDir "out/ld_decay/", mode: 'copy'

	input:
	set val( x ), file( vcf ) from vcf_LD_decay_windows

	output:
	file( "r2.*.txt.gz" ) into ld_decay_output

	script:
	"""
	vcftools \
		--gzvcf ${vcf} \
		--chr ${x.CHROM} \
		--from-bp ${x.START} \
		--to-bp  ${x.END} \
		--maf 0.1 \
		--hap-r2 \
		--stdout | \
		gzip > r2.${x.CHROM}.${x.START}-${x.END}.txt.gz
	"""
}
/* selscan section -------- */

/* create channel of linkage groups */
Channel
	.from( ('01'..'09') + ('10'..'19') + ('20'..'24') )
	.map{ "LG" + it }
	.into{ lg_ch1; lg_ch2 }


Channel
	.from("gem", "may", "nig", "pue", "uni")
	.combine( lg_ch1 )
	.combine( vcf_ihh12 )
	.set{ ihh12_start }

Channel
	.fromPath('comparisons.txt')
	.splitCsv(header:true, sep:"\t")
	.map{ row -> [ pop1:row.pop1, pop2:row.pop2] }
	.combine( lg_ch2 )
	.combine( vcf_xpehh )
	.set { comparisons_ch }

	/* ihh12 */
process ihh_plink {
	label "L_10g30m_plink_ihh"

	input:
	set val( pop ), val( lg ), file( vcf ) from ihh12_start

	output:
	set val( pop ), val( lg ), file( vcf ), file ( "*.ped" ), file ( "*.map" ) into ihh12_plink

	script:
	"""
	vcftools \
		--gzvcf ${vcf} \
		--chr ${lg} \
		--keep \$BASE_DIR/pops/pop.${pop}.txt \
		--plink \
		--out plink_prep.${pop}.${lg};
	"""
}

process ihh_vcf_transform {
	label "L_10g30m_ihh_transform"

	input:
	set val( pop ), val( lg ), file( vcf ), file ( ped ), file ( map ) from ihh12_plink

	output:
	set val( pop ), val( lg ), file( "selscan.*.vcf.gz" ), file( "selscan.*.map" ) into ihh12_ready

	script:
	"""
	vcftools \
		--gzvcf ${vcf} \
		--chr ${lg} \
		--keep \$BASE_DIR/pops/pop.${pop}.txt \
		--recode \
		--stdout | \
		awk -v "OFS=\\t" ' {if (substr(\$1,1,1) != "#" ) {\$4=0;  \$5=1} ;print \$0}' | \
		grep -v '#' | \
		sed 's/LG0//g; s/LG//g' | \
		gzip -c  > selscan.${pop}.${lg}.vcf.gz ;

	cut -f 2 plink_prep.${pop}.${lg}.map | \
		sed 's/:/\\t/g'| \
		awk '{print \$1"\\t"\$2"\\t"\$2"\\t"\$2}' | \
		sed 's/LG0//g; s/LG//g' > selscan.${pop}.${lg}.map ;
	"""
}

process ihh_run {
	label "L_32g2h5t_ihh_run"
	publishDir "out/ihh12/by_SNP/${pop}/", mode: 'copy'

	input:
	set val( pop ), val( lg ), file( vcf ), file ( map ) from ihh12_ready

	output:
	set val( pop ), file( "selscan.*.ihh12.out" ) into ihh12_done

	script:
	"""
	selscan \
		--ihh12 \
		--vcf ${vcf} \
		--map ${map} \
		--out selscan.${pop}.${lg} \
		--threads 5
	"""
}

process ihh_merge_and_slide {
	label "L_32g2h5t_ihh_merge"
	publishDir "out/ihh12/50kb/", mode: 'copy', pattern: "*5kb.txt.gz"
	publishDir "out/ihh12/10kb/", mode: 'copy', pattern: "*1kb.txt.gz"

	input:
	set val( pop ), file( in_file ) from ihh12_done.groupTuple()

	output:
	file( "ihh12.*.txt.gz" ) into ihh12_output

	script:
	"""
	bash \$BASE_DIR/sh/merge_and_slide.sh selscan.${pop}.XXtagXX.ihh12.out 50000 5000 ihh12.${pop}.50kb.5kb iHH12
	bash \$BASE_DIR/sh/merge_and_slide.sh selscan.${pop}.XXtagXX.ihh12.out 10000 1000 ihh12.${pop}.10kb.1kb iHH12
	"""
}

/* xpIHH */
process xpehh_plink {
	label "L_10g30m_plink_xpehh"

	input:
	set val(x), val( lg ), file( vcf ) from comparisons_ch

	output:
	set val( x ), val( lg ), file( vcf ), file ( "*.ped" ), file ( "*.map" ) into xpehh_plink

	script:
	"""
	vcftools \
		--gzvcf ${vcf} \
		--chr ${lg} \
		--keep \$BASE_DIR/pops/pop.${x.pop1}.txt \
		--keep \$BASE_DIR/pops/pop.${x.pop2}.txt \
		--plink \
		--out plink_prep.${x.pop1}-${x.pop2}.${lg};
	"""
}

process xpehh_vcf_transform {
	label "L_10g30m_xpehh_transform"

	input:
	set val( x ), val( lg ), file( vcf ), file ( ped ), file ( map ) from xpehh_plink

	output:
	set val( x ), val( lg ), file( "selscan.*.pop1.${lg}.vcf.gz" ), file( "selscan.*.pop2.${lg}.vcf.gz" ), file( "selscan.*.map" ) into xpehh_ready

	script:
	"""
	vcftools \
		--gzvcf ${vcf} \
		--chr ${lg} \
		--keep \$BASE_DIR/pops/pop.${x.pop1}.txt \
		--recode \
		--stdout | \
		awk -v "OFS=\\t" ' {if (substr(\$1,1,1) != "#" ) {\$4=0; \$5=1} ;print \$0}' | \
		grep -v '#' | \
		sed 's/LG0//g; s/LG//g' | \
		gzip -c  > selscan.${x.pop1}-${x.pop2}.pop1.${lg}.vcf.gz ;

	vcftools \
		--gzvcf ${vcf} \
		--chr ${lg} \
		--keep \$BASE_DIR/pops/pop.${x.pop2}.txt \
		--recode \
		--stdout | \
		awk -v "OFS=\\t" ' {if (substr(\$1,1,1) != "#" ) {\$4=0; \$5=1} ;print \$0}' | \
		grep -v '#' | \
		sed 's/LG0//g; s/LG//g' | \
		gzip -c  > selscan.${x.pop1}-${x.pop2}.pop2.${lg}.vcf.gz

	cut -f 2 plink_prep.${x.pop1}-${x.pop2}.${lg}.map | \
		sed 's/:/\\t/g'| \
		awk '{print \$1"\\t"\$2"\\t"\$2"\\t"\$2}' | \
		sed 's/LG0//g; s/LG//g' > selscan.${x.pop1}-${x.pop2}.${lg}.map ;
	"""
}

process xpehh_run {
	label "L_32g2h5t_xpehh_run"
	publishDir "out/xpehh/by_SNP/${x.pop1}-${x.pop2}/", mode: 'copy'

	input:
	set val( x ), val( lg ), file( pop1vcf ), file( pop2vcf ), file( map ) from xpehh_ready

	output:
	set val( "${x.pop1}-${x.pop2}" ), val( x ), file( "selscan.*.xpehh.out" ) into xpehh_done

	script:
	"""
	selscan \
		--xpehh \
		--vcf ${pop1vcf} \
		--vcf-ref ${pop2vcf} \
		--map ${map} \
		--out selscan.${x.pop1}-${x.pop2}.${lg} \
		--threads 5
	"""
}

process xpehh_merge_and_slide {
	label "L_32g2h5t_ihh_merge"
	publishDir "out/xpehh/50kb/", mode: 'copy', pattern: "*5kb.txt.gz"
	publishDir "out/xpehh/10kb/", mode: 'copy', pattern: "*1kb.txt.gz"

	input:
	set val( run ), val( x ), file( in_file ) from xpehh_done.groupTuple()

	output:
	file( "xpehh.*.txt.gz" ) into xpehh_output

	script:
	"""
	bash \$BASE_DIR/sh/merge_and_slide.sh selscan.${run}.XXtagXX.xpehh.out 50000 5000 xpehh.${run}.50kb.5kb xpEHH
	bash \$BASE_DIR/sh/merge_and_slide.sh selscan.${run}.XXtagXX.xpehh.out 10000 1000 xpehh.${run}.10kb.1kb xpEHH
	"""
}