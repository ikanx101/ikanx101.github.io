rm(list=ls())

setwd("~/ikanx101 BLOG/_posts/Explainable AI/post 5")

library(dplyr)
library(rvest)
library(stringr)
library(tidyr)
library(reshape2)

scrape_euro = function(url){
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
  temp = 
    temp %>% 
    mutate_if(is.character,as.numeric)
  temp$grup = teams
  row.names(temp) = NULL
  temp$result = NA
  temp$result[1] = ifelse(temp$goals[1] > temp$goals[2],"win","not win")
  temp$result[2] = ifelse(temp$goals[2] > temp$goals[1],"win","not win")
  
  return(temp)
}

# ambil semua url
urls = c("https://www.uefa.com/uefaeuro-2020/match/2024491--italy-vs-england/",
         "https://www.uefa.com/uefaeuro-2020/match/2024489--italy-vs-spain/",
         "https://www.uefa.com/uefaeuro-2020/match/2024490--england-vs-denmark/",
         "https://www.uefa.com/uefaeuro-2020/match/2024485--switzerland-vs-spain/",
         "https://www.uefa.com/uefaeuro-2020/match/2024486--belgium-vs-italy/",
         "https://www.uefa.com/uefaeuro-2020/match/2024488--czech-republic-vs-denmark/",
         "https://www.uefa.com/uefaeuro-2020/match/2024487--ukraine-vs-england/")

# sisanya di txt yah
urls_temp = readLines("macis.txt")

# gabung datanya
urls = c(urls,urls_temp)

# final urls
link = paste0(urls,"statistics/?iv=true&iv=true")

hasil = vector("list", length(link))

# menentukan batas percobaan
batas = 5

for (i in 1:length(link)) {
  if (!(link[i] %in% names(hasil))) {
    cat(paste("Scraping", link[i], "..."))
    ok = FALSE
    counter = 0
    while (ok == FALSE & counter <= batas) {
      counter = counter + 1
      out = tryCatch({                  
        scrape_euro(link[i])
      },
      error = function(e) {
        Sys.sleep(2)
        e
      }
      )
      if ("error" %in% class(out)) {
        cat(".")
      } else {
        ok = TRUE
        cat(" Done.")
      }
    }
    cat("\n")
    hasil[[i]] = out
    names(hasil)[i] = link[i]
  }
} 


save(hasil,data,file = "bahan blog.rda")

data = data.frame()

for(i in 1:51){
  data = rbind(hasil[[i]],data)
}

