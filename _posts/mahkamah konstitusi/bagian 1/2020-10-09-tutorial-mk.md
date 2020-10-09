---
date: 2020-10-09T5:30:00-04:00
title: "Tutorial Webscrape dan Data Carpentry di R: Data Rekap Gugatan Undang-Undang di Mahkamah Konstitusi"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrap
  - R
  - Data Carpentry
  - Tutorial
  - Kemenkes
  - Kesehatan
---


Konon katanya riuh-ricuh pengesahan **Undang-Undang Cipta Kerja** akan
bermuara di **Mahkamah Konstitusi**. Nah, sebelum saya akan membahas
mengenai analisa data tersebut **Mahkamah Konstitusi**, saya akan
berikan dulu tutorial *web scrape* dan *data carpentry* dari situs
tersebut.

Data yang mau saya ambil adalah data **rekapitulasi perkara pengujian
UU** yang disajikan dalam bentuk tabel di [situs resmi **Mahkamah
Konstitusi**](https://mkri.id/index.php?page=web.RekapPUU&menu=4).
Berikut adalah tabel yang ada di situs tersebut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/mahkamah%20konstitusi/bagian%201/rekap.png" width="799" />

Oh iya, hampir semua data di website pemerintah sudah berbentuk tabel.
Jadi sangat mudah untuk di-*scrape* menggunakan `library(rvest)`. Namun
yang menjadi permasalahan adalah pada saat *data carpentry*-nya yang
cenderung rumit sehingga membuat orang menjadi malas untuk
mengerjakannya.

> Oke, yuk saya tunjukkan caranya\!

-----

## Panggil *Libraries*

Tiga *libraries* utama yang akan saya pakai adalah:

1.  `library(rvest)` untuk melakukan *web scraping*. *Script* utama yang
    akan saya gunakan adalah `html_table()`. Cukup mudah kan.
2.  `library(dplyr)` untuk melakukan *data carpentry* dengan prinsip
    *tidy* (`%>%`).
3.  `library(tidyr)` untuk melakukan *data carpentry* juga. *Script*
    yang akan saya gunakan adalah `separate()`.

Selain *libraries* di atas, saya akan gunakan juga
`janitor::clean_names()` untuk membersihkan `colnames()` dari dataset.

``` r
library(rvest)
library(dplyr)
library(tidyr)
```

-----

## Ambil *url* dan *Scrape*

Sekarang saya akan melakukan *webscraping*. Caranya cukup mudah, hanya
perlu menentukan *url*-nya saja dan tulis algoritma menggunakan
`library(rvest)`.

``` r
# url
url = "https://mkri.id/index.php?page=web.RekapPUU&menu=4"

# web scrape
data = 
  read_html(url) %>% 
  html_table(fill = T)
```

Dalam hitungan detik (tergantung koneksi juga), tabel di situs tersebut
sudah masuk ke dalam *global environment* di **R**. Mari kita lihat dulu
data apa saja yang terambil.

``` r
str(data)
```

    ## List of 1
    ##  $ :'data.frame':    20 obs. of  8 variables:
    ##   ..$ Tahun               : chr [1:20] "" "2003" "2004" "2005" ...
    ##   ..$ Dalam ProsesYanglalu: int [1:20] NA 0 20 12 9 7 10 12 39 59 ...
    ##   ..$ Diregistrasi        : int [1:20] NA 24 27 25 27 30 36 78 81 86 ...
    ##   ..$ Jumlah              : int [1:20] NA 24 47 37 36 37 46 90 120 145 ...
    ##   ..$ Amar Putusan        : chr [1:20] "" "Kabul : 0\r\n\t\t\t\t\t\t\tTolak : 0\r\n\t\t\t\t\t\t\tTidak Diterima : 3\r\n\t\t\t\t\t\t\tTarik Kembali : 1\r\n"| __truncated__ "Kabul : 11\r\n\t\t\t\t\t\t\tTolak : 8\r\n\t\t\t\t\t\t\tTidak Diterima : 12\r\n\t\t\t\t\t\t\tTarik Kembali : 4\r"| __truncated__ "Kabul : 10\r\n\t\t\t\t\t\t\tTolak : 14\r\n\t\t\t\t\t\t\tTidak Diterima : 4\r\n\t\t\t\t\t\t\tTarik Kembali : 0\r"| __truncated__ ...
    ##   ..$ JumlahPutusan       : int [1:20] NA 4 35 28 29 27 34 51 61 94 ...
    ##   ..$ DalamProsesTahun ini: chr [1:20] "" "20" "12" "9" ...
    ##   ..$ JumlahUUyangDiuji   : int [1:20] NA 16 14 12 9 12 18 27 58 55 ...

Data yang masuk berbentuk *list* berisi hanya `1` *data frame* saja.
Oleh karena itu, saya hanya akan mengambil *data frame* tersebut. Lalu
saya bersihkan penamaan `colnames()` data tersebut dengan `janitor`.

``` r
# ambil data frame dari element pertama dari list
data = data[[1]]

# membersihkan nama kolom
data = 
  data %>% 
  janitor::clean_names()
```

Sekarang kita lihat *raw data* hasil *scrape*-nya.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/mahkamah%20konstitusi/bagian%201/raw.png" width="866" />

-----

## *Data Carpentry*

Dari *raw data* tersebut, ada banyak **PR** yang harus saya selesaikan.
Apa saja?

1.  Menghapus baris pertama yang kosong.
2.  Menghapus baris terakhir karena berisi `Jumlah`. Saya tidak
    memerlukannya karena saya bisa menghitung sendiri nanti.
3.  Memecah kolom `amar_putusan` menjadi beberapa kolom lain.

Oke, sebelum melakukannya, saya cek kembali struktur datanya:

``` r
str(data)
```

    ## 'data.frame':    20 obs. of  8 variables:
    ##  $ tahun                 : chr  "" "2003" "2004" "2005" ...
    ##  $ dalam_proses_yanglalu : int  NA 0 20 12 9 7 10 12 39 59 ...
    ##  $ diregistrasi          : int  NA 24 27 25 27 30 36 78 81 86 ...
    ##  $ jumlah                : int  NA 24 47 37 36 37 46 90 120 145 ...
    ##  $ amar_putusan          : chr  "" "Kabul : 0\r\n\t\t\t\t\t\t\tTolak : 0\r\n\t\t\t\t\t\t\tTidak Diterima : 3\r\n\t\t\t\t\t\t\tTarik Kembali : 1\r\n"| __truncated__ "Kabul : 11\r\n\t\t\t\t\t\t\tTolak : 8\r\n\t\t\t\t\t\t\tTidak Diterima : 12\r\n\t\t\t\t\t\t\tTarik Kembali : 4\r"| __truncated__ "Kabul : 10\r\n\t\t\t\t\t\t\tTolak : 14\r\n\t\t\t\t\t\t\tTidak Diterima : 4\r\n\t\t\t\t\t\t\tTarik Kembali : 0\r"| __truncated__ ...
    ##  $ jumlah_putusan        : int  NA 4 35 28 29 27 34 51 61 94 ...
    ##  $ dalam_proses_tahun_ini: chr  "" "20" "12" "9" ...
    ##  $ jumlah_u_uyang_diuji  : int  NA 16 14 12 9 12 18 27 58 55 ...

-----

### *Data Carpentry* Tahap I

Sekarang saya akan melakukan hal yang mudah terlebih dahulu. Melakukan
poin `1` dan `2` dari **PR** saya. Namun ada yang perlu diperhatikan.
Setelah nanti kita menghapus baris pertama dan baris `Jumlah`, kolom
`tahun` dan kolom `dalam_proses_tahun_ini` akan kita ubah menjadi
`numeric`.

``` r
data = 
  data %>% 
  filter(!is.na(jumlah)) %>% 
  filter(tahun != "Jumlah") %>% 
  mutate(tahun = as.numeric(tahun),
         dalam_proses_tahun_ini = as.numeric(dalam_proses_tahun_ini))
```

Hasilnya sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/mahkamah%20konstitusi/bagian%201/raw2.png" width="881" />

-----

### *Data Carpentry* Tahap II

Berikutnya adalah membereskan kolom `amar_putusan`. Ini adalah pekerjaan
yang paling asyik menurut saya karena sebenarnya *gak* sulit *kok*.

Pertama-tama, mari kita lihat dulu apa *sih* isi dari kolom
`amar_putusan`. Berikut adalah `3` data teratas untuk `amar_putusan`:

    ## [1] "Kabul : 0\r\n\t\t\t\t\t\t\tTolak : 0\r\n\t\t\t\t\t\t\tTidak Diterima : 3\r\n\t\t\t\t\t\t\tTarik Kembali : 1\r\n\t\t\t\t\t\t\tGugur : 0\r\n\t\t\t\t\t\t\tTidak Berwenang : 0"  
    ## [2] "Kabul : 11\r\n\t\t\t\t\t\t\tTolak : 8\r\n\t\t\t\t\t\t\tTidak Diterima : 12\r\n\t\t\t\t\t\t\tTarik Kembali : 4\r\n\t\t\t\t\t\t\tGugur : 0\r\n\t\t\t\t\t\t\tTidak Berwenang : 0"
    ## [3] "Kabul : 10\r\n\t\t\t\t\t\t\tTolak : 14\r\n\t\t\t\t\t\t\tTidak Diterima : 4\r\n\t\t\t\t\t\t\tTarik Kembali : 0\r\n\t\t\t\t\t\t\tGugur : 0\r\n\t\t\t\t\t\t\tTidak Berwenang : 0"

Nah, setelah melihat data tersebut apakah sudah terbayang apa yang akan
dilakukan? Kira-kira ini yang akan saya lakukan:

1.  Menghapus `\r` dan `\t` dari data tersebut.
2.  Melakukan `separate()` dengan *separator* berupa `\n`.
3.  Hanya mengambil angka dari masing-masing kolom lalu membuatnya
    menjadi `numeric`.

> Simpel kan?

Ini *script*-nya:

``` r
data = 
  data %>% 
  mutate(amar_putusan = gsub("\\\r","",amar_putusan),
         amar_putusan = gsub("\\\t","",amar_putusan)) %>% 
  separate(amar_putusan,
           into = c("kabul","tolak","tidak_diterima","tarik_kembali","gugur","tidak_berwenang"),
           sep = "\\\n") %>% 
  mutate(tolak = gsub("\\D","",tolak),
         tolak = as.numeric(tolak),
         kabul = gsub("\\D","",kabul),
         kabul = as.numeric(kabul),
         tidak_diterima = gsub("\\D","",tidak_diterima),
         tidak_diterima = as.numeric(tidak_diterima),
         tarik_kembali = gsub("\\D","",tarik_kembali),
         tarik_kembali = as.numeric(tarik_kembali),
         gugur = gsub("\\D","",gugur),
         gugur = as.numeric(gugur),
         tidak_berwenang = gsub("\\D","",tidak_berwenang),
         tidak_berwenang = as.numeric(tidak_berwenang))
```

Sekarang kita lihat [data yang sudah bersihnya](https://github.com/ikanx101/ikanx101.github.io/raw/master/_posts/mahkamah%20konstitusi/bagian%201/clean.rda):

``` r
colnames(data) = c("Tahun",
                   "Dalam proses yg lalu",
                   "Diregistrasi",
                   "Jumlah",
                   "Dikabulkan",
                   "Ditolak",
                   "TIdak diterima",
                   "Tarik kembali",
                   "Gugur",
                   "Tidak berwenang",
                   "Jumlah putusan",
                   "Dalam proses tahun ini",
                   "Jumlah UU yg diuji")
knitr::kable(data)
```

| Tahun | Dalam proses yg lalu | Diregistrasi | Jumlah | Dikabulkan | Ditolak | TIdak diterima | Tarik kembali | Gugur | Tidak berwenang | Jumlah putusan | Dalam proses tahun ini | Jumlah UU yg diuji |
| ----: | -------------------: | -----------: | -----: | ---------: | ------: | -------------: | ------------: | ----: | --------------: | -------------: | ---------------------: | -----------------: |
|  2003 |                    0 |           24 |     24 |          0 |       0 |              3 |             1 |     0 |               0 |              4 |                     20 |                 16 |
|  2004 |                   20 |           27 |     47 |         11 |       8 |             12 |             4 |     0 |               0 |             35 |                     12 |                 14 |
|  2005 |                   12 |           25 |     37 |         10 |      14 |              4 |             0 |     0 |               0 |             28 |                      9 |                 12 |
|  2006 |                    9 |           27 |     36 |          8 |       8 |             11 |             2 |     0 |               0 |             29 |                      7 |                  9 |
|  2007 |                    7 |           30 |     37 |          4 |      11 |              7 |             5 |     0 |               0 |             27 |                     10 |                 12 |
|  2008 |                   10 |           36 |     46 |         10 |      12 |              7 |             5 |     0 |               0 |             34 |                     12 |                 18 |
|  2009 |                   12 |           78 |     90 |         15 |      18 |             11 |             7 |     0 |               0 |             51 |                     39 |                 27 |
|  2010 |                   39 |           81 |    120 |         18 |      22 |             16 |             5 |     0 |               0 |             61 |                     59 |                 58 |
|  2011 |                   59 |           86 |    145 |         21 |      29 |             35 |             9 |     0 |               0 |             94 |                     51 |                 55 |
|  2012 |                   51 |          118 |    169 |         30 |      31 |             28 |             5 |     2 |               1 |             97 |                     72 |                  0 |
|  2013 |                   72 |          109 |    181 |         22 |      52 |             22 |            12 |     1 |               1 |            110 |                     71 |                 64 |
|  2014 |                   71 |          140 |    211 |         29 |      41 |             37 |            17 |     6 |               1 |            131 |                     80 |                 71 |
|  2015 |                   80 |          140 |    220 |         25 |      50 |             61 |            15 |     4 |               2 |            157 |                     63 |                 77 |
|  2016 |                   63 |          111 |    174 |         19 |      34 |             30 |             9 |     3 |               1 |             96 |                     78 |                 72 |
|  2017 |                   78 |          102 |    180 |         22 |      48 |             44 |            12 |     4 |               1 |            131 |                     49 |                 58 |
|  2018 |                   49 |          102 |    151 |         15 |      42 |             47 |             7 |     1 |               2 |            114 |                     37 |                 45 |
|  2019 |                   37 |           85 |    122 |          4 |      46 |             32 |             8 |     2 |               0 |             92 |                     30 |                 51 |
|  2020 |                   30 |           82 |    112 |          3 |      16 |             33 |            10 |     0 |               0 |             62 |                     50 |                 49 |

*Gimana*? Mudah kan?
