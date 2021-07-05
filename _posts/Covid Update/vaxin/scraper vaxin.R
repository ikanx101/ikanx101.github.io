rm(list=ls())

setwd("~/ikanx101 BLOG/_posts/Covid Update/vaxin")

# libraries
library(dplyr)
library(rvest)

# url
url = paste0("https://www.detik.com/search/searchall?query=vaksin&siteid=3&sortby=time&sorttime=0&page=",1:300)

# function
judul = function(url){
  read_html(url) %>%
    html_nodes(".title") %>%
    html_text()
}

# siapin rumah
judul_berita = c()

# scraper
for(i in 1:length(url)){
  hasil = judul(url[i])
  judul_berita = c(hasil,judul_berita)
  print(i)
}

# hasilnya
judul_berita

# kita rapikan dulu
data = data.frame(id = 1:length(judul_berita),
                  headline = judul_berita)

clean = data %>% filter(grepl("vaksin",headline,ignore.case = T))

# =============================================
# save dulu
save(data,
     file = "bahan_blog.rda")

# ===========================================================================





# rapihin text
library(tidytext)

id_stop = readLines("https://raw.githubusercontent.com/ikanx101/ID-Stopwords/master/id.stopwords.02.01.2016.txt")

# kita bikin wc
wc = 
  data %>%
  unnest_tokens("words",headline) %>% 
  group_by(words) %>% 
  tally() %>% 
  ungroup() %>% 
  mutate(marker = as.numeric(words)) %>% 
  filter(is.na(marker)) %>%
  filter(!words %in% id_stop) %>% 
  arrange(desc(n)) %>% 
  head(300)

# wordcloud
library(wordcloud)
wordcloud(wc$words,
          wc$n,
          rot.per=0.25,
          colors=brewer.pal(10, "Dark2"))

# bigram
bigram = 
  data %>% 
  unnest_tokens("words",headline) %>% 
  filter(!words %in% id_stop) %>% 
  group_by(id) %>% 
  summarise(headline = paste(words,collapse = " ")) %>% 
  unnest_tokens("bigrams",headline,"ngrams",n=2) %>% 
  group_by(bigrams) %>% 
  tally() %>% 
  ungroup() %>% 
  arrange(desc(n))

library(tidyr)