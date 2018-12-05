# hamlets_endemism_Ne
These scripts and resources are needed to reproduce the results of a study of *Hypoplectrus maya* demography and speciation.
Software dependencies are listed in Suppl. Table 5 of the study's manuscript, and should be added to the $PATH variable for proper functioning of all scripts. In addition, the location of the GATK and Picard `.jar` files must be represented by specific environmental variables, `$GATK` and `$PICARD`, respectively.
Due to constraints on file sizes and copyrights, most raw data and larger resources (e.g. genome assemblies, geographic maps) cannot be included in this repo. As such, they'll need to be downloaded from their respective sources:

| Data | Source | Directory |
| --- | --- | --- |
| *H. maya* & *H. gemma* Sequences | ENA project number PRJEB29705 | `$WORK/0_data/1_fastq/` |
| *H. puella*, *H. nigricans*, & *H. unicolor* sequences | ENA project number PRJEB27858 | `$WORK/1_output/1.4_dedup/` |
| *H. puella* reference genome | ENA project number PRJEB27858 | `$WORK/0_data/0_resources/HP_genome_unmasked_01.fa` |
| Belize Map shapefile | GADM: https://gadm.org/download_country_v3.html | `$WORK/6_graphs/0_data/` |
| Mexico Map shapefile | GADM: https://gadm.org/download_country_v3.html | `$WORK/6_graphs/0_data/` |
| Florida (USA) Map shapefile | GADM: https://gadm.org/download_country_v3.html | `$WORK/6_graphs/0_data/` |
| Coral Map shapefile | UNEP-WCMC: http://data.unep-wcmc.org/datasets/1 | `$WORK/6_graphs/0_data/` |


**Note** that the Belizean *H. puella*, *H. nigricans*, & *H. unicolor* sequencing data will require pre-processing before placement in the directory above. The raw `.fastq` files must be converted to deduplicated `.bam` files, following https://git.geomar.de/puebla-lab/hamlets_ILD_vision_pigmentation.

Once it is properly placed in the `$WORK/0_data/0_resources/` folder, the genome will need to be indexed with command `bwa index HP_genome_unmasked_01.fa` (a script suitable for cluster submission of this commanded is included in `$WORK/1_genotyping-scripts/`).

Running all scripts in numerical order (i.e. folder `1_genotyping-scripts` before `2_popgen-scripts`, `1.1.loop_fq2ubam.sh` before `1.2.loop_markAdapters.sh`, and `1.9.1.subset_LGs.sh` before `1.9.2.subset_allBP.sh`) will create all figures presented in the manuscript. Specifically, data for each figure of the may be found in the following locations:

Figure | Source
--- | ---
Table 1: |`$WORK/5_KH_analyses/out/fst/fst_globals.txt` and `$WORK/5_KH_analyses/out/tables/dxy.csv`
Figure 1: |`$WORK/6_output/range_map.pdf`
Figure 2: |`$WORK/6_output/diverge_pcas.pdf`
Figure 3: |`$WORK/6_output/inbhetrel_stats.pdf`
Figure 4: |`$WORK/6_output/gemplusbel_msmc2_trimmed.pdf`
Figure 5: |`$WORK/6_output/gemplusbel_crosscoal_joined_cowplot.pdf`
Figure 6: |`$WORK/6_output/maybel_LDNe.pdf`
Suppl. Fig. 1: |`$WORK/6_output/Bel_map.pdf`
Suppl. Fig. 2: |`$WORK/6_output/FL_map.pdf`
Suppl. Fig. 3: |`$WORK/6_output/FL_dens.pdf`
Suppl. Fig. 4: |`$WORK/6_output/NMDS_hams.pdf`
Suppl. Fig. 5: |`$WORK/5_KH_analyses/out/plots/fst_maya_only.png`
Suppl. Fig. 6: |`$WORK/6_output/pi_plot.pdf`
Suppl. Fig. 7: |`$WORK/6_output/relatedness_mle_ajk.pdf`
Suppl. Fig. 8: |`$WORK/6_output/gemplusbel_msmc2_full.pdf`
Suppl. Fig. 9: |`$WORK/6_output/gemplusbel_msmc2_unmasked.pdf`
Suppl. Fig. 10: |`$WORK/6_output/gemplusbel_smcpp.pdf`
Suppl. Tab. 3: |`$WORK/5_KH_analyses/tables/outlier_table.tex`
Suppl. Tab. 4: |`$WORK/3_output/3.3_phased_indiv_depths/phased.snps.idepth`

Specific numerical values quoted in the manuscript text are drawn from the same datasets which generated these figures and tables. All those tables not included required no intermediate analysis steps, and have sources listed in the manuscript.
