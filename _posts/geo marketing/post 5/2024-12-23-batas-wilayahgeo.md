---
date: 2024-12-23T13:50:00-04:00
title: "Mencari Batas-Batas Wilayah Kota dan Kabupaten di R dari Data Shapefile"
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
  - Geografi
---

Pada bulan Juni lalu, saya pernah menuliskan bagaimana cara mendapatkan
data berupa nama kecamatan, kota / kabupaten, dan provinsi dari data
berupa titik longlat menggunakan **R**. Hal itu dimungkinkan menggunakan
data geografi *shapefile* yang didapatkan dari situs
[GADM](https://gadm.org/download_country.html). Sekarang saya akan coba
mengutilisasi data *shapefile* tersebut lebih lanjut.

> Saya akan mencari batas-batas wilayah longlat dari semua kota yang ada
> di Indonesia.

Bagaimana caranya? *Cekidot!*

## Persiapan

Pertama-tama kita memerlukan data *shapefiles* dari situs GADM. Kemudian
pada **R**, silakan *install* `library(sf)`. Betul, kita memerlukan
`library(sf)` untuk mengambil data dari *shapefile* tersebut.

## Pengambilan Data

Sekarang kita akan ambil data batas wilayah dari *shapefile* yang ada.
Saya akan baca *file* bernama `gadm41_IDN_2.shp` dari GADM. Jika kalian
hendak mendapatkan data batas untuk level kecamatan, maka kita
memerlukan data *shapefile* level ketiga.

    # step 1
    # kita baca shapefile menggunakan library sf
    library(sf)
    city_boundary   = st_read("gadm41_IDN_2.shp")

Dari *object* bernama `city_boundary` kita sebenarnya sudah mendapatkan
**sejenis** *data frame* yang berisi semua data wilayah perkota. Namun
strukturnya masih cukup rumit untuk sebagian besar orang. Maka saya akan
buat satu *function* untuk melakukan ekstraksi lebih lanjut dan
menjadikannya dalam struktur *data frame* yang rapi. Sebagai *input*
*function*-nya adalah nama kota yang sudah didapatkan dari *object*
`city_boundary`.

    # step 2
    # merapikan bentuk data menjadi data frame
    # dimulai dari mempersiapkan data input
    city_boundary = 
      city_boundary |> 
      mutate(pencarian = paste(NAME_1,NAME_2,sep = "-"))

    # menuliskan semua nama kota
    nama_semua_kota = city_boundary$pencarian

    # membuat function per kota
    extrak_kota = function(kota_input){
      # ambil longlatnya
      selected_city = city_boundary %>% filter(pencarian == kota_input)
      bbox = sf::st_bbox(selected_city)
      min_lat = bbox[2]
      max_lat = bbox[4]
      min_lon = bbox[1]
      max_lon = bbox[3]
      
      output  = data.frame(kota = kota_input,
                           min_lat,max_lat,min_lon,max_lon)
      
      return(output)
    }

Setelah ini saya akan lakukan komputasi parallel untuk semua kota
tersebut.

    # memanggil library(parallel)
    library(parallel)
    # menentukan berapa banyak cores yang terlibat
    ncore = detectCores()

    # run parallel function-nya
    temp       = mclapply(nama_semua_kota,extrak_kota,mc.cores = ncore)
    batas_kota = 
      data.table::rbindlist(temp) %>% as.data.frame() |> 
      separate(kota,into = c("provinsi","kota"),sep = "\\-")

*Segitu* aja caranya. Prosesnya cukup mudah dan cepat. Berikut adalah
sampel dari data yang saya dapatkan:

                  provinsi              kota   min_lat    max_lat  min_lon  max_lon
    1      Bangka Belitung     Bangka Tengah -2.721151 -2.1445124 105.7493 106.8494
    2         Jakarta Raya     Jakarta Timur -6.370783 -6.1514230 106.8383 106.9719
    3          Jawa Tengah          Grobogan -7.283214 -6.9126353 110.5415 111.2468
    4           Jawa Timur             Tuban -7.165087 -6.7537127 111.5701 112.2220
    5  Nusa Tenggara Timur       Sumba Barat -9.797201 -9.3734970 119.1436 119.5430
    6                Papua           Waropen -3.282288 -2.1763300 136.0091 137.3843
    7                 Riau   Indragiri Hilir -1.122273  0.5373848 102.5550 103.8146
    8     Sulawesi Selatan        Luwu Timur -3.013185 -2.0510042 120.4716 121.7904
    9     Sulawesi Selatan        Luwu Utara -2.918168 -1.8952355 119.6283 120.6560
    10    Sulawesi Selatan Sidenreng Rappang -4.133101 -3.4830859 119.6641 120.3317

Perlu saya garis bawahi bahwa untuk mempermudah penulisan batas wilayah,
digunakan *rounding box* berbentuk persegi.

Dengan menggunakan prinsip yang sama dengan [simulasi Monte Carlo
ini](https://ikanx101.com/blog/hitung-pi/), kita bisa menggambarkan area
sebenarnya dari suatu kabupaten kota. Misalkan saya hendak menggambarkan
Kota Kediri.

              used (Mb) gc trigger (Mb) max used (Mb)
    Ncells  850947 45.5    1402950   75  1402950 75.0
    Vcells 1509214 11.6    8388608   64  2425871 18.6

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post%205/post_files/figure-commonmark/unnamed-chunk-2-1.png)

Semoga membantu.

------------------------------------------------------------------------

`if you find this article helpful support this blog by clicking the ads.`
