#!/usr/bin/env Rscript
# ===============================================================
# This script produces an overview over 4 metrics of relatedness 
# among the individuals of a given VCF file.  
# It used the package SNPrelate and VCFtools output.
# ---------------------------------------------------------------
# The produced output contains:
#  - 1 plot (4 half matices of relatednss metrics)
#  - 1 table containing all individual pairs with all 4 relatednss metrics
# ===============================================================
args = commandArgs(trailingOnly=FALSE)
args = args[7:9]
print(args)

library(SNPRelate)
library(stringr)
library(tidyverse)
library(forcats)
library(grid)

source(as.character(args[3]))
# config ----------------------------
set.seed(1000)
vcf.fn <- as.character(args[1])
vcf_samples <- as.character(args[2])
base_name <- str_remove(vcf.fn,'.vcf.gz')
# sample metadata ----------------------------
id_labs <- read_delim(vcf_samples, delim = '\t',col_names = c('id','spec')) %>% 
  mutate(order = str_c(spec,id))

# PLOT 1 (SNPRelate) ========

# read the vcf --------------
snpgdsVCF2GDS(vcf.fn = vcf.fn, out.fn = str_c(base_name,'.gds'), method="biallelic.only")
snpgdsSummary(str_c(base_name,'.gds'))
genofile <- snpgdsOpen(str_c(base_name,'.gds'))
# SNP filtering --------------
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2,autosome.only = FALSE)
snpset.id <- unlist(snpset)
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
# MoM ----------------------------------
ibd_1 <- snpgdsIBDMoM(genofile, sample.id=sample.id, snp.id=snpset.id,
                    maf = NaN, missing.rate=NaN, num.thread=2,autosome.only = FALSE)

ibd_1.coeff <- snpgdsIBDSelection(ibd_1) %>% 
  as.tibble() %>% 
  mutate(ID1 = factor(ID1,levels = id_labs$id[order(id_labs$order)]),
         ID2 = factor(ID2,levels = id_labs$id[order(id_labs$order)]),
         x_prep = as.numeric(ID1),y_prep = as.numeric(ID2),
         x = ifelse(x_prep < y_prep,x_prep,y_prep),
         y = ifelse(x_prep < y_prep,y_prep,x_prep),
         test = str_c(levels(ID1)[x],'-',levels(ID2)[y])) %>%
  select(-x_prep,-y_prep)
# MLE ------------------------------------------------
ibd_2 <- snpgdsIBDMLE(genofile, sample.id=sample.id, snp.id=snpset.id,
                    maf=NaN, missing.rate=NaN, num.thread=2,autosome.only = FALSE)
ibd_2.coeff <- snpgdsIBDSelection(ibd_2) %>% 
  as.tibble() %>% 
  mutate(ID1 = factor(ID1,levels = id_labs$id[order(id_labs$order)]),
         ID2 = factor(ID2,levels = id_labs$id[order(id_labs$order)]),
         x_prep = as.numeric(ID1),y_prep = as.numeric(ID2),
         x = ifelse(x_prep > y_prep,x_prep,y_prep),
         y = ifelse(x_prep > y_prep,y_prep,x_prep),
         test = str_c(levels(ID1)[y],'-',levels(ID2)[x])) %>%
  select(-x_prep,-y_prep)
# plotting prep------------------------
spec_box <- id_labs %>% group_by(spec) %>% 
  count() %>% ungroup() %>%
  mutate(start = cumsum(lag(x = n,default = 0))+.6,
         end = start+n-.2)

whisker=.4
ybase = -.7  
clr = c('#9fd9e3','#2c5aa0','#000000','#d45500','#ffe373')
# plotting -------------------  
p1 <- ggplot()+
  coord_equal()+
  # data 
  geom_tile(data = ibd_1.coeff, aes(x=x,y=y,fill=kinship))+
  geom_tile_swap(data = ibd_2.coeff, aes(x=x,y=y,stupid=kinship))+
  # horizontal labels
  geom_segment(data = spec_box,aes(x=start,xend=end,y=ybase,yend=ybase,col=spec))+
  geom_segment(data = spec_box,aes(x=end,xend=end,y=-whisker+ybase,yend=whisker+ybase,col=spec))+
  geom_segment(data = spec_box,aes(x=start,xend=start,y=-whisker+ybase,yend=whisker+ybase,col=spec))+
  ggrepel::geom_label_repel(data = spec_box,aes(x = (start+end)/2,y=ybase,label=spec,col=spec),
                           nudge_x = 0,nudge_y = 0,force = 0)+
  # vertical labels
  geom_segment(data = spec_box,aes(y=start,yend=end,x=ybase,xend=ybase,col=spec))+
  geom_segment(data = spec_box,aes(y=end,yend=end,x=-whisker+ybase,xend=whisker+ybase,col=spec))+
  geom_segment(data = spec_box,aes(y=start,yend=start,x=-whisker+ybase,xend=whisker+ybase,col=spec))+
  # scales 
  guides(stupid = guide_colorbar_stupid(order=2),
         fill = guide_colorbar(order=1)) +
  scale_fill_distiller(name = 'MoM',type = 'seq', palette = 'Blues',direction = 1) +
  scale_color_manual(values = clr, guide = FALSE)+
  scale_stupid_distiller(name = 'MLE',type = 'seq',palette = 'Oranges',direction = 1)+
  scale_x_continuous(breaks = 1:length(levels(ibd_1.coeff$ID1)),
                     labels = levels(ibd_1.coeff$ID1),expand = c(0,0))+
  scale_y_continuous(breaks = 1:length(levels(ibd_1.coeff$ID1)),
                     labels = levels(ibd_1.coeff$ID1),expand = c(.022,0))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=-90),
        panel.grid = element_blank(),
        axis.title = element_blank())

# PLOT 2 (VCFtools) =============
ibd_3.coeff <- read_delim('querry.relatedness',delim = '\t',col_types = 'ccd') %>%
  set_names(., nm = c('ID1','ID2','AJK')) %>% 
  filter(ID1!=ID2) %>%
  mutate(ID1 = factor(ID1,levels = id_labs$id[order(id_labs$order)]),
         ID2 = factor(ID2,levels = id_labs$id[order(id_labs$order)]),
         x_prep = as.numeric(ID1),y_prep = as.numeric(ID2),
         x = ifelse(x_prep < y_prep,x_prep,y_prep),
         y = ifelse(x_prep < y_prep,y_prep,x_prep),
         test = str_c(levels(ID1)[x],'-',levels(ID2)[y])) %>%
  select(-x_prep,-y_prep)

ibd_4.coeff <- read_delim('querry.relatedness2',delim = '\t',col_types = 'cciiiid') %>%
  select(INDV1,INDV2,RELATEDNESS_PHI) %>%
  set_names(., nm = c('ID1','ID2','PHI')) %>%
  mutate(ID1 = factor(ID1,levels = id_labs$id[order(id_labs$order)]),
         ID2 = factor(ID2,levels = id_labs$id[order(id_labs$order)]),
         x = as.numeric(ID1),y = as.numeric(ID2),
         test = str_c(levels(ID1)[y],'-',levels(ID2)[x])) %>%
  filter(x>y)

p2 <- ggplot()+
  coord_equal()+
  # data 
  geom_tile(data = ibd_3.coeff, aes(x=x,y=y,fill=AJK))+
  geom_tile_swap(data = ibd_4.coeff, aes(x=x,y=y,stupid=PHI))+
  # horizontal labels
  geom_segment(data = spec_box,aes(x=start,xend=end,y=ybase,yend=ybase,col=spec))+
  geom_segment(data = spec_box,aes(x=end,xend=end,y=-whisker+ybase,yend=whisker+ybase,col=spec))+
  geom_segment(data = spec_box,aes(x=start,xend=start,y=-whisker+ybase,yend=whisker+ybase,col=spec))+
  ggrepel::geom_label_repel(data = spec_box,aes(x = (start+end)/2,y=ybase,label=spec,col=spec),
                            nudge_x = 0,nudge_y = 0,force = 0)+
  # vertical labels
  geom_segment(data = spec_box,aes(y=start,yend=end,x=ybase,xend=ybase,col=spec))+
  geom_segment(data = spec_box,aes(y=end,yend=end,x=-whisker+ybase,xend=whisker+ybase,col=spec))+
  geom_segment(data = spec_box,aes(y=start,yend=start,x=-whisker+ybase,xend=whisker+ybase,col=spec))+
  # scales 
  guides(stupid = guide_colorbar_stupid(order=2),
         fill = guide_colorbar(order=1)) +
  scale_fill_distiller(name = 'AJK',type = 'seq', palette = 'Greens',direction = 1) +
  scale_color_manual(values = clr, guide = FALSE)+
  scale_stupid_distiller(name = ' PHI',type = 'seq',palette = 'Purples',direction = 1)+
  scale_x_continuous(breaks = 1:length(levels(ibd_1.coeff$ID1)),
                     labels = levels(ibd_1.coeff$ID1),expand = c(0,0))+
  scale_y_continuous(breaks = 1:length(levels(ibd_1.coeff$ID1)),
                     labels = levels(ibd_1.coeff$ID1),expand = c(.022,0))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=-90),
        panel.grid = element_blank(),
        axis.title = element_blank())
# export ---------------
p <- cowplot::plot_grid(p1,p2,ncol = 2)
ggsave(p,filename = str_c(base_name,'.kinship.pdf'), width = 16,height = 8)

ibd_all <- ibd_1.coeff %>% select(ID1:kinship,x,y,test) %>% 
  set_names(.,nm = c('ID1','ID2','k0_mom','k1_mom','kinship_mom','x','y','test')) %>% 
  left_join(.,(ibd_2.coeff %>% 
                 select(k0,k1,niter,kinship,test) %>%
                 set_names(.,nm = c('k0_mle','k1_mle','niter_mle','kinship_mle','test')))) %>% 
  left_join(.,(ibd_3.coeff %>% select(AJK,test)))%>% 
  left_join(.,(ibd_4.coeff %>% select(PHI,test))) %>% 
  select(-test) %>% as_tibble()

write_delim(x = ibd_all,path = str_c(base_name,'.kinship.txt'),delim = '\t')
system(str_c("gzip ",str_c(base_name,'.kinship.txt')))
# close the door ----------------

