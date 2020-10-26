rm(list=ls())

library(dplyr)

n = 1000
kota = sample(c("Jakarta","Bandung","Tasikmalaya","Garut","Sukabumi"),n,replace = T)
gender = sample(c("pria","wanita"),n,replace = T, prob = c(.3,.7))
usia = sample(c(25:40),n,replace = T)
pernah = rep(sample(c("ya","tidak"),n/5,replace = T, prob = c(abs(rnorm(2)))),5)
rating = sample(c("sangat tidak suka",
                  "tidak suka",
                  "suka",
                  "sangat suka"),
                n,
                replace = T,
                prob = c(.2,
                         .1,
                         .4,
                         .1))

tempat = sample(c("pasar","warung","minimarket","supermarket","online"),n*2,replace = T)

data = data.frame(
  id = c(1:n),
  kota,
  gender,
  usia,
  pernah,
  rating
)

pilter = 
  data %>%
  filter(pernah == "ya") %>% 
  select(id)

new = data.frame(
  id = sample(pilter$id,2000,replace = T),
  tempat
) %>% 
  distinct() %>% 
  arrange(id)

new = 
  new %>% 
  group_by(id) %>% 
  summarise(gabung = stringr::str_c(tempat,collapse = ",")) %>% 
  ungroup()

data = merge(data,new,all = T)

data %>% 
  tidyr::separate(gabung,
                  into = c("tempat_1","tempat_2","tempat_3","tempat_4","tempat_5"),
                  sep = ",") %>% 
  write.csv("data survey.csv")
