rm(list=ls())

library(tidyverse)
library(ellmer)

# api key
Sys.setenv(DEEPSEEK_API_KEY="sk")
Sys.setenv(OPENAI_API_KEY="sk")

txt_cerita = readLines("Sups.txt")

prompt_viz =
  glue::glue("Kamu adalah extractor AI.
              User akan memberikan cerita plot dari film.
              Berikan informasi dari cerita tersebut berupa:
                      
              1. peran utama: nama tokoh utama dalam film.
              2. peran lain: nama-nama supporting character dalam film. Gunakan koma sebagai pembatas.
              3. rangkum: rangkuman jalan cerita film dalam 1 kalimat padat dan jelas.
              
              Buat output dalam struktur list terpisah antar ketiga informasi yang didapatkan.
                      ")
model_1 = "deepseek-chat"

chat_1 = chat_deepseek(system_prompt = prompt_viz,
                      model          = model_1)

tes_1 = chat_1$chat(txt_cerita)

# fungsi yang merapikan
buat_df = function(input){
  data.frame(ket = input) |> 
    separate(ket,
             into = c("utama","support","rangkum"),
             sep = "\\\n") |> 
    mutate(utama = gsub("1. peran utama: ","",utama,fixed = T),
           support = gsub("2. peran lain: ","",support,fixed = T),
           rangkum = gsub("3. rangkum: ","",rangkum,fixed = T))
}

buat_df(tes_1) 

# ini adalah fungsi berikutnya
sis_prom = glue::glue("Kamu ada extractor AI.
                      User akan memberikan plot film. Tugas kamu adalah memberikan rangkuman informasi berikut ini:
                      
                      1. nama karakter = nama-nama karakter yang ada pada plot.
                      2. kepribadian = kepribadian karakter tersebut yang dijelaskan dalam satu kalimat.
                      
                      buat output dalam bentuk list.
                      ")

chat_2 = chat_deepseek(system_prompt = sis_prom,
                       model          = model_1)

tes_2 = chat_2$chat(txt_cerita,echo = "none")

data.frame(all = tes_2) |> 
  separate_rows(all,sep = "\\\n") |> 
  separate(all,
           into = c("a1","a2","a3","a4"),
           sep = "\\:") |> 
  select(a2,a3) |> 
  mutate(a2 = gsub('", "kepribadian"','',a2,fixed = T),
         a2 = gsub('\\"','',a2),
         a3 = gsub('\\"','',a3)) |> 
  filter(!is.na(a2)) |> 
  mutate(a2 = stringr::str_squish(a2),
         a3 = stringr::str_squish(a3)) |> 
  rename(karakter = a2,
         kepribadian = a3)
  View()


tbl_2

# pake open ai itu bisa langsung otomatis
prompt_viz =
  stringr::str_squish("Kamu adalah extractor AI.
                      User akan memberikan cerita plot dari film.
                      Berikan informasi dari cerita tersebut
                      ")
chat_2 = chat_openai(system_prompt = prompt_viz)

output_struktur = type_object(
  peran_utama = type_string(description = "Nama tokoh utama"),
  peran_support = type_string(description = "Nama-nama supporting character, gunakan koma sebagai pembatas"),
  cerita = type_string(description = "rangkuman jalan cerita film dalam 1 kalimat padat dan jelas.")
)

tes_2 = chat_2$chat_structured(txt_cerita,type = output_struktur)

tes_2 |> as_tibble()
