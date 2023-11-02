setwd("~/ikanx101.github.io/_posts/web scraping/palestina/scraper")
rm(list=ls())

library(dplyr)
library(rvest)
library(RSelenium)

# panggil docker selenium
remote_driver = remoteDriver(remoteServerAddr = "localhost", port = 4445L, browserName = "firefox")
remote_driver$open()

# home url
home_url = "https://www.cnnindonesia.com/indeks/2/"
list_url = paste0(home_url,1:500)

# bikin function untuk ambil data
scrape_detikcom = function(url_input){
  # buka url
  remote_driver$navigate(url_input)
  Sys.sleep(runif(1,2,4))
  
  # kita baca dulu url nya
  baca_html = 
    remote_driver$getPageSource()[[1]] %>% read_html() 
  
  # link berita
  links = 
    baca_html %>% 
    html_nodes(.,".flex-grow") %>% 
    html_attr("href")
  # judul berita
  judul = 
    baca_html %>% 
    html_nodes(.,".flex-grow") %>% 
    html_text() %>% 
    stringr::str_trim()
  # gabungin data
  df = data.frame(judul,links) %>% filter(judul != "") %>% distinct()
  return(df)
}


temp_df = vector("list",500)
for(i in 1:length(list_url)){
  temp_df[[i]] = scrape_detikcom(list_url[i])
  Sys.sleep(.5)
  print(paste0("Proses scraping ke-",i))
}

save(temp_df,file = "cnn.rda")
