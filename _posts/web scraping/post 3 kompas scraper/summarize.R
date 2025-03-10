library(katadasaR)
library(stringdist)

mobil = 
  mobil %>% 
  mutate(berita = janitor::make_clean_names(berita),
         berita = gsub("\\_"," ",berita))


# ===================================
# hitung score
# stop words
stop = readLines("https://raw.githubusercontent.com/ikanx101/ID-Stopwords/master/id.stopwords.02.01.2016.txt")

# fungsi stemming
stem_ikanx = function(kata){
  hasil = katadasar(kata)
  hasil = unlist(hasil) 
  hasil = hasil[nchar(hasil) == max(nchar(hasil))]
  hasil = ifelse(length(hasil) == 1,hasil,NA)
  return(hasil)
}

# process hitung score
stem_data = 
  mobil %>% 
  unnest_tokens(kata,berita,"words") %>% 
  filter(!kata %in% stop) %>% 
  mutate(penanda = as.numeric(kata)) %>% 
  filter(is.na(penanda)) %>% 
  select(-penanda)

stem_data
dbase_score = 
  stem_data %>% 
  group_by(kata) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  mutate(score = n/sum(n))

hasil = 
  stem_data %>% 
  merge(dbase_score) %>% 
  group_by(id_paragraf,id_kalimat) %>% 
  summarise(kalimat = paste(word_stemmed,collapse = " "),
            score = sum(score)/n()) %>% 
  ungroup()

# hanya mengambil kalimat dengan nilai terbaik 
hasil_importance = hasil
matrix = stringsimmatrix(hasil_importance$kalimat,method = "cosine")
hasil_importance$degree_kalimat = evcent(matrix)

hasil_new = 
  hasil_importance %>% 
  group_by(id_paragraf) %>% 
  mutate(mean_degree = mean(degree_kalimat),
         mean_score = mean(score)) %>% 
  ungroup() %>%
  rowwise() %>% 
  filter(degree_kalimat > mean_degree & score > mean_score) %>% 
  ungroup()

summary_all = 
  referensi %>% 
  filter(id_kalimat %in% hasil_new$id_kalimat) %>% 
  summarise(all = paste(kalimat,collapse = ". "))

kesimpulan = trimws(summary_all$all)
kesimpulan = gsub('\\[([0-9]+)\\]', '', kesimpulan)

sink("hasil_summarizing_wumard.txt")
print(kesimpulan)
sink()
