---
date: 2023-10-11T09:21:00-04:00
title: "Mengubah Grafik ggplot2 Menjadi Bentuk Tiga Dimensi"
categories:
  - Blog
tags:
  - ggplot2
  - Gantt Chart
  - R
  - Machine Learning
  - Artificial Intelligence
  - Data Viz
---


> Salah satu kelebihan **R** dibanding *Python* adalah keberadaan
> *library* visualisasi data seperti `ggplot2` dan `plotly`.

Setidaknya itu adalah komentar dari beberapa rekan saya pengguna
`Python`.

*Jujurly*, saya sangat menyukai keluwesan `ggplot2` untuk membuat *plot*
atau grafik. Saya pernah menuliskan bagaimana `ggplot2` bisa digunakan
untuk menggambar [fungsi
matematika](https://ikanx101.com/blog/lukis-fx/) dan [graf
matematika](https://ikanx101.com/blog/ggplot-graf/).

Pada tulisan saya tentang [*geomarketing*
lalu](https://ikanx101.com/blog/geomkt-bks/), seorang pembaca memberukan
komentar:

> *Tulisannya bagus tapi grafiknya kalau dibuat oleh orang desain, pasti
> lebih bagus.*

Bukan untuk *self defense*, tapi memang grafik tersebut saya buat sangat
sederhana karena saya lebih fokus untuk membangun algoritma
*geomarketing*-nya.

*Nah*, pada tulisan kali ini saya akan membuat grafik `ggplot2` lebih
“cantik” lagi dengan membuatnya menjadi grafik tiga dimensi dengan
bantuan `library(rayshader)`.

Sebagai contoh, saya akan membuat grafik dari data `mtcars` sebagai
berikut:

``` r
library(dplyr)
library(ggplot2)
library(rayshader)

mtplot = 
  mtcars %>% 
  ggplot() + 
  geom_point(aes(x    = hp,
                 y    = qsec,
                color = am)) + 
  labs(title    = "HP vs QSEC",
       subtitle = "Data mtcars",
       caption  = "Dibuat dengan R\nikanx101.com")

mtplot
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ggplot/3d%20rayshader/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />

Saya akan buat *shading* cahaya sebagai berikut:

``` r
plot_gg(mtplot, 
        width    = 5,
        sunangle = 225, 
        preview  = TRUE)
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ggplot/3d%20rayshader/post_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Sekarang saya akan ubah sudut rotasinya:

``` r
plot_gg(mtplot, 
        width     = 5, 
        multicore = TRUE, 
        sunangle  = 225,
        zoom      = 0.8, 
        phi       = 45, 
        theta     = 45)
render_snapshot()
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ggplot/3d%20rayshader/post_files/figure-gfm/unnamed-chunk-3-1.png" width="672" style="display: block; margin: auto;" />

------------------------------------------------------------------------

Bagaimana? Menarik kan?

`if you find this article helpful, support this blog by clicking the ads.`
