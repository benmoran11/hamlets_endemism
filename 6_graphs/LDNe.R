library(tidyverse)

LDNe <- read_table('../4_output/4.5_LDNe_output/maybel_LDNe.txt',
                        col_names = c("ID", "Indivs", "H_mean", "N_comp", "R2_observed", "R2_expected", "Ne",
                                      "lower_par", "upper_par", "lower_jackknife",
                                      "upper_jackknife", "effective_df")) %>%
  arrange(effective_df) %>%
  mutate("Trial_ID"=1:100, "upper_jackknife" = Inf, "Run" = "All Hamlets")


LDNe_plot <- ggplot(LDNe, aes(x=Trial_ID, y = Ne)) +
  geom_ribbon(aes(ymin=lower_jackknife, ymax=upper_jackknife, fill = "Ne 95% CI"), alpha = .25) +
  geom_line(aes(x=Trial_ID, y= effective_df/500, colour = "Effective d.f.")) +
  geom_hline(aes(yintercept = 1073.2), lty = 'dashed', lwd = 0.2) +
  geom_hline(aes(yintercept = 4425.7), lty = 'dashed', lwd = 0.2) +
  geom_point(aes(colour="Ne")) +
  theme_bw() +
  theme(legend.position = 'bottom',
        legend.title = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x = element_blank())+
  labs(y = expression(italic(N[e]))) +
  scale_y_log10(sec.axis = sec_axis(~.*.005, name=expression("Effective"~italic(d.f.)~(~'?'~10^{5})))) +
  scale_colour_manual(name = 'Data', values = c('Effective d.f.'='blue', 'Ne'='black'), 
                      labels = c("Effective d.f.", "Ne") ) +
  annotation_logticks(sides = 'l') +
  guides(colour = F, fill = F)

ggsave(filename = "../6_output/maybel_LDNe.pdf", 
       plot=LDNe_plot, device = "pdf", width = 80, height = 75, units = "mm")

median(LDNe$Ne)
quantile(LDNe$Ne, 0.025, type = 1)
quantile(LDNe$Ne, 0.975, type = 1)
