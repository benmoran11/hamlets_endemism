# function to import fst results (for use with purrr::pmap)
get_data <- function(file,pop1,pop2,base_dir){
  data_windows <- hypo_import_windows(file = str_c(base_dir,file), gz = TRUE) %>% 
    mutate(run = str_c(pop1,pop2,sep = '-'),
           window = 'bolditalic(F[ST])') %>% 
    group_by(CHROM) 
}

# helper function to directly get species comparison grobs 
# (for use with purrr::pmap)
plot_pair <- function(...){
  hypo_anno_pair(...) %>%
    ggplotGrob()
}

plot_single <- function(...){
  hypo_anno_single(...) %>%
    ggplotGrob()
}
# scaling funtion to rescale global fst values for
# the horizontal bars on the side
#rescale_fst <- function(fst){
#  start <- hypogen::hypo_karyotype$GEND %>% last()*1.01
#  end <- 6.3e+08
#  fst_max <- max(globals$weighted)
#  
#  scales::rescale(fst,from = c(0,fst_max), to = c(start,end))
#}

rescale_fst <- function(fst){
  start <- 0#hypogen::hypo_karyotype$GEND %>% last()*1.01
  end <- 1
  fst_max <- max(globals$weighted)
  
  scales::rescale(fst,from = c(0,fst_max), to = c(start,end))
}

# helper function to crate a tibble for global fst values using
# th erescaling function above (prep for geom_rect)
fst_bar_row <- function(fst,run){
  tibble(xmin = rescale_fst(0),
         xmax = rescale_fst(fst),
         xmin_org = 0,
         xmax_org = fst,
         ymin = 0,
         ymax= .15,run = run)
}

# helper function to refactor runs according to global fst values
refactor <- function(self,globals){
  factor(as.character(self$run),
         levels = c(levels(globals$run)))
  }

# function to extract the genome annotation from hypogen for a particular LG
annotab <- function(lg){
  hypogen::hypo_annotation_get(lg,xrange = c(-Inf,Inf))[[1]] %>% 
    select(seqid,start,end,Parentgenename)}

# export funtion to save a tibble in latex tabular format
export_2_latex <- function(table, name){
  table %>% 
    mutate(`\\\\\\hline` = '\\\\') %>% 
    write_delim(.,path = '.tmp.tex',delim = '&')
  # clean last column
  n <- names(table) %>% length()
  
  # open latex table 
  write_lines(str_c('\\begin{tabular}{',
                    str_c(rep(' c',n),collapse = ''),
                    ' }'), name)
  # add table body
  read_lines('.tmp.tex') %>% 
    str_replace(.,'&\\\\',' \\\\') %>%
    str_replace(.,'&',' & ') %>%
    write_lines(name, append = TRUE)
  
  # close latex table 
  write_lines('\\end{tabular}', name, append = TRUE)
  # remove temporary file
  file.remove('.tmp.tex')
  message(str_c('Exportet latex table to "',name,'".'))
} 