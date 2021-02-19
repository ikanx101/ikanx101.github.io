setwd("~/ikanx101.github.io/_posts/data carpentry/air crash database")
library(dplyr)
library(rvest)
library(ggplot2)
rm(list=ls())

url = paste0("https://aviation-safety.net/database/dblist.php?Year=",2011:2021)
url = c(paste0(url,"&lang=&page=1"),
        paste0(url,"&lang=&page=2"),
        paste0(url,"&lang=&page=3"))


scraper_data = function(link){
  dbase = read_html(link) %>% html_table(fill = T)
  pertanda = length(dbase)
  if(pertanda > 0){
    dbase = dbase[[1]]
    dbase = dbase[-7]
    temp = dbase
  } else(temp = ilok)
  return(temp)
}

i = 1
data_fin = scraper_data(url[i])
# ilok = data_fin[0,]

for(i in 2:33){
  temp = scraper_data(url[i])
  data_fin = rbind(data_fin,temp)
}

raw = distinct(data_fin)

dbase =
  raw %>%
  mutate(manufacture = case_when(
    grepl("boeing",type,ignore.case = T) ~ "Boeing",
    grepl("airbus",type,ignore.case = T) ~ "Airbus",
    grepl("antonov",type,ignore.case = T) ~ "Antonov",
    grepl("cessna",type,ignore.case = T) ~ "Cessna"
  )) %>%
  mutate(manufacture = ifelse(is.na(manufacture),
                              "Others",
                              manufacture)) %>%
  mutate(cat_1 = case_when(
    grepl("A",cat) ~ "Accident",
    grepl("I",cat) ~ "Incident",
    grepl("H",cat) ~ "Hijacking",
    grepl("C",cat) ~ "Criminal",
    grepl("U|O",cat) ~ "Others"
  )) %>%
  mutate(cat_2 = ifelse(grepl("1",cat),
                        "Loss",
                        "Repairable"),
         date = trimws(date)) %>%
  select(-pic) %>% 
  tidyr::separate(date,
                  into = c("tgl","bln","thn"),
                  sep = "-") %>% 
  mutate(date = paste("01",bln,thn,sep = "-"),
         date = as.Date(date,"%d-%B-%Y"),
         bln = lubridate::month(date))

save(raw,dbase,file = "aviation.rda")