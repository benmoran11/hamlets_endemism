library(ggplot2)
library(tidyverse)
library(reshape2)
library(gridExtra)
library(cowplot)

mu <- 3.7e-8
gen <- 1

maycols <- c("H. nigricans" ='#F8766D', 
             "H. unicolor" = '#E76BF3', 
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')

twogemmay1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemmay1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-maya",
         Species_1 = "H. gemma",
         Species_2 = "H. maya",
         Run = "twogem-may1 (2)")
twogemmay2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemmay2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-maya",
         Species_1 = "H. gemma",
         Species_2 = "H. maya",
         Run = "twogem-may2 (2)")

twogemnig1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemnig1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-nigricans",
         Species_1 = "H. gemma",
         Species_2 = "H. nigricans",
         Run = "twogem-nig1 (2)")
twogemnig2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemnig2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-nigricans",
         Species_1 = "H. gemma",
         Species_2 = "H. nigricans",
         Run = "twogem-nig2 (2)")

twogempue1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gempue1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-puella",
         Species_1 = "H. gemma",
         Species_2 = "H. puella",
         Run = "twogem-pue1 (2)")
twogempue2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gempue2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-puella",
         Species_1 = "H. gemma",
         Species_2 = "H. puella",
         Run = "twogem-pue2 (2)")

twogemuni1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemuni1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-unicolor",
         Species_1 = "H. gemma",
         Species_2 = "H. unicolor",
         Run = "twogem-uni1 (2)")
twogemuni2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_gemuni2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "gemma-unicolor",
         Species_1 = "H. gemma",
         Species_2 = "H. unicolor",
         Run = "twogem-uni2 (2)")

twomaynig1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maynig1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-nigricans",
         Species_1 = "H. nigricans",
         Species_2 = "H. maya",
         Run = "twomay-nig1 (2)")
twomaynig2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maynig2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-nigricans",
         Species_1 = "H. nigricans",
         Species_2 = "H. maya",
         Run = "twomay-nig2 (2)")
twomaynig3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maynig3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-nigricans",
         Species_1 = "H. nigricans",
         Species_2 = "H. maya",
         Run = "twomay-nig3 (2)")
twomaynig4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maynig4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-nigricans",
         Species_1 = "H. nigricans",
         Species_2 = "H. maya",
         Run = "twomay-nig4 (2)")
twomaynig5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maynig5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-nigricans",
         Species_1 = "H. nigricans",
         Species_2 = "H. maya",
         Run = "twomay-nig5 (2)")

twomaypue1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maypue1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-puella",
         Species_1 = "H. maya",
         Species_2 = "H. puella",
         Run = "twomay-pue1 (2)")
twomaypue2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maypue2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-puella",
         Species_1 = "H. maya",
         Species_2 = "H. puella",
         Run = "twomay-pue2 (2)")
twomaypue3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maypue3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-puella",
         Species_1 = "H. maya",
         Species_2 = "H. puella",
         Run = "twomay-pue3 (2)")
twomaypue4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maypue4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-puella",
         Species_1 = "H. maya",
         Species_2 = "H. puella",
         Run = "twomay-pue4 (2)")
twomaypue5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_maypue5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-puella",
         Species_1 = "H. maya",
         Species_2 = "H. puella",
         Run = "twomay-pue5 (2)")

twomayuni1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_mayuni1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-unicolor",
         Species_1 = "H. maya",
         Species_2 = "H. unicolor",
         Run = "twomay-uni1 (2)")
twomayuni2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_mayuni2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-unicolor",
         Species_1 = "H. maya",
         Species_2 = "H. unicolor",
         Run = "twomay-uni2 (2)")
twomayuni3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_mayuni3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-unicolor",
         Species_1 = "H. maya",
         Species_2 = "H. unicolor",
         Run = "twomay-uni3 (2)")
twomayuni4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_mayuni4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-unicolor",
         Species_1 = "H. maya",
         Species_2 = "H. unicolor",
         Run = "twomay-uni4 (2)")
twomayuni5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_mayuni5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "maya-unicolor",
         Species_1 = "H. maya",
         Species_2 = "H. unicolor",
         Run = "twomay-uni5 (2)")

twonigpue1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue1 (2)")
twonigpue2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue2 (2)")
twonigpue3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue3 (2)")
twonigpue4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue4 (2)")
twonigpue5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue5 (2)")
twonigpue6 <- read.table("../3_output/3.9_crosscoal_msmc/combined_nigpue6_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-puella",
         Species_1 = "H. nigricans",
         Species_2 = "H. puella",
         Run = "twonig-pue6 (2)")

twoniguni1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni1 (2)")
twoniguni2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni2 (2)")
twoniguni3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni3 (2)")
twoniguni4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni4 (2)")
twoniguni5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni5 (2)")
twoniguni6 <- read.table("../3_output/3.9_crosscoal_msmc/combined_niguni6_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "nigricans-unicolor",
         Species_1 = "H. nigricans",
         Species_2 = "H. unicolor",
         Run = "twonig-uni6 (2)")

twopueuni1 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni1_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni1 (2)")
twopueuni2 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni2_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni2 (2)")
twopueuni3 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni3_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni3 (2)")
twopueuni4 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni4_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni4 (2)")
twopueuni5 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni5_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni5 (2)")
twopueuni6 <- read.table("../3_output/3.9_crosscoal_msmc/combined_pueuni6_msmc.final.txt", header=TRUE) %>%
  gather("Side", "time_value", 2:3) %>%
  arrange(time_index) %>%
  mutate(YBP=time_value/mu*gen,
         Cross_coal = 2 * lambda_01 / (lambda_00 + lambda_11),
         N_haplotypes = 4,
         Method = "MSMC2",
         Comparison = "puella-unicolor",
         Species_1 = "H. puella",
         Species_2 = "H. unicolor",
         Run = "twopue-uni6 (2)")

ms_data <- rbind(twogemmay1, twogemmay2, 
                 twogemnig1, twogemnig2,
                 twogempue1, twogempue2, 
                 twogemuni1, twogemuni2,
                 twomaynig1, twomaynig2, twomaynig3, twomaynig4, twomaynig5,
                 twomaypue1, twomaypue2, twomaypue3, twomaypue4, twomaypue5,
                 twomayuni1, twomayuni2, twomayuni3, twomayuni4, twomayuni5,
                 twonigpue1, twonigpue2, twonigpue3, twonigpue4, twonigpue5, twonigpue6,
                 twoniguni1, twoniguni2, twoniguni3, twoniguni4, twoniguni5, twoniguni6,
                 twopueuni1, twopueuni2, twopueuni3, twopueuni4, twopueuni5, twopueuni6) %>%
  mutate(N_haplotypes = as.factor(N_haplotypes))
levels(ms_data$N_haplotypes) <- c("4 Haplotypes", "6 Haplotypes")
ms_data$Comparison <- factor(ms_data$Comparison, 
                             levels = unique(ms_data$Comparison)[c(1:4,6:7,5,10,8:9)])
levels(ms_data$Comparison) <- c("H. gemma - H. maya", "H. gemma - H. nigricans", 
                                "H. gemma - H. puella", "H. gemma - H. unicolor",
                          "H. maya - H. puella", "H. maya - H. unicolor", "H. nigricans - H. maya", 
                          "H, puella - H. unicolor", "H. nigricans - H. puella", "H. nigricans - H. unicolor")


gemma_cc <- ggplot(filter(ms_data, Species_1 == 'H. gemma'), aes(x=YBP, y=Cross_coal, group = Run, colour=Species_2)) +
  theme_bw() +
  theme(legend.justification = c(0,0),
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 10, face = 'italic')) +
  scale_color_manual(breaks = c('H. nigricans', 'H. maya', 'H. puella', 'H. unicolor'),
                     values = maycols, drop=FALSE) +
  geom_line(alpha = 0.75)

maya_cc <- ggplot(filter(ms_data, Species_1 == 'H. maya'), aes(x=YBP, y=Cross_coal, group = Run, colour=Species_2)) +
  theme_bw() +
  theme(legend.justification = c(0,0),
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 10, face = 'italic')) +
  scale_color_manual(values = maycols,
                     drop=FALSE) +
  geom_line(alpha = 0.75)

nigricans_cc <- ggplot(filter(ms_data, Species_1 == 'H. nigricans'), aes(x=YBP, y=Cross_coal, group = Run, colour=Species_2)) +
  theme_bw() +
  theme(legend.justification = c(0,0),
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 10, face = 'italic')) +
  scale_color_manual(values = maycols,
                     drop=FALSE) +
  geom_line(alpha = 0.75)

puella_cc <- ggplot(filter(ms_data, Species_1 == 'H. puella'), aes(x=YBP, y=Cross_coal, group = Run, colour=Species_2)) +
  theme_bw() +
  theme(legend.justification = c(0,0),
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.spacing.x = unit(3, units = "mm"),
        legend.text = element_text(size = 10, face = 'italic')) +
  scale_color_manual(values = maycols,
                     drop=FALSE) +
  geom_line(alpha = 0.75)

legg <- get_legend(gemma_cc)
legm <- get_legend(maya_cc)
legn <- get_legend(nigricans_cc)
legp <- get_legend(puella_cc)
multileg <- ggdraw(multi_comp) + 
  draw_grob(legg, x = 0.35, y = .5) +
  draw_grob(legm, x = 0.8, y = .5) + 
  draw_grob(legn, x = 0.35, y = 0.1) + 
  draw_grob(legp, x = 0.8, y = 0.1)
print(multileg)
ggsave(filename = "../6_output/gemplusbel_crosscoal_joined_cowplot.pdf", 
       plot=multileg, device = "pdf", width = 169, height = 120, units = "mm")