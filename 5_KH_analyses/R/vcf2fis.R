#!/usr/bin/env Rscript
# ===============================================================
# This script used the package hierfstat to compute the Fis for
# all specified populationson within a given VCF file.
# ---------------------------------------------------------------
# The produced output contains:
# - 1 plot (fis boxplot by population)
# - 1 table (fis statistcs by population)
# ===============================================================
# args = c('maya_head.vcf.gz', 'vcf_samples.txt', 'test_fis')
args = commandArgs(trailingOnly=FALSE)
args = args[7:9]
print(args)

vcf_file <- as.character(args[1])
vcf_samples <- as.character(args[2])
base_name = as.character(args[3])

library(adegenet)
library(vcfR)
library(hierfstat)

library(dplyr)
library(ggplot2)
library(purrr)
library(tibble)
library(stringr)
library(tidyr)
library(readr)

get_fis <- function(data,pops){
  base_Stats <- basic.stats(data)$Fis
  rn <- base_Stats %>% rownames()
  base_Stats %>%
    as_tibble() %>%
    mutate(rn = rn) %>%
    separate(rn, into = c("CHROM","POS"),convert = TRUE) %>%
    select(CHROM,POS,pops) %>%
    gather(key = 'POP',
           value = 'FIS',
           3:(2+length(pops)))
}

outpop <- function(x,label){
  x_ul <- unlist(x)
  tibble(POP = rep(label,length(x_ul)), y = x_ul)
}

darken <- function(color, factor=.4){
  col <- col2rgb(color)
  col <- col*factor
  col <- rgb(t(col), maxColorValue=255)
  col
}

POP <- read_delim(vcf_samples,delim = '\t',col_names = c('ID','POP'))$POP
pops <- POP %>% factor() %>% levels()
#pops <- str_c("P0",1:6)
bw = .4
maycols <- c("H. nigricans" ='#F8766D',
             "H. unicolor" = '#E76BF3',
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')

clr_hamlets <- tibble(clr = maycols, spec = names(maycols)) %>% arrange(spec)

vcf <- read.vcfR(vcf_file)
data <-  vcfR2genind(vcf)
data@pop <- factor(POP)

summary_fis <- get_fis(data,pops = pops) %>%
  group_by(POP) %>%
  summarise(mean_fis = mean(FIS,na.rm = TRUE),
            median_fis = median(FIS,na.rm = TRUE),
            sts = list(boxplot.stats(na.omit(FIS))$stats),
            outl = list(na.omit(FIS)[(na.omit(FIS) > boxplot.stats(na.omit(FIS))$stats[5] ) | (na.omit(FIS) < boxplot.stats(na.omit(FIS))$stats[1] ) ])) %>%
  rowwise() %>%
  mutate(lw = unlist(sts)[1],
         hw = unlist(sts)[5],
         lh = unlist(sts)[2],
         hh = unlist(sts)[4],
         mid = unlist(sts)[3]) %>%
  ungroup() %>%
  mutate(x = as.numeric(as.factor(POP)))

sum_outl <- purrr::map2(summary_fis$outl,summary_fis$POP,outpop) %>% bind_rows() %>%
  mutate(x = as.numeric(factor(POP,levels=pops)))

legend_expressions <- sapply(str_c('H. ',summary_fis$POP,c('ma','a','ricans','lla','color')),
                             function(i) {as.expression(substitute(italic(B),list(B = as.name(i))))})

p1 <- summary_fis %>%
  ggplot(.)+
  geom_point(data=sum_outl,aes(x=x,y=y,col=POP,fill=POP),alpha=.4,shape=21)+
  geom_segment(aes(x = x,xend = x, y = lw, yend = hw))+
  geom_rect(aes(xmin=x-bw,
                xmax=x+bw,
                ymin=lh,ymax=hh,
                fill=POP,col=POP))+
  geom_point(aes(x=x,y=mean_fis),size=2)+
  geom_segment(aes(x = x-bw,xend = x+bw, y = median_fis, yend = median_fis))+
  scale_x_continuous(breaks = summary_fis$x,
                     labels = legend_expressions)+
  scale_y_continuous(name = expression(italic('F'[IS])))+
  scale_fill_manual(values = clr_hamlets$clr,guide = FALSE)+
  scale_color_manual(values = darken(clr_hamlets$clr,.5),guide = FALSE)+
  theme_bw(base_size = 10, base_family = "Helvetica")+
  theme(axis.title.x = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        plot.background = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(),axis.text.x = element_text())

ggsave(p1 ,filename = str_c(base_name,'_boxplot.pdf'), width = 6, height = 8, device = cairo_pdf)

summary_fis %>%
  select(POP:median_fis,lw:hh) %>%
  write_delim(., path = str_c(base_name,'_summary.txt'), delim = '\t')
