# dimulai dari nol
rm(list=ls())

# ambil semua library yang diperlukan
library(dplyr)
library(tidyr)
library(janitor)
library(parallel)

# berapa banyak cores?
n_core = 7

# kita buat dulu data surveynya
# function untuk men-generate data survey per orang
survey_donk = function(dummy){
  lokasi = sample(c("a","b","c","d","e","f"),1)
  gender = sample(c("pria","wanita"),
                  1,prob = c(.5,.5))
  usia   = sample(c("< 15 th","16 - 20 th","21 - 25 th","26 - 30 th","> 30 th"),
                  1,prob = c(.1,.15,.35,.2,.1))
  ses    = sample(c("upper","middle"),1,prob = c(.5,.5),replace = T)
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang tom semakin tinggi
  prob_  = ifelse(ses == "upper",.9,.6)
  prob_  = c(prob_,1-prob_)
  tom    = sample(c("ya","tidak"),1,prob = prob_)
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang aided semakin tinggi
  # selain itu, jika pada tom == ya, jangan sampai aidednya menjadi tidak
  prob_  = ifelse(ses == "upper",.99,.8)
  prob_  = c(prob_,1-prob_)
  aided  = ifelse(tom == "ya","ya",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang trial semakin tinggi
  # tapi harus inline dengan aided
  # jangan sampai dia trial tapi aided == tidak
  prob_  = ifelse(ses == "upper",.8,.5)
  prob_  = c(prob_,1-prob_)
  trial  = ifelse(aided == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang repeat semakin rendah
  # tapi harus inline dengan trial
  # jangan sampai dia repeat tapi trial == tidak
  prob_  = ifelse(ses == "upper",.5,.8)
  prob_  = c(prob_,1-prob_)
  repe   = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang last usage semakin tinggi
  # tapi harus inline dengan trial
  # jangan sampai dia last usage tapi trial == tidak
  prob_  = ifelse(ses == "upper",.8,.7)
  prob_  = c(prob_,1-prob_)
  last   = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # kita akan buat conditional
  # seandainya ses nya up, makan peluang future intention semakin tinggi
  # tapi harus inline dengan trial
  # jangan sampai dia future intention tapi trial == tidak
  prob_  = ifelse(ses == "upper",.3,.9)
  prob_  = c(prob_,1-prob_)
  futur  = ifelse(trial == "tidak","tidak",
                  sample(c("ya","tidak"),1,prob = prob_))
  
  # mengeluarkan output dari function
  return(
    data.frame(lokasi,gender,usia,ses,tom,aided,trial,repe,last,futur)
  )
}

# berapa banyak responden
n_resp    = 1000

# proses komputasi paralel
df_survey = mclapply(1:n_resp,survey_donk,mc.cores = n_core)

# kita gabung dalam bentuk data frame
df_survey = 
  data.table::rbindlist(df_survey) %>% 
  as.data.frame() %>% 
  mutate(id = 1:n_resp) %>% 
  relocate(id,.before = "lokasi")

df_survey %>% tabyl(ses)
save(df_survey,file = "survey.rda")



