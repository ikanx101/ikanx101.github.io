setwd("~/ikanx101.github.io/_posts/ellmer/post_7")

rm(list=ls())

library(ellmer)
library(tidyverse)

cat("\014")
cat("Kita akan mulai FGD dengan 1 agent moderator dan 3 agents sebagai responden")
Sys.sleep(3)

# kita ambil persona masing-masing responden
persona_1 = readLines("resp_1.txt")
persona_2 = readLines("resp_2.txt")
persona_3 = readLines("resp_3.txt")

# 1. Definisi Panel Responden (Persona)
# Kita simpan dalam list agar mudah di-looping
panel_responden <- list(
  "Rita Repulsa" = chat_deepseek(
    system_prompt = persona_1
  ),
  "Sari Dewi" = chat_deepseek(
    system_prompt = persona_2
  ),
  "Rizki Pratama" = chat_deepseek(
    system_prompt = persona_3
  )
)

# 2. Stimulus dari Moderator
stimulus_1 <- "Bagaimana prinsip Anda dan keluarga dalam menjaga kesehatan?"
stimulus_2 <- "Jika ada perusahaan katering sehat yang menawarkan paket katering dengan harga Rp 50.000 per orang sekali makan. Apakah Anda tertarik untuk memakainya untuk Anda dan keluarga?"

stimulus = c(stimulus_1,stimulus_2)

# Wadah untuk menyimpan transkrip
transkrip <- tibble(pemeran = "Moderator", dialog = stimulus)

# 3. Proses Looping Diskusi
# Kita akan jalankan 2 putaran (round) diskusi
jumlah_putaran <- 2

cat("\014")

for (i in 1:jumlah_putaran) {
  message(paste("--- Memulai Putaran ke-", i, "---"))
  
  konteks_terakhir <- stimulus[i]
  
  Sys.sleep(3)
  cat("\014")
  cat(stimulus[i])
  
  # kita tanya orang pertama dulu
  nama_agen = "Rita Repulsa"
  agen_sekarang <- panel_responden[[nama_agen]]
  
  cat("\n\n")
  cat(nama_agen)
  cat("\n\n")
  
  respon <- agen_sekarang$chat(paste(
    "Konteks diskusi saat ini:", 
    konteks_terakhir, 
    ". Apa pendapatmu?"),
    echo = "output")
  
  # Simpan ke transkrip
  transkrip <- 
    transkrip %>% 
    add_row(pemeran = nama_agen, dialog = as.character(respon))
  
  
  # persiapan konteks
  konteks_tanya = paste("Konteks diskusi saat ini:",
                        nama_agen,
                        "sedang menjawab pertanyaan: ",
                        stimulus[i],
                        "Dengan jawaban:",as.character(respon))
  
  # Setiap persona dalam list akan menanggapi
  for (nama_agen in names(panel_responden)[2:3]) {
    
    # Agen mengambil session chat mereka
    agen_sekarang <- panel_responden[[nama_agen]]
    
    cat("\n\n")
    cat(nama_agen)
    cat("\n\n")
    
    respon <- agen_sekarang$chat(paste(konteks_tanya),echo = "output")
    
    # Simpan ke transkrip
    transkrip <- 
      transkrip %>% 
      add_row(pemeran = nama_agen, dialog = as.character(respon))
    
    # Update konteks terakhir agar agen berikutnya bisa menanggapi agen ini
    # persiapan konteks
    konteks_tanya = paste("Konteks diskusi saat ini:",
                          nama_agen,
                          "sedang menjawab pertanyaan: ",
                          stimulus[i],
                          "Dengan jawaban:",as.character(respon))
    
  }
}

# 4. Hasil Akhir (Tabel Transkrip)
# print(transkrip)

save(transkrip,file = "data_fgd.rda")