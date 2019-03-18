#!/usr/bin/env Rscript
library(Hmisc)
library(IRanges)
library(GenomicRanges)
library(tidyverse)
library(hypogen)
library(hypoimg)
library(stringr)
library(scico)


source('R/geom_rect_swap.R')
source('R/fst_functions.R')
source('R/roh_and_ihh_functions.R')

# FST section ----------------------

# config -----------------------
base_dir <- 'out/fst/'
base_name <- 'out/plots/fst_'
globals_file <- as.character(str_c(base_dir,'fst_globals.txt'))
# read data ----------------------------
globals <- read_delim(globals_file, delim = '\t',
                      col_names = c('run','mean','weighted')) %>%
  filter(grepl('may',run)) %>%
  mutate(run = fct_reorder(run,weighted))


runs <- tibble(file = dir(path = base_dir, pattern = 'may.*50k')) %>%
  mutate(pops = str_sub(file,1,7)) %>%
  separate(pops,into = c('pop1','pop2'))

data <- pmap(runs,get_data,base_dir=base_dir) %>%
  bind_rows() %>%
  filter(!grepl('Contig',CHROM)) %>%
  filter(grepl('may',run))

match_df <- tibble(short = c('gem', 'may', 'nig', 'pue', 'uni','all'),
                   long =c('gemma', 'maya', 'nigricans', 'puella', 'unicolor','maya'))

maycols <- c("H. nigricans" ='#F8766D',
             "H. unicolor" = '#E76BF3',
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')

maycols_short <- c(
  all = '#000000',
  nig ='#F8766D', 
  uni = '#E76BF3', 
  pue = '#00BF7D',
  gem = '#00B0F6',
  may = '#A3A500')

clr_hamlets <- tibble(clr = maycols, spec = names(maycols))
# Our color map
clr <- clr_hamlets$clr[c(5,3,2,1,4)][2:5]
# Our color map
clr_tibble <- tibble(ord = as.numeric(globals$run),
                     run = globals$run,
                     clr = clr[as.numeric(globals$run)])

# prepare hamlet annotations ----------------------
grob_table <- runs %>%
  left_join(.,match_df, by = c("pop1" = "short")) %>%
  left_join(.,match_df, by = c("pop2" = "short")) %>%
  mutate(run = str_c(pop1,pop2,sep='-')) %>%
  left_join(.,clr_tibble) %>%
  select(long.x, long.y,clr) %>%
  set_names(.,nm = c('left','right','circle_fill')) %>%
  mutate( right = ifelse(left == 'gemma','gemma',right),
          left = ifelse(left == 'gemma','maya',left)) %>%
  pmap(.,plot_pair)

t1 <- runs %>%
  mutate(run = str_c(pop1,pop2,sep='-')) %>%
  select(run)

grob_tibble <- tibble( run = t1$run,
        grob = grob_table)

global_bar <- globals %>%
  select(weighted,run) %>%
  mutate(run = as.character(run)) %>%
  setNames(.,nm = c('fst','run')) %>%
  pmap(.,fst_bar_row) %>%
  bind_rows()
# arrange factor order ----------------
data$run <- refactor(data, globals)
grob_tibble$run <- refactor(grob_tibble, globals)
global_bar$run <- refactor(global_bar,globals)
global_bar <- global_bar %>% filter(grepl('may',run))

# scale for global fst bars ------------
bar_x <- tibble(xorg = c(0,max(globals$weighted)),
                x = rescale_fst(xorg),y = rep(.01,2))

# plotting --------------------
ys <- global_bar$ymax[1]
annoclr <- rgb(.4,.4,.4)

threshs <- data %>% group_by(run) %>% summarise(thresh=quantile(WEIGHTED_FST,.9999))

data_outlier <- data %>% left_join(.,threshs) %>%
  filter(grepl('LG',CHROM)) %>%
  mutate(OUTL = (WEIGHTED_FST>thresh) %>% as.numeric()) %>%
  filter(OUTL == 1 ) %>%
  select(CHROM,BIN_START,BIN_END,run,OUTL,GPOS)

#p1 <- ggplot()+
#   facet_grid( run~., as.table = TRUE)+
#   geom_hypo_LG()+
#   geom_vline(data = data_outlier, aes(xintercept = GPOS),
#              col = 'darkgray', lwd = .2)+
#   geom_hypo_grob(data = grob_tibble,
#                  aes(grob = grob, angle = angle, height = height, x = .95,y = .6),
#                  angle = 0, height = .5)+
#   geom_point(data = data, aes(x = GPOS, y = WEIGHTED_FST, col = run),size=.4) +
#   geom_segment(data = bar_x,aes(x = x, xend = x, y = -y, yend = ys+y), col = hypogen::hypo_clr_lg)+
#   geom_text(data = (bar_x %>% bind_cols(.,tibble(run = factor(rep('may-pue',2),
#                                                               levels = levels(globals$run))))),
#             aes(x = x-c(0,3*10^6),y=.6,label = round(xorg,3)),size=3,angle=-90)+
#   geom_rect_swap(data = global_bar,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,col=run),fill=NA)+
#   scale_fill_hypo_LG_bg() +
#   scale_x_hypo_LG(limits = c(0,6.3e+08),breaks = c((hypo_karyotype$GSTART + hypo_karyotype$GEND)/2,5.98e+08),
#                   labels = c(1:24,expression(global~italic('F'[ST]))))+
#   scale_y_continuous(name = expression(italic('F'[ST])),limits = c(-.1,1))+
#   scale_color_manual(values = clr)+
#   theme_hypo()+
#   theme(strip.text = element_blank(),
#         legend.position = 'none')


p1_1 <- ggplot()+
  facet_grid( run~., as.table = TRUE)+
  geom_hypo_LG()+
  geom_vline(data = data_outlier, aes(xintercept = GPOS),
             col = 'darkgray', lwd = .2)+
  geom_point(data = data, aes(x = GPOS, y = WEIGHTED_FST, col = run),size=.4) +
  scale_fill_hypo_LG_bg() +
  scale_x_hypo_LG(name = expression(global~italic('F'[ST])))+
  scale_y_continuous(name = expression(italic('F'[ST])),limits = c(-.1,1),
                     breaks = (0:4)/4, labels = format((0:4)/4))+
  scale_color_manual(values = clr)+
  theme_hypo()+
  theme(strip.text = element_blank(),
        legend.position = 'none',
        axis.title.x = element_text(color='transparent'))

x_fst <- seq(0,0.06,length.out = 5)[1:4]
p1_2 <- ggplot()+
  facet_grid( run~., as.table = TRUE)+
  geom_hypo_grob(data = grob_tibble,
                 aes(grob = grob, x = .5,y = .6),
                 angle = 0, height = .5)+
  geom_rect_swap(data = global_bar,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,col=run),fill=NA)+
  scale_x_continuous(name = expression(global~italic('F'[ST])),
                     limits = c(0,1),expand = c(0,0),
                     breaks = rescale_fst(x_fst),labels = x_fst,position = "top")+
  scale_y_continuous(sec.axis = sec_axis(~ . , name = "y2"),limits = c(-.1,1))+
  scale_color_manual(values = clr)+
  theme_bw(base_size = 10, base_family = "Helvetica") +
  theme(plot.background = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(), 
        #axis.title.x = element_blank(),
        axis.line = element_line(),
        axis.line.y = element_line(color = hypogen::hypo_clr_lg),
        axis.line.y.right = element_line(color = hypogen::hypo_clr_lg),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        strip.background = element_rect(fill = NA,color = hypo_clr_lg),
        legend.background = element_rect(fill = "transparent", 
                                         color = NA),
        legend.key = element_rect(fill = "transparent",color = NA),
        strip.text = element_blank(),
        legend.position = 'none')

#  ROH section -----------------------------

samps <- read.table(file = "sample_id.txt", sep = '\t', header = F) %>%
  rename(INDV = V1, ID = V2, POP = V3, Pop = V4) %>%
  select(ID,POP)
# --- ^ K_input ^ -------


roh_data <- read.table('out/ROH/gemplusbel_maf5_150kb_relaxed.hom', header = T) %>%
  mutate(CHROM = CHR %>% str_pad(width = 2,pad = '0') %>% str_c('LG',.)) %>%
  select(FID,CHROM,POS1,POS2) %>%
  mutate(ID=as.character(FID))%>%
  left_join(samps) %>% 
  select(-FID) %>%
  left_join(hypogen::hypo_chrom_start) %>%
  mutate(GPOS1 =  POS1 + GSTART,
         GPOS2 =  POS2 + GSTART)

roh_data_ranges <- roh_data %>%
  group_by(POP) %>%
  select(POP,GPOS1,GPOS2) %>%
  arrange(POP,GPOS1) %>%
  group_by(POP) %>%
  summarise(data = list(tibble(GPOS1=GPOS1,GPOS2=GPOS2))) %>%
  purrr::pmap(ranger_run)


merged_cov <- roh_data_ranges %>% 
  purrr::map(merge_prep) %>%
  purrr::reduce(c) %>%
  GRanges(seqnames = 'hypo',ranges = .,seqlengths = c('hypo' = hypogen::hypo_karyotype$GEND[24]))  %>%
  coverage()

combined_cov  <- roh_data_ranges %>%
  purrr::map(extract_cov) %>%
  bind_rows() 

p2_1 <- combined_cov %>%
  gather(key = 'TYPE',value = 'GPOS',start:end) %>%
  arrange(POP,GPOS,-as.numeric(factor(TYPE))) %>%
  ggplot(aes(x=GPOS,y=cov,col=POP))+
  geom_hypo_LG()+
  geom_path(alpha=.9,size=.2)+
  hypogen::scale_fill_hypo_LG_bg()+
  facet_grid(POP~.)+
  hypogen::scale_x_hypo_LG()+
  scale_y_continuous("ROH coverage (n haplotypes)",
                     breaks = (0:4)*2, labels = str_c('      ',(0:4)*2))+
  scale_color_manual(values = maycols_short)+
  theme_hypo(legend.position = 'none')+
  theme(strip.background = element_blank(),
        strip.text = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank())

grob_table_roh <- tibble(POP = combined_cov$POP %>% levels()) %>%
  left_join(.,match_df, by = c("POP" = "short")) %>%
  left_join(.,tibble(POP = maycols_short %>% names(),
                     circle_fill = maycols_short)) %>%
  set_names(.,nm = c('POP','species','circle_fill')) %>%
  pmap(.,plot_single)

grob_tibble_roh <- tibble( run = combined_cov$POP %>% levels(),
                       grob = grob_table_roh)


p2_2 <- ggplot()+
  facet_grid( run~., as.table = TRUE)+
  geom_hypo_grob(data = grob_tibble_roh,
                 aes(grob = grob, x = .5,y = .5),
                 angle = 0, height = 1, width = 1)+
  theme_bw(base_size = 10, base_family = "Helvetica") +
  theme(plot.background = element_blank(),
        panel.background = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(), 
        #axis.title.x = element_blank(),
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        strip.background = element_blank(),
        strip.text = element_blank(),
        legend.position = 'none')

#  ihh12 section -----------------------------


ihhdir <- 'out/ihh12/50kb/'

ihh_files <- dir(path = ihhdir, pattern = '*.txt.gz')

ihh_data <- ihh_files %>% purrr::map(get_ihh) %>% bind_rows()

p3_1 <- ggplot(ihh_data,aes( x = GPOS, y = AVG_iHH12/1000, col = RUN))+
  geom_hypo_LG()+
  geom_line()+
  scale_fill_hypo_LG_bg()+
  scale_color_manual(values = maycols_short)+
  scale_x_hypo_LG()+
  facet_grid(RUN~.)+
  scale_y_continuous(expression(iHH[12]~(x %.% 10^-3)))+
  theme_hypo(legend.position = 'none')+
  theme(strip.background = element_blank(),
        strip.text = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank())

# compose plot -----------------------
p1 <- cowplot::plot_grid(p1_1,p1_2,ncol = 2,align = 'h',rel_widths = c(1,.15))
p2 <- cowplot::plot_grid(p2_1,p2_2,ncol = 2,align = 'h',rel_widths = c(1,.15))
p3 <- cowplot::plot_grid(p3_1,p2_2,ncol = 2,align = 'h',rel_widths = c(1,.15))

p <- cowplot::plot_grid(p1,p2,p3,ncol = 1,labels = c('(a)','(b)','(c)'),label_size = 10)                                        

ggsave(p, filename = str_c(base_name,'fst_ROH_ihh12.png'),width = 297*.95,height = 85*.95*3,units = 'mm')

#====== create outlier table ==========================

# we want to create a .bed file that includes thee outlier windws exclusive to maya comparisons
data_bed <- data %>% left_join(.,threshs) %>%
  filter(grepl('LG',CHROM)) %>%
  mutate(OUTL = (WEIGHTED_FST>thresh) %>% as.numeric()) %>%
  filter(OUTL == 1 ) %>%
  select(CHROM,BIN_START,BIN_END,run,OUTL,GPOS) %>%
  spread(key = run, value = OUTL,fill = 0) %>%
  # we introduce columns that check if a window is an outlier anywhere,
  # in a maya comparison and in a non-maya comparison
  # window type: 1 = only maya, 2 = ony other, 3 = maya & other
  mutate(n_maya = (`may-pue`+`may-uni`+`may-nig`+`gem-may`),
         is_maya_outl =  (n_maya > 0) %>% as.numeric() ) %>% 
  select(CHROM:BIN_END,n_maya) %>%
  # next, we want to collapse overlapping windows
  group_by(CHROM) %>%
  # we check for overlap and create 'region' IDs
  mutate(check = 1-(lag(BIN_END,default = 0)>BIN_START),
         ID = str_c(CHROM,'_',cumsum(check),'_n',max(n_maya))) %>%
  ungroup() %>%
  # then we collapse the regions by ID
  group_by(ID) %>%
  summarise(CHROM = CHROM[1],
            BIN_START = min(BIN_START),
            BIN_END = max(BIN_END)) %>%
  select(CHROM:BIN_END,ID) %>%
  mutate_if(., is.numeric, as.integer)

data_bed %>%
  write_delim(x = .,
            path = 'out/tables/outlier.bed',
            col_names = FALSE,delim = '\t')

# we create a bed file from the hamlet annotation for intersection
purrr::map(str_c('LG',str_pad(c(4,8,9,12),width = 2,pad = 0)),annotab) %>%
  bind_rows() %>% write_delim(.,path = 'out/tables/part_anno.bed',
            col_names = FALSE,delim = '\t')

# quick run of bedtools intersect
system("bedtools intersect -a out/tables/part_anno.bed -b out/tables/outlier.bed > out/tables/outlier_intersect.bed", wait=FALSE)

genes <- read_delim('out/tables/outlier_intersect.bed',
                    delim = '\t',col_names = c('CHROM','START','END','GENE'))

# creating the template for the latex table
# for some reason this needs to be excuted interactively (works in Rstudio but breaks in Rscript)
genes %>%
  fuzzyjoin::fuzzy_join(data_bed,
                        by = c("CHROM" = "CHROM", "END" = "BIN_START", "START" = "BIN_END"),
                        match_fun = list(`==`, `>`,`<`)) %>%
  group_by(ID) %>%
  summarise(CHROM = CHROM.x[1],
            START = BIN_START[1],
            END = BIN_END[1],
            GENE_N = length(GENE),
            GENES = str_c(GENE,collapse = ', ')
            ) %>%
  ungroup() %>%
  separate(ID, into = c('chr_drop','NR','maya')) %>%
  mutate(COMPARISONS_N = str_remove(maya,'n')) %>%
  select(CHROM, NR, START, END, COMPARISONS_N, GENE_N, GENES) %>%
  export_2_latex(.,'out/tables/outlier_table.tex')
