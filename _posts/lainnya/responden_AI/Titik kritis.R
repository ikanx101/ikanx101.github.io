rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(stringr)
library(ellmer)
library(epoxy)

# model yang digunakan
model = "deepseek-chat"

# buat agent 1
persona_1 =
  glue::glue("Kamu adalah seorang responden survey dengan ciri-ciri sebagai berikut:
  
             1. pria berumur 45 tahun.
             2. bekerja sebagai direktur pada perusahaan penyedia jasa internet.
             3. suka meminum kopi tubruk pada pagi dan malam hari. 
                minum kopi pagi hari setelah shalat shubuh.
                minum kopi malam hari setelah shalat isya.
             4. memiliki hobi menonton film dan series saat waktu luang.
             5. sudah menikah selama 20 tahun dan memiliki 1 orang anak perempuan berusia 12 tahun.
             6. memiliki sosial ekonomi status kelas atas.
             7. rutin berolahraga setiap pagi dengan cara jogging di gym.
             
             kamu akan menjawab semua pertanyaan survey yang diajukan dengan singkat dan lugas.
             ")
resp_1  = chat_deepseek(system_prompt = persona_1,model = model)

# buat agent 2
persona_2 =
  glue::glue("Kamu adalah seorang responden survey dengan ciri-ciri sebagai berikut:
  
             1. pria berumur 45 tahun.
             2. bekerja sebagai direktur pada perusahaan penyedia jasa internet.
             3. suka meminum kopi tubruk pada pagi dan malam hari. 
             4. memiliki hobi menonton film dan series saat waktu luang.
             5. sudah menikah selama 20 tahun.
             6. memiliki sosial ekonomi status kelas atas.
             
             kamu akan menjawab semua pertanyaan survey yang diajukan dengan singkat dan lugas.
             ")
resp_2  = chat_deepseek(system_prompt = persona_2,model = model)

# buat agent 3
persona_3 =
  glue::glue("Kamu adalah seorang responden survey dengan ciri-ciri sebagai berikut:
  
             1. pria berumur 45 tahun.
             2. bekerja sebagai direktur pada perusahaan penyedia jasa internet.
             3. sudah menikah selama 20 tahun.
             4. memiliki sosial ekonomi status kelas atas.
             
             kamu akan menjawab semua pertanyaan survey yang diajukan dengan singkat dan lugas.
             ")
resp_3  = chat_deepseek(system_prompt = persona_3,model = model)

# buat agent 4
persona_4 =
  glue::glue("Kamu adalah seorang responden survey dengan ciri-ciri sebagai berikut:
  
             1. pria berumur 45 tahun.
             2. memiliki sosial ekonomi status kelas atas.
             
             kamu akan menjawab semua pertanyaan survey yang diajukan dengan singkat dan lugas.
             ")
resp_4  = chat_deepseek(system_prompt = persona_4,model = model)

# responden full
persona_5 = readLines("Persona_detail.txt") |> paste(collapse = " ")
persona_5 = stringr::str_squish(persona_5)
persona_5 = 
  glue::glue("Kamu adalah seorang responden survey dengan ciri-ciri sebagai berikut:
             
             ",persona_5,
  "
  
  kamu akan menjawab semua pertanyaan survey yang diajukan dengan singkat dan lugas.
             ")
resp_5    = chat_deepseek(system_prompt = persona_5,model = model)

# Kita akan tanyakan
tanya = glue::glue("Bagaimana pendapat Anda tentang produk minuman buah rendah gula? 
                   Apakah Anda ingin mengkonsumsi produk tersebut?")

# kita tanyakan saja
jawab_1 = resp_1$chat(tanya,echo = F)
jawab_2 = resp_2$chat(tanya,echo = F)
jawab_3 = resp_3$chat(tanya,echo = F)
jawab_4 = resp_4$chat(tanya,echo = F)
jawab_5 = resp_5$chat(tanya,echo = F)

# bikin output dulu
output = data.frame(Responden = paste0("Responden ",1:4),
                    Jawaban   = c(jawab_1,jawab_2,jawab_3,jawab_4))

# save titik kritis 1
save(persona_1,persona_2,persona_3,persona_4,
     jawab_1,jawab_2,jawab_3,jawab_4,
     output,
     persona_5,jawab_5,
     file = "titik_1.rda")

# titik kritis 2

iterasi = 5

for(i in 1:iterasi){
  # lima x
  jawab_1 = resp_1$chat(tanya,echo = F)
  jawab_4 = resp_4$chat(tanya,echo = F)
  jawab_5 = resp_5$chat(tanya,echo = F)
  
  assign(paste0("resp_1_iter_",i),jawab_1)
  assign(paste0("resp_4_iter_",i),jawab_4)
  assign(paste0("resp_5_iter_",i),jawab_5)
  
  cat(i)
}

# kita buatkan outputnya
output_resp_1 = data.frame(Responden = "I",
                           Iterasi   = 1:5,
                           Jawaban   = c(resp_1_iter_1,
                                         resp_1_iter_2,
                                         resp_1_iter_3,
                                         resp_1_iter_4,
                                         resp_1_iter_5))

# kita buatkan outputnya
output_resp_4 = data.frame(Responden = "IV",
                           Iterasi   = 1:5,
                           Jawaban   = c(resp_4_iter_1,
                                         resp_4_iter_2,
                                         resp_4_iter_3,
                                         resp_4_iter_4,
                                         resp_4_iter_5))
# kita buatkan outputnya
output_resp_5 = data.frame(Responden = "V",
                           Iterasi   = 1:5,
                           Jawaban   = c(resp_5_iter_1,
                                         resp_5_iter_2,
                                         resp_5_iter_3,
                                         resp_5_iter_4,
                                         resp_5_iter_5))

save(output_resp_1,output_resp_4,output_resp_5,file = "titik_2.rda")


