---
date: 2021-07-29T15:54:00-04:00
title: "Mencari Kondisi Cuaca Saat Ini dengan R"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - API
  - Weather
  - Cuaca
---

Pada 2016 lalu, saya pernah mengerjakan suatu model prediksi yang
berkaitan dengan cuaca di suatu area tertentu. Saat itu, saya belum
berkenala dengan **R** dan masih kesusahan untuk mencari data cuaca yang
*reliable*.

Saat ini, kita bisa dengan mudahnya mendapatkan data cuaca untuk
dianalisa lebih lanjut atau dijadikan *support data* dari analisa yang
hendak kita kerjakan.

Layanan cuaca dari ***Oke Google*** sebenarnya sangat baik tapi ada cara
lain yang lebih mudah untuk mendapatkan data cuaca dan menghubungkannya
ke **R** *environment*, yakni dengan memanfaatkan layanan situs [**Open
Weather Map**](https://openweathermap.org).

Prosesnya cukup mudah, yaitu:

1.  Daftarkan *email* kita ke sana.
2.  Ambil *API Key*.
3.  Panggil *API* dan baca sebagai `.json` dari **R**.

Untuk kebutuhan saya saat ini, saya tidak memerlukan *API* yang
berbayar. Layanan *free* sudah cukup.

Berikut saya berikan langkah-langkah di **R**-nya:

## Langkah 1

Saya buat *single object* bernama `API_key`. Kita *copy-paste* *API Key*
yang didapatkan dari situs Open Weather:

``` r
API_Key = "copy key di sini"
```

## Langkah 2

Panggil *API* dengan rumus:

**api.openweathermap.org/data/2.5/weather?q=** KOTA **&appid=** API KEY

Baca *link* tersebut dengan *function* `fromJSON()` dari
`library(jsonlite)`.

Di akhir *link* tersebut saya tambahkan **units=metric** agar satuan
yang dihasilkan standar (bukan *imperial units*).

Sebagai contoh, saya akan mengambil cuaca saat ini di Jakarta:

``` r
# panggil library
library(jsonlite)

# set kotanya
city = "Jakarta"

# tempel kota dan api key ke dalam link API
api = paste0("http://api.openweathermap.org/data/2.5/weather?q=",
             city,
             "&appid=",
             API_key,
             "&units=metric")

# baca datanya
data = fromJSON(api)
```

Data yang didapatkan memiliki struktur berupa *list* sederhana. Kita
bisa lihat menggunakan *function* dari *base* **R** yakni `str()`
sebagai berikut:

``` r
str(data)
```

    ## List of 13
    ##  $ coord     :List of 2
    ##   ..$ lon: num 107
    ##   ..$ lat: num -6.21
    ##  $ weather   :'data.frame':  1 obs. of  4 variables:
    ##   ..$ id         : int 721
    ##   ..$ main       : chr "Haze"
    ##   ..$ description: chr "haze"
    ##   ..$ icon       : chr "50d"
    ##  $ base      : chr "stations"
    ##  $ main      :List of 6
    ##   ..$ temp      : num 33.5
    ##   ..$ feels_like: num 36.2
    ##   ..$ temp_min  : num 30.5
    ##   ..$ temp_max  : num 34.5
    ##   ..$ pressure  : int 1008
    ##   ..$ humidity  : int 46
    ##  $ visibility: int 5000
    ##  $ wind      :List of 2
    ##   ..$ speed: num 3.09
    ##   ..$ deg  : int 330
    ##  $ clouds    :List of 1
    ##   ..$ all: int 40
    ##  $ dt        : int 1627548518
    ##  $ sys       :List of 5
    ##   ..$ type   : int 1
    ##   ..$ id     : int 9383
    ##   ..$ country: chr "ID"
    ##   ..$ sunrise: int 1627513436
    ##   ..$ sunset : int 1627556042
    ##  $ timezone  : int 25200
    ##  $ id        : int 1642911
    ##  $ name      : chr "Jakarta"
    ##  $ cod       : int 200

> ***Gimana? Mudah kan?***

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
