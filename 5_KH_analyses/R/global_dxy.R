# This script was used to calculate the global dXY values

library(tidyverse)
library(hypogen)

# config
base_dir <- 'out/dxy/'
files <- dir(base_dir)

# import function for dxy data (fpr use with purrr::map)
get_dxy <- function(file){
  run <-  file %>% str_remove(".all.50kb-5kb.txt.gz") %>% str_remove("dxy.")
  read_csv(str_c(base_dir,file)) %>% 
  setNames(.,nm = c("CHROM","BIN_START","BIN_END","BIN_MID","N_SITES",
                    "pi_pop1","pi_pop2","dXY","FST")) %>%
  left_join(.,hypo_chrom_start) %>%
  mutate(GMID = GSTART + BIN_MID,
         run = run)
  }

# import data
data <- purrr::map(files,get_dxy) %>% bind_rows()

# visual sanity check for data completenes
# (because of the nextflow legacy - s. dyx.nf)
ggplot(data,aes(x = GMID,y = dXY,group = CHROM)) + 
  geom_hypo_LG()+
  geom_point(size= .2)+
  geom_smooth()+
  facet_grid(run~.) +
  scale_x_hypo_LG() +
  scale_fill_hypo_LG_bg()+
  theme_hypo()

# calculate mean dXY over the  genome wide 50kb windows
# whighted by the number of SNPs
data %>%
  mutate( WdXY = dXY*N_SITES ) %>%
  group_by(run) %>%
  summarise(n_snps = sum(N_SITES),
            sum_dxy = sum(WdXY),
            mean_dxy = sum_dxy/n_snps )