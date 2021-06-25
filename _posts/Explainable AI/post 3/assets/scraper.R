setwd("~/ikanx101 BLOG/_posts/Explainable AI/post 3")

rm(list=ls())

library(dplyr)
library(rvest)

url = "https://www.carmudi.co.id/en/for-sale/toyota-alphard-g-dki-jakarta-pondok-indah/7976525"

# import dbase links
links = readLines("links.txt") %>% unique()
dbase = 
  data.frame(id = 1, links) %>% 
    filter(grepl("carmudi",links)) %>% 
    filter(!grepl("indonesia",links)) %>% 
    filter(grepl("for-sale",links))

link = dbase$links

# ua string
uastring = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36"

# function scraper
scrape_mobil = function(url){
  x = html_session(url,httr::user_agent(uastring))
  
  hasil = 
    x %>% read_html() %>% {
      tibble(
        harga = html_nodes(.,".portable-one-whole .delta") %>% html_text() %>% unique(),
        brand = html_nodes(.,".icon--car-front~ .float--right") %>% html_text() %>% unique(),
        status = html_nodes(.,".icon--search-car~ .float--right") %>% html_text() %>% unique(),
        year = html_nodes(.,".icon--calendar~ .float--right") %>% html_text() %>% unique(),
        trans = html_nodes(.,".icon--gear~ .float--right") %>% html_text() %>% unique(),
        seat = html_nodes(.,".icon--car-seat~ .float--right") %>% html_text() %>% unique(),
        mileage = html_nodes(.,".icon--meter~ .float--right") %>% html_text() %>% unique()
      )
    }
  return(hasil)
}

# menentukan batas percobaan
batas = 3

# rumah data
hasil = vector("list", length(link))

# scraper
for (i in 1:length(link)) {
  if (!(link[i] %in% names(hasil))) {
    cat(paste("Scraping", i, "..."))
    ok = FALSE
    counter = 0
    while (ok == FALSE & counter <= batas) {
      counter = counter + 1
      out = tryCatch({                  
        scrape_mobil(link[i])
      },
      error = function(e) {
        Sys.sleep(1)
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


save(dbase,hasil,file = "data.rda")
