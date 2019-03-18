library(tidyverse)
data <- read_delim('out/fis/fis_summary.txt',delim = '\t')
maycols <- c("H. nigricans" ='#F8766D',
             "H. unicolor" = '#E76BF3',
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')
clr_hamlets <- tibble(clr = maycols, spec = names(maycols)) %>% arrange(spec)


data %>% ggplot(.,aes(x=pop, y= whg_avg_Fis,fill=pop))+
  geom_bar(stat='identity')+
  xlab('')+ylab(expression(italic(F[IS])~(weighted~mean)))+
  scale_fill_manual(values=clr_hamlets$clr)+theme(legend.position = 'none')

ggsave('~/Dropbox/maya_data/plots/fis.pdf')
