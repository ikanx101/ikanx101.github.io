rm(list=ls())

library(dplyr)

n = 300
gender = sample(c("pria","wanita"),n,replace = T, prob = c(.3,.7))
usia = sample(c(25:40),n,replace = T)
pernah = sample(c("ya","tidak"),n,replace = T, prob = c(.7,.3))
tempat = sample(c("pasar","warung","minimarket","supermarket","online"),n,replace = T)



