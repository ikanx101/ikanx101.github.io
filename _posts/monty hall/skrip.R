setwd("~/Documents/ikanx101.com/_posts/monty hall")

rm(list=ls())

library(dplyr)

pintu = function(x){
  hasil = sample(c(0,0,1),3,replace = F)
  hasil = stringr::str_c(hasil,collapse = ",")
  return(hasil)
}

data = data.frame(id = c(1:100))
data$hasil = sapply(data$id,pintu)
                    