---
date: 2024-11-21T09:45:00-04:00
title: "Geocoding di R Menggunakan tidygeocoder"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Raster
  - Geocoding
  - tidygeocoder
  - Geomarketing
---

Di *blog* ini saya sudah menuliskan berbagai macam metode dan teknik
pengambilan data longlat dari alamat (*vice versa*). Istilah kerennya
itu ***geocoding***.

> Salah satu metode andalan saya dalam melakukan *geocoding* adalah
> dengan menggunakan `library(googleway)` dan `Google Geocode API`.

Salah satu kelemahan metode ini adalah *budget* yang dikeluarkan untuk
melakukan *geocode* dalam jumlah banyak.

Kali ini saya hendak melakukan *geocoding* yang gratis dengan
memanfaatkan `library(tidygeocoder)`. Bagaimana caranya?

## Tahap I

*Install* *library* yang dibutuhkan:

    install.packages("tidygeocoder")

## Tahap II

Panggil *libraries* yang dibutuhkan:

``` r
library(dplyr)
library(tidygeocoder)
```

## Tahap III

Kita buat data *input* berupa dummy alamat dari beberapa tempat yang ada
di Jakarta dan kota lainnya.

``` r
address_single = 
  data.frame(address = c(
  "Wisma 46 Jakarta",
  "Hotel Tentrem Jogjakarta",
  "Kampus Ganesha ITB Bandung",
  "Nutrifood Pulogadung Jakarta"
))
```


## Tahap IV

Selanjutnya kita lakukan *geocoding*. Ada berbagai macam metode yang
diberikan oleh `tidygeocoder`, saya akan tunjukkan dua metode yang
gratis (tanpa memerlukan API dari layanan *online*) yakni:

1.  Metode berbasis *Open Street Map*.
2.  Metode berbasis *ARCGIS*.

### Metode *Open Street Map*

Berikut adalah *function*-nya:

``` r
osm_output = geo(
  address = address_single$address, 
  method  = "osm",
  lat     = latitude, 
  long    = longitude, 
  full_results = T
)
```

Berikut keluarannya:

| address | latitude | longitude | place_id | licence | osm_type | osm_id | class | type | place_rank | importance | addresstype | name | display_name | boundingbox |
|:---|---:|---:|---:|:---|:---|---:|:---|:---|---:|---:|:---|:---|:---|:---|
| Wisma 46 Jakarta | -6.203565 | 106.8204 | 26163516 | Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright | way | 334982528 | office | commercial | 30 | 8.31e-05 | office | Wisma 46 | Wisma 46, 1, Jalan Jenderal Sudirman, RW 09, Karet Tengsin, Tanah Abang, Jakarta Pusat, Daerah Khusus ibukota Jakarta, Jawa, 10220, Indonesia | -6.2039813 , -6.2031530 , 106.8197614, 106.8208612 |
| Hotel Tentrem Jogjakarta | -7.773754 | 110.3687 | 27303196 | Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright | way | 247974332 | tourism | hotel | 30 | 5.00e-05 | tourism | Hotel Tentrem | Hotel Tentrem, Jalan Monjali, Cokrodiningratan, Jetis, Kota Yogyakarta, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55223, Indonesia | -7.7741915 , -7.7733171 , 110.3682090, 110.3692202 |
| Kampus Ganesha ITB Bandung | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NULL |
| Nutrifood Pulogadung Jakarta | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NULL |

Ternyata kita dapatkan ada dua buah *input* yang tidak bisa
di-*geocoding*. Sekarang kita gunakan metode lain:

### Metode *ARC GIS*

Berikut adalah *function*-nya:


``` r
gis_output = 
  geo(
  address      = address_single$address, 
  method       = "arcgis",
  lat          = latitude, 
  long         = longitude, 
  full_results = T
)
```

Berikut keluarannya:

| address | latitude | longitude | arcgis_address | score | location.x | location.y | extent.xmin | extent.ymin | extent.xmax | extent.ymax |
|:---|---:|---:|:---|---:|---:|---:|---:|---:|---:|---:|
| Wisma 46 Jakarta | -6.203538 | 106.8199 | KFC Wisma 46 | 80.18 | 106.8199 | -6.203538 | 106.8149 | -6.208538 | 106.8249 | -6.198538 |
| Hotel Tentrem Jogjakarta | -7.795102 | 110.3696 | Hotel Tentrem Yogyakarta | 94.94 | 110.3696 | -7.795102 | 110.3646 | -7.800102 | 110.3746 | -7.790102 |
| Kampus Ganesha ITB Bandung | -6.894440 | 107.6094 | Ganesha, Jawa Barat | 83.50 | 107.6094 | -6.894440 | 107.5994 | -6.904440 | 107.6194 | -6.884440 |
| Nutrifood Pulogadung Jakarta | -6.179720 | 106.8803 | Pulogadung, Jakarta | 86.15 | 106.8803 | -6.179720 | 106.8703 | -6.189720 | 106.8903 | -6.169720 |

Kita dapatkan bahwa metode `arcgis` bisa memberikan hasil *geocoding*
untuk semua *input* namun data dari `osm` memberikan informasi yang
lebih banyak.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
