rm(list=ls())

library(rvest)
library(dplyr)
library(stringr)
library(tidyr)

# function utk extract info rumah sakit
extractorizer = function(url){
  data = 
    url %>% 
    read_html() %>% 
    {tibble(
      rs = html_nodes(.,"h5") %>% html_text() %>% str_trim(),
      bed = html_nodes(.,".mb-1+ .mb-0") %>% html_text() %>% str_trim()
    )} 
  data = 
    data %>% 
    mutate(bed = extract_numeric(bed),
           bed = ifelse(is.na(bed),0,bed)) %>% 
    arrange(desc(bed))
  return(data)
}

url = c("https://yankes.kemkes.go.id/app/siranap/rumah_sakit?jenis=1&propinsi=32prop&kabkota=3275",
        "https://yankes.kemkes.go.id/app/siranap/rumah_sakit?jenis=1&propinsi=32prop&kabkota=3216")




df_1 = extractorizer(url[1])
df_2 = extractorizer(url[2])

df_final = 
  rbind(df_1,df_2) %>% 
  arrange(desc(bed))

save(df_final,file = "rs_bekasi.rda")