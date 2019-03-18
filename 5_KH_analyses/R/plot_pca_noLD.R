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

samps <-read.table(file = "sample_id.txt", sep = '\t', header = F) %>%
  rename(ID = V1, INDV = V2, Species = V3, Pop = V4)

pca_scores <- read.table(gzfile('out/pca/belize_only.scores.txt.gz'), header = T) %>%
  rename(INDV = 'id') %>%
  left_join(samps)
levels(pca_scores$Species) <- c("H. gemma", "H. maya", "H. nigricans",
                                "H. puella", "H. unicolor")

pca_vars <- read.table(gzfile('out/pca/belize_only.exp_var.txt.gz'), header = T)

pca <- ggplot(pca_scores, aes(x = EV01, y = EV02, colour = Species)) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_colour_manual(name = "Species", values = maycols, drop = F) +
  labs(x = 'PC1 (2.5 %)', y = 'PC2 (2.4 %)') +
  guides(colour = F) +
  geom_point()

### Belize Only PCA ###

no_ld_scores <- read.table(gzfile('out/pca/belize_only_noLD.scores.txt.gz'), header = T) %>%
  rename(INDV = 'id') %>%
  left_join(samps)
levels(no_ld_scores$Species) <- c("H. gemma", "H. maya", "H. nigricans",
                                "H. puella", "H. unicolor")

no_ld_vars <- read.table(gzfile('out/pca/belize_only_noLD.exp_var.txt.gz'), header = T)

no_ld_pca <- ggplot(no_ld_scores, aes(x = EV01, y = EV02, colour = Species)) +
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


legend_grob_single <- hypo_legend_single(species = c('nigricans', 'unicolor', 'puella', 'maya'), 
                                         color_map = maycols[c(1:3,5)], ncol = 4, 
                                         circle_color = 'black', plot_names = TRUE, plot_name_size = 3) %>% 
  ggplotGrob()

top_plot <- plot_grid(pca, no_ld_pca, align = 'h', axis = 'b') + 
  draw_plot_label(c('(a)', '(b)'), x = c(0, 0.5), y = c(1,1), hjust = 0)

pca_plot <- plot_grid(top_plot, legend_grob_single, nrow = 2, rel_heights = c(0.9, 0.2))

# Separate plot of PCAs, not included in final manuscript          
ggsave("out/plots/pca_belize_noLD.pdf",plot = pca_plot, device = "pdf", width = 169, height = 100, units = "mm")
