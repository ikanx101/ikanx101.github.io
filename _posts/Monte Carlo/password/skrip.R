rm(list=ls())

library(dplyr)

set.seed(101)

pin = 209210

coba = 1:10^6

tebak_pin = function(dummy){
  tebak1 = sample(0:9,6,replace = T)
  tebak1 = paste(tebak1,collapse = "") %>% as.numeric()
  tebak2 = sample(0:9,6,replace = T)
  tebak2 = paste(tebak2,collapse = "") %>% as.numeric()
  tebak3 = sample(0:9,6,replace = T)
  tebak3 = paste(tebak3,collapse = "") %>% as.numeric()
  temp = (tebak1 == pin) + (tebak2 == pin) + (tebak3 == pin)
  return(temp)
}

# paralel
library(parallel)
numCores = detectCores()

mulai = Sys.time()

#hasil = sapply(coba,tebak_pin)
#sum(hasil)/length(hasil) * 100

hasil = mclapply(coba,tebak_pin,mc.cores = numCores)

sink("run.txt")
do.call(sum,hasil)/length(hasil) * 100 %>% round(3)
Sys.time() - mulai
sink()