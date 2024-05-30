---
date: 2024-05-30T17:04:00-04:00
title: "Data Cuaca yang Dikumpulkan Otomatis dengan Github Action"
categories:
  - Blog
tags:
  - Github
  - Github Action
  - Artificial Intelligence
  - Web Scraping
  - Cuaca
  - Otomasi
---

Pada 2021 lalu, saya sempat menuliskan bagaimana cara mendapatkan data
cuaca *real time* dari [situs
*openweathermap*](https://ikanx101.com/blog/open-cuaca/). Beberapa bulan
lalu, saya juga menuliskan bagaimana cara membuat Github bisa melakukan
[*web scrape* secara otomatis](https://ikanx101.com/blog/gh-action/).

Nah, kali ini saya akan mengawinkan kedua teknik tersebut agar Github
bisa *web scrape* data cuaca *real time* per dua jam sekali.

*Workflow* github *action*-nya saya buat seperti ini:

    on:
      #push:
        #branches: main
      schedule:
        - cron: "0 */2 * * *"  # run every 3 hrs
        
    jobs:
      import-data:
        runs-on: ubuntu-latest
        steps:
          - name: Set up R
            uses: r-lib/actions/setup-r@v2

          - name: Install packages
            uses: r-lib/actions/setup-r-dependencies@v2
            with:
              packages: |
                any::dplyr 
                any::jsonlite

          - name: Check out repository
            uses: actions/checkout@v3

          - name: Import data
            run: Rscript -e 'source("real feel.R")'

          - name: Commit results
            run: |
              git config --local user.email "xxx@gmail.com"
              git config --local user.name "xx"
              git add .
              git commit -m 'Data updated' 
              git push 

Sementara skrip algoritma *web scrape*-nya saya simpan sebagai
`real feel.R` (silakan lihat *postingan* [saya
sebelumnya](https://ikanx101.com/blog/open-cuaca/)).

Apa saja data yang saya dapatkan? Berikut adalah *variables*-nya:

     [1] "kota"           "kondisi"        "detail_kondisi" "suhu"          
     [5] "suhu_min"       "suhu_max"       "feel_like"      "humidity"      
     [9] "lon"            "lat"            "waktu"          "pressure"      
    [13] "wind_spd"      

Kenapa mengambil data cuaca dari situs [Open Weather
Map](openweathermap.org)? Alasannya:

1.  **BMKG**:
    - **API** dari situs **BMKG** tidak *reliable* dan sulit digunakan.
    - Tidak ada data *real feel* di situs **BMKG**.
2.  [Open Weather Map](openweathermap.org):
    - API dari [Open Weather Map](openweathermap.org) cukup *reliable*
      untuk diambil datanya **per dua jam**.
    - Ada data *real feel*.
    - Cakupan kota lumayan.
    - Proses *scrape* bisa dilakukan otomatis tanpa supervisi sama
      sekali.

------------------------------------------------------------------------

# DATA YANG DIAMBIL

Pada bagian ini, saya akan tunjukkan beberapa data cuaca di kota
**Semarang, Jakarta, dan Surabaya**. Namun saya akan menggunakan data
cuaca pada waktu jam kerja saja, yakni **pukul 08.00 - 18.00**.

## Sebaran Data

Berikut adalah sebaran data di kota-kota tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-4-1.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-4-2.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-4-3.png"
data-fig-align="center" />

## *Trend Feel Like*

Berikut adalah *trend feel like* dari kota-kota tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-5-1.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-5-2.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-5-3.png"
data-fig-align="center" />

## *Trend Humidity*

Berikut adalah *trend humidity* dari kota-kota tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-6-1.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-6-2.png"
data-fig-align="center" />

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/github/cuaca/post_files/figure-commonmark/unnamed-chunk-6-3.png"
data-fig-align="center" />

---

`if you find this article helpful, support this blog by clicking the ads.`