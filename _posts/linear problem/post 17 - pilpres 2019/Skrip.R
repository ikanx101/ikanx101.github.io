# ==============================================================================
setwd("~/ikanx101.github.io/_posts/linear problem/post 17 - pilpres 2019")

rm(list=ls())

library(parallel)
library(dplyr)
library(tidyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

n_core = 2
# ==============================================================================

# ==============================================================================
# ambil data dulu
nama_files = c("Aren Jaya.txt","Bekasi Jaya.txt","Duren Jaya.txt","Margahayu.txt")

# nama function
ambil_file = function(nama_file){
  teks = readLines(nama_file)
  df = 
    data.frame(tps = teks) |>
    separate(tps,
             sep  = "\\t",
             into = c("tps","jkw","prb"))
  return(df)
}

