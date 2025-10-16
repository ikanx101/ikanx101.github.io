rm(list=ls())

library(dplyr)
library(ggplot2)

load("data.rda")


library(clustMixType)
data = 
  df %>% 
  select(-ID) %>% 
  mutate_if(is.character,as.factor)

# Contoh menentukan k optimal
results <- list()
for (k in 2:10) {
  results[[k]] <- kproto(data, k = k)
}

# Hitung metrik untuk setiap k
metrics <- data.frame(
  k = 2:10,
  wss = sapply(results[2:10], function(x) x$tot.withinss)
)

save(metrics,results,file = "cluster.rda")