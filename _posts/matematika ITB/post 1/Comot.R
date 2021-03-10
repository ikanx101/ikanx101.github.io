rm(list=ls())

library(dplyr)
library(chromote)

link = readLines("links.txt")
n = length(link)

# setting
b <- ChromoteSession$new()
b$Network$setUserAgentOverride(userAgent = "Chrome")
b$view()
cookies <- b$Network$getCookies()
b$Network$setCookies(cookies = cookies$cookies)

chrome_do_your_magic = function(link){
  # navigate
  b$Page$navigate(link)
  Sys.sleep(10)
  # extract nama
  x <- b$Runtime$evaluate('document.querySelector(".t-24").innerText')
  nama = x$result$value
  nama = ifelse(is.null(nama),NA,nama)
  # extract roles
  x <- b$Runtime$evaluate('document.querySelector(".t-18").innerText')
  roles = x$result$value
  roles = ifelse(is.null(roles),NA,roles)
  
  data = data.frame(nama,roles)
  return(data)
}

i = 1
scraped_data = chrome_do_your_magic(link[i])

for(i in 2:n){
  temp = chrome_do_your_magic(link[i])
  scraped_data = rbind(scraped_data,temp)
}

special = c("pt","indonesia","tbk","persero","bukalapak","mandiri","negara","corporate","garuda","geco",
            "aerotrans","aia","astra","axa","bhakti","blibli","buana","gojek","clove","samsung")

olah = 
  scraped_data %>% 
  mutate(roles = janitor::make_clean_names(roles),
         roles = gsub("\\_"," ",roles)) %>% 
  tidytext::unnest_tokens("words",roles,"words") %>% 
  group_by(words) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  filter(!words %in% stopwords::stopwords()) %>% 
  filter(!words %in% special)

save(scraped_data,olah,file = "bahan blog.rda")

library(wordcloud)
wordcloud(olah$words,olah$n,min.freq = 2)
wordcloud()