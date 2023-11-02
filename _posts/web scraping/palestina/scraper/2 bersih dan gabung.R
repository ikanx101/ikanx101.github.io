rm(list=ls())

# libraries
library(dplyr)
library(tidyr)
library(tidytext)

setwd("~/ikanx101.github.io/_posts/web scraping/palestina/scraper")

# ambil stopwords
stop = readLines("https://raw.githubusercontent.com/stopwords-iso/stopwords-id/master/stopwords-id.txt")

# kita list dulu kata-kata yang terafiliasi dengan konflik palestina

# ambil semua data
load("detikcom.rda")
df_detik = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()

load("kompascom.rda")
df_kompas = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()

load("cnn.rda")
df_cnn    = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()


# kita buat function untuk membersihkan stopwords dari semua data yang ada
bersihkan = function(input){
  # menambahkan id
  input$id = 1:nrow(input)
  # membersihkan
  output = 
    input %>%
    unnest_tokens("words",judul) %>% 
    filter(!words %in% stop) %>% 
    group_by(id) %>% 
    summarise(judul = paste(words,collapse = " ")) %>% 
    ungroup() %>% 
    distinct()
  return(output)
}

# proses pembersihan
df_detik  = bersihkan(df_detik)
df_kompas = bersihkan(df_kompas)
df_cnn    = bersihkan(df_cnn)
