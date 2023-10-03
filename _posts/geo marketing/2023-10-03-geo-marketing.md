---
date: 2023-10-03T10:30:00-04:00
title: "Mencari Nama Kota/Kabupaten dan Kecamatan dari Data Titik Longlat"
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


Pada tahun ini, salah satu *project* besar yang kami kerjakan di kantor
adalah terkait *geo marketing*. Jika rekan-rekan tahu, saya sudah pernah
menulis beberapa tulisan terkait [bagaimana mengambil data *geolocation*
dan *geocoding* dari Google
Maps](https://ikanx101.com/tags/#geolocation). Nah, *project
geomarketing* yang kami lakukan adalah untuk mengutilisasi data
*geolocation* dan *geocoding* lebih lanjut.

Salah satu tahapan *pre-processing* yang biasa dilakukan adalah
menemukan nama `kecamatan`, `kota`/`kabupaten`, dan `provinsi` dari data
`longitude` dan `latitude`. Oleh karena data `longitude` dan `latitude`
yang saya miliki banyak, maka mencari *manual* dengan cara *searching*
di *Google Maps* bukanlah pilihan yang bijaksana. Saya harus bisa
melakukannya secara otomatis dan cepat dengan **R**.

Setidaknya ada dua cara yang saya bisa lakukan:

1.  Menggunakan **API** dari *Google Maps*. Saya pernah menuliskannya di
    [*blog* saya yang
    lama](https://passingthroughresearcher.wordpress.com/2018/09/24/geocoding-with-r-and-google-geocoding-api/).
2.  Menggunakan data *raster* yang tersedia.

Pada tulisan ini, saya akan menggunakan cara kedua karena lebih cepat
dan gratis. Bagaimana caranya?

------------------------------------------------------------------------

## Data yang Digunakan

Saya memiliki data lokasi **koperasi** sebagai berikut:

``` r
data %>% knitr::kable()
```

| nama                                                 |       lat |      lon |
|:-----------------------------------------------------|----------:|---------:|
| Koperasi Budhi Setiya                                | -6.295531 | 106.8784 |
| Koperasi Anugrah Mandiri                             | -6.343229 | 106.8171 |
| Koperasi Tri Dharma Mandiri                          | -6.127773 | 106.9063 |
| Koperasi Swadarma Ekakerta IX                        | -6.122570 | 106.8874 |
| Koperasi Kredit Pelita Harapan                       | -6.120244 | 106.8750 |
| Koperasi Bengkel Pusat Angkutan                      | -6.109990 | 106.8818 |
| Koperasi Pegawai Puslitarkenas “Teratai”             | -6.277697 | 106.8312 |
| Induk Koperasi TNI Angkatan Darat                    | -6.171479 | 106.8195 |
| Koperasi Karyawan Universitas Mercu Buana            | -6.210024 | 106.7383 |
| Koperasi Wadhika                                     | -6.189716 | 106.9113 |
| Koperasi Pegawai Negeri PPSJ                         | -6.110579 | 106.8023 |
| Koperasi Wahana Kalpika                              | -6.351766 | 106.9011 |
| Koperasi Telkomsel                                   | -6.174982 | 106.8516 |
| Gabungan Koperasi Batik Indonesia                    | -6.187454 | 106.8125 |
| Induk Koperasi Wanita Pengusaha Indonesia (INKOWAPI) | -6.181843 | 106.8441 |

Berikut adalah visualisasi petanya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/post_files/figure-gfm/unnamed-chunk-2-1.png" width="80%" style="display: block; margin: auto;" />

Sekarang saya akan cari nama kecamatan dan nama kotanya dengan skrip
berikut ini:

    ### Getting the Indonesia shapefile
    indo_data = getData('GADM', country = 'Indonesia', level = 3, type = "sp")

    ### Extracting the attributes from the shapefile for the given points
    city_names = extract(indo_data,                 # shapefile data indo
                         data[, c("lon", "lat")])   # mengambil data longlat dari data kita ke shapefile

    ### nama kota
    kota       = city_names$NAME_2

    ### nama kecamatan
    kecamatan  = city_names$NAME_3

Sekarang kita masukkan nama `kota` dan `kecamatan` ke *object* `data`:

    df$kota      = kota
    df$kecamatan = kecamatan

Berikut adalah hasil akhirnya:

| nama                                                 |       lat |      lon | kecamatan     | kota            |
|:-----------------------------------------------------|----------:|---------:|:--------------|:----------------|
| Koperasi Budhi Setiya                                | -6.295531 | 106.8784 | Kramatjati    | Jakarta Timur   |
| Koperasi Anugrah Mandiri                             | -6.343229 | 106.8171 | Jagakarsa     | Jakarta Selatan |
| Koperasi Tri Dharma Mandiri                          | -6.127773 | 106.9063 | Koja          | Jakarta Utara   |
| Koperasi Swadarma Ekakerta IX                        | -6.122570 | 106.8874 | Tanjung Priok | Jakarta Utara   |
| Koperasi Kredit Pelita Harapan                       | -6.120244 | 106.8750 | Tanjung Priok | Jakarta Utara   |
| Koperasi Bengkel Pusat Angkutan                      | -6.109990 | 106.8818 | Tanjung Priok | Jakarta Utara   |
| Koperasi Pegawai Puslitarkenas “Teratai”             | -6.277697 | 106.8312 | Pasar Minggu  | Jakarta Selatan |
| Induk Koperasi TNI Angkatan Darat                    | -6.171479 | 106.8195 | Gambir        | Jakarta Pusat   |
| Koperasi Karyawan Universitas Mercu Buana            | -6.210024 | 106.7383 | Kembangan     | Jakarta Barat   |
| Koperasi Wadhika                                     | -6.189716 | 106.9113 | Cakung        | Jakarta Timur   |
| Koperasi Pegawai Negeri PPSJ                         | -6.110579 | 106.8023 | Penjaringan   | Jakarta Utara   |
| Koperasi Wahana Kalpika                              | -6.351766 | 106.9011 | Cipayung      | Jakarta Timur   |
| Koperasi Telkomsel                                   | -6.174982 | 106.8516 | Johar Baru    | Jakarta Pusat   |
| Gabungan Koperasi Batik Indonesia                    | -6.187454 | 106.8125 | Tanahabang    | Jakarta Pusat   |
| Induk Koperasi Wanita Pengusaha Indonesia (INKOWAPI) | -6.181843 | 106.8441 | Senen         | Jakarta Pusat   |

Prosesnya cukup mudah dan cepat. Hasilnya juga *reliable*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
