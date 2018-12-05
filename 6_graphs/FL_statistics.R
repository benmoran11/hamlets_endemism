install.packages('devtools')
devtools::install_github('jeremiaheb/rvc')
library(rvc)
library(tidyverse)
library(ggalt)
library(cowplot)
library(hrbrthemes)

## Data from Florida Reef Visual Census (RVC), from Key West to 
FLK_02_16 <- getRvcData(years = 2002:2016, regions = c("FLA KEYS"))
spcs <- c("HYP GEMM", 'HYP PUEL', 'HYP NIGR',
          'HYP CHLO', 'HYP GUTT', 'HYP HYBR',
          'HYP INDI', "HYP UNIC", 'HYP TANN', 'HYP SPE.')
ddens <- getDomainDensity(FLK_02_16, species = spcs)

ham_dens <- ddens %>% 
  select(YEAR, SPECIES_CD, density) %>%
  mutate(density_m2 = density/(7.5^2 * pi)) %>%
  select(-density)

# Our data: 400 m2 transects, densities per transect:
PL_transects <- read.csv('./0_data/PL_FL_transects.csv') 


## Summary statistics
mean(PL_transects$TOTAL/400)
sd(PL_transects$TOTAL/400)


## Combining datasets

PL_density <- PL_transects %>%
  select(HYP.PUEL:HYP.CHLO) %>%
  gather(key = SPECIES_CD, value = density) %>%
  group_by(SPECIES_CD) %>%
  summarise(density = mean(density)) %>%
  ungroup()

PL_density$SPECIES_CD <- str_replace(PL_density$SPECIES_CD, 
                                     pattern = "[.]", replacement = " ")

PL_data <- data.frame(YEAR = rep(2017, 5), SPECIES_CD = c("HYP GEMM", "HYP NIGR", "HYP PUEL", "HYP UNIC", "HYP TANN")) %>%
  inner_join(PL_density) %>%
  mutate(density_m2 = density / 400) %>%
  select(YEAR, SPECIES_CD, density_m2)


ham_dens <- rbind(ham_dens, PL_data)

ham_dens$Species <- factor(ham_dens$SPECIES_CD) 

## Tests for change in abundance and effective number of species
## between first and second halfs of dataset

library(vegan)
ham_wide <- ham_dens %>%
  select(YEAR, Species, density_m2) %>%
  spread(Species, density_m2) %>%
  select(-YEAR) %>%
  as.matrix()
ham_wide[is.na(ham_wide)] <- 0
row.names(ham_wide) <- unique(ham_dens$YEAR)
colnames(ham_wide) <- lapply(X = colnames(ham_wide), FUN = function(x) substr(x,5,7)) %>%
  unlist()

ham_groups <- data.frame(Year = as.integer(c(2002:2012, "2014", "2016", "2017")),
                         Period = rep(c("2002-2008", "2009-2017"), each = 7))

ham_dist <- vegdist(ham_wide)
set.seed(15)
adonis2(ham_dist ~ Period, data = ham_groups)
comm <- metaMDS(ham_wide, k = 2, distance = 'bray')
stressplot(comm)

ham.scores <- as.data.frame(scores(comm))
ham.scores$Year <- rownames(ham.scores)
species.scores <- as.data.frame(scores(comm, "species"))
species.scores$species <- rownames(species.scores)
ham_wide <- ham_wide %>%
  as.data.frame() %>%
  mutate(Year = ham_groups$Year, Period = ham_groups$Period)
ham_wide <- merge(ham_wide, ham.scores,by='Year')

aggregate(GEM~Period, ham_wide, FUN = mean)
aggregate(GEM~Period, ham_wide, FUN = function(x) sd(x)/sqrt(length(x)))

nmds_plot <- ggplot(ham_wide,aes(x=NMDS1,y=NMDS2,group=Period)) + 
  # fixed aspect ration for x and y scale
  coord_equal() +
  # adding line ad x = 0 and y = 0
  geom_hline(yintercept = 0,color='lightgray')+geom_vline(xintercept = 0,color='lightgray')+
  # add the species labels
  geom_text(inherit.aes = F,data=filter(species.scores,
                                        species %in% c("GEM", "NIG", "PUE", "UNI")),
            aes(x=NMDS1,y=NMDS2,label=species),
            col='red') +
  # add the sample positions
  geom_point(aes(colour=Period, shape = Period),size=3) +
  # add the outer hull of the three groups (function from the ggalt package)
  geom_encircle(aes(colour=Period,fill=Period),
                s_shape=1,alpha=0.2,size=1, expand=0)+
  # add the sample labels
  geom_text(aes(label=Year),size=4,vjust=0,nudge_y=.02) +
  # change the coler map (from the hrbrthemes package)
  scale_fill_hue()+scale_color_hue()+
  coord_cartesian(xlim = c(-0.6, 0.6), ylim = c(-0.25, 0.25)) +
  # change the overall plot layout (from the hrbrthemes package)
  theme_bw() +
  theme(panel.grid = element_blank(),
        legend.position = c(1,1),
        legend.background = element_blank(),
        legend.justification = c(1,1), 
        plot.margin = unit(c(5,5,5,5),'pt'),
        axis.title = element_text(face = 'bold'))

ggsave('C:/Users/benmo/Documents/R/BZhams/ms_plots/NMDS_hams.pdf',
       nmds_plot, device = 'pdf', width = 169, height = 100, units = 'mm')

agg_dens <- ham_dens %>%
  filter(!SPECIES_CD %in% c("HYP GEMM", "HYP NIGR", "HYP PUEL", "HYP UNIC")) %>%
  group_by(YEAR) %>%
  summarise(density_m2 = sum(density_m2)) %>%
  cbind(Species = "HYP ETC.", .)

summ_dens <- ham_dens %>%
  filter(SPECIES_CD %in% c("HYP GEMM", "HYP NIGR", "HYP PUEL", "HYP UNIC")) %>%
  select(-SPECIES_CD) %>%
  rbind(agg_dens)

summ_dens$Species <- factor(summ_dens$Species,
                           levels = c("HYP ETC.", "HYP GEMM", "HYP NIGR",
                                      "HYP PUEL", "HYP UNIC"))

levels(summ_dens$Species) <- c("Other", "H.gemma", "H. nigricans", "H. puella", "H. unicolor")
summ_cols <- c('lightgreen', 'dodgerblue', 'gray17', 'goldenrod', 'khaki')

trans_dens <- ggplot(summ_dens, aes(x = YEAR, y = density_m2, fill = Species)) +
  geom_area(position = 'stack') +
  theme_bw() +
  theme(legend.text = element_text(face = 'italic')) +
  scale_fill_manual(name = "Hamlet \nSpecies", values = summ_cols) +
  labs(x='Year', y = expression(paste("Density (Individuals ",~m^{-2},")")))

ggsave('C:/Users/benmo/Documents/R/BZhams/ms_plots/FL_dens.pdf',
       trans_dens, device = 'pdf', width = 150, height = 90, units = 'mm')
