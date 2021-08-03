rm(list=ls())

setwd("~/ikanx101 BLOG/_posts/Explainable AI/post 5")

library(dplyr)
library(rvest)
library(stringr)
library(tidyr)
library(reshape2)

url = "https://www.uefa.com/uefaeuro-2020/match/2024491--italy-vs-england/statistics/?iv=true"

data = url %>% read_html() %>% html_nodes(".match-statistics--item") %>% html_text() %>% str_squish()
teams = url %>% read_html() %>% html_nodes(".js-fitty") %>% html_text() %>% str_squish()

data = 
  data.frame(var = data) %>% 
  separate(var,
           into = c("grup_1","grup_2","var"),
           sep = " ") %>% 
  mutate(grup_1 = as.numeric(grup_1),
         grup_2 = as.numeric(grup_2)) %>% 
  filter(!is.na(grup_1)) %>% 
  mutate(var = janitor::make_clean_names(var))

temp = 
  data %>% 
  t() %>% 
  as.data.frame()
colnames(temp) = temp[3,]
temp = temp[-3,]
temp$grup = teams
row.names(temp) = NULL
temp$result = NA
temp$result[1] = ifelse(temp$goals[1] > temp$goals[2],"win","not win")
temp$result[2] = ifelse(temp$goals[2] > temp$goals[1],"win","not win")
