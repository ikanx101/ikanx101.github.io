---
date: 2025-12-23T15:46:00-04:00
title: "Seberapa Mudah Mencari Laundry di Kota Bekasi?"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Raster
  - Geocoding
  - OSRM
  - Geomarketing
  - Laundry
  - Voronoi
  - Aksesbilitas
  - Jarak
---

Beberapa hari yang lalu, *nyonya* meminta saya untuk mencari *laundry*
yang bisa “mencuci” sepatu dan tas sekolah anak-anak. *“Mumpung sedang
liburan”*, katanya. Berdasarkan hasil *Googling* sana-sini, akhirnya
saya memilih salah satu *laundry* modern yang ada di dekat rumah untuk
mencuci tas dan sepatu tersebut.

Sepanjang perjalanan dari rumah ke *laundry* itu, saya merasa melewati
beberapa *laundry* lainnya. Mulai dari *laundry* rumahan hingga
*self-service laundry* yang sedang *nge-trend* di Bekasi. Saya jadi
berpikir, sangat mudah bagi saya untuk mengakses *laundry* di dekat
rumah.

> Tahun 2023 lalu, saya pernah melakukan [analisa
> *geomarketing*](https://ikanx101.com/blog/geomkt-bks/) untuk melihat
> seberapa *accessible* rumah makan padang, warteg, dan bakso-mie ayam
> di kota Bekasi.

Kali ini saya akan melakukan hal yang sama, yakni menghitung seberapa
mudah orang di Kota Bekasi mengakses *laundry*. Secara simpel, saya akan
menghitung jarak tempuh seseorang ke *laundry* berdasarkan [jarak *real*
di *Open Street Maps*](https://ikanx101.com/blog/osrm-R/) dengan moda
sepeda motor.

Untuk melakukannya, tahap pertama yang saya lakukan adalah mengambil
(hampir) semua data *laundry* yang ada di kota Bekasi menggunakan
[***Google Places API***](https://ikanx101.com/blog/google-places/).
Saya mendapatkan sebanyak **237 titik *laundry*** di Kota Bekasi sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/laundry/laundry.png" width="650" />

Berikut adalah sampel 5 data *laundry* yang saya dapatkan:

| nama | alamat | long | lat | rating | user_rating | neighborhood | city |
|:---|:---|---:|---:|---:|---:|:---|:---|
| Nusantara Laundry | Jl. Nusantara Raya No.2 Blok A4, Aren Jaya, Kec. Bekasi Tim., Kota Bks, Jawa Barat 17111, Indonesia | 107.0387 | -6.244168 | 4.9 | 11 | Aren Jaya | Bekasi Timur |
| Super Mami Laundry | Jl. P. Kalimantan Raya No.25, RT.003/RW.015, Aren Jaya, Kec. Bekasi Tim., Kota Bks, Jawa Barat 17111, Indonesia | 107.0318 | -6.241656 | 5.0 | 10 | Aren Jaya | Bekasi Timur |
| BEKASI LAUNDRY EXPRESS | Jl. Kusuma Tim. C No.A 7, RT.001/RW.020, Aren Jaya, Kec. Bekasi Tim., Kota Bks, Jawa Barat 17111, Indonesia | 107.0327 | -6.236055 | 5.0 | 2 | Aren Jaya | Bekasi Timur |
| Get Clean Laundry Bekasi | Jl. P. Sumatera Raya Jl. Perumnas 3 Bekasi No.26, RT.007/RW.014, Aren Jaya, Kec. Bekasi Tim., Kota Bks, Jawa Barat 17111, Indonesia | 107.0313 | -6.242188 | 5.0 | 2 | Aren Jaya | Bekasi Timur |
| Diana Laundry Bekasi JAWA | Jl. Pulau Jawa 5 No.28B, RT.002/RW.013, Aren Jaya, Kec. Bekasi Tim., Kota Bks, Jawa Barat 17111, Indonesia | 107.0302 | -6.246579 | 4.5 | 11 | Aren Jaya | Bekasi Timur |

Sekarang saya akan men-*generate* ratusan titik pelanggan secara
*random* dan secara iteratif akan menghitung jarak antara titik
pelanggan tersebut ke semua *laundry* yang ada.

Sebagai contoh seperti ini titik pelanggan yang saya *generate* pada
satu iterasi:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/laundry/pelanggan.png" width="650" />

Berikut adalah contoh hasil perhitungan pelanggan pertama ke 5 *laundry*
yang ada di data ***Google Places***:

| id_pelanggan | id_laundry | jarak (km) |
|-------------:|-----------:|-----------:|
|            1 |          1 |     1.2994 |
|            1 |          2 |     0.8321 |
|            1 |          3 |     0.3192 |
|            1 |          4 |     0.9174 |
|            1 |          5 |     1.5654 |

**Aksesbilitas** saya hitung dari [jarak
terpendek](https://ikanx101.com/blog/geomkt-bks/) seorang pelanggan
untuk mencapai *laundry*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/laundry/draft_files/figure-commonmark/unnamed-chunk-4-1.png)

Dari hasil perhitungan di atas, kita bisa dapatkan bahwa rata-rata jarak
seseorang pelanggan di Bekasi mengakses *laundry* adalah 1.2 km dengan
median sekitar 850 meter.

> Namun, dari *density plot* di atas kita lihat puncak grafik berada
> pada jarak 500 meter. Artinya “sebagian besar” pelanggan bisa
> mengakses *laundry* dalam jarak 500 meter saja.

Dari grafik tersebut, Saya bisa menghitung peluang bahwa *laundry* bisa
diakses dengan jarak kurang dari 1 km sebesar:

    [1] "Peluang seorang pelanggan mengakses laundry di bawah 1 km sebesar: 61.9%"

## Voronoi Diagram

Setelah membaca beberapa artikel, saya tertarik untuk melakukan analisa
**diagram Voronoi**.

### Apa Itu Diagram Voronoi?

Saya kutip dari berbagai sumber: **Diagram Voronoi** (atau **Tessellasi
Voronoi**) adalah pembagian wilayah berdasarkan kedekatan dengan
titik-titik tertentu. Dalam konteks ini:

1.  Setiap titik longlat *laundry* menjadi pusat sel Voronoi.
2.  Setiap lokasi dalam sel tersebut akan lebih dekat ke *laundry* di
    sel itu dibanding *laundry* lain di titik mana pun.
3.  Garis-garis pada diagram adalah batas wilayah yang sama jauhnya dari
    dua *laundry* terdekat.

Secara sederhana diagram Voronoi bisa menjawab pertanyaan berikut ini:

> *“Jika saya di titik X, laundry mana yang paling dekat?”*

### Apa Saja *Insights* yang Bisa Didapat dari Analisis Voronoi?

1.  Cakupan Layanan & Area Dominasi
    - Setiap sel menunjukkan area teoretis yang dilayani *laundry*
      tersebut.
    - Kita bisa melihat *laundry* mana yang wilayah layanannya:
      - Luas (mungkin karena kurang kompetisi - indikasi jarangnya
        *laundry* di sel tersebut) atau
      - Sempit (karena daerah padat *laundry*).
2.  Potensi Konflik atau Persaingan Berdasarkan Jarak
    - Dua *laundry* yang berbagi batas Voronoi panjang adalah pesaing
      langsung untuk pelanggan di area perbatasan.
    - Jika ada *laundry* yang selnya dikelilingi banyak laundry lain,
      artinya dia di tengah persaingan ketat.
3.  Analisis Demografi & Potensi Pasar
    - Jika kita gabungkan diagram Voronoi dengan peta kepadatan penduduk
      atau kelas ekonomi, kita bisa mendapatkan gambaran terkait
      strategi *marketing*.
4.  Perencanaan Ekspansi atau Pemindahan Lokasi
    - Jika ingin membuka *laundry* baru, tempatkan di pusat sel Voronoi
      yang sangat besar untuk maksimalkan cakupan.
    - Jika ingin menghindari kompetisi, cari area yang jarak ke *laundry
      existing* jauh.

Ini adalah diagram Voronoi:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/geo%20marketing/laundry/draft_files/figure-commonmark/unnamed-chunk-6-1.png)

**Kita bisa melihat ada beberapa sel yang ternyata luas di tengah
kota.**

Apa yang bisa kita simpulkan dari diagram ini?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
