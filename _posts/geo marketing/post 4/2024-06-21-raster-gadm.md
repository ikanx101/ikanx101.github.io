---
date: 2024-06-21T21:02:00-04:00
title: "Update: Cara Mencari Nama Kota/Kabupaten dari Data LongLat"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Raster
  - Geocoding
  - Google
  - Geomarketing
---

Tahun lalu, saya pernah menuliskan bagaimana caranya agar dari data
berupa *longitude* dan *latitude* kita bisa [mendapatkan data detail
lokasi](https://ikanx101.com/blog/geo-marketing/) seperti:

- Negara,
- Provinsi,
- Kota / Kabupaten,
- Kecamatan, dan
- Level lokasi lainnya.

Data ini juga bersifat umum, tidak hanya berlaku di Indonesia saja.

------------------------------------------------------------------------

Beberapa hari belakangan ini, saya mendapatkan *request* untuk melakukan
*web scraping* sekian ribu tempat keramaian di beberapa kota luar negeri
dari *Google Maps*. Salah satu kota targetnya adalah kota Kuala Lumpur
di Malaysia.

Langkah pertama yang saya biasanya saya kerjakan adalah membuat area
persegi panjang dari Kuala Lumpur. Walaupun kita ketahui bersama bahwa
tidak mungkin ada kota yang memiliki area berbentuk persegi panjang
sempurna. Dari area ini, saya akan ambil semua titik keramaian yang
mungkin ada.

Nah, PR saya selanjutnya adalah memilih titik-titik mana saja yang
benar-benar berada di Kuala Lumpur. Bagaimana caranya?

> Caranya adalah dengan menggunakan cara yang saya [tulis
> sebelumnya](https://ikanx101.com/blog/geo-marketing/).

Sebagai contoh, saya punya data *longlat* berikut:

``` r
lat  = 3.154614
long = 101.635143
# kita bentuk ke dalam data frame
df   = data.frame(long,lat)
```

Ternyata **cara yang dahulu saya gunakan sudah tidak bisa lagi!**.
Kenapa? Salah satu proses yang wajib dijalankan pada skrip terdahulu
adalah men-*download* data *raster* dari *database* **GADM**. Nah,
ternyata versi **GADM** yang terbaru sudah tidak *support* lagi dengan
skrip yang dahulu.

Akhirnya saya harus mencari cara lain untuk mendapatkan informasi yang
dibutuhkan.

------------------------------------------------------------------------

## Alternatif Cara

Dari *website*-nya, data **GADM** terbaru merupakan versi 4.1 yang harus
kita [*download manual* per
negara](https://gadm.org/download_country.html). Nah, kita cukup
mengubah bentuk file hasil *download* ke bentuk *shapefile* yang siap
kita gunakan. Berikut langkah-langkahnya:

### Langkah I

Buka [situs **GADM**](https://gadm.org/download_country.html), pilih
`negara` yang diinginkan. Misalkan: Malaysia.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%204/gb1.png)

Pilih data ***shapefile***. Tunggu hingga *zipped file*-nya sudah
selesai masuk ke *local drive* kita.

### Langkah II

*Unzip file* tersebut, lalu masukkan ke dalam *working directory*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%204/gb2.png)

### Langkah III

Sekarang kita akan *import* data *shapefile* yang sudah di-*download*
tersebut ke dalam **R** dengan menggunakan `library(raster)` dan
`library(sp)`. Misalkan saya hendak mendapatkan informasi hingga level
ke dua.

``` r
# load libraries
library(raster)
library(sp)
library(dplyr)

# import data
malaysia = shapefile("gadm41_MYS_2.shp", package = "raster")
```

### Langkah IV

Sekarang kita akan ekstrak informasinya.

``` r
city_names = extract(malaysia,               # ini data referensinya
                     df[, c("long", "lat")]) # ini data inputnya
```

Berikut adalah hasilnya:

``` r
city_names
```

      id.y     GID_2 GID_0  COUNTRY   GID_1       NAME_1 NL_NAME_1       NAME_2
    1    1 MYS.4.1_1   MYS Malaysia MYS.4_1 Kuala Lumpur      <NA> Kuala Lumpur
      VARNAME_2 NL_NAME_2              TYPE_2         ENGTYPE_2 CC_2   HASC_2
    1      <NA>      <NA> Wilayah Persekutuan Federal Territory <NA> MY.KL.KL

Oke, saya hanya akan menampilkan hasil yang dibutuhkan saja:

``` r
city_names %>% 
  select(COUNTRY,NAME_2,TYPE_2,ENGTYPE_2) %>% 
  knitr::kable()
```

| COUNTRY  | NAME_2       | TYPE_2              | ENGTYPE_2         |
|:---------|:-------------|:--------------------|:------------------|
| Malaysia | Kuala Lumpur | Wilayah Persekutuan | Federal Territory |

Bagaimana? Mudah kan?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
