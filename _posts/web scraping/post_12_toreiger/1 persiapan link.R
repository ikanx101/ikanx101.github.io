rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(parallel)

ncore = detectCores()

url_torch = c("https://www.tokopedia.com/torch-id/product",
              paste0("https://www.tokopedia.com/torch-id/product/page/",2:19))

eiger_url = c("https://www.tokopedia.com/eigeradventure/product",
              paste0("https://www.tokopedia.com/eigeradventure/product/page/",2:61))

vektor_teks = c(url_torch,eiger_url)

# Format setiap elemen dengan sprintf
teks_berformat <- sprintf("'%s'", vektor_teks)
hasil_gabungan <- paste(teks_berformat, collapse = ",")

# teks_berformat <- sprintf("%s", vektor_teks)
# hasil_gabungan <- paste(teks_berformat, collapse = "\n")

# Menampilkan hasil
sink("copas.txt")
cat(hasil_gabungan)
sink()