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
waktu_scrape = Sys.time()

# url
url = "https://www.worldometers.info/coronavirus/"

# scrape
tabel = url %>% read_html() %>% html_table(fill = T)

# ambil data elemen pertama
data = tabel[[1]]

# bebersih nama
raw_data = data %>% janitor::clean_names()

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
  mutate(ratio_sakit = total_cases/population,
	 ratio_aktif = active_cases/total_cases,
	 ratio_death = total_deaths/total_cases,
	 ratio_cured = total_recovered/total_cases)

save(url,waktu_scrape,raw_data,clean_data,file = "bahan_blog.rda")
