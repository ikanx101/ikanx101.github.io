rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)

n_core = detectCores()

weekend  = 2
weekdays = 4

duit = function(dummy){rnorm(1,80000,30000)}

pelanggan_wd = function(dummy){
  calon = c("keluarga","pasangan","rombongan","sendiri")
  proba = c(.5,.3,.1,.1)
  siapa = sample(calon,1,prob = proba)
  n_orang = case_when(
    siapa == "keluarga" ~ sample(3:7,1),
    siapa == "pasangan" ~ 1,
    siapa == "rombongan" ~ sample(5:10,1)
  )
}

