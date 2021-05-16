library(dplyr)
library(rvest)
library(ggplot2)
library(ggpubr)

rm(list=ls())

# populasi
url = "https://www.worldometers.info/world-population/population-by-country/"
populasi = read_html(url) %>% html_table(fill = T)
populasi = populasi[[1]]
populasi_clean = populasi %>% janitor::clean_names() %>% select(country_or_dependency,population_2020,land_area_km2)

benford = function(x){
  dummy = substr(x,1,1)
  dummy = as.numeric(dummy)
  dummy = data.frame(id = 1,
                     benford = dummy) %>% 
    mutate(benford = factor(benford,levels = 1:9)) %>% 
    group_by(benford) %>% 
    tally() %>% 
    ungroup() %>% 
    mutate(persen = n/sum(n)*100) %>% 
    filter(!is.na(benford))
  return(dummy)
}

# covid 19
url = "https://en.wikipedia.org/wiki/Template:COVID-19_pandemic_data"
cov = read_html(url) %>% html_table(fill = T)
cov = cov[[1]]
cov_clean = cov %>% janitor::clean_names()

benford(cov_clean$cases_b)

pemilu = "ACEH (99,9%)	402.474	2.387.904
SUMATERA UTARA (99,9%)	3.921.733	3.578.597
SUMATERA BARAT (100%)	407.638	2.485.265
RIAU (100%)	1.246.888	1.973.298
JAMBI (100%)	858.738	1.200.255
SUMATERA SELATAN (98,9%)	1.916.832	2.832.745
BENGKULU (100%)	582.845	585.598
LAMPUNG (100%)	2.845.798	1.951.645
KEPULAUAN BANGKA BELITUNG (100%)	495.500	288.097
KEPULAUAN RIAU (100%)	548.388	462.666
DKI JAKARTA (100%)	3.269.971	3.057.851
JAWA BARAT (100%)	10.729.229	16.044.787
JAWA TENGAH (100%)	16.784.716	4.939.445
DAERAH ISTIMEWA YOGYAKARTA (100%)	1.640.789	735.789
JAWA TIMUR (100%)	16.189.282	8.419.928
BANTEN (100%)	2.530.608	4.045.338
BALI (100%)	2.342.628	212.586
NUSA TENGGARA BARAT (100%)	950.480	2.009.305
NUSA TENGGARA TIMUR (100%)	2.362.041	305.615
KALIMANTAN BARAT (100%)	1.707.147	1.260.600
KALIMANTAN TENGAH (100%)	828.596	536.213
KALIMANTAN SELATAN (100%)	823.219	1.467.906
KALIMANTAN TIMUR (100%)	1.093.148	870.043
SULAWESI UTARA (100%)	1.218.303	359.131
SULAWESI TENGAH (100%)	913.753	705.310
SULAWESI SELATAN (100%)	2.117.839	2.807.109
SULAWESI TENGGARA (100%)	554.247	840.029
GORONTALO (100%)	369.338	344.798
SULAWESI BARAT (100%)	474.852	263.345
MALUKU (99,5%)	591.661	394.493
MALUKU UTARA (100%)	310.585	344.366
PAPUA (79,5%)	2.363.009	211.032
PAPUA BARAT (90,4%)	437.630	108.924
KALIMANTAN UTARA (100%)	247.352	105.498
+Luar Negeri (98,6%)	577.637	223.575"

pemilu = unlist(strsplit(pemilu,"\n"))

data = data.frame(id = 1,hasil = pemilu)

data_pemilu = 
  data %>% tidyr::separate(hasil,
                         into = c("daerah","jomin","prasangka"),
                         sep = "\\t")
benford(c(data_pemilu$jomin,data_pemilu$prasangka))

url = "https://blog.miftahussalam.com/jumlah-ayat-dalam-alquran/"
quran = read_html(url) %>% html_table(fill = T)
quran = quran[[1]]
colnames(quran) = quran[1,]

quran = quran[-1,] %>% janitor::clean_names()
quran = quran %>% filter(!grepl("total",nama_surat,ignore.case = T))
benford(quran$jumlah_ayat)


save(populasi,
     populasi_clean,
     benford,
     cov,
     cov_clean,
     data_pemilu,
     quran,
     file = "~/Documents/ikanx101.github.io/_posts/advance analysis/benford law/bahan blog.rda")

mart = read.csv("/home/ikanx101githubio/Documents/Antara/Pekerjaan Sebelumnya/212 Mart/jan 2020.csv")
benford(mart$harga)
