ranger_run <- function(POP,data){
  list(POP = POP,
       RANGES = IRanges(start = data$GPOS1, end = data$GPOS2),
       COV = list(covtib = range_to_cov(IRanges(start = data$GPOS1, end = data$GPOS2)))
  )
}

range_to_cov <- function(ir){
  COV <- ir %>%
    GRanges(seqnames = 'hypo',ranges = .,seqlengths = c('hypo' = hypogen::hypo_karyotype$GEND[24]))  %>%
    coverage() 
  
  tibble(length = COV$hypo@lengths,
         cov = COV$hypo@values) %>%
    mutate(start = cumsum((lag(length,default = 1))),
           end = start -1 + length) 
}

extract_cov <- function(input){
  input$COV$covtib %>%
    mutate(POP = input$POP)
}

merge_prep <- function(input){
  input$RANGES
}

merge_cov <- function(input){
  input$COV$covtib %>%
    mutate(POP = input$POP)
}

get_ihh <- function(file){
  run <- file %>% str_remove(.,'ihh12.') %>% str_remove(.,'.50kb.5kb.txt.gz')
  hypo_import_windows(str_c(ihhdir,file),run = run)
}