rm(list=ls())

# libraries
library(dplyr)
library(rvest)

# bikin function untuk membersihkan kolom yang berisi angka
bebersih = function(var){
  var = gsub("\\,","",var)
  var = gsub("\\.","",var)
  var = gsub(" ","",var)
  var = as.numeric(var)
}

# mencatat waktu scrape
waktu_scrape = Sys.time() + (7*60^2)

# url
url = "https://www.worldometers.info/coronavirus/"

# scrape
tabel = url %>% read_html() %>% html_table(fill = T)

# ambil data elemen pertama
data = tabel[[1]]

# bebersih nama
raw_data = data %>% janitor::clean_names()
raw_data[is.na(raw_data)] = 0

# kita akan pilihkan beberapa variabel penting
clean_data = 
  raw_data %>%
  select(number,country_other,population,
	 active_cases,total_cases,total_recovered,
	 total_deaths) %>%
  rowwise() %>%
  mutate(population = bebersih(population),
	 active_cases = bebersih(active_cases),
	 total_cases = bebersih(total_cases),
	 total_recovered = bebersih(total_recovered),
	 total_deaths = bebersih(total_deaths)) %>%
  ungroup() %>%
  filter(!is.na(population)) %>%
  mutate(ratio_sakit = round(total_cases/population*100,2),
	 ratio_aktif = round(active_cases/total_cases*100,2),
	 ratio_death = round(total_deaths/total_cases*100,2),
	 ratio_cured = round(total_recovered/total_cases*100,2))

show_data = 
  clean_data %>%
  select(-contains("ratio"))
  
clean_data = 
  clean_data %>%
  select(country_other,contains("ratio")) %>%
  filter(!is.na(ratio_sakit)) %>%
  filter(!is.na(ratio_aktif)) %>%
  filter(!is.na(ratio_death)) %>%
  filter(!is.na(ratio_cured))

save(url,waktu_scrape,raw_data,clean_data,show_data,file = "bahan_blog.rda")
