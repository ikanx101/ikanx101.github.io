library(ralger)
library(dplyr)

rm(list=ls())

url = list.files()

url = data.frame(id = 1, url) %>% filter(grepl("html",url,ignore.case = T))

url = url$url

data = 
  tidy_scrap(url[1],
             c(".name___1Ls94",".ratingText___1Q08c",".openHoursText___9q0va",
               ".menuItemInfo___PyfMY",".discountedPrice___3MBVA"),
             c("nama_merchant","rating","open_hours",
               "menu","harga"))

data
