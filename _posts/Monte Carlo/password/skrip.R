rm(list=ls())

library(dplyr)

set.seed(101)

pin = 193618
max = 50 * 10^6
coba = 1:max

tebak_pin = function(dummy){
  tebak1 = sample(0:9,6,replace = T)
  tebak1 = paste(tebak1,collapse = "") %>% as.numeric()
  tebak2 = sample(0:9,6,replace = T)
  tebak2 = paste(tebak2,collapse = "") %>% as.numeric()
  tebak3 = sample(0:9,6,replace = T)
  tebak3 = paste(tebak3,collapse = "") %>% as.numeric()
  temp = (tebak1 == pin) + (tebak2 == pin) + (tebak3 == pin)
  temp = ifelse(temp > 1,1,0)
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
cat("Simulasi sebanyak: ")
cat(max)
prb = do.call(sum,hasil)/length(hasil) * 100 %>% round(3)
cat("Berapa kali bisa tembus: ")
cat(do.call(sum,hasil))
cat("\n")
cat("\nPeluang PIN bisa ditembus: ")
cat(prb)
cat("% \n")
Sys.time() - mulai
sink()
print("DONE")
