---
date: 2021-03-04T10:00:00-04:00
title: "Tutorial Visualisasi di R: Membuat Gantt Chart dengan ggplot2"
categories:
  - Blog
tags:
  - ggplot2
  - Gantt Chart
  - R
  - Machine Learning
  - Artificial Intelligence
---


Selama kerja di bidang *market research*, saya diharuskan membuat
*research proposal* setiap kali hendak memulai suatu *project*. Salah
satu isi yang wajib ada di proposal tersebut adalah perkiraan
*timeline*.

Visualisasi yang sering digunakan untuk menggambarkan *timeline*
pengerjaan *project* adalah *gantt chart*.

Tidak hanya berguna bagi *market research*, setiap pekerjaan yang
berkaitan dengan visualisasi *timeline* biasanya selalu menggunakan
*gantt chart*.

Di **R** kita bisa membuat *gantt chart* dengan berbagai macam cara.
Salah satunya adalah dengan `library(ggplot2)`.

Bagaimana caranya?

-----

# Langkah Pertama

Pertama-tama, siapkan terlebih dahulu data sebagai berikut:

| activity                      | state           | start      | end        |
| :---------------------------- | :-------------- | :--------- | :--------- |
| Pembuatan proposal            | Preparation     | 2021-03-04 | 2021-03-06 |
| Proposal submission           | Preparation     | 2021-03-06 | 2021-03-07 |
| Pembuatan kuesioner           | Preparation     | 2021-03-08 | 2021-03-10 |
| Finalisasi kuesioner          | Preparation     | 2021-03-10 | 2021-03-13 |
| Fieldwork                     | Fieldwork       | 2021-03-14 | 2021-03-23 |
| Quality control               | Fieldwork       | 2021-03-20 | 2021-03-24 |
| Data entry                    | Data Processing | 2021-04-23 | 2021-04-28 |
| Data preparation dan cleaning | Data Processing | 2021-04-29 | 2021-05-05 |
| Data processing               | Data Processing | 2021-05-06 | 2021-05-10 |
| Pembuatan report              | Reporting       | 2021-05-09 | 2021-05-14 |
| Report submission             | Reporting       | 2021-05-15 | 2021-05-21 |
| Presentasi report             | Reporting       | 2021-05-22 | 2021-05-25 |

Data di atas bisa kita siapkan di Excel lalu diimpor ke **R** atau kita
buat langsung di **R** dalam bentuk `data.frame()`.

Misalkan tabel di atas saya simpan sebagai `data.frame()` bernama
`gant`.

``` r
str(gant)
```

    ## 'data.frame':    12 obs. of  4 variables:
    ##  $ activity: chr  "Pembuatan proposal" "Proposal submission" "Pembuatan kuesioner" "Finalisasi kuesioner" ...
    ##  $ state   : chr  "Preparation" "Preparation" "Preparation" "Preparation" ...
    ##  $ start   : chr  "2021-03-04" "2021-03-06" "2021-03-08" "2021-03-10" ...
    ##  $ end     : chr  "2021-03-06" "2021-03-07" "2021-03-10" "2021-03-13" ...

Sebelum saya membuat *gantt chart*-nya, ada beberapa hal yang harus
dilakukan terlebih dahulu:

## Pertama

Mengubah `start` dan `end` ke dalam format `date`. Lalu saya akan buat
`activity` menjadi `factor` agar tidak ada perubahan urutan saat dibuat
*plot*-nya.

``` r
gant$activity = factor(gant$activity,levels = gant$activity)
gant$start = as.Date(gant$start,"%Y-%m-%d")
gant$end = as.Date(gant$end,"%Y-%m-%d")
```

## Kedua

Saya ubah dulu struktur datanya menjadi tabular dengan bantuan
`library(reshape2)` sebagai berikut:

``` r
library(reshape2)

gant_2 = 
  gant %>% 
  melt(id.vars = c("activity","state")) %>% 
  rename(keterangan = variable,
         date = value) 

gant_2
```

    ##                         activity           state keterangan       date
    ## 1             Pembuatan proposal     Preparation      start 2021-03-04
    ## 2            Proposal submission     Preparation      start 2021-03-06
    ## 3            Pembuatan kuesioner     Preparation      start 2021-03-08
    ## 4           Finalisasi kuesioner     Preparation      start 2021-03-10
    ## 5                      Fieldwork       Fieldwork      start 2021-03-14
    ## 6                Quality control       Fieldwork      start 2021-03-20
    ## 7                     Data entry Data Processing      start 2021-04-23
    ## 8  Data preparation dan cleaning Data Processing      start 2021-04-29
    ## 9                Data processing Data Processing      start 2021-05-06
    ## 10              Pembuatan report       Reporting      start 2021-05-09
    ## 11             Report submission       Reporting      start 2021-05-15
    ## 12             Presentasi report       Reporting      start 2021-05-22
    ## 13            Pembuatan proposal     Preparation        end 2021-03-06
    ## 14           Proposal submission     Preparation        end 2021-03-07
    ## 15           Pembuatan kuesioner     Preparation        end 2021-03-10
    ## 16          Finalisasi kuesioner     Preparation        end 2021-03-13
    ## 17                     Fieldwork       Fieldwork        end 2021-03-23
    ## 18               Quality control       Fieldwork        end 2021-03-24
    ## 19                    Data entry Data Processing        end 2021-04-28
    ## 20 Data preparation dan cleaning Data Processing        end 2021-05-05
    ## 21               Data processing Data Processing        end 2021-05-10
    ## 22              Pembuatan report       Reporting        end 2021-05-14
    ## 23             Report submission       Reporting        end 2021-05-21
    ## 24             Presentasi report       Reporting        end 2021-05-25

## *Final Step*

Sekarang bagian terakhirnya, kita akan buat *gantt chart*-nya:

``` r
library(ggplot2)

gant_2 %>% 
  ggplot(aes(date,activity,color = state)) +
  geom_line(aes(group = activity),size = 10) +
  theme_minimal() +
  labs(title = "Timeline Project Research",
       subtitle = "Sebuah Proposal",
       x = "Tanggal",
       y = "Aktivitas",
       color = "Keterangan")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/ggplot/gant%20chart/post_files/figure-gfm/unnamed-chunk-5-1.png" width="672" style="display: block; margin: auto;" />

-----

`if you find this article helpful, support this blog by clicking the ads
shown`.
