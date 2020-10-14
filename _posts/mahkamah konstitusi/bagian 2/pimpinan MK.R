library(rvest)
library(tidyr)

url = "https://id.wikipedia.org/wiki/Pimpinan_Mahkamah_Konstitusi_Republik_Indonesia"

data = read_html(url) %>% html_table(fill = T)

pimpinan = data[[3]] %>% janitor::clean_names()

pimpinan = 
  pimpinan %>% 
  separate(dari,into = c("hapus1","hapus2","tahun_dari"),sep = " ") %>% 
  mutate(hapus1 = NULL,
         hapus2 = NULL,
         tahun_dari = as.numeric(tahun_dari)) %>% 
  separate(sampai,into = c("hapus1","hapus2","tahun_sampai"),sep = " ") %>% 
  mutate(hapus1 = NULL,
         hapus2 = NULL,
         tahun_sampai = as.numeric(tahun_sampai),
         tahun_sampai = ifelse(is.na(tahun_sampai),2020,tahun_sampai))
save(pimpinan,file = "pimp.rda")
