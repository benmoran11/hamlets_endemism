library(tidyverse)
library(reshape2)
library(scales)

maycols <- c("H. nigricans" ='#F8766D', 
               "H. unicolor" = '#E76BF3', 
               "H. puella" = '#00BF7D',
               "H. gemma" = '#00B0F6',
               "H. maya" = '#A3A500')

mu <- 3.7e-8
gen <- 1

may484 <- read.table("../3_output/3.7_msmc/maybel1.msmc2.final.txt", 
                     header=TRUE)
may371 <- read.table("../3_output/3.7_msmc/maybel2.msmc2.final.txt", 
                     header=TRUE)
may285 <- read.table("../3_output/3.7_msmc/maybel3.msmc2.final.txt", 
                     header=TRUE)
nigbel1 <- read.table("../3_output/3.7_msmc/nigbel1.msmc2.final.txt", 
                      header=TRUE)
nigbel2 <- read.table("../3_output/3.7_msmc/nigbel2.msmc2.final.txt", 
                      header=TRUE)
nigbel3 <- read.table("../3_output/3.7_msmc/nigbel3.msmc2.final.txt", 
                      header=TRUE)
puebel1 <- read.table("../3_output/3.7_msmc/puebel1.msmc2.final.txt", 
                      header=TRUE)
puebel2 <- read.table("../3_output/3.7_msmc/puebel2.msmc2.final.txt", 
                      header=TRUE)
puebel3 <- read.table("../3_output/3.7_msmc/puebel3.msmc2.final.txt", 
                      header=TRUE)
unibel1 <- read.table("../3_output/3.7_msmc/unibel1.msmc2.final.txt", 
                      header=TRUE)
unibel2 <- read.table("../3_output/3.7_msmc/unibel2.msmc2.final.txt", 
                      header=TRUE)
unibel3 <- read.table("../3_output/3.7_msmc/unibel3.msmc2.final.txt", 
                      header=TRUE)
gemflo1 <- read.table("../3_output/3.7_msmc/gemflo1.msmc2.final.txt", 
                      header=TRUE)

may484_noFstPeaks <- read.table("../3_output/3.7_msmc/may484.noFstPeaks.msmc2.final.txt", 
                     header=TRUE)
may371_noFstPeaks <- read.table("../3_output/3.7_msmc/may371.noFstPeaks.msmc2.final.txt", 
                     header=TRUE)
may285_noFstPeaks <- read.table("../3_output/3.7_msmc/may285.noFstPeaks.msmc2.final.txt", 
                     header=TRUE)
nigbel1_noFstPeaks <- read.table("../3_output/3.7_msmc/nigbel1.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
nigbel2_noFstPeaks <- read.table("../3_output/3.7_msmc/nigbel2.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
nigbel3_noFstPeaks <- read.table("../3_output/3.7_msmc/nigbel3.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
puebel1_noFstPeaks <- read.table("../3_output/3.7_msmc/puebel1.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
puebel2_noFstPeaks <- read.table("../3_output/3.7_msmc/puebel2.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
puebel3_noFstPeaks <- read.table("../3_output/3.7_msmc/puebel3.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
unibel1_noFstPeaks <- read.table("../3_output/3.7_msmc/unibel1.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
unibel2_noFstPeaks <- read.table("../3_output/3.7_msmc/unibel2.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
unibel3_noFstPeaks <- read.table("../3_output/3.7_msmc/unibel3.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
gemflo1_noFstPeaks <- read.table("../3_output/3.7_msmc/gemflo1.noFstPeaks.msmc2.final.txt", 
                      header=TRUE)
gmay484 <- gather(may484, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 8,
         Species = "maya",
         Peaks = "Unmasked",
         Run = "Maya 484 Unmasked")
gmay371 <- gather(may371, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 6,
         Species = "maya",
         Peaks = "Unmasked", 
         Run = "Maya 371 Unmasked")
gmay285 <- gather(may285, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 6,
         Species = "maya",
         Peaks = "Unmasked", 
         Run = "Maya 285 Unmasked")
gnigbel1 <- gather(nigbel1, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Unmasked",
         Run = "Black 1 Unmasked")
gnigbel2 <- gather(nigbel2, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Unmasked",
         Run = "Black 2 Unmasked")
gnigbel3 <- gather(nigbel3, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Unmasked",
         Run = "Black 3 Unmasked")
gpuebel1 <- gather(puebel1, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Unmasked",
         Run = "Barred 1 Unmasked")
gpuebel2 <- gather(puebel2, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Unmasked",
         Run = "Barred 2 Unmasked")
gpuebel3 <- gather(puebel3, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu, 
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Unmasked",
         Run = "Barred 3 Unmasked")
gunibel1 <- gather(unibel1, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Unmasked",
         Run = "Butter 1 Unmasked")
gunibel2 <- gather(unibel2, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Unmasked",
         Run = "Butter 2 Unmasked")
gunibel3 <- gather(unibel3, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Unmasked",
         Run = "Butter 3 Unmasked")
ggemflo1 <- gather(gemflo1, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "gemma",
         Peaks = "Unmasked",
         Run = "Blue 1 Unmasked")

gmay484_noFstPeaks <- gather(may484_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 8,
         Species = "maya",
         Peaks = "Masked", 
         Run = "Maya 484 Masked")
gmay371_noFstPeaks <- gather(may371_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 6,
         Species = "maya",
         Peaks = "Masked", 
         Run = "Maya 371 Masked")
gmay285_noFstPeaks <- gather(may285_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen, 
         Ne = (1/lambda)/mu, 
         N_haplotypes = 6,
         Species = "maya",
         Peaks = "Masked", 
         Run = "Maya 285 Masked")
gnigbel1_noFstPeaks <- gather(nigbel1_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Masked",
         Run = "Black 1 Masked")
gnigbel2_noFstPeaks <- gather(nigbel2_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Masked",
         Run = "Black 2 Masked")
gnigbel3_noFstPeaks <- gather(nigbel3_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "nigricans",
         Peaks = "Masked",
         Run = "Black 3 Masked")
gpuebel1_noFstPeaks <- gather(puebel1_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Masked",
         Run = "Barred 1 Masked")
gpuebel2_noFstPeaks <- gather(puebel2_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Masked",
         Run = "Barred 2 Masked")
gpuebel3_noFstPeaks <- gather(puebel3_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu, 
         N_haplotypes = 8,
         Species = "puella",
         Peaks = "Masked",
         Run = "Barred 3 Masked")
gunibel1_noFstPeaks <- gather(unibel1_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Masked",
         Run = "Butter 1 Masked")
gunibel2_noFstPeaks <- gather(unibel2_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Masked",
         Run = "Butter 2 Masked")
gunibel3_noFstPeaks <- gather(unibel3_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "unicolor",
         Peaks = "Masked",
         Run = "Butter 3 Masked")
ggemflo1_noFstPeaks <- gather(gemflo1_noFstPeaks, "Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Ne = (1/lambda)/mu,
         N_haplotypes = 8,
         Species = "gemma",
         Peaks = "Masked",
         Run = "Blue 1 Masked")
gfinal <- rbind(gnigbel1, gnigbel2, gnigbel3, gpuebel1, gpuebel2, gpuebel3,
                gunibel1, gunibel2, gunibel3, gmay484, gmay371, gmay285, ggemflo1,
                gnigbel1_noFstPeaks, gnigbel2_noFstPeaks, gnigbel3_noFstPeaks, 
                gpuebel1_noFstPeaks, gpuebel2_noFstPeaks, gpuebel3_noFstPeaks,
                gunibel1_noFstPeaks, gunibel2_noFstPeaks, gunibel3_noFstPeaks, 
                gmay484_noFstPeaks, gmay371_noFstPeaks, gmay285_noFstPeaks, 
                ggemflo1_noFstPeaks)
gfinal$Species <- factor(gfinal$Species, levels = c("nigricans", "unicolor", "puella", "gemma","maya"))
levels(gfinal$Species) <- c("H. nigricans", "H. unicolor", "H. puella", "H. gemma", "H. maya")

gpretty <- filter(gfinal, !time_index %in% c(0:2,29:31))
pretty <- ggplot(filter(gpretty, Peaks == "Masked"), aes(x=YBP, y=Ne, group = Run, colour = Species)) +
  #facet_wrap(~ Peaks) +
  theme_bw()+
  coord_cartesian(ylim = c(8000, 400000)) +
  guides(colour = guide_legend(title.position = "top",
                               override.aes = list(alpha = 1, size=1),
                               nrow = 2, byrow=TRUE)) +
  theme(panel.grid = element_blank(),
        axis.text.x.top = element_text(size = 12, vjust = 2),
        axis.text.x.bottom = element_text(size = 12, vjust = -1),
        axis.text.y.left = element_text(size = 12, #hjust = 0,
                                        margin = margin(0,7,0,10)),
        axis.title = element_text(size = 14),
        legend.direction = "horizontal",
        legend.position = c(0.25,0.1),
        legend.justification = c(0,0),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 12, face = 'italic'))+ 
  scale_color_manual(values = maycols) +
  scale_x_log10(labels = scales::trans_format("log10", scales::math_format(10^.x)),
                sec.axis = sec_axis(~log10(.),
                                    breaks = c(3, 4, 5),
                                    labels = c("1-3 kya", "10-30 kya", "100-300 kya"), 
                                    name="Years Before Present\n")) +
  annotation_logticks(sides="tbl") +
  scale_y_log10(labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  labs(x="\nGenerations Before Present", y = "Effective Population Size") +
  geom_line(alpha=.75)

ggsave(filename = "../5_output/gemplusbel_msmc2_trimmed.pdf", 
       plot=pretty, device = "pdf", width = 169, height = 120, units = "mm")


full_plot <- ggplot(filter(gfinal, Peaks == "Masked"), aes(x=YBP, y=Ne, group = Run, colour = Species)) +
  #facet_wrap(~ Peaks) +
  theme_bw()+
  coord_cartesian(xlim = c(40,2000000), ylim= c(5000, 200000000),expand = F) +
  guides(colour = guide_legend(title.position = "top",
                               override.aes = list(alpha = 1, size=1),
                               title.hjust = 0.5, 
                               nrow = 2, byrow=TRUE)) +
  theme(panel.grid = element_blank(),
        axis.text.x.top = element_text(size = 12, vjust = 2),
        axis.text.x.bottom = element_text(size = 12, vjust = -1),
        axis.text.y.left = element_text(size = 12, #hjust = 0,
                                        margin = margin(0,7,0,10)),
        axis.title = element_text(size = 14),
        legend.direction = "horizontal",
        legend.position = c(0.6,0.8),
        legend.justification = c(0.5,0.5),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 12, face = 'italic'))+
  scale_color_manual(values = maycols) +
  scale_x_log10(labels = scales::trans_format("log10", scales::math_format(10^.x)),
                sec.axis = sec_axis(~log10(.),
                                    breaks = c(2, 3, 4, 5, 6),
                                    labels = c("100-300 ya", "1-3 kya", "10-30 kya", "100-300 kya", "1-3 mya"), 
                                    name="Years Before Present\n")) +
  annotation_logticks(sides="tbl") +
  scale_y_log10(labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  labs(x="\nGenerations Before Present", y = "Effective Population Size") +
  geom_line(alpha=.75)

ggsave(filename = "../5_output/gemplusbel_msmc2_full.pdf", 
       plot=full_plot, device = "pdf", width = 169, height = 120, units = "mm")

unmasked_plot <- ggplot(filter(gfinal, Peaks == "Unmasked"), aes(x=YBP, y=Ne, group = Run, colour = Species)) +
  #facet_wrap(~ Peaks) +
  theme_bw()+
  coord_cartesian(xlim = c(40,2000000), ylim= c(5000, 200000000),expand = F) +
  guides(colour = guide_legend(title.position = "top",
                               override.aes = list(alpha = 1, size=1),
                               title.hjust = 0.5, 
                               nrow = 2, byrow=TRUE)) +
  theme(panel.grid = element_blank(),
        axis.text.x.top = element_text(size = 12, vjust = 2),
        axis.text.x.bottom = element_text(size = 12, vjust = -1),
        axis.text.y.left = element_text(size = 12, #hjust = 0,
                                        margin = margin(0,7,0,10)),
        axis.title = element_text(size = 14),
        legend.direction = "horizontal",
        legend.position = c(0.6,0.8),
        legend.justification = c(0.5,0.5),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 12, face = 'italic'))+ 
  scale_color_manual(values = maycols) +
  scale_x_log10(labels = scales::trans_format("log10", scales::math_format(10^.x)),
                sec.axis = sec_axis(~log10(.),
                                    breaks = c(2, 3, 4, 5, 6),
                                    labels = c("100-300 ya", "1-3 kya", "10-30 kya", "100-300 kya", "1-3 mya"), 
                                    name="Years Before Present\n")) +
  annotation_logticks(sides="tbl") +
  scale_y_log10(labels = scales::trans_format("log10", scales::math_format(10^.x))) +
  labs(x="\nGenerations Before Present", y = "Effective Population Size") +
  geom_line(alpha=.75)

ggsave(filename = "../5_output/gemplusbel_msmc2_unmasked.pdf", 
       plot=full_plot, device = "pdf", width = 169, height = 120, units = "mm")
