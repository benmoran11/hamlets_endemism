#!/usr/bin/env Rscript
library(tidyverse)
library(hypogen)
library(hypoimg)
library(stringr)

source('R/geom_rect_swap.R')
source('R/fst_functions.R')

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

p1 <- ggplot()+
   facet_grid( run~., as.table = TRUE)+
   geom_hypo_LG()+
   geom_vline(data = data_outlier, aes(xintercept = GPOS),
              col = 'darkgray', lwd = .2)+
   geom_hypo_grob(data = grob_tibble,
                  aes(grob = grob, angle = angle, height = height, x = .95,y = .6),
                  angle = 0, height = .5)+
   geom_point(data = data, aes(x = GPOS, y = WEIGHTED_FST, col = run),size=.4) +
   geom_segment(data = bar_x,aes(x = x, xend = x, y = -y, yend = ys+y), col = hypogen::hypo_clr_lg)+
   geom_text(data = (bar_x %>% bind_cols(.,tibble(run = factor(rep('may-pue',2),
                                                               levels = levels(globals$run))))),
             aes(x = x-c(0,3*10^6),y=.6,label = round(xorg,3)),size=3,angle=-90)+
   geom_rect_swap(data = global_bar,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,col=run),fill=NA)+
   scale_fill_hypo_LG_bg() +
   scale_x_hypo_LG(limits = c(0,6.3e+08),breaks = c((hypo_karyotype$GSTART + hypo_karyotype$GEND)/2,5.98e+08),
                   labels = c(1:24,expression(global~italic('F'[ST]))))+
   scale_y_continuous(name = expression(italic('F'[ST])),limits = c(-.1,1))+
   scale_color_manual(values = clr)+
   theme_hypo()+
   theme(strip.text = element_blank(),
         legend.position = 'none')

ggsave(p1, filename = str_c(base_name,'maya_only.png'),width = 297*.95,height = 85*.95,units = 'mm')

#====== create outlier table ==========================
# here all comparisons need to be considered, thus:
# 1) the runs are updated
runs_all <- tibble(file = dir(path = base_dir, pattern = '*50k')) %>%
  mutate(pops = str_sub(file,1,7)) %>%
  separate(pops,into = c('pop1','pop2'))

# 2) the data is updated
data_all <- pmap(runs_all,get_data,base_dir=base_dir) %>%
  bind_rows() %>%
  filter(!grepl('Contig',CHROM))

# 3) the thersholds are updated
threshs_all <- data_all %>% group_by(run) %>% summarise(thresh=quantile(WEIGHTED_FST,.9999))

# we want to create a .bed file that includes thee outlier windws exclusive to maya comparisons
data_bed <- data_all %>% left_join(.,threshs_all) %>%
  filter(grepl('LG',CHROM)) %>%
  mutate(OUTL = (WEIGHTED_FST>thresh) %>% as.numeric()) %>%
  filter(OUTL == 1 ) %>%
  select(CHROM,BIN_START,BIN_END,run,OUTL,GPOS) %>%
  spread(key = run, value = OUTL,fill = 0) %>%
  # we introduce columns that check if a window is an outlier anywhere,
  # in a maya comparison and in a non-maya comparison
  # window type: 1 = only maya, 2 = ony other, 3 = maya & other
  mutate(sum_maya =  `may-pue`+`may-uni`+`may-nig`+`gem-may`,
         sum_other = `pue-uni`+`nig-uni`+`nig-pue`+`gem-uni`+`gem-pue`+`gem-nig`,
         window_type = (sum_maya>0) + 2*(sum_other>0))%>%
  select(CHROM:BIN_END,window_type) %>%
  # we select exclusve maya outliers
  filter(window_type == 1) %>%
  # next, we want to collapse overlapping windows
  group_by(CHROM) %>%
  # we check for overlap and create 'region' IDs
  mutate(check = 1-(lag(BIN_END,default = 0)>BIN_START),
         ID = str_c(CHROM,'_',cumsum(check))) %>%
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
            SART = BIN_START[1],
            END = BIN_END[1],
            GENE_N = length(GENE),
            GENES = str_c(GENE,collapse = ', ')
            ) %>%
  export_2_latex(.,'out/tables/outlier_table.tex')
