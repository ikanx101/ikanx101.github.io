rm(list=ls())
setwd("~/ikanx101.github.io/_posts/data carpentry/adu cepat")

library(bench)
library(dplyr)
library(tidypolars)
library(parallel)
n_core = detectCores()

# Create Dataframe
n_generate = 10^7
df_input <- data.frame(
  grup = sample(LETTERS[1:6], n_generate, replace = TRUE),
  nilai = rnorm(n_generate)
)

# =======================================================================
# definisikan proses dengan dplyr
proses_dplyr <- function(data) {
  data %>%
    group_by(grup) %>%
    summarize(
      rata_rata = mean(nilai)
    ) %>% 
    ungroup()
}
# =======================================================================


# =======================================================================
# definisikan proses dengan dplyr - parallel
proses_dplyr_2 <- function(data) {
  data %>%
    summarize(
      grup      = unique(grup),
      rata_rata = mean(nilai)
    ) 
}
proses_dplyr_parallel <- function(data) {
  temp  = data %>% group_split(grup)
  hasil = mclapply(temp,proses_dplyr_2)
  hasil
  #do.call(rbind,hasil)
}
# =======================================================================


# =======================================================================
# definisikan proses dengan dtplyr
proses_dtplyr <- function(data) {
  data |>
    dtplyr::lazy_dt() |> 
    group_by(grup) |>
    summarise(
      rata_rata = mean(nilai)
    ) %>% 
    ungroup() 
}
# =======================================================================


# =======================================================================
# definisikan proses dengan dtplyr - parallel
proses_dtplyr_2 <- function(data) {
  data |>
    dtplyr::lazy_dt() |> 
    summarise(
      grup      = unique(grup),
      rata_rata = mean(nilai)
    ) %>% 
    ungroup() 
}
proses_dtplyr_parallel <- function(data) {
  temp  = data %>% group_split(grup)
  hasil = mclapply(temp,proses_dtplyr_2)
  hasil
  #do.call(rbind,hasil)
}
# =======================================================================


# =======================================================================
# definisikan proses dengan tidypolars
proses_tidypolars <- function(data) {
  data |>
    as_polars_df() |> 
    group_by(grup) |>
    summarise(
      rata_rata = mean(nilai)
    ) %>% 
    ungroup() 
}
# =======================================================================


# =======================================================================
proses_dplyr(df_input)
proses_dplyr_parallel(df_input)
proses_dtplyr(df_input)
proses_dtplyr_parallel(df_input)
proses_tidypolars(df_input)
# =======================================================================


# Pengukuran waktu dan memori
bench_result <- bench::mark(
  proses_dplyr(df_input),
  #proses_dplyr_parallel(df_input),
  proses_tidypolars(df_input),
  proses_dtplyr(df_input),
  #proses_dtplyr_parallel(df_input),
  iterations = 5,
  check = F,
  #memory = F
)

bench_result |> arrange(total_time) |> select(-memory)# %>% as.data.frame()

save(bench_result,file = "bench.rda")
