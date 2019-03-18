library(tidyverse)
library(hypogen)

rand_window <- function(nr,width = 30000){
  LG <- runif(n = 1,min = 1,max = 25) %>% 
    floor() %>%
    str_pad(.,width = 2,pad = '0') %>%
    str_c('LG',.)
  
  tibble(NR = nr,
         CHROM = LG) %>%
    left_join(hypogen::hypo_karyotype) %>%
    select(NR,CHROM,LENGTH,GSTART) %>%
    mutate(SAMPLE_POINT = runif(n = 1,min = 1,max = LENGTH) %>% 
             floor(),
           WIDTH = min(width,LENGTH),
           RADIUS = WIDTH/2,
           START = ifelse(SAMPLE_POINT < RADIUS,0,
                          ifelse(SAMPLE_POINT > (LENGTH-RADIUS),LENGTH-WIDTH,SAMPLE_POINT-RADIUS)),
           END = ifelse(SAMPLE_POINT > (LENGTH-RADIUS),
                        LENGTH,
                        ifelse(SAMPLE_POINT < RADIUS,min(WIDTH,LENGTH),SAMPLE_POINT+RADIUS)),
           CHECK = END - START,
           GS = GSTART + START,
           GE = GSTART + END) 
}

set.seed(27678)

random_windows <- 1:200 %>% 
  purrr::map(rand_window,width = 30000) %>%
  bind_rows() %>%
  arrange(CHROM,START) %>%
  mutate(ORDER = row_number())


p <- random_windows %>%
  ggplot() +
  geom_hypo_LG()+
  scale_fill_hypo_LG_bg()+
  scale_color_viridis_c(guide=FALSE)+
  scale_x_hypo_LG()+
  theme_hypo()

p_ordered <- p + geom_segment(aes(x = GS,xend = GE,y = ORDER,yend=ORDER,color=NR),
                 arrow = arrow(length = unit(3,'pt'),type = 'closed'),size=1)

p_nr <- p + geom_segment(aes(x = GS,xend = GE,y = NR,yend=NR,color=NR),
                 arrow = arrow(length = unit(3,'pt'),type = 'closed'),size=1)

export_table <- random_windows %>%
  select(CHROM,START,END)

write_delim(export_table,path = '~/Desktop/random_hamlet_windows_30kb.txt',delim = '\t')

cowplot::plot_grid(p_nr,p_ordered,ncol = 1,align = 'v') %>%
  ggsave(plot = .,filename = '~/Desktop/ld_decay_windows.pdf',width = 12,height = 8)
