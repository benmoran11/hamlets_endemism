library(tidyverse)
library(cowplot)
library(scico)
library(Hmisc)
library(hypoimg)

maycols <- c("H. nigricans" ='#F8766D', 
             "H. unicolor" = '#E76BF3', 
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')


# Joint VCFTools

samps <-read.table(file = "./0_data/sample_id.txt", sep = '\t', header = F) %>%
  rename(ID = V1, INDV = V2, Species = V3, Pop = V4)

jointvcftools <- read.table(file = "../2_output/bi-allelic_snps.het",
                          sep = '\t', header = T) %>%
  rename(Observed = O.HOM., Expected = E.HOM., Inb_coef = `F`) %>%
  left_join(samps) %>%
  mutate(prop.het = 1-Observed/N_SITES)
levels(jointvcftools$Species) <- c("H. gemma", "H. maya", "H. nigricans",
                                 "H. puella", "H. unicolor")

### Plot

jointhet <- ggplot(jointvcftools, aes(x = Species, y = Inb_coef, fill = Species)) +
  theme_bw()+
  theme(plot.margin = unit(c(0,0,0,0), unit = "mm"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title = element_text(face = 'italic'),
        panel.grid = element_blank(),
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.line.y = element_line(colour = 'black'),
        axis.line.x = element_blank()) +
  guides(fill = F) + 
  labs(y = expression(italic(F))) +
  geom_hline(yintercept = 0, lwd = 0.2) +
  geom_boxplot(lwd = 0.2, outlier.size = 0.5) +
  scale_fill_manual(name = "Species", values = maycols, drop = F) 

aggregate(Inb_coef ~ Species, jointvcftools, FUN = median)
aggregate(Inb_coef ~ Species, jointvcftools, FUN = mean)
aggregate(Inb_coef ~ Species, jointvcftools, FUN = function(x) sd(x)/sqrt(length(x)))


prophet <- ggplot(jointvcftools, aes(x = Species, y = prop.het, fill = Species)) +
  theme_bw()+
  theme(plot.margin = unit(c(0,0,0,0), unit = "mm"),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.line.y = element_line(colour = 'black'),
        axis.line.x = element_blank()) +
  guides(fill = F) + 
  labs(y = "Het.") +
  geom_boxplot(lwd = 0.2, outlier.size = 0.5) +
  scale_y_continuous(breaks = seq(0.16, 0.18, 0.005)) +
  scale_fill_manual(name = "Species", values = maycols, drop = F)

aggregate(prop.het ~ Species, jointvcftools, FUN = median)
aggregate(prop.het ~ Species, data = jointvcftools, FUN = function(x) quantile(x = x, 0.25))



### Relatedness

source('K_R/R/geom_tile_stupid.R')
vcf_samples <- 'K_R/vcf_samples.txt'
id_labs <- read_delim(vcf_samples, delim = '\t',col_names = c('ID1','spec')) %>% 
  mutate(order = str_c(spec,ID1))
id_labs2 <- id_labs %>%
  rename(ID2 = ID1, spec2 = spec)
  

relscores <- read.table('K_R/out/relatedness/gemplusbel_biallelic_filteredSNPs.kinship.txt',
                        header = T) %>%
  mutate(ID1 = factor(ID1,levels = id_labs$ID1[order(id_labs$order)]),
         ID2 = factor(ID2,levels = id_labs$ID1[order(id_labs$order)]),
         x_prep = as.numeric(ID1),y_prep = as.numeric(ID2),
         x = ifelse(x_prep < y_prep,x_prep,y_prep),
         y = ifelse(x_prep < y_prep,y_prep,x_prep),
         test = str_c(levels(ID1)[x],'-',levels(ID2)[y])) %>%
  select(-x_prep,-y_prep)

sumkin <- left_join(relscores, id_labs) %>%
  left_join(id_labs2, by = 'ID2') %>%
  mutate(comp = str_c(spec,'-',spec2))
aggregate(kinship_mle ~ comp, data = sumkin, FUN = mean)
aggregate(AJK ~ comp, data = sumkin, FUN = mean)

# Plotting Prep
spec_box <- id_labs %>% group_by(spec) %>% 
  count() %>% ungroup() %>%
  mutate(start = cumsum(lag(x = n,default = 0))+.6,
         end = start+n-.2)

whisker=.4
ybase = -.7  
clr <- unname(maycols[c(4,5,1,3,2)]) 

pMLE_AJK <- ggplot()+
  coord_equal()+
  # data 
  geom_tile(data = relscores, aes(x=x,y=y,fill=kinship_mle))+
  geom_tile_swap(data = relscores, aes(x=y,y=x,stupid=AJK))+
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
  scale_fill_distiller(name = 'MLE',type = 'seq', palette = 'Oranges',direction = 1) +
  scale_color_manual(values = clr, guide = FALSE)+
  scale_stupid_distiller(name = 'AJK',type = 'seq',palette = 'Blues',direction = 1)+
  scale_x_continuous(breaks = 1:length(levels(relscores$ID1)),
                     labels = levels(relscores$ID1),expand = c(0,0))+
  scale_y_continuous(breaks = 1:length(levels(relscores$ID1)),
                     labels = levels(relscores$ID1),expand = c(.022,0))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=-90),
        panel.grid = element_blank(),
        axis.title = element_blank())


ggsave('../6_output/relatedness_mle_ajk.pdf', 
       pMLE_AJK, device = 'pdf', width = 169, height = 169, units = 'mm')


## Dummy Plot of only MLE (just to extract with get_legend)

dummle <- ggplot()+
  geom_tile_swap(data = relscores, aes(x=y,y=x,fill=kinship_mle))+
  guides(fill = guide_colorbar(title.hjust = 0.5, order=1)) +
  scale_color_manual(values = clr, guide = FALSE)+
  scale_fill_distiller(name = expression(atop('MLE',italic(r))),type = 'seq',palette = 'Oranges',direction = 1) +
  theme_minimal()+
  theme(legend.position = 'bottom')
print(dummle)
diag_leg <- get_legend(dummle)

# Another Dummy plot, to get Species legend

diag_data <- tibble(x = c(1:51), y = c(1:51), spec = rep(spec_box$spec, times = spec_box$n))

dumbpoint <- ggplot(diag_data, aes(x = x, y = y, colour = spec)) +
  geom_point(shape = 'square') +
  guides(stupid = F, colour = guide_legend(title = 'Species', nrow = 2)) +
  scale_colour_manual(values = clr, labels = c('H. gemma', 'H. maya', 'H. nigricans',
                                             'H. puella', 'H. unicolor'))+
  theme_void() +
  theme(legend.position = 'bottom',
        legend.title = element_blank(),
        legend.text = element_text(size = 9, face = 'italic'),
        legend.key.size = unit(2, 'mm'),
        legend.spacing.x = unit(2, units = "mm"),
        legend.spacing.y = unit(2, units = "mm"),
        legend.key.height = unit(2, units = 'mm'))
print(dumbpoint)
spec_leg <- get_legend(dumbpoint)

## Make simplified triangle for rotatation

simp_tri <- ggplot()+
  coord_equal()+
  geom_tile_swap(data = relscores, aes(x=y,y=x,stupid=kinship_mle))+
  geom_tile(data = diag_data, aes(x=y,y=x,fill=spec))+
  guides(stupid = F) +
  scale_color_manual(values = clr, guide = FALSE)+
  scale_fill_manual(values = clr, guide = FALSE)+
  scale_stupid_distiller(name = 'MLE',type = 'seq',palette = 'Oranges',direction = 1)+
  scale_x_continuous(breaks = 1:length(levels(relscores$ID1)),
                     labels = levels(relscores$ID1),expand = c(0,0))+
  scale_y_continuous(breaks = 1:length(levels(relscores$ID1)),
                     labels = levels(relscores$ID1),expand = c(.022,0))+
  geom_text(data = spec_box,aes(x = (start+end)/2 - sqrt(2),y=(start+end)/2 + sqrt(2), angle = 45, label=spec, col=spec),
                            nudge_x = 0,nudge_y = 0,force = 0)+
  theme_void()

diag <- ggplotGrob(simp_tri)
rotated <- editGrob(diag, vp=viewport(x=0.5, y=0.95, angle=-45,width = .7), name="tri")

wleg <- ggdraw(rotated) + 
  draw_plot(prophet, x = 0.025, y = 0.12, width = 0.4, height = 0.45) +
  draw_plot(jointhet, x = .62, y = 0.12, width = 0.38, height = 0.45) +
  draw_plot(diag_leg, x = 0.15, y = 0.0, width = 0.1, height = 0.1, scale = 0.2) +
  draw_plot(spec_leg, x = 0.485, y = 0.01, width = 0.40, height = 0.1) +
  draw_plot_label(c("(a)", "(b)", "(c)"), c(.03, .03, 0.62), c(0.85, 0.6, 0.6), hjust = 0)

ggsave('../6_output/inbhetrel_stats.pdf', 
       wleg, device = 'pdf', width = 112, height = 120, units = 'mm')



### Nucleotide Diversity Pi

maypi_10kb <- read.table(gzfile('../2_output/2.2_pi/pi.maybel-10kb.windowed.pi.gz'),
                         sep = '\t', header = T) %>%
  mutate(Species = 'H. maya')
puepi_10kb <- read.table(gzfile('../2_output/2.2_pi/pi.puebel-10kb.windowed.pi.gz'),
                         sep = '\t', header = T) %>%
  mutate(Species = 'H. puella')
nigpi_10kb <- read.table(gzfile('../2_output/2.2_pi/pi.nigbel-10kb.windowed.pi.gz'),
                         sep = '\t', header = T) %>%
  mutate(Species = 'H. nigricans')
unipi_10kb <- read.table(gzfile('../2_output/2.2_pi/pi.unibel-10kb.windowed.pi.gz'),
                         sep = '\t', header = T) %>%
  mutate(Species = 'H. unicolor')
gempi_10kb <- read.table(gzfile('../2_output/2.2_pi/pi.gemflo-10kb.windowed.pi.gz'),
                         sep = '\t', header = T) %>%
  mutate(Species = 'H. gemma')

pi_10kb <- rbind(maypi_10kb, puepi_10kb, nigpi_10kb, unipi_10kb, gempi_10kb)

pi_plot <- ggplot(pi_10kb, aes(x = Species, y = PI, fill = Species)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = 'black')) +
  guides(fill = F) +
  scale_fill_manual(values = maycols) +
  scale_y_continuous(breaks = c(0, 0.005, 0.010), 
                     labels = c("0.000", "0.005", "0.010")) +
  coord_cartesian(xlim= c(0.375, 5.625), ylim = c(0, 0.015), expand = F) +
  labs(y = expression(italic(pi))) + 
  geom_boxplot() 

ggsave('../6_output/pi_plot.pdf',
       pi_plot, device = 'pdf', width = 80, height = 80, units = 'mm')

aggregate(PI ~ Species, data = pi_10kb, FUN = median)
aggregate(PI ~ Species, data = pi_10kb, FUN = IQR)
aggregate(PI ~ Species, data = pi_10kb, FUN = mean)
aggregate(PI ~ Species, data = pi_10kb, FUN = function(x) sd(x)/length(x))



### Gemplusbel PCA ###

pca_scores <- read.table('gemplusbel_biallelic_filteredSNPs.scores.txt', header = T) %>%
  rename(INDV = 'id') %>%
  left_join(samps)
levels(pca_scores$Species) <- c("H. gemma", "H. maya", "H. nigricans",
                          "H. puella", "H. unicolor")

pca_vars <- read.table('gemplusbel_biallelic_filteredSNPs.exp_var.txt', header = T)

pca <- ggplot(pca_scores, aes(x = EV01, y = EV02, colour = Species)) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_colour_manual(name = "Species", values = maycols, drop = F) +
  labs(x = 'PC1 (2.5 %)', y = 'PC2 (2.3 %)') +
  guides(colour = F) +
  geom_point()


### Belize Only PCA ###

bel_scores <- read.table('belize_only.scores.txt', header = T) %>%
  rename(INDV = 'id') %>%
  left_join(samps)
levels(bel_scores$Species) <- c("H. gemma", "H. maya", "H. nigricans",
                                "H. puella", "H. unicolor")

bel_vars <- read.table('belize_only.exp_var.txt', header = T)

bel_pca <- ggplot(bel_scores, aes(x = EV01, y = EV02, colour = Species)) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_colour_manual(name = "Species", values = maycols, drop = F) +
  labs(x = 'PC1 (2.5 %)', y = 'PC2 (2.4 %)') +
  guides(colour = F) +
  geom_point()


################# Legends ########################
hypo_anno_single <- function (species, circle_color = NA, circle_fill = "white", 
                              circle_lwd = 0.8, plot_names = FALSE, plot_name_size = 3, 
                              font_family = "sans", ...) 
{
  stopifnot(length(species) == 1)
  stopifnot(length(plot_names) == 1)
  stopifnot(is.logical(plot_names))
  stopifnot(is.character(species))
  stopifnot(species %in% hypo_img$spec)
  nr_species <- which(hypo_img$spec == species)
  p <- ggplot() + 
    ggforce::geom_circle(data = tibble(x = 0, y = 0, r = 0.28), aes(x0 = x, y0 = y, r = r), 
                         fill = circle_fill, color = circle_color, lwd = circle_lwd) + 
    coord_fixed(xlim = c(-1,1)) + 
    theme_void() + 
    scale_x_continuous(expand = c(0,0)) + 
    scale_y_continuous(limits = c(-0.5, 0.5)) + 
    annotation_custom(hypo_img$l[[nr_species]], xmin = -0.45, xmax = 0.45, ymin = -Inf, ymax = Inf)
  if (plot_names) {
    names_df <- tibble(name = str_c("italic(H.~", species, 
                                    ")"), x = 0, y = -0.45)
    p_names <- p + geom_text(data = names_df, aes(x = x, y = y, label = name), 
                             size = plot_name_size, parse = TRUE, family = font_family)
    return(p_names)
  }
  else {
    return(p)
  }
}

hypo_legend_single <- function (species, color_map, circle_color = NA, circle_lwd = 0.5,
plot_names = FALSE, plot_name_size = 3, font_family = "sans",
ncol = 1, plot = TRUE)
{
n <- length(species)
stopifnot(n > 0)
stopifnot(length(color_map) == n)
stopifnot(is.character(species))
legend_df <- tibble(species = species, circle_fill = color_map,
circle_color = rep(circle_color, n), circle_lwd = rep(circle_lwd,
n), plot_names = rep(plot_names, n), plot_name_size = rep(plot_name_size,
n), font_family = rep(font_family, n))
legend_list <- legend_df %>% purrr::pmap(hypo_anno_single)
if (plot == TRUE) {
out <- cowplot::plot_grid(plotlist = legend_list, ncol = ncol,
align = "v")
return(out)
}
else {
return(legend_list)
}
}


######


legend_grob_single <- hypo_legend_single(species = c('nigricans', 'unicolor', 'puella', 'gemma', 'maya'), 
                                         color_map = maycols, ncol = 5, 
                                         circle_color = 'black', plot_names = TRUE, plot_name_size = 3) %>% 
    ggplotGrob()

top_plot <- plot_grid(pca, bel_pca, align = 'h', axis = 'b') + 
  draw_plot_label(c('(a)', '(b)'), x = c(0, 0.5), y = c(1,1), hjust = 0)

div_plot <- plot_grid(top_plot, legend_grob_single, nrow = 2, rel_heights = c(0.9, 0.2))

ggsave("../6_output/diverge_pcas.pdf",
       plot = div_plot, device = "pdf", width = 169, height = 100, units = "mm")
