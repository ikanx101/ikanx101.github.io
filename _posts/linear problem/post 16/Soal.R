rm(list=ls())

library(dplyr)
library(tidyr)

# diketahui
# banyak team member 5
# banyak hari 5
# banyak jam kerja perhari 7
# maks boleh lembur 2 jam, maks 2 x seminggu

4*4*7

n_kerjaan = 35
df_req    = data.frame(kegiatan    = paste("kegiatan",
                                           1:n_kerjaan),
                       waktu_kerja = sample(6,
                                            n_kerjaan,
                                            prob = c(.5,.5,.3,
                                                     .3,.3,.1),
                                            replace = T))

sum(df_req$waktu_kerja)

save(df_req,file = "soal 2.rda")
