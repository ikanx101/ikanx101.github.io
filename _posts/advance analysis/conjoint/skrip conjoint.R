setwd("~/Documents/ikanx101/_posts/advance analysis/conjoint")
rm(list=ls())

library(dplyr)
library(conjoint)
library(ggplot2)

kamera = c("10 MP","15 MP","20 MP")
lock = c("fingerprint","face recog","fingerprint and face recog")
charging = c("fast","normal")

experiment = expand.grid(kamera,lock,charging)
experiment

factdesign = caFactorialDesign(data=experiment,type="orthogonal")
factdesign 

prof = caEncodedDesign(design=factdesign)
colnames(prof) = c("kamera","lock","charging")

# buat ngeliat orthogonal atau gak
print(round(cov(prof),5))
print(round(cor(prof),5))

case_level = c(kamera,lock,charging)
case_level

# buat responden palsu
jawab = function(){
  sample(6,8,replace = T)
}

for(i in 1:10){
  nam = paste0("resp",i)
  tes = jawab()
  assign(nam,tes)
}

responses = data.frame(resp1,resp2,resp3,resp4,resp5,resp6,resp7,resp8,resp9,resp10)
responses_print = data.frame(factdesign,responses)

save(experiment,factdesign,prof,case_level,responses,responses_print,
     file = "bahan blog.rda")

# bikin kmeans
aSegmentation(y=responses, x=prof, c=3)
