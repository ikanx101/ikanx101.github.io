setwd("~/Documents/ikanx101.com/_posts/monty hall")

rm(list=ls())

library(dplyr)
library(tidyr)

pintu = function(x){
hasil = sample(c(0,0,1),3,replace=F)
stringr::str_c(hasil,collapse=",")
}

data = data.frame(id=c(1:900))

data$sim = sapply(data$id,pintu)

data =
data %>%
separate(sim,into=c("A","B","C"),sep=",") %>%
mutate_if(is.character,as.numeric)

summary(data)
                    
