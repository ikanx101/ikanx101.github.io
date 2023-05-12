rm(list=ls())

setwd("~/ikanx101.github.io/_posts/home tester club/tulisan ketiga")

library(dplyr)
library(tidyr)
library(tidytext)

# ==============================================
# ambil data yang telah didapatkan
saved_rda = "hasil komen.rda"
load(saved_rda)

df = data.frame(komen = c(temp[[1]],
                          temp[[2]],
                          temp[[3]]))
df$resp_id = 1:nrow(df)

# kita ambil stopwords
stop = readLines("https://raw.githubusercontent.com/ikanx101/ID-Stopwords/master/id.stopwords.02.01.2016.txt")

# kita pecah perkalimat ya
df = 
  df |>
  mutate(komen = tolower(komen),
         komen = stringr::str_trim(komen)) |>
  separate_rows(komen,sep = "\\.") |>
  mutate(komen = stringr::str_trim(komen),
         filt  = stringr::str_length(komen)) |>
  filter(filt > 0) |>
  mutate(komen = gsub("[[:punct:]]|\\n|\\r|\\t"," ",komen),
         komen = stringr::str_trim(komen)) |>
  select(-filt) |>
  unnest_tokens("words",komen) |>
  filter(!words %in% stop)

df
# ==============================================
