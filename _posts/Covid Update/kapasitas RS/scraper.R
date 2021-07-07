rm(list=ls())

setwd("~/ikanx101 BLOG/_posts/Covid Update/kapasitas RS")

library(rvest)
library(dplyr)
library(tidyr)

# ambil links
link = readLines("bengkulu.txt")

# function ambil data
scrape_donk = function(url){
  nama = url %>% read_html() %>% html_nodes("span") %>% html_text()
  alamat = url %>% read_html() %>% html_nodes(".fa-hospital-o") %>% html_text()
  jenis_kamar = url %>% read_html() %>% html_nodes("h5:nth-child(1)") %>% html_text()
  n_kamar = url %>% read_html() %>% html_nodes(".mr-2 h1") %>% html_text()
  n_kamar_kosong = url %>% read_html() %>% html_nodes(".pt-1+ .pt-1 h1") %>% html_text()
  
  final = 
    data.frame(nama_rs = nama,
               alamat_rs = alamat,
               jenis_kamar,
               n_kamar,
               n_kamar_kosong)
  
  return(final)
}

# proses scrape
# menentukan batas percobaan
batas = 3
hasil = vector("list", length(link))

for (i in 1:length(link)) {
  if (!(link[i] %in% names(hasil))) {
    cat(paste("Scraping", link[i], "..."))
    ok = FALSE
    counter = 0
    while (ok == FALSE & counter <= batas) {
      counter = counter + 1
      out = tryCatch({                  
        scrape_donk(link[i])
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

data = data.frame()
n = length(hasil)

for(i in 9:n){
  data = rbind(hasil[[i]],data)
}



# cleaning
clean = 
  data %>% 
  mutate(nama_rs = stringr::str_squish(nama_rs),
         alamat_rs = stringr::str_squish(alamat_rs),
         jenis_kamar = stringr::str_squish(jenis_kamar),
         n_kamar = as.numeric(n_kamar),
         n_kamar_kosong = as.numeric(n_kamar_kosong)
         )

#dki = clean

#save(dki,file = "dki.rda")

# visualisasi
library(ggplot2)

clean %>% 
  mutate(jenis_kamar = tolower(jenis_kamar),
         jenis_kamar = stringr::str_squish(jenis_kamar),
         jenis_kamar = stringr::str_to_title(jenis_kamar)) %>% 
  group_by(jenis_kamar,keterangan) %>% 
  summarise(n = sum(n_kamar)) %>% 
  ungroup() %>% 
  filter(!jenis_kamar %in% c("7","8","Alamanda, Ged A")) %>%
  ggplot(aes(y = jenis_kamar,
             x = n)) +
  geom_col(aes(fill = keterangan),
           position = "dodge") +
  scale_fill_manual(values = c("darkgreen","darkred")) +
  geom_label(aes(fill = keterangan,
                 label = n),
             color = "white",
             position = position_dodge(1),
             size = 3) +
  theme_minimal() +
  labs(title = "DATA KETERSEDIAAN TEMPAT TIDUR 34 RUMAH SAKIT DI KOTA BEKASI",
       caption = "Sumber Data: SIRANAP (Sistem Informasi Rawat Inap v2.0) http://yankes.kemkes.go.id/app/siranap\nData di-scrape pada 24 Juni 2021 15:36 WIB dan divisualisasikan dengan R\nikanx101.com",
       subtitle = "Penambahan kasus aktif Covid-19 di Indonesia yang membesar dengan cepat bisa membuat fasilitas kesehatan seperti RS kolaps.\nSore ini Saya scrape data realtime dari SIRANAP Kemenkes.\nJika data ini benar, bisa disimpulkan bahwa RS sudah hampir penuh.",
       fill = "Keterangan") +
  theme(axis.text.x = element_blank(),
        plot.title = element_text(size = 15,face="bold",hjust = .5),
        plot.subtitle = element_text(size = 10,hjust = .5),
        plot.caption = element_text(size = 10,hjust = .5),
        axis.title = element_blank())
  
ggsave("post.png",
       width = 10,
       height = 8,
       dpi = 450)