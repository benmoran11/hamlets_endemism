library(ggplot2)
library(tidyverse)
library(reshape2)
library(cowplot)

maycols <- c("H. nigricans" ='#F8766D', 
             "H. unicolor" = '#E76BF3', 
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')

mu <- 3.7e-8
gen <- 1


maybel_smcpp_withpeaks <- read.csv("../3_output/3.12_smcpp_graphs/allmaybel_estimate.withpeaks.plot.csv") %>%
  mutate(Peaks = "Unmasked")
gemflo_smcpp_withpeaks <- read.csv("../3_output/3.12_smcpp_graphs/allgemflo_estimate.withpeaks.plot.csv") %>%
  mutate(Peaks = "Unmasked")
nigbel_smcpp_withpeaks <- read.csv("../3_output/3.12_smcpp_graphs/allnigbel_estimate.withpeaks.plot.csv") %>%
  mutate(Peaks = "Unmasked")
puebel_smcpp_withpeaks <- read.csv("../3_output/3.12_smcpp_graphs/allpuebel_estimate.withpeaks.plot.csv") %>%
  mutate(Peaks = "Unmasked")
unibel_smcpp_withpeaks <- read.csv("../3_output/3.12_smcpp_graphs/allunibel_estimate.withpeaks.plot.csv") %>%
  mutate(Peaks = "Unmasked")
maybel_smcpp_nopeaks <- read.csv("../3_output/3.12_smcpp_graphs/allmaybel_estimate.nopeaks.plot.csv") %>%
  mutate(Peaks = "Masked")
gemflo_smcpp_nopeaks <- read.csv("../3_output/3.12_smcpp_graphs/allgemflo_estimate.nopeaks.plot.csv") %>%
  mutate(Peaks = "Masked")
nigbel_smcpp_nopeaks <- read.csv("../3_output/3.12_smcpp_graphs/allnigbel_estimate.nopeaks.plot.csv") %>%
  mutate(Peaks = "Masked")
puebel_smcpp_nopeaks <- read.csv("../3_output/3.12_smcpp_graphs/allpuebel_estimate.nopeaks.plot.csv") %>%
  mutate(Peaks = "Masked")
unibel_smcpp_nopeaks <- read.csv("../3_output/3.12_smcpp_graphs/allunibel_estimate.nopeaks.plot.csv") %>%
  mutate(Peaks = "Masked")
sfinal <- rbind(maybel_smcpp_withpeaks, gemflo_smcpp_withpeaks, nigbel_smcpp_withpeaks, puebel_smcpp_withpeaks, unibel_smcpp_withpeaks,
                maybel_smcpp_nopeaks, gemflo_smcpp_nopeaks, nigbel_smcpp_nopeaks, puebel_smcpp_nopeaks, unibel_smcpp_nopeaks)
sfinal <- sfinal %>%
  mutate(YBP = x * gen, 
         Ne = y, 
         Species = as.factor(sfinal$label),
         Run = as.factor(sfinal$label)) %>%
  filter(x >= 1000)
levels(sfinal$Species) <- c("H. maya", "H. gemma", "H. nigricans", "H. puella",  "H. unicolor")

smcpp_plot <- ggplot(sfinal, aes(x=YBP, y=Ne, colour = Species)) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.direction = "horizontal",
        legend.position = c(0.6,0.6),
        legend.justification = c(0.5,0.5),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 12, face = 'italic')) +
  facet_grid(Peaks~.) +
  scale_x_log10(labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  annotation_logticks() +
  guides(colour = guide_legend(title.position = "top",
                               override.aes = list(alpha = 1, size=1),
                               title.hjust = 0.5, 
                               nrow = 2, byrow=TRUE)) +
  coord_cartesian(xlim = c(1000,100000), ylim = c(1000, 100000), expand = F) +
  labs(x="Generations Before Present", y = "Effective Population Size") +
  scale_y_log10(labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  scale_color_manual(values = maycols) +
  geom_line()

ggsave(filename = "../5_output/gemplusbel_smcpp.pdf", 
              plot=smcpp_plot, device = "pdf", width = 169, height = 120, units = "mm")


