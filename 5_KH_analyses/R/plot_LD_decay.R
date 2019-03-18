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

pred_10 <- function(mod,span){
  predict(mod,newdata = c(distance = seq(0,30,by = .1))) %>% 
    as.data.frame() %>% 
    setNames(., nm = c("R^2"))  %>%
    mutate(distance = rownames(.) %>% str_remove(.,'distance') %>% as.numeric(),
           distance =  (distance-1) /10,
           span = span) %>%
    filter(!is.na(.$`R^2`))%>%
    as_tibble()
}

set.seed(27678)

random_windows <- 1:200 %>%
  purrr::map(rand_window,width = 30000) %>%
  bind_rows() %>%
  arrange(CHROM,START) %>%
  mutate(ORDER = row_number())


p1 <- random_windows %>%
  ggplot() +
  geom_hypo_LG()+
  geom_segment(aes(x = GS,xend = GE,y = 1,yend=1,color=NR),
               arrow = arrow(length = unit(3,'pt'),type = 'closed'),size=.2)+
  scale_fill_hypo_LG_bg()+
  scale_color_viridis_c(guide=FALSE)+
  scale_x_hypo_LG()+
  theme_hypo(axis.title.y = element_blank(),
             axis.text.y = element_blank(),
             axis.ticks.y = element_blank(),
             axis.line.y = element_blank(),
             axis.text.x = element_text(size=6))

lgclr <- rgb(.9,.9,.9)
annoclr <- rgb(.4,.4,.4)
secclr <- rgb(.75,.75,.75)
secclrLAB <- rgb(.45,.45,.45)
secScale <- 10

theme_gw <- theme(plot.margin = unit(c(2,5,2,0),'pt'),
                  panel.grid = element_blank(),
                  panel.spacing.y = unit(3,'pt'),
                  legend.position = 'none',
                  axis.title.x = element_blank(),
                  axis.ticks.y = element_line(color = annoclr),
                  axis.line.y =  element_line(color = annoclr),
                  axis.text.x = element_text(size=6),
                  axis.text.y = element_text(margin = unit(c(0,3,0,0),'pt'),size=6),
                  axis.title.y = element_text(vjust = -1,size=8),
                  axis.title.y.right = element_text(color=secclrLAB,size=8),
                  axis.text.y.right = element_text(color=secclrLAB,size=6),
                  strip.background = element_blank(),
                  strip.placement = "outside")

decay_path <- 'out/ld_decay/'
files_d <- dir(path = decay_path,pattern = 'txt.gz')
read_r2 <- function(file){read_delim(file = str_c(decay_path,file),delim = '\t')}
data_d <- files_d %>% purrr::map(.,read_r2) %>% 
  bind_rows() %>%
  mutate(distance = (POS2-POS1)/1000)

gr_size <- 1000
subset <- data_d %>% 
  select(distance, `R^2`) %>% 
  arrange(distance) %>%
  mutate(bin = (distance %/% 1.5)+1) %>%
  group_by(bin) %>%
  dplyr::sample_n(1000,replace = FALSE)

# subsample bins
#loessMod05 <- loess(`R^2` ~ distance, data=subset, span=0.05) 
loessMod10 <- loess(`R^2` ~ distance, data=subset, span=0.10) 
#loessMod25 <- loess(`R^2` ~ distance, data=subset, span=0.25)
#loessMod50 <- loess(`R^2` ~ distance, data=subset, span=0.50) 

#smoothed <- pred_10(loessMod05,0.05) %>%
#  bind_rows(pred_10(loessMod10,0.1))%>%
#  bind_rows(pred_10(loessMod25,0.25))%>%
#  bind_rows(pred_10(loessMod50,0.5)) 

smoothed <- pred_10(loessMod10,0.1)

p2 <- ggplot(data=data_d,aes(x=distance,y=`R^2`))+
  geom_hex(aes(fill=log10(..count..)),binwidth = c(.015*15,.015)) +
  #geom_line(data = smoothed,aes(y = `R^2`, color = factor(span)))+
  geom_line(data = smoothed,aes(y = `R^2`),col='red')+
 # geom_smooth(col='red',se=FALSE,size=.3,
#              method = 'gam', formula = y ~ s(x, bs = "cs"))+
  #scale_color_brewer("Smoothing span", palette = 'Set1')+
  scale_fill_gradient(name = expression(Count~(log[10])),
                      low = rgb(.9,.9,.9), high = "black")+
  guides(fill=guide_colorbar(direction = 'vertical',
                             title.position = 'right',barheight = unit(120,'pt'),barwidth = unit(10,'pt')))+
  scale_x_continuous(name = "Distance (kb)",expand = c(0,0))+
  scale_y_continuous(name = expression(Linkage~(r^2)),
                     expand = c(0.002,0.002))+
  theme_gw+
  theme(plot.background = element_blank(),
        panel.background  = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        plot.margin = unit(c(0,15,0,25),'pt'),
        axis.line =  element_line(color = annoclr),
        axis.text = element_text(size=6),
        axis.title.x = element_text(size=8),
        axis.title.y = element_text(size=8,vjust = 1),
        legend.title = element_text(size=8,angle=90),
        legend.text = element_text(size=6),
        legend.key.height = unit(4,'pt'),
        legend.position = 'right')


p <- cowplot::plot_grid(NULL,p1,NULL,p2,ncol = 1,rel_heights = c(.05,.15,.05,1),labels = c('(a)',"", '(b)',""),label_size = 10)
ggsave(plot = p,filename = 'out/plots/ld_decay.pdf',width = 183,height = 183/2,units = 'mm',device = cairo_pdf)

