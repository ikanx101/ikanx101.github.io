rm(list=ls())
gc()

setwd("~/ikanx101.github.io/_posts/market riset/post 8")

library(dplyr)
library(tidyr)
library(janitor)
library(klaR)
library(parallel)

n_core = detectCores()

file_name = "Dummy k modes - Data.csv"

df = read.csv(file_name) %>% clean_names()

within_diff = function(k_input){
  kmodes_result = kmodes(df,k_input,iter.max = 15)
  output        = kmodes_result$withindiff %>% sum()
  return(output)
}

k_output = 2:11
mcmapply(within_diff,k_output)
