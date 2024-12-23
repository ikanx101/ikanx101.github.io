---
date: 2024-12-23T14:22:00-04:00
title: "Reverse Geocoding di R Menggunakan tidygeocoder"
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
  - Reverse Geocoding
---

Beberapa waktu belakangan ini, saya sedang mengerjakan kembali beberapa
*project* terkait *geomarketing* di kantor. Agar tidak lupa, saya juga
menuliskan beberapa algoritma terkait pengerjaan data *geolocation* di
blog ini.

Setidaknya ada beberapa tulisan yang pernah saya tulis terkait tahapan
pre-analisa *geolocation* dan *geomarketing*, yakni:

1.  [Mencari nama kecamatan, kota / kabupaten, dan provinsi dari data
    longlat menggunakan data
    GADM.](https://ikanx101.com/blog/raster-gadm/)
2.  [Mencari titik longlat dari data berupa alamat
    lengkap.](https://ikanx101.com/blog/tidy-geocoding/)
3.  [Menghitung jarak antara dua titik longlat menggunakan *open street
    map*.](https://ikanx101.com/blog/osrm-R/)
4.  [Mencari batas-batas wilayah dari data
    GADM.](https://ikanx101.com/blog/batas-wilayahgeo/)

Pada tulisan kali ini saya akan menuliskan bagaimana cara melakukan
*reverse geocoding* di **R**. Apa itu *reverse geocoding*?

> Jadi *reverse geocoding* adalah mencari alamat lengkap dari data
> berupa titik longlat.

Bagaimana caranya? Cukup mudah.

Misalkan saya memiliki data *geolocation* sebagai berikut:

``` r
df = data.frame(lat = c(-6.187633,-6.648847), 
                lon = c(106.912530,106.843400))
```

|       lat |      lon |
|----------:|---------:|
| -6.187633 | 106.9125 |
| -6.648847 | 106.8434 |

Untuk mencari alamatnya, kita gunakan skrip sebagai berikut ini:

``` r
library(tidygeocoder)

output_1 = 
  df %>%
  reverse_geocode(
    lat = lat,
    long = lon,
    method = "osm",
    full_results = TRUE
  )
```

Mari kita lihat *output*-nya sebagai berikut:

| lat | lon | address | place_id | licence | osm_type | osm_id | osm_lat | osm_lon | class | type | place_rank | importance | addresstype | name | road | city_block | industrial | suburb | city | ISO3166-2-lvl4 | region | ISO3166-2-lvl3 | postcode | country | country_code | boundingbox | city_district | state |
|---:|---:|:---|---:|:---|:---|---:|:---|:---|:---|:---|---:|---:|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| -6.187633 | 106.9125 | Jalan Rawa Bali II, RW 03, Jakarta Industrial Estate Pulogadung, Cakung, Jakarta Timur, Daerah Khusus ibukota Jakarta, Jawa, 13920, Indonesia | 26300369 | Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright | way | 29564738 | -6.187631301920013 | 106.91270637688699 | highway | residential | 26 | 0.0534165 | road | Jalan Rawa Bali II | Jalan Rawa Bali II | RW 03 | Jakarta Industrial Estate Pulogadung | Cakung | Jakarta Timur | ID-JK | Jawa | ID-JW | 13920 | Indonesia | id | -6.1894040 , -6.1859501 , 106.9126493, 106.9127242 | NA | NA |
| -6.648847 | 106.8434 | Jalan Raya Tajur, Bogor Timur, Bogor, Jawa Barat, Jawa, 16720, Indonesia | 25981736 | Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright | way | 162789946 | -6.6488066648184905 | 106.8434541815871 | highway | trunk | 26 | 0.0533937 | road | Jalan Raya Tajur | Jalan Raya Tajur | NA | NA | NA | Bogor | ID-JB | Jawa | ID-JW | 16720 | Indonesia | id | -6.6538402 , -6.6473213 , 106.8426713, 106.8461023 | Bogor Timur | Jawa Barat |

Jika rekan-rekan perhatikan, metode yang digunakan pada skrip tersebut
adalah `osm`. Sebagaimana fungsi lain dari `library(tidygeocoder)`, kita
bisa mengganti metodenya menjadi `arcgis`. Apa bedanya? Coba kita ganti:

``` r
output_2 = 
  df %>%
  reverse_geocode(
    lat = lat,
    long = lon,
    method = "arcgis",
    full_results = TRUE
  )
```

Mari kita lihat *output*-nya sebagai berikut:

| lat | lon | address | Match_addr | ShortLabel | Addr_type | Type | PlaceName | AddNum | Address | Block | Sector | Neighborhood | District | City | MetroArea | Subregion | Region | RegionAbbr | Territory | Postal | PostalExt | CntryName | CountryCode | X | Y | InputX | InputY | StrucType | StrucDet |
|---:|---:|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|---:|---:|---:|---:|:---|:---|
| -6.187633 | 106.9125 | Jalan Rawa Bali 2, Cakung, DKI Jakarta, 13920, IDN | Jalan Rawa Bali 2, Cakung, DKI Jakarta, 13920 | Jalan Rawa Bali 2 | StreetName |  |  |  | Jalan Rawa Bali 2 |  |  | Rawa Terate |  | Cakung | Jakarta | Jakarta Timur | DKI Jakarta | JK |  | 13920 |  | Indonesia | IDN | 106.9127 | -6.187633 | 106.9125 | -6.187633 |  |  |
| -6.648847 | 106.8434 | BNI, Jl. Raya Wangun No.240C, Bogor Timur, West Java, 16146, IDN | BNI | BNI | POI | ATM | BNI |  | Jl. Raya Wangun No.240C |  |  | Sindangsari |  | Bogor Timur | Bogor City | Kota Bogor | West Java | JB |  | 16146 |  | Indonesia | IDN | 106.8432 | -6.648800 | 106.8434 | -6.648847 |  |  |

Bagaimana? Mudah *kan*?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
