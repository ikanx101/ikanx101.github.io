# mulai dari hati yang bersih
rm(list = ls())

# panggil libraries
library(dplyr)
library(ggplot2)

# gambar lingkaran
xc = 1
yc = 1
r = 1
ggplot() + annotate("path",
   x=xc+r*cos(seq(0,2*pi,length.out=100)),
   y=yc+r*sin(seq(0,2*pi,length.out=100)))
   
   
# sekarang kita hitung dengan simulasi montecarlo
# kita tentukan terlebih dahulu berapa banyak simulasinya
# ini fungsi utk menghitungnya
set.seed(10104074)
hitung_pi = function(n){
  x = runif(n)
  y = runif(n)
  data = data.frame(x,y)
  data =
    data %>%
    mutate(jatuh = x^2 + y^2,
           ket = ifelse(jatuh <= 1, 1,0))
  return(4 * sum(data$ket)/n)
}

# saatnya simulasi
simulasi = data.frame(
  n = c(10,20,50,75,100,400,600,999,1100,2000,
        3000,5000,7500,10000,20000,30000,500000,
        1000000),
  pi = 0
)

simulasi$pi = sapply(simulasi$n,hitung_pi)
simulasi$beda = pi - simulasi$pi

simulasi

simulasi %>%
    ggplot(aes(x = n,
               y = pi)) +
    geom_line(color = "darkred") +
    labs(title = "Berapa nilai Pi?\nDihitung dengan pendekatan luas lingkaran yang memiliki radius = 1",
        subtitle = "Perhitungan menggunakan simulasi Monte Carlo",
        caption = "Simulasi dan visualisasi\nmenggunakan R\nikanx101.com",
        x = "Banyak Simulasi",
        y = "Nilai aproksimasi") +
        annotate("text",
                 x = 500000, 
                 y = 3.19, 
                 label = paste0("Pi ~ ",simulasi$pi[18],
                                "\nselisih dengan Pi aslinya = ",round(simulasi$beda[18],7))
                 )
