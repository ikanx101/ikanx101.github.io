---
date: 2021-03-24T14:45:00-04:00
title: "Tutorial Data Carpentry: Ngoprek Data mtcars dan Covid19"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Covid
  - Corona
  - Covid 19
  - Data Manipulation
  - Data Carpentry
  - mtcars
  - Tidyverse
---

Akibat kesibukan beberapa hari belakangan ini di kantor, saya belum
sempat *update* blog ini. Kali ini saya mau *post* sesuatu yang
ringan-ringan saja dulu *yah*.

## *Training Refreshment* **R**

Seperti yang sudah pernah saya ceritakan di blog saya
[dulu](https://ikanx101.com/blog/training-replikasi/), saya dan beberapa
rekan menginisiasi *training data science* menggunakan **R**. *Training*
tersebut sudah selesai dilakukan tahun lalu.

Kemarin beberapa rekan meminta saya untuk mengadakan *refreshment
training* **R**. Kebetulan juga, di malam harinya salah seorang *mentee*
meminta saya untuk memberikan tugas kepada dia sebagai latihan. Sontak
saja saya berikan tugas yang sama dengan materi *refreshment* yang saya
berikan di kantor.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/data%20carpentry/mtcars%20dan%20covid/discord.jpg" width="560" style="display: block; margin: auto;" />

------------------------------------------------------------------------

> ***Apa sih materinya?***

## *Data Carpentry*

Kali ini saya akan memberikan *tutorial data carpentry* menggunakan
prinsip **Tidyverse** di **R** untuk membersihkan data dan melakukan
analisa sederhana.

Ada dua *datasets* yang saya gunakan:

1.  `mtcars`: data yang sudah *pre-installed* di **R** berisi *spec*
    beberapa varian mobil.
2.  Data Covid 19 per negara yang akan saya *scrape* *realtime*.

Pada tutorial ini, saya hanya akan menggunakan dua *libraries* dari
**Tidyverse**, yakni:

``` r
library(dplyr) # library utk data carpentry
library(tidyr) # library utk data carpentry juga - function pamungkas yang sering saya pakai dari library ini adalah separate()
```

### Part 1: `mtcars`

`mtcars` adalah *dataset* standar yang paling sering digunakan untuk
bahan *training* di **R**. *Dataset* ini berisi spesifikasi dari
beberapa varian mobil. Berikut adalah datanya:

|                     | mpg  | cyl | disp  | hp  | drat |  wt   | qsec  | vs  | am  | gear | carb |
|:--------------------|:----:|:---:|:-----:|:---:|:----:|:-----:|:-----:|:---:|:---:|:----:|:----:|
| Mazda RX4           | 21.0 |  6  | 160.0 | 110 | 3.90 | 2.620 | 16.46 |  0  |  1  |  4   |  4   |
| Mazda RX4 Wag       | 21.0 |  6  | 160.0 | 110 | 3.90 | 2.875 | 17.02 |  0  |  1  |  4   |  4   |
| Datsun 710          | 22.8 |  4  | 108.0 | 93  | 3.85 | 2.320 | 18.61 |  1  |  1  |  4   |  1   |
| Hornet 4 Drive      | 21.4 |  6  | 258.0 | 110 | 3.08 | 3.215 | 19.44 |  1  |  0  |  3   |  1   |
| Hornet Sportabout   | 18.7 |  8  | 360.0 | 175 | 3.15 | 3.440 | 17.02 |  0  |  0  |  3   |  2   |
| Valiant             | 18.1 |  6  | 225.0 | 105 | 2.76 | 3.460 | 20.22 |  1  |  0  |  3   |  1   |
| Duster 360          | 14.3 |  8  | 360.0 | 245 | 3.21 | 3.570 | 15.84 |  0  |  0  |  3   |  4   |
| Merc 240D           | 24.4 |  4  | 146.7 | 62  | 3.69 | 3.190 | 20.00 |  1  |  0  |  4   |  2   |
| Merc 230            | 22.8 |  4  | 140.8 | 95  | 3.92 | 3.150 | 22.90 |  1  |  0  |  4   |  2   |
| Merc 280            | 19.2 |  6  | 167.6 | 123 | 3.92 | 3.440 | 18.30 |  1  |  0  |  4   |  4   |
| Merc 280C           | 17.8 |  6  | 167.6 | 123 | 3.92 | 3.440 | 18.90 |  1  |  0  |  4   |  4   |
| Merc 450SE          | 16.4 |  8  | 275.8 | 180 | 3.07 | 4.070 | 17.40 |  0  |  0  |  3   |  3   |
| Merc 450SL          | 17.3 |  8  | 275.8 | 180 | 3.07 | 3.730 | 17.60 |  0  |  0  |  3   |  3   |
| Merc 450SLC         | 15.2 |  8  | 275.8 | 180 | 3.07 | 3.780 | 18.00 |  0  |  0  |  3   |  3   |
| Cadillac Fleetwood  | 10.4 |  8  | 472.0 | 205 | 2.93 | 5.250 | 17.98 |  0  |  0  |  3   |  4   |
| Lincoln Continental | 10.4 |  8  | 460.0 | 215 | 3.00 | 5.424 | 17.82 |  0  |  0  |  3   |  4   |
| Chrysler Imperial   | 14.7 |  8  | 440.0 | 230 | 3.23 | 5.345 | 17.42 |  0  |  0  |  3   |  4   |
| Fiat 128            | 32.4 |  4  | 78.7  | 66  | 4.08 | 2.200 | 19.47 |  1  |  1  |  4   |  1   |
| Honda Civic         | 30.4 |  4  | 75.7  | 52  | 4.93 | 1.615 | 18.52 |  1  |  1  |  4   |  2   |
| Toyota Corolla      | 33.9 |  4  | 71.1  | 65  | 4.22 | 1.835 | 19.90 |  1  |  1  |  4   |  1   |
| Toyota Corona       | 21.5 |  4  | 120.1 | 97  | 3.70 | 2.465 | 20.01 |  1  |  0  |  3   |  1   |
| Dodge Challenger    | 15.5 |  8  | 318.0 | 150 | 2.76 | 3.520 | 16.87 |  0  |  0  |  3   |  2   |
| AMC Javelin         | 15.2 |  8  | 304.0 | 150 | 3.15 | 3.435 | 17.30 |  0  |  0  |  3   |  2   |
| Camaro Z28          | 13.3 |  8  | 350.0 | 245 | 3.73 | 3.840 | 15.41 |  0  |  0  |  3   |  4   |
| Pontiac Firebird    | 19.2 |  8  | 400.0 | 175 | 3.08 | 3.845 | 17.05 |  0  |  0  |  3   |  2   |
| Fiat X1-9           | 27.3 |  4  | 79.0  | 66  | 4.08 | 1.935 | 18.90 |  1  |  1  |  4   |  1   |
| Porsche 914-2       | 26.0 |  4  | 120.3 | 91  | 4.43 | 2.140 | 16.70 |  0  |  1  |  5   |  2   |
| Lotus Europa        | 30.4 |  4  | 95.1  | 113 | 3.77 | 1.513 | 16.90 |  1  |  1  |  5   |  2   |
| Ford Pantera L      | 15.8 |  8  | 351.0 | 264 | 4.22 | 3.170 | 14.50 |  0  |  1  |  5   |  4   |
| Ferrari Dino        | 19.7 |  6  | 145.0 | 175 | 3.62 | 2.770 | 15.50 |  0  |  1  |  5   |  6   |
| Maserati Bora       | 15.0 |  8  | 301.0 | 335 | 3.54 | 3.570 | 14.60 |  0  |  1  |  5   |  8   |
| Volvo 142E          | 21.4 |  4  | 121.0 | 109 | 4.11 | 2.780 | 18.60 |  1  |  1  |  4   |  2   |

Tujuan utama dari *data carpentry* ini adalah untuk menjawab dua
pertanyaan berikut ini:

1.  Merek mobil apa yang memiliki rata-rata *horse power* tertinggi dan
    *miles per gallon* terendah?
2.  Apakah ada perbedaan keiritan bahan bakar antara mobil *matic* dan
    manual dari data tersebut?

Sebelum melakukan analisa, saya selalu membiasakan untuk melihat
struktur dari *dataset* tersebut. Kenapa?

> ***Dengan melihat struktur data, kita bisa mengukur seberapa jauh kita
> akan melakukan data preparation dan data cleaning.***

Berdasarkan pengalaman saya, sangat jarang suatu *raw data* bisa
langsung dianalisa dan dibuat visualisasinya. Langkah *proper* yang
biasanya harus dilalui adalah:

<img src="https://raw.githubusercontent.com/ikanx101/Live-Session-Nutrifood-R/master/LEFO%20Market%20Research/NRC%20Grant/getting.png" style="display: block; margin: auto;" />

Untuk kasus *dataset* `mtcars`, saya hanya akan melakukan *data
preparation*. Saya asumsikan semua data yang ada di sana sudah benar
secara kaidah statistik (terkait *extreme values*)

#### Cek Struktur Data dengan *Function* `str()`

Sekarang kita cek struktur data `mtcars`.

``` r
str(mtcars)
```

    ## 'data.frame':    32 obs. of  11 variables:
    ##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
    ##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
    ##  $ disp: num  160 160 108 258 360 ...
    ##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
    ##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
    ##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
    ##  $ qsec: num  16.5 17 18.6 19.4 17 ...
    ##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
    ##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
    ##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
    ##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

Dari temuan di atas, sudah terlihat jelas apa saja yang harus kita
lakukan untuk *data preparation*, yakni:

1.  Dari tabel sebelumnya, nama varian mobil muncul **tapi** pada saat
    kita lihat struktur datanya **tidak ada sama sekali** variabel yang
    menunjukkan varian mobil.
2.  Belum ada variabel yang menunjukkan info merek mobil.
3.  Variabel `am` yang menunjukkan jenis transmisi mobil (manual atau
    *matic*) di kenali sebagai variabel bertipe `numeric`.

#### Data Preparation

Berikut ini adalah langkah-langkah yang akan saya kerjakan di **R** dari
tiga poin di atas:

1.  Membuat variabel baru bernama `varian_mobil` yang isinya merupakan
    `row.names` dari `mtcars`. Setelah itu saya akan menghapus
    `row.names` karena sudah tidak diperlukan.
2.  Membuat variabel baru bernama `merek_mobil` yang isinya merupakan
    **kata pertama** dari variabel `varian_mobil`. Untuk melakukannya,
    saya akan menggunakan *function* `separate()`.
3.  Mengubah `am` menjadi variabel bertipe `factor` berisi `0` untuk
    manual dan `1` untuk *matic*.

Perlu saya sampaikan bahwa cara saya ini bukanlah satu-satunya. Jika
rekan-rekan memiliki cara lain yang lebih *simple*, *feel free yah*.

``` r
clean_data = 
  # memanggil dataset mtcars
  mtcars %>% 
  # membuat variabel varian mobil dan 
  # dummy merek untuk kemudian ekstrak merek
  mutate(varian_mobil = row.names(mtcars),
         dummy_merek = varian_mobil) %>% 
  # ekstrak merek mobil
  separate(dummy_merek,
           into = "merek_mobil",
           sep = " ") %>% 
  # mengubah am menjadi factor
  mutate(am = ifelse(am == 0,
                     "manual",
                     "matic"),
         am = factor(am, 
                     levels = c("manual","matic")
                     )
         ) %>% 
  # mengurutkan variabel merek dan varian mobil menjadi 
  # urutan paling kiri dalam tabel 
  relocate(merek_mobil,varian_mobil,.before = mpg)

# hapus row names karena sudah tidak diperlukan
row.names(clean_data) = NULL
```

Berikut adalah hasil *data preparation* yang sudah saya lakukan di atas:

| merek\_mobil |    varian\_mobil    | mpg  | cyl | disp  | hp  | drat |  wt   | qsec  | vs  |   am   | gear | carb |
|:------------:|:-------------------:|:----:|:---:|:-----:|:---:|:----:|:-----:|:-----:|:---:|:------:|:----:|:----:|
|    Mazda     |      Mazda RX4      | 21.0 |  6  | 160.0 | 110 | 3.90 | 2.620 | 16.46 |  0  | matic  |  4   |  4   |
|    Mazda     |    Mazda RX4 Wag    | 21.0 |  6  | 160.0 | 110 | 3.90 | 2.875 | 17.02 |  0  | matic  |  4   |  4   |
|    Datsun    |     Datsun 710      | 22.8 |  4  | 108.0 | 93  | 3.85 | 2.320 | 18.61 |  1  | matic  |  4   |  1   |
|    Hornet    |   Hornet 4 Drive    | 21.4 |  6  | 258.0 | 110 | 3.08 | 3.215 | 19.44 |  1  | manual |  3   |  1   |
|    Hornet    |  Hornet Sportabout  | 18.7 |  8  | 360.0 | 175 | 3.15 | 3.440 | 17.02 |  0  | manual |  3   |  2   |
|   Valiant    |       Valiant       | 18.1 |  6  | 225.0 | 105 | 2.76 | 3.460 | 20.22 |  1  | manual |  3   |  1   |
|    Duster    |     Duster 360      | 14.3 |  8  | 360.0 | 245 | 3.21 | 3.570 | 15.84 |  0  | manual |  3   |  4   |
|     Merc     |      Merc 240D      | 24.4 |  4  | 146.7 | 62  | 3.69 | 3.190 | 20.00 |  1  | manual |  4   |  2   |
|     Merc     |      Merc 230       | 22.8 |  4  | 140.8 | 95  | 3.92 | 3.150 | 22.90 |  1  | manual |  4   |  2   |
|     Merc     |      Merc 280       | 19.2 |  6  | 167.6 | 123 | 3.92 | 3.440 | 18.30 |  1  | manual |  4   |  4   |
|     Merc     |      Merc 280C      | 17.8 |  6  | 167.6 | 123 | 3.92 | 3.440 | 18.90 |  1  | manual |  4   |  4   |
|     Merc     |     Merc 450SE      | 16.4 |  8  | 275.8 | 180 | 3.07 | 4.070 | 17.40 |  0  | manual |  3   |  3   |
|     Merc     |     Merc 450SL      | 17.3 |  8  | 275.8 | 180 | 3.07 | 3.730 | 17.60 |  0  | manual |  3   |  3   |
|     Merc     |     Merc 450SLC     | 15.2 |  8  | 275.8 | 180 | 3.07 | 3.780 | 18.00 |  0  | manual |  3   |  3   |
|   Cadillac   | Cadillac Fleetwood  | 10.4 |  8  | 472.0 | 205 | 2.93 | 5.250 | 17.98 |  0  | manual |  3   |  4   |
|   Lincoln    | Lincoln Continental | 10.4 |  8  | 460.0 | 215 | 3.00 | 5.424 | 17.82 |  0  | manual |  3   |  4   |
|   Chrysler   |  Chrysler Imperial  | 14.7 |  8  | 440.0 | 230 | 3.23 | 5.345 | 17.42 |  0  | manual |  3   |  4   |
|     Fiat     |      Fiat 128       | 32.4 |  4  | 78.7  | 66  | 4.08 | 2.200 | 19.47 |  1  | matic  |  4   |  1   |
|    Honda     |     Honda Civic     | 30.4 |  4  | 75.7  | 52  | 4.93 | 1.615 | 18.52 |  1  | matic  |  4   |  2   |
|    Toyota    |   Toyota Corolla    | 33.9 |  4  | 71.1  | 65  | 4.22 | 1.835 | 19.90 |  1  | matic  |  4   |  1   |
|    Toyota    |    Toyota Corona    | 21.5 |  4  | 120.1 | 97  | 3.70 | 2.465 | 20.01 |  1  | manual |  3   |  1   |
|    Dodge     |  Dodge Challenger   | 15.5 |  8  | 318.0 | 150 | 2.76 | 3.520 | 16.87 |  0  | manual |  3   |  2   |
|     AMC      |     AMC Javelin     | 15.2 |  8  | 304.0 | 150 | 3.15 | 3.435 | 17.30 |  0  | manual |  3   |  2   |
|    Camaro    |     Camaro Z28      | 13.3 |  8  | 350.0 | 245 | 3.73 | 3.840 | 15.41 |  0  | manual |  3   |  4   |
|   Pontiac    |  Pontiac Firebird   | 19.2 |  8  | 400.0 | 175 | 3.08 | 3.845 | 17.05 |  0  | manual |  3   |  2   |
|     Fiat     |      Fiat X1-9      | 27.3 |  4  | 79.0  | 66  | 4.08 | 1.935 | 18.90 |  1  | matic  |  4   |  1   |
|   Porsche    |    Porsche 914-2    | 26.0 |  4  | 120.3 | 91  | 4.43 | 2.140 | 16.70 |  0  | matic  |  5   |  2   |
|    Lotus     |    Lotus Europa     | 30.4 |  4  | 95.1  | 113 | 3.77 | 1.513 | 16.90 |  1  | matic  |  5   |  2   |
|     Ford     |   Ford Pantera L    | 15.8 |  8  | 351.0 | 264 | 4.22 | 3.170 | 14.50 |  0  | matic  |  5   |  4   |
|   Ferrari    |    Ferrari Dino     | 19.7 |  6  | 145.0 | 175 | 3.62 | 2.770 | 15.50 |  0  | matic  |  5   |  6   |
|   Maserati   |    Maserati Bora    | 15.0 |  8  | 301.0 | 335 | 3.54 | 3.570 | 14.60 |  0  | matic  |  5   |  8   |
|    Volvo     |     Volvo 142E      | 21.4 |  4  | 121.0 | 109 | 4.11 | 2.780 | 18.60 |  1  | matic  |  4   |  2   |

Setelah rapi seperti di atas, mari kita lihat *summary statistics*-nya:

``` r
summary(clean_data)
```

    ##  merek_mobil        varian_mobil            mpg             cyl       
    ##  Length:32          Length:32          Min.   :10.40   Min.   :4.000  
    ##  Class :character   Class :character   1st Qu.:15.43   1st Qu.:4.000  
    ##  Mode  :character   Mode  :character   Median :19.20   Median :6.000  
    ##                                        Mean   :20.09   Mean   :6.188  
    ##                                        3rd Qu.:22.80   3rd Qu.:8.000  
    ##                                        Max.   :33.90   Max.   :8.000  
    ##       disp             hp             drat             wt       
    ##  Min.   : 71.1   Min.   : 52.0   Min.   :2.760   Min.   :1.513  
    ##  1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080   1st Qu.:2.581  
    ##  Median :196.3   Median :123.0   Median :3.695   Median :3.325  
    ##  Mean   :230.7   Mean   :146.7   Mean   :3.597   Mean   :3.217  
    ##  3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920   3rd Qu.:3.610  
    ##  Max.   :472.0   Max.   :335.0   Max.   :4.930   Max.   :5.424  
    ##       qsec             vs              am          gear            carb      
    ##  Min.   :14.50   Min.   :0.0000   manual:19   Min.   :3.000   Min.   :1.000  
    ##  1st Qu.:16.89   1st Qu.:0.0000   matic :13   1st Qu.:3.000   1st Qu.:2.000  
    ##  Median :17.71   Median :0.0000               Median :4.000   Median :2.000  
    ##  Mean   :17.85   Mean   :0.4375               Mean   :3.688   Mean   :2.812  
    ##  3rd Qu.:18.90   3rd Qu.:1.0000               3rd Qu.:4.000   3rd Qu.:4.000  
    ##  Max.   :22.90   Max.   :1.0000               Max.   :5.000   Max.   :8.000

Sekarang saatnya menjawab `2` pertanyaan sebelumnya:

#### Merek mobil apa yang memiliki rata-rata *horse power* tertinggi dan *miles per gallon* terendah?

``` r
clean_data %>% 
  # group per merek mobil
  group_by(merek_mobil) %>%
  # menghitung rata-rata dari horse power dan miles per gallon
  summarise(avg_hp = mean(hp),
            avg_mpg = mean(mpg)) %>% 
  # jangan lupa di-ungroup
  ungroup() %>% 
  # sort  data dari hp tertinggi dan mpg terendah
  arrange(desc(avg_hp),avg_mpg) %>% 
  # menampilkan top 5
  head(5)
```

    ## # A tibble: 5 x 3
    ##   merek_mobil avg_hp avg_mpg
    ##   <chr>        <dbl>   <dbl>
    ## 1 Maserati       335    15  
    ## 2 Ford           264    15.8
    ## 3 Camaro         245    13.3
    ## 4 Duster         245    14.3
    ## 5 Chrysler       230    14.7

#### Apakah ada perbedaan keiritan bahan bakar antara mobil *matic* dan manual dari data tersebut?

``` r
clean_data %>% 
  group_by(am) %>% 
  summarise(max = max(mpg),
            avg = mean(mpg),
            min = min(mpg)) %>% 
  ungroup()
```

    ## # A tibble: 2 x 4
    ##   am       max   avg   min
    ##   <fct>  <dbl> <dbl> <dbl>
    ## 1 manual  24.4  17.1  10.4
    ## 2 matic   33.9  24.4  15

------------------------------------------------------------------------

### Part 2: Data Covid 19

Bagian selanjutnya adalah *data carpentry* dari data Covid 19 yang saya
dapatkan dari situs
[**worldometers**](https://www.worldometers.info/coronavirus/).

Berbeda dari kasus `mtcars` yang sudah punya tujuan dan pertanyaan yang
harus dijawab. Kali ini saya mau melakukan eksplorasi bebas dari
datanya.

Data saya dapatkan dengan cara *web scrape* menggunakan `library(rvest)`
sebagai berikut:

``` r
library(rvest)
# set target url
url = "https://www.worldometers.info/coronavirus/"
# scrape tabel data
data_cov = read_html(url) %>% html_table(fill = T)
data_cov = data_cov[[1]]
```

Mari kita intip datanya terlebih dahulu:

|  \# | Country,Other | TotalCases  | NewCases | TotalDeaths | NewDeaths | TotalRecovered | NewRecovered | ActiveCases | Serious,Critical | Tot Cases/1M pop | Deaths/1M pop | TotalTests  | Tests/1M pop | Population    | Continent         | 1 Caseevery X ppl | 1 Deathevery X ppl | 1 Testevery X ppl |
|----:|:--------------|:------------|:---------|:------------|:----------|:---------------|:-------------|:------------|:-----------------|:-----------------|:--------------|:------------|:-------------|:--------------|:------------------|:------------------|:-------------------|:------------------|
|  NA | North America | 35,240,790  | +6,632   | 806,677     | +829      | 26,864,936     | +4,289       | 7,569,177   | 15,142           |                  |               |             |              |               | North America     |                   |                    |                   |
|  NA | South America | 20,221,563  | +879     | 524,033     | +19       | 18,053,016     | +1,088       | 1,644,514   | 19,850           |                  |               |             |              |               | South America     |                   |                    |                   |
|  NA | Asia          | 27,229,699  | +7,454   | 418,620     | +59       | 25,270,656     | +5,467       | 1,540,423   | 24,152           |                  |               |             |              |               | Asia              |                   |                    |                   |
|  NA | Europe        | 37,928,410  | +28,594  | 885,671     | +465      | 26,923,205     | +19,352      | 10,119,534  | 29,555           |                  |               |             |              |               | Europe            |                   |                    |                   |
|  NA | Africa        | 4,157,953   |          | 110,745     |           | 3,717,254      |              | 329,954     | 2,666            |                  |               |             |              |               | Africa            |                   |                    |                   |
|  NA | Oceania       | 54,582      | +15      | 1,117       |           | 34,482         | +7           | 18,983      | 9                |                  |               |             |              |               | Australia/Oceania |                   |                    |                   |
|  NA |               | 721         |          | 15          |           | 706            |              | 0           | 0                |                  |               |             |              |               |                   |                   |                    |                   |
|  NA | World         | 124,833,718 | +43,574  | 2,746,878   | +1,372    | 100,864,255    | +30,203      | 21,222,585  | 91,374           | 16,015           | 352.4         |             |              |               | All               |                   |                    |                   |
|   1 | USA           | 30,636,534  |          | 556,883     |           | 23,039,585     |              | 7,040,066   | 8,643            | 92,165           | 1,675         | 392,235,568 | 1,179,974    | 332,410,303   | North America     | 11                | 597                | 1                 |
|   2 | Brazil        | 12,136,615  |          | 298,843     |           | 10,601,658     |              | 1,236,114   | 8,318            | 56,805           | 1,399         | 28,600,000  | 133,861      | 213,654,630   | South America     | 18                | 715                | 7                 |
| 220 | Micronesia    | 1           |          |             |           | 1              |              | 0           |                  | 9                |               |             |              | 115,896       | Australia/Oceania | 115,896           |                    |                   |
| 221 | China         | 90,125      | +10      | 4,636       |           | 85,331         | +10          | 158         |                  | 63               | 3             | 160,000,000 | 111,163      | 1,439,323,776 | Asia              | 15,970            | 310,467            | 9                 |
|  NA | Total:        | 35,240,790  | +6,632   | 806,677     | +829      | 26,864,936     | +4,289       | 7,569,177   | 15,142           |                  |               |             |              |               | North America     |                   |                    |                   |
|  NA | Total:        | 20,221,563  | +879     | 524,033     | +19       | 18,053,016     | +1,088       | 1,644,514   | 19,850           |                  |               |             |              |               | South America     |                   |                    |                   |
|  NA | Total:        | 27,229,699  | +7,454   | 418,620     | +59       | 25,270,656     | +5,467       | 1,540,423   | 24,152           |                  |               |             |              |               | Asia              |                   |                    |                   |
|  NA | Total:        | 37,928,410  | +28,594  | 885,671     | +465      | 26,923,205     | +19,352      | 10,119,534  | 29,555           |                  |               |             |              |               | Europe            |                   |                    |                   |
|  NA | Total:        | 4,157,953   |          | 110,745     |           | 3,717,254      |              | 329,954     | 2,666            |                  |               |             |              |               | Africa            |                   |                    |                   |
|  NA | Total:        | 54,582      | +15      | 1,117       |           | 34,482         |              | 18,983      | 9                |                  |               |             |              |               | Australia/Oceania |                   |                    |                   |
|  NA | Total:        | 721         |          | 15          |           | 706            |              | 0           | 0                |                  |               |             |              |               |                   |                   |                    |                   |
|  NA | Total:        | 124,833,718 | +43,574  | 2,746,878   | +1,372    | 100,864,255    | +30,203      | 21,222,585  | 91,374           | 16,015.0         | 352.4         |             |              |               | All               |                   |                    |                   |

Lalu kita lihat struktur datanya sebagai berikut:

``` r
str(data_cov)
```

    ## tibble [237 × 19] (S3: tbl_df/tbl/data.frame)
    ##  $ #                 : int [1:237] NA NA NA NA NA NA NA NA 1 2 ...
    ##  $ Country,Other     : chr [1:237] "North America" "South America" "Asia" "Europe" ...
    ##  $ TotalCases        : chr [1:237] "35,240,790" "20,221,563" "27,229,699" "37,928,410" ...
    ##  $ NewCases          : chr [1:237] "+6,632" "+879" "+7,454" "+28,594" ...
    ##  $ TotalDeaths       : chr [1:237] "806,677" "524,033" "418,620" "885,671" ...
    ##  $ NewDeaths         : chr [1:237] "+829" "+19" "+59" "+465" ...
    ##  $ TotalRecovered    : chr [1:237] "26,864,936" "18,053,016" "25,270,656" "26,923,205" ...
    ##  $ NewRecovered      : chr [1:237] "+4,289" "+1,088" "+5,467" "+19,352" ...
    ##  $ ActiveCases       : chr [1:237] "7,569,177" "1,644,514" "1,540,423" "10,119,534" ...
    ##  $ Serious,Critical  : chr [1:237] "15,142" "19,850" "24,152" "29,555" ...
    ##  $ Tot Cases/1M pop  : chr [1:237] "" "" "" "" ...
    ##  $ Deaths/1M pop     : chr [1:237] "" "" "" "" ...
    ##  $ TotalTests        : chr [1:237] "" "" "" "" ...
    ##  $ Tests/1M pop      : chr [1:237] "" "" "" "" ...
    ##  $ Population        : chr [1:237] "" "" "" "" ...
    ##  $ Continent         : chr [1:237] "North America" "South America" "Asia" "Europe" ...
    ##  $ 1 Caseevery X ppl : chr [1:237] "" "" "" "" ...
    ##  $ 1 Deathevery X ppl: chr [1:237] "" "" "" "" ...
    ##  $ 1 Testevery X ppl : chr [1:237] "" "" "" "" ...

Terlihat jelas ya dari datanya. Ada banyak hal yang harus dibereskan.

1.  Saya hanya akan mengambil variabel `country`, `continent`,
    `TotalCase` dan `ActiveCase`.
2.  Saya hanya ingin nama negara saja yang masuk ke variabel `country`.
    Oleh karena itu baris data yang berisi **nama benua dan tulisan
    TOTAL harus dikeluarkan dari data**.
3.  Variabel `TotalCases` dan `ActiveCases` harus diubah menjadi tipe
    `numeric`.

Sekali lagi saya tekankan bahwa cara yang saya pakai hanya satu dari
sekian banyak cara yang bisa dilakukan di **R**. Oke,saya mulai *yah*.

``` r
# hal yang akan saya kerjakan
  # 1. rename nama variabel: Country,Other -> negara
  # 2. saya hanya ingin ambil variabel: negara, Continent, TotalCases, ActiveCases
  # 3. saya mau ubah TotalCases dan ActiveCases yang tadinya character ke numeric
  # 4. variabel negara murni hanya nama negara. Gak boleh isinya itu total atau nama benua
  # 5. kita pastikan bahwa tidak ada kolom yang kosong

# Khusus untuk melakukan filter terhadap benua, saya akan bikin variabel baru bernama sensor
sensor = c("Asia","North America","South America","Europe","Africa","Oceania","World","Total:")

# proses pembuatan data yang clean
data_cov_clean = 
  data_cov %>%
  rename(negara = `Country,Other`) %>% # ini proses rename variabel
  select(negara, Continent, TotalCases, ActiveCases) %>% # ini proses seleksi variabel
  mutate(TotalCases = gsub("\\,","",TotalCases),
         ActiveCases = gsub("\\,","",ActiveCases),
         TotalCases = as.numeric(TotalCases),
         ActiveCases = as.numeric(ActiveCases)
        ) %>%
  filter(!negara %in% sensor) %>% # filter negara yang diluar sensor
  filter(!is.na(negara)) %>% # filter gak boleh ada yang kosong di negara
  filter(!is.na(TotalCases)) %>% # filter gak boleh ada yang kosong di TotalCases
  filter(!is.na(ActiveCases)) %>% # filter gak boleh ada yang kosong di ActiveCases
  filter(Continent != "")
```

Berikut adalah hasil data yang sudah bersih:

|         negara         |     Continent     | TotalCases | ActiveCases |
|:----------------------:|:-----------------:|:----------:|:-----------:|
|       Micronesia       | Australia/Oceania |     1      |      0      |
|         Samoa          | Australia/Oceania |     3      |      1      |
|        Vanuatu         | Australia/Oceania |     3      |      2      |
|    Marshall Islands    | Australia/Oceania |     4      |      0      |
|     Western Sahara     |      Africa       |     10     |      1      |
|    Solomon Islands     | Australia/Oceania |     18     |      2      |
|       Montserrat       |   North America   |     20     |      0      |
|        Anguilla        |   North America   |     22     |      2      |
| Saint Pierre Miquelon  |   North America   |     24     |      0      |
|      Vatican City      |      Europe       |     27     |     12      |
|       Greenland        |   North America   |     31     |      0      |
| Saint Kitts and Nevis  |   North America   |     44     |      2      |
|         Macao          |       Asia        |     48     |      1      |
|          Laos          |       Asia        |     49     |      4      |
|    Falkland Islands    |   South America   |     54     |      0      |
|          Fiji          | Australia/Oceania |     67     |      1      |
|     New Caledonia      | Australia/Oceania |    116     |     58      |
| British Virgin Islands |   North America   |    153     |     21      |
|        Grenada         |   North America   |    154     |      2      |
|        Dominica        |   North America   |    156     |     15      |
|         Brunei         |       Asia        |    206     |     15      |
|   Wallis and Futuna    | Australia/Oceania |    329     |     309     |
|      Timor-Leste       |       Asia        |    351     |     227     |
|     Cayman Islands     |   North America   |    482     |     32      |
|        Tanzania        |      Africa       |    509     |     305     |
|     Faeroe Islands     |      Europe       |    661     |      0      |
|       St. Barth        |   North America   |    775     |     312     |
|       Mauritius        |      Africa       |    826     |     224     |
|        Bermuda         |   North America   |    840     |     113     |
|         Bhutan         |       Asia        |    869     |      1      |
|         Taiwan         |       Asia        |    1009    |     30      |
|  Antigua and Barbuda   |   North America   |    1080    |     337     |
| Caribbean Netherlands  |   North America   |    1119    |     461     |
|      Isle of Man       |      Europe       |    1516    |     788     |
|      Saint Martin      |   North America   |    1619    |     208     |
| St. Vincent Grenadines |   North America   |    1700    |     167     |
|        Cambodia        |       Asia        |    1817    |     779     |
|        Liberia         |      Africa       |    2042    |     58      |
|      Sint Maarten      |   North America   |    2108    |     21      |
| Sao Tome and Principe  |      Africa       |    2159    |     126     |
|         Monaco         |      Europe       |    2199    |     142     |
|    Turks and Caicos    |   North America   |    2307    |     116     |
|      New Zealand       | Australia/Oceania |    2470    |     67      |
|        Vietnam         |       Asia        |    2575    |     294     |
|        Burundi         |      Africa       |    2628    |    1849     |
|     Liechtenstein      |      Europe       |    2634    |     36      |
|        Eritrea         |      Africa       |    3163    |     232     |
|        Barbados        |   North America   |    3574    |     144     |
|     Guinea-Bissau      |      Africa       |    3586    |     639     |
|         Yemen          |       Asia        |    3612    |    1261     |
|        Comoros         |      Africa       |    3681    |     52      |
|    Papua New Guinea    | Australia/Oceania |    3758    |    2875     |
|       Seychelles       |      Africa       |    3828    |     605     |
|      Sierra Leone      |      Africa       |    3949    |    1078     |
|    Channel Islands     |      Europe       |    4046    |      0      |
|      Saint Lucia       |   North America   |    4149    |     129     |
|       Gibraltar        |      Europe       |    4271    |     21      |
|       San Marino       |      Europe       |    4432    |     478     |
|          Chad          |      Africa       |    4440    |     223     |
|         Niger          |      Africa       |    4939    |     201     |
|          CAR           |      Africa       |    5087    |     85      |
|         Gambia         |      Africa       |    5255    |     219     |
|        Mongolia        |       Asia        |    5610    |    1658     |
|        Iceland         |      Europe       |    6122    |     57      |
|        Curaçao         |   North America   |    6174    |    1259     |
|       Nicaragua        |   North America   |    6629    |    2227     |
|        Djibouti        |      Africa       |    6771    |     561     |
|   Equatorial Guinea    |      Africa       |    6780    |     435     |
|         Benin          |      Africa       |    6818    |    1176     |
|       Martinique       |   North America   |    7710    |    7563     |
|  Trinidad and Tobago   |   North America   |    7865    |     151     |
|         Aruba          |   North America   |    8902    |     510     |
|        Bahamas         |   North America   |    8935    |     990     |
|        Suriname        |   South America   |    9074    |     333     |
|          Togo          |      Africa       |    9147    |    1701     |
|          Mali          |      Africa       |    9474    |    2441     |
|         Congo          |      Africa       |    9564    |    1916     |
|         Guyana         |   South America   |    9732    |     912     |
|      South Sudan       |      Africa       |    9919    |     811     |
|        Somalia         |      Africa       |   10369    |    5352     |
|        Lesotho         |      Africa       |   10685    |    5981     |
|       Guadeloupe       |   North America   |   10976    |    8569     |
|       Hong Kong        |       Asia        |   11410    |     270     |
|        Andorra         |      Europe       |   11591    |     428     |
|         Belize         |   North America   |   12410    |     47      |
|      Burkina Faso      |      Africa       |   12572    |     187     |
|         Haiti          |   North America   |   12732    |    1727     |
|       Tajikistan       |       Asia        |   13308    |      0      |
|        Réunion         |      Africa       |   15561    |    1395     |
|       Cabo Verde       |      Africa       |   16555    |     547     |
|     French Guiana      |   South America   |   16764    |    6682     |
|        Eswatini        |      Africa       |   17296    |     530     |
|       Mauritania       |      Africa       |   17658    |     273     |
|         Syria          |       Asia        |   17743    |    4766     |
|         Gabon          |      Africa       |   18078    |    2316     |
|    French Polynesia    | Australia/Oceania |   18595    |    13612    |
|         Guinea         |      Africa       |   18945    |    2753     |
|        Mayotte         |      Africa       |   19224    |    16106    |
|         Rwanda         |      Africa       |   20975    |    1370     |
|         Angola         |      Africa       |   21774    |    1145     |
|       Madagascar       |      Africa       |   22682    |    1180     |
|        Maldives        |       Asia        |   22790    |    2498     |
|          DRC           |      Africa       |   27580    |    1568     |
|        Thailand        |       Asia        |   28346    |    1381     |
|         Malta          |      Europe       |   28409    |    2479     |
|       Australia        | Australia/Oceania |   29218    |    2056     |
|         Sudan          |      Africa       |   29542    |    3681     |
|         Malawi         |      Africa       |   33323    |    3104     |
|        Jamaica         |   North America   |   36231    |    19199    |
|        Zimbabwe        |      Africa       |   36717    |     754     |
|        Botswana        |      Africa       |   37559    |    4524     |
|        Senegal         |      Africa       |   37958    |    1759     |
|        Cameroon        |      Africa       |   40622    |    4760     |
|         Uganda         |      Africa       |   40719    |    25246    |
|      Ivory Coast       |      Africa       |   40868    |    3702     |
|        Namibia         |      Africa       |   42771    |    2579     |
|         Cyprus         |       Asia        |   42993    |    40690    |
|      Afghanistan       |       Asia        |   56192    |    3974     |
|       Luxembourg       |      Europe       |   59662    |    3175     |
|       Singapore        |       Asia        |   60221    |     128     |
|      El Salvador       |   North America   |   63344    |     677     |
|       Mozambique       |      Africa       |   66496    |    12558    |
|          Cuba          |   North America   |   68250    |    3417     |
|        Finland         |      Europe       |   72713    |    25905    |
|       Uzbekistan       |       Asia        |   81678    |    1010     |
|        Uruguay         |   South America   |   86007    |    14808    |
|         Zambia         |      Africa       |   86779    |    2116     |
|       Kyrgyzstan       |       Asia        |   87652    |    1821     |
|       Montenegro       |      Europe       |   88116    |    7906     |
|         Norway         |      Europe       |   89120    |    14139    |
|         Ghana          |      Africa       |   89893    |    2911     |
|         China          |       Asia        |   90125    |     158     |
|       Sri Lanka        |       Asia        |   90765    |    2907     |
|        Estonia         |      Europe       |   97456    |    26301    |
|         Latvia         |      Europe       |   98094    |    7932     |
|        S. Korea        |       Asia        |   99846    |    6579     |
|        Algeria         |      Africa       |   116349   |    32302    |
|    North Macedonia     |      Europe       |   120882   |    15153    |
|        Albania         |      Europe       |   121847   |    33194    |
|         Kenya          |      Africa       |   123167   |    30533    |
|        Bahrain         |       Asia        |   137550   |    7202     |
|        Myanmar         |       Asia        |   142264   |    7295     |
|          Oman          |       Asia        |   152364   |    10885    |
|       Venezuela        |   South America   |   152508   |    9737     |
|         Libya          |      Africa       |   153411   |    10427    |
| Bosnia and Herzegovina |      Europe       |   156346   |    24104    |
|        Nigeria         |      Africa       |   162076   |    11515    |
|         Qatar          |       Asia        |   174762   |    13376    |
|        Honduras        |   North America   |   184031   |   110084    |
|        Armenia         |       Asia        |   186184   |    13301    |
|       Guatemala        |   North America   |   189067   |    9716     |
|        Ethiopia        |      Africa       |   190594   |    38311    |
|         Egypt          |      Africa       |   196709   |    34105    |
|        Paraguay        |   South America   |   198135   |    31438    |
|        Slovenia        |      Europe       |   207298   |    10874    |
|       Lithuania        |      Europe       |   210202   |    11586    |
|       Costa Rica       |   North America   |   213438   |    19580    |
|        Moldova         |      Europe       |   217715   |    21462    |
|         Kuwait         |       Asia        |   221743   |    14317    |
|        Denmark         |      Europe       |   227031   |    9593     |
|       Palestine        |       Asia        |   228044   |    23891    |
|        Ireland         |      Europe       |   231484   |   203510    |
|       Kazakhstan       |       Asia        |   235095   |    19253    |
|         Greece         |      Europe       |   242347   |    27635    |
|        Tunisia         |      Africa       |   246507   |    24392    |
|       Azerbaijan       |       Asia        |   248307   |    11567    |
|   Dominican Republic   |   North America   |   250177   |    40158    |
|        Croatia         |      Europe       |   258745   |    6394     |
|        Bolivia         |   South America   |   266086   |    40214    |
|         Nepal          |       Asia        |   276244   |    1128     |
|        Georgia         |       Asia        |   278628   |    3984     |
|        Belarus         |      Europe       |   312474   |    7269     |
|        Bulgaria        |      Europe       |   312741   |    60832    |
|        Ecuador         |   South America   |   313570   |    25219    |
|        Malaysia        |       Asia        |   335540   |    14454    |
|        Slovakia        |      Europe       |   350551   |    86061    |
|         Panama         |   North America   |   351667   |    5114     |
|      Saudi Arabia      |       Asia        |   385834   |    4051     |
|          UAE           |       Asia        |   444398   |    15759    |
|        Lebanon         |       Asia        |   444865   |    89792    |
|         Japan          |       Asia        |   457754   |    13532    |
|        Morocco         |      Africa       |   492403   |    3528     |
|        Austria         |      Europe       |   519980   |    32919    |
|         Jordan         |       Asia        |   553727   |    99762    |
|         Serbia         |      Europe       |   561372   |    82458    |
|       Bangladesh       |       Asia        |   577241   |    42809    |
|      Switzerland       |      Europe       |   586096   |    38178    |
|        Hungary         |      Europe       |   586123   |   189244    |
|        Pakistan        |       Asia        |   637042   |    36849    |
|      Philippines       |       Asia        |   677653   |    86200    |
|          Iraq          |       Asia        |   803041   |    65689    |
|        Portugal        |      Europe       |   818212   |    32332    |
|         Israel         |       Asia        |   829689   |    14698    |
|        Belgium         |      Europe       |   842775   |   764320    |
|        Romania         |      Europe       |   907007   |    70383    |
|         Canada         |   North America   |   942320   |    36310    |
|         Chile          |   South America   |   942958   |    37802    |
|       Indonesia        |       Asia        |  1471225   |   126439    |
|          Peru          |   South America   |  1481259   |    33444    |
|        Czechia         |      Europe       |  1486510   |   171328    |
|      South Africa      |      Africa       |  1538961   |    21506    |
|        Ukraine         |      Europe       |  1579906   |   272861    |
|          Iran          |       Asia        |  1815712   |   197995    |
|         Poland         |      Europe       |  2089869   |   346233    |
|         Mexico         |   North America   |  2203041   |   259731    |
|       Argentina        |   South America   |  2261577   |   162797    |
|        Colombia        |   South America   |  2347224   |    45014    |
|        Germany         |      Europe       |  2689205   |   168197    |
|         Turkey         |       Asia        |  3061520   |   167322    |
|         Spain          |      Europe       |  3234319   |   167727    |
|         Italy          |      Europe       |  3419616   |   560654    |
|           UK           |      Europe       |  4307304   |   468362    |
|         France         |      Europe       |  4313073   |   3936658   |
|         Russia         |      Europe       |  4474610   |   290747    |
|         India          |       Asia        |  11734058  |   368421    |
|         Brazil         |   South America   |  12136615  |   1236114   |
|          USA           |   North America   |  30636534  |   7040066   |

Dari data tersebut, saya bisa menghitung top 10 negara dengan *ratio
active cases* tertinggi:

``` r
data_cov_clean %>% 
  mutate(ratio = round(ActiveCases / TotalCases * 100,2)) %>% 
  arrange(desc(ratio)) %>% 
  head(10)
```

    ## # A tibble: 10 x 5
    ##    negara            Continent         TotalCases ActiveCases ratio
    ##    <chr>             <chr>                  <dbl>       <dbl> <dbl>
    ##  1 Martinique        North America           7710        7563  98.1
    ##  2 Cyprus            Asia                   42993       40690  94.6
    ##  3 Wallis and Futuna Australia/Oceania        329         309  93.9
    ##  4 France            Europe               4313073     3936658  91.3
    ##  5 Belgium           Europe                842775      764320  90.7
    ##  6 Ireland           Europe                231484      203510  87.9
    ##  7 Mayotte           Africa                 19224       16106  83.8
    ##  8 Guadeloupe        North America          10976        8569  78.1
    ##  9 Papua New Guinea  Australia/Oceania       3758        2875  76.5
    ## 10 French Polynesia  Australia/Oceania      18595       13612  73.2

------------------------------------------------------------------------

`if you find this article helpful, please support this blog by clicking the ads shown.`
