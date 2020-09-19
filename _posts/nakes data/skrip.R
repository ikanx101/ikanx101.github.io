library(dplyr)
library(rvest)
library(tidyr)
rm(list=ls())

setwd("~/Documents/ikanx101.com/_posts/nakes data")

dbase_link = readLines("link dokter.txt")

scrape = function(url){
  data = read_html(url) %>% html_table(fill = T)
  data = data[[1]]
  colnames(data) = data[1,]
  data = data[-1,]
  data$prov = read_html(url) %>% html_nodes("h3") %>% html_text()
  data = 
    data %>% 
    separate(prov,into = c("hapus","provinsi"),sep = "Provinsi ") %>% 
    mutate(hapus = NULL)
  return(data)
}

data = scrape(dbase_link[1])

for(i in 2:length(dbase_link)){
  temp = scrape(dbase_link[i])
  data = rbind(data,temp)
}

data = 
  data %>% 
  janitor::clean_names() %>% 
  filter(no!="Total")

target_numeric = colnames(data)[c(1,3:9)]

data[,target_numeric] = sapply(data[,target_numeric],as.numeric)

colnames(data) = c("no","Nama Kab/Kota","Jumlah Unit","Dokter Umum","Dokter Gigi","Dokter Spesialis",
                   "Dokter Sub Spesialis","Dokter Gigi Spesialis dan Sub Spesialis","Jumlah Total","Provinsi")

data %>% openxlsx::write.xlsx("Data Dokter.xlsx")
