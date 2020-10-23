rm(list=ls())

library(dplyr)

n = 300
gender = sample(c("pria","wanita"),n,replace = T, prob = c(.3,.7))
usia = sample(c(25:40),n,replace = T)
pernah = sample(c("ya","tidak"),n,replace = T, prob = c(.7,.3))
rating = sample(c("sangat tidak suka","tidak suka","suka","sangat suka"),n,replace = T)

tempat = sample(c("pasar","warung","minimarket","supermarket","online"),n*4,replace = T)

data = data.frame()

