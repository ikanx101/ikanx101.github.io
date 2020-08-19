---
date: 2020-08-20T7:30:00-04:00
title: "Menemukan LongLat dari Data Berupa Alamat"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - RPA
  - Geocoding
  - Google
  - API
  - Cloud Computing
---

Ternyata sudah hampir dua tahun sejak [postingan pertama
saya](https://passingthroughresearcher.wordpress.com/2018/10/11/masih-tentang-geocoding/)
terkait **Google Geocoding AI** saya tulis di blog yang lama. Sejak saat
itu, saya kira saya tak akan pernah lagi bersinggungan mencari titik
longlat dari data suatu alamat. Sampai minggu kemarin, akhirnya saya
turun gunung untuk melakukan hal ini lagi.

> Tentunya dengan jeda dua tahun tersebut, *knowledge* **R** saya lebih
> banyak dikit dibanding dulu dong. *Hehe*

Oleh karena itu ada banyak *improvement* yang saya lakukan untuk membuat
pekerjaan saya kali ini lebih mudah.

# Problem Statement

Ceritanya, saya memiliki ribuan baris berisi nama kecamatan di
Indonesia. Tidak semua kecamatan yang ada yah, hanya sebagian saja.
Berikut contoh datanya:

<table>

<caption>

Data Alamat

</caption>

<thead>

<tr>

<th style="text-align:left;">

kecamatan

</th>

<th style="text-align:left;">

kota_kabupaten

</th>

<th style="text-align:left;">

provinsi

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

PANCORAN MAS

</td>

<td style="text-align:left;">

KOTA DEPOK

</td>

<td style="text-align:left;">

JAWA BARAT

</td>

</tr>

<tr>

<td style="text-align:left;">

KARAWACI

</td>

<td style="text-align:left;">

KOTA TANGERANG

</td>

<td style="text-align:left;">

BANTEN

</td>

</tr>

<tr>

<td style="text-align:left;">

SEMARANG UTARA

</td>

<td style="text-align:left;">

KOTA SEMARANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

</tr>

<tr>

<td style="text-align:left;">

SIDOREJO

</td>

<td style="text-align:left;">

KOTA SALATIGA

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

</tr>

<tr>

<td style="text-align:left;">

SALAMAN

</td>

<td style="text-align:left;">

KABUPATEN MAGELANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

</tr>

<tr>

<td style="text-align:left;">

NGADIROJO

</td>

<td style="text-align:left;">

KABUPATEN WONOGIRI

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

</tr>

<tr>

<td style="text-align:left;">

BONTORAMBA

</td>

<td style="text-align:left;">

KABUPATEN JENEPONTO

</td>

<td style="text-align:left;">

SULAWESI SELATAN

</td>

</tr>

<tr>

<td style="text-align:left;">

TANAH JAWA

</td>

<td style="text-align:left;">

KABUPATEN SIMALUNGUN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

</tr>

<tr>

<td style="text-align:left;">

SIANTAR BARAT

</td>

<td style="text-align:left;">

KOTA PEMATANG SIANTAR

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

</tr>

<tr>

<td style="text-align:left;">

MEDAN LABUHAN

</td>

<td style="text-align:left;">

KOTA MEDAN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

</tr>

</tbody>

</table>

Nah, kali ini saya membutuhkan data *longlat* dari setiap kecamatan yang
ada. Jika hanya ada 20 baris data, cara termudah adalah dengan
menggunakan *Google Maps*, yakni dengan mencarinya secara manual satu
persatu di *maps* lalu meng-*copy* *longlat* hasil pencarian.

Tapi kali ini saya memiliki banyak sekali data yang harus dicari dengan
segera\!

## Memanfaatkan Google Geocode AI

Cara termudah dan termurah untuk melakukan ini adalah dengan
memanfaatkan AI buatan Google. Kita sebenarnya bisa menggunakan AI ini
dengan cara mengaktifkan akun di [**Google Cloud
Console**](https://console.cloud.google.com/). Saat mengaktifkan pertama
kali, kita akan mendapatkan *free credit* sebesar `$300`. Walaupun
demikian, beberapa AI yang bisa kita akses memiliki harga yang murah
meriah.

Saking murahnya jadi seolah-olah layanan ini gratis. Berdasarkan
pengalaman, saat melakukan *geocoding* jutaan alamat, baru saya terkena
*charge* (walaupun tetap murah jika dibandingkan dengan layanan sejenis
yang ditawarkan para raksasa *cloud computing* di luar sana). Tapi saat
melakukan *geocoding* ribuan alamat, masih *free* jatuhnya.

Jadi yang perlu kita lakukan di halaman **Google Cloud Console** adalah
mengaktifkan akun dan membuat *API key* untuk layanan *Google Geocode*.

Setelah itu, *API key* tersebut akan kita gunakan di **R** menggunakan
`library(googleway)` untuk berinteraksi dan mendapatkan data.

Kira-kira, seperti ini alur pengerjaannya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google%20geocoding/2020-08-20-geocode-ai_files/figure-gfm/unnamed-chunk-2-1.png" width="40%" />

## Fungsi Geocoding di `library(googleway)`

Seandainya kita telah mendapatkan *API key*, maka kita perlu membuat
*function* sebagai berikut:

``` r
# API key dari Google:
key = "XXXXXX"

# Function yang Saya buat
geogeo = function(xxx){
  hasil=google_geocode(address=xxx,key=key)
  lengkap = hasil$results$formatted_address
  lat = hasil$results$geometry$location$lat
  long = hasil$results$geometry$location$lng
  final = paste(lengkap,lat,long,sep=";")
  return(final)
}
```

## Saatnya Beraksi\!

Sekarang saatnya *function* tersebut beraksi\! Kita tinggal aplikasikan
fungsi tersebut ke dalam data dengan perintah `sapply()` berikut:

``` r
data = 
  data %>% 
  mutate(alamat_gabung = paste(kecamatan,kota_kabupaten,provinsi,sep = ","),
         geocode = sapply(alamat_gabung,geogeo)) %>% 
  select(-alamat_gabung)
```

Berikut hasilnya:

<table>

<caption>

Data Hasil Google Geocode

</caption>

<thead>

<tr>

<th style="text-align:left;">

kecamatan

</th>

<th style="text-align:left;">

kota\_kabupaten

</th>

<th style="text-align:left;">

provinsi

</th>

<th style="text-align:left;">

geocode

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

PANCORAN MAS

</td>

<td style="text-align:left;">

KOTA DEPOK

</td>

<td style="text-align:left;">

JAWA BARAT

</td>

<td style="text-align:left;">

Pancoran Mas, Depok City, West Java, Indonesia;-6.3971623;106.8001396

</td>

</tr>

<tr>

<td style="text-align:left;">

KARAWACI

</td>

<td style="text-align:left;">

KOTA TANGERANG

</td>

<td style="text-align:left;">

BANTEN

</td>

<td style="text-align:left;">

Karawaci Sub-District, Tangerang City, Banten,
Indonesia;-6.1805852;106.6202025

</td>

</tr>

<tr>

<td style="text-align:left;">

SEMARANG UTARA

</td>

<td style="text-align:left;">

KOTA SEMARANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

North Semarang, Semarang City, Central Java,
Indonesia;-6.9607692;110.4083341

</td>

</tr>

<tr>

<td style="text-align:left;">

SIDOREJO

</td>

<td style="text-align:left;">

KOTA SALATIGA

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Sidorejo, Salatiga City, Central Java, Indonesia;-7.3055182;110.4947314

</td>

</tr>

<tr>

<td style="text-align:left;">

SALAMAN

</td>

<td style="text-align:left;">

KABUPATEN MAGELANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Salaman, Magelang, Central Java, Indonesia;-7.571206;110.128347

</td>

</tr>

<tr>

<td style="text-align:left;">

NGADIROJO

</td>

<td style="text-align:left;">

KABUPATEN WONOGIRI

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Ngadirojo, Wonogiri Regency, Central Java,
Indonesia;-7.8351953;111.0102737

</td>

</tr>

<tr>

<td style="text-align:left;">

BONTORAMBA

</td>

<td style="text-align:left;">

KABUPATEN JENEPONTO

</td>

<td style="text-align:left;">

SULAWESI SELATAN

</td>

<td style="text-align:left;">

Bontoramba, Jeneponto Regency, South Sulawesi,
Indonesia;-5.5632196;119.6846813

</td>

</tr>

<tr>

<td style="text-align:left;">

TANAH JAWA

</td>

<td style="text-align:left;">

KABUPATEN SIMALUNGUN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

Tanah Jawa, Simalungun Regency, North Sumatra,
Indonesia;2.8901607;99.1788304

</td>

</tr>

<tr>

<td style="text-align:left;">

SIANTAR BARAT

</td>

<td style="text-align:left;">

KOTA PEMATANG SIANTAR

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

West Siantar, Pematang Siantar City, North Sumatra,
Indonesia;2.9528658;99.0543447

</td>

</tr>

<tr>

<td style="text-align:left;">

MEDAN LABUHAN

</td>

<td style="text-align:left;">

KOTA MEDAN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

Medan Labuhan, Medan City, North Sumatra, Indonesia;3.7307552;98.6930685

</td>

</tr>

</tbody>

</table>

Kita tinggal merapikan formatnya saja dengan `function` `separate()`
dari `library(tidyr)` sebagai berikut:

``` r
library(tidyr)
data = 
  data %>%
  separate(geocode,
           into = c("alamat_google","lat","long"),
           sep = ";")
```

Berikut hasilnya:

<table>

<caption>

Data FINAL Google Geocode

</caption>

<thead>

<tr>

<th style="text-align:left;">

kecamatan

</th>

<th style="text-align:left;">

kota\_kabupaten

</th>

<th style="text-align:left;">

provinsi

</th>

<th style="text-align:left;">

alamat\_google

</th>

<th style="text-align:left;">

lat

</th>

<th style="text-align:left;">

long

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

PANCORAN MAS

</td>

<td style="text-align:left;">

KOTA DEPOK

</td>

<td style="text-align:left;">

JAWA BARAT

</td>

<td style="text-align:left;">

Pancoran Mas, Depok City, West Java, Indonesia

</td>

<td style="text-align:left;">

-6.3971623

</td>

<td style="text-align:left;">

106.8001396

</td>

</tr>

<tr>

<td style="text-align:left;">

KARAWACI

</td>

<td style="text-align:left;">

KOTA TANGERANG

</td>

<td style="text-align:left;">

BANTEN

</td>

<td style="text-align:left;">

Karawaci Sub-District, Tangerang City, Banten, Indonesia

</td>

<td style="text-align:left;">

-6.1805852

</td>

<td style="text-align:left;">

106.6202025

</td>

</tr>

<tr>

<td style="text-align:left;">

SEMARANG UTARA

</td>

<td style="text-align:left;">

KOTA SEMARANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

North Semarang, Semarang City, Central Java, Indonesia

</td>

<td style="text-align:left;">

-6.9607692

</td>

<td style="text-align:left;">

110.4083341

</td>

</tr>

<tr>

<td style="text-align:left;">

SIDOREJO

</td>

<td style="text-align:left;">

KOTA SALATIGA

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Sidorejo, Salatiga City, Central Java, Indonesia

</td>

<td style="text-align:left;">

-7.3055182

</td>

<td style="text-align:left;">

110.4947314

</td>

</tr>

<tr>

<td style="text-align:left;">

SALAMAN

</td>

<td style="text-align:left;">

KABUPATEN MAGELANG

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Salaman, Magelang, Central Java, Indonesia

</td>

<td style="text-align:left;">

-7.571206

</td>

<td style="text-align:left;">

110.128347

</td>

</tr>

<tr>

<td style="text-align:left;">

NGADIROJO

</td>

<td style="text-align:left;">

KABUPATEN WONOGIRI

</td>

<td style="text-align:left;">

JAWA TENGAH

</td>

<td style="text-align:left;">

Ngadirojo, Wonogiri Regency, Central Java, Indonesia

</td>

<td style="text-align:left;">

-7.8351953

</td>

<td style="text-align:left;">

111.0102737

</td>

</tr>

<tr>

<td style="text-align:left;">

BONTORAMBA

</td>

<td style="text-align:left;">

KABUPATEN JENEPONTO

</td>

<td style="text-align:left;">

SULAWESI SELATAN

</td>

<td style="text-align:left;">

Bontoramba, Jeneponto Regency, South Sulawesi, Indonesia

</td>

<td style="text-align:left;">

-5.5632196

</td>

<td style="text-align:left;">

119.6846813

</td>

</tr>

<tr>

<td style="text-align:left;">

TANAH JAWA

</td>

<td style="text-align:left;">

KABUPATEN SIMALUNGUN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

Tanah Jawa, Simalungun Regency, North Sumatra, Indonesia

</td>

<td style="text-align:left;">

2.8901607

</td>

<td style="text-align:left;">

99.1788304

</td>

</tr>

<tr>

<td style="text-align:left;">

SIANTAR BARAT

</td>

<td style="text-align:left;">

KOTA PEMATANG SIANTAR

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

West Siantar, Pematang Siantar City, North Sumatra, Indonesia

</td>

<td style="text-align:left;">

2.9528658

</td>

<td style="text-align:left;">

99.0543447

</td>

</tr>

<tr>

<td style="text-align:left;">

MEDAN LABUHAN

</td>

<td style="text-align:left;">

KOTA MEDAN

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

Medan Labuhan, Medan City, North Sumatra, Indonesia

</td>

<td style="text-align:left;">

3.7307552

</td>

<td style="text-align:left;">

98.6930685

</td>

</tr>

</tbody>

</table>

### Mudah kan?

Selamat mencoba\!
