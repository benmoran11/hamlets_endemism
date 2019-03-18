## The maya repo

The repo contains 2 **NextFlow** pipelines (`fst_pca_kinship.nf` & `dxy.nf`).
Unfortunately, the `dxy.nf` pipeline currently doesn't finish properly (s. comments therein).
Therefore, after this pipeline fails, the script `sh/collapse_dxy.sh` needs to be run to collect the pieces.

The **R** folder contains 3 major scripts (`vcf2pca.R`, `vcf2relatedness.R` & `plot_fst.R`). Of these , the `vcf2*R` scripts are run from within the `fst_pca_kinship.nf` pipeline, while the `plot_fst.R` script needs to run interactively from within the **RProject** `maya.Rproj`. The remaining **R** scripts are helper scripts that are needed for the scripts above.

The folder `pops/` contains the sample IDs for the different populations used for the fst calculations within **VCFtools**.

The output folder (`out/*`) is omitted but should contain the following after running the pipeline & **R** scripts:

```
out/
├── dxy
│   ├── dxy.gem-may.all.50kb-5kb.txt.gz
│   ├── dxy.gem-nig.all.50kb-5kb.txt.gz
│   ├── dxy.gem-pue.all.50kb-5kb.txt.gz
│   ├── dxy.gem-uni.all.50kb-5kb.txt.gz
│   ├── dxy.may-nig.all.50kb-5kb.txt.gz
│   ├── dxy.may-pue.all.50kb-5kb.txt.gz
│   ├── dxy.may-uni.all.50kb-5kb.txt.gz
│   ├── dxy.nig-pue.all.50kb-5kb.txt.gz
│   ├── dxy.nig-uni.all.50kb-5kb.txt.gz
│   └── dxy.pue-uni.all.50kb-5kb.txt.gz
├── fst
│   ├── 10k
│   │   ├── gem-may.10k.windowed.weir.fst.gz
│   │   ├── gem-nig.10k.windowed.weir.fst.gz
│   │   ├── gem-pue.10k.windowed.weir.fst.gz
│   │   ├── gem-uni.10k.windowed.weir.fst.gz
│   │   ├── may-nig.10k.windowed.weir.fst.gz
│   │   ├── may-pue.10k.windowed.weir.fst.gz
│   │   ├── may-uni.10k.windowed.weir.fst.gz
│   │   ├── nig-pue.10k.windowed.weir.fst.gz
│   │   ├── nig-uni.10k.windowed.weir.fst.gz
│   │   └── pue-uni.10k.windowed.weir.fst.gz
│   ├── fst_globals.txt
│   ├── gem-may.50k.windowed.weir.fst.gz
│   ├── gem-nig.50k.windowed.weir.fst.gz
│   ├── gem-pue.50k.windowed.weir.fst.gz
│   ├── gem-uni.50k.windowed.weir.fst.gz
│   ├── may-nig.50k.windowed.weir.fst.gz
│   ├── may-pue.50k.windowed.weir.fst.gz
│   ├── may-uni.50k.windowed.weir.fst.gz
│   ├── nig-pue.50k.windowed.weir.fst.gz
│   ├── nig-uni.50k.windowed.weir.fst.gz
│   └── pue-uni.50k.windowed.weir.fst.gz
├── pca
│   ├── gemplusbel_biallelic_filteredSNPs.exp_var.txt.gz
│   ├── gemplusbel_biallelic_filteredSNPs.pca.pdf
│   ├── gemplusbel_biallelic_filteredSNPs.scores.txt.gz
│   ├── gemplusbel_biallelic_filteredSNPs.snp_loadings.pdf
│   ├── gemplusbel_biallelic_filteredSNPs.top_snps.txt.gz
│   └── mac1
│       ├── belize_only.exp_var.txt.gz
│       ├── belize_only.pca.pdf
│       ├── belize_only.scores.txt.gz
│       ├── belize_only.snp_loadings.pdf
│       └── belize_only.top_snps.txt.gz
├── plots
│   └── fst_maya_only.png
├── relatedness
│   ├── gemplusbel_biallelic_filteredSNPs.kinship.pdf
│   └── gemplusbel_biallelic_filteredSNPs.kinship.txt.gz
└── tables
    ├── dxy.csv
    ├── outlier.bed
    ├── outlier_intersect.bed
    ├── outlier_table.tex
    └── part_anno.bed

```

---

<center><img src="logo.svg" alt="logo" width="150"/></center>