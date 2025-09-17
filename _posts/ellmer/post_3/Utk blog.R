rm(list=ls())

library(ellmer)
library(tidyverse)

load("~/ikanx101.github.io/_posts/market riset/post 10/data_survey.rda")

# kita enrich dulu sebentar
input = 
  df_survey %>% 
  mutate(id_responden = 1:365) %>% 
  relocate(id_responden,.before = "gender") %>% 
  rename(awareness = aware)

prompt_viz =
  glue::glue("Kamu adalah asisten AI yang berfungsi sebagai:
             
             1. Expert dalam bahasa R terutama pada:
                Data manipulation menggunakan tidyverse
                Data visualization menggunakan ggplot2 dan library turunannya.
                Machine learning menggunakan caret terutama untuk model random forest dan SVM.
             2. Expert dalam analisis data.
             
             User akan memasukkan data survey dan akan bertanya. Kamu akan menjawab dengan singkat, padat, dan jelas. 
             
             Aturan menjawab:
             
             1. Jika user bertanya tentang kode R, maka jawab dengan tegas kode R yang dibuat tanpa ada penjelasan kode sama sekali.
             2. Jika user bertanya tentang hal selain kode R, maka dari data yang ada, cari jawaban dari pertanyaan user!
             
             ")

# model_1 = "deepseek-chat"
model_1 = "deepseek-reasoner"
chat = chat_deepseek(system_prompt = prompt_viz,
                     model         = model_1)

masukin_pak = function(){
  input
}

# membuat as a tool
get_smart = tool(
  masukin_pak,
  name = "masukin_pak",
  description = "Memasukkan data survey dalam environment Deepseek agar asisten AI bisa membaca input sebagai data dan menjawab pertanyaan dari user"
)

# register ke chat
chat$register_tool(get_smart)

hasil_1 = chat$chat("buat analisa profil responden meliputi gender, usia, dan ses (sosial ekonomi status)")

hasil_2 = chat$chat("buat analisa tentang kolom awareness! buat juga crosstabulasinya dengan profil responden!")

hasil_3 = chat$chat("jika saya hendak meningkatkan awareness, responden tipe apa yang harus saya jadikan target marketing campaign?")

save(hasil_1,hasil_2,hasil_3,file = "tes.rda")

# live_browser(chat)

hasil_4 = chat$chat("jika saya hendak meningkatkan awareness, responden tipe apa yang harus saya jadikan target marketing campaign? Untuk menjawab pertanyaan ini, lakukan analisa korelasi untuk bisa menangkap variabel mana yang berkorelasi dengan awareness. Lakukan juga analisa clustering untuk bisa memetakan kelompok konsumen yang bisa dijadikan target marketing!")

save(hasil_4,file = "best.rda")
