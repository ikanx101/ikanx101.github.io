rm(list=ls())

library(ellmer)
library(tidyverse)

# kita ambil persona masing-masing responden
persona_1 = readLines("resp_1.txt")
persona_2 = readLines("resp_2.txt")
persona_3 = readLines("resp_3.txt")


# 1. Definisi Panel Responden (Persona)
# Kita simpan dalam list agar mudah di-looping
panel_responden <- list(
  "Budi" = chat_deepseek(
    system_prompt = "Nama Anda Budi, bapak-bapak hemat. Fokus pada harga dan value for money."
  ),
  "Santi" = chat_deepseek(
    system_prompt = "Nama Anda Santi, aktivis lingkungan. Fokus pada keberlanjutan dan etika produk."
  ),
  "Rara" = chat_deepseek(
    system_prompt = "Nama Anda Rara, selebgram. Fokus pada desain kemasan dan apakah produk ini layak diposting."
  )
)

# 2. Stimulus dari Moderator
stimulus <- "Bagaimana pendapat kalian jika sabun cuci Eco-Clean seharga 45rb ini tidak menggunakan botol, 
tapi dalam bentuk tablet yang harus dilarutkan sendiri di rumah?"

# Wadah untuk menyimpan transkrip
transkrip <- tibble(pemeran = "Moderator", dialog = stimulus)

# 3. Proses Looping Diskusi
# Kita akan jalankan 2 putaran (round) diskusi
jumlah_putaran <- 2
konteks_terakhir <- stimulus

for (i in 1:jumlah_putaran) {
  message(paste("--- Memulai Putaran ke-", i, "---"))
  
  # Setiap persona dalam list akan menanggapi
  for (nama_agen in names(panel_responden)) {
    
    # Agen mengambil session chat mereka
    agen_sekarang <- panel_responden[[nama_agen]]
    
    # Agen menanggapi berdasarkan konteks terakhir (ucapan orang sebelumnya)
    respon <- agen_sekarang$chat(paste("Konteks diskusi saat ini:", konteks_terakhir, 
                                       ". Apa pendapatmu?"))
    
    # Simpan ke transkrip
    transkrip <- 
      transkrip %>% 
      add_row(pemeran = nama_agen, dialog = as.character(respon))
    
    # Update konteks terakhir agar agen berikutnya bisa menanggapi agen ini
    konteks_terakhir <- respon
    
    cat(paste0("\n", nama_agen, ": ", respon, "\n"))
  }
}

# 4. Hasil Akhir (Tabel Transkrip)
print(transkrip)