rm(list=ls())

library(dplyr)
library(tidyr)
library(parallel)
library(ggplot2)

n_core = detectCores() - 1
n_sim  = 10^2

simu_liu = function(performa_sim){
  # generate sales 3 bulan
  bln_1 = sample(0:1,size = n_sim,prob = c(1-performa_sim,performa_sim),replace = T)
  bln_2 = sample(0:1,size = n_sim,prob = c(1-performa_sim,performa_sim),replace = T)
  bln_3 = sample(0:1,size = n_sim,prob = c(1-performa_sim,performa_sim),replace = T)
  
  # kita hitung persentase nya
  persen = sum(bln_1,bln_2,bln_3) / (3 * n_sim)
  persen = round(persen * 100,2)
  
  # kita hitung f3 = 0
  f3   = bln_1 + bln_2 + bln_3
  f3_0 = f3[which(f3 == 0)] |> length()
  
  # kita buat output
  output = data.frame(persen,f3_0)
  return(output)
}

input_1 = seq(1,100,by = 0.1) / 100
input_2 = seq(1,100,by = 0.05) / 100
input_3 = seq(1,100,by = 0.025) / 100
input_4 = seq(1,100,by = 0.075) / 100
input_5 = seq(1,100,by = 0.015) / 100

temp  = mclapply(c(input_1,input_2),simu_liu,mc.cores = n_core)
temp  = data.table::rbindlist(temp) |> as.data.frame()

input = c(input_1,input_2,input_3,input_4,input_5)
input = rep(input,40)
temp_ = mclapply(input,simu_liu,mc.cores = n_core)
temp_ = data.table::rbindlist(temp_) |> as.data.frame()

save(temp,temp_,file = "ready.rda")
# temp |>
#   ggplot(aes(x = persen,y = f3_0)) +
#   geom_point() +
#   geom_smooth(method = "loess") +
#   geom_vline(xintercept = 40) +
#   geom_hline(yintercept = 20)
