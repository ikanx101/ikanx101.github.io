rm(list=ls())

# =============================================================================
setwd("/home/ikanx101/ikanx101.github.io/_posts/home tester club/tulisan ketiga")

library(dplyr)
library(tidyr)
library(RSelenium)
library(rvest)
# =============================================================================


# =============================================================================
# kita buatkan dulu seleniumnya
# untuk ubuntu
remote_driver = remoteDriver(remoteServerAddr = "localhost", 
                             port             = 4445L, 
                             browserName      = "firefox")

# untuk windows
#remote_driver = remoteDriver(remoteServerAddr = "myselcontainer", 
#                             port             = 4444L, 
#                             browserName      = "firefox")

remote_driver$open()
# =============================================================================


# =============================================================================
# kita simpan dulu urls nya
urls = paste0("https://www.hometesterclub.com/id/id/reviews/tropicana-slim-oat-drink?review-page=",
              1:3)

# kita bikin functionnya terlebih dahulu
# buka situs
buka_situs = function(url){
  remote_driver$navigate(url)
  Sys.sleep(4)
}

# function untuk ambil komen-nya
ambil_komen = function(dummy){
    # baca situsnya
  baca = 
    remote_driver$getPageSource()[[1]] %>% 
    read_html() 
  # ambilin datanya
  komen = baca %>% 
          html_nodes(.,".review-user_comment") %>% 
          html_text()
  # kita output-kan
  return(komen)
  Sys.sleep(2)
}

temp = vector("list",3)
for(i in 1:3){
    buka_situs(urls[i])
    temp[[1]] = ambil_komen(101040)
    print(i)
}

save(temp,file = "hasil komen.rda")

temp[[1]]
