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
prof

case_level = c(kamera,lock,charging)
case_level

save(experiment,factdesign,prof,case_level,
     file = "bahan blog.rda")