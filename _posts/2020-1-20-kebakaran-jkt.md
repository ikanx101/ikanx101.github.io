---
date: 2020-1-20T1:30:00-04:00
title: "Open Data Jakarta: Kebakaran di Tahun 2018"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Jakarta
  - Kebakaran
  - Descriptive Statistics
  - Open Data
---

Ceritanya Senin ini, 20 Januari 2020 dalam rangka memperingati **Bulan
K3**, saya dan beberapa rekan di area kerja yang bertugas sebagai
petugas peran K3 **Nutrifood** harus memberikan materi mengenai
kebakaran dan banjir kepada semua rekan kerja di lantai kami.

Seharusnya ada tujuh orang petugas peran di lantai saya. Tapi karena
satu dan lain hal, hanya ada dua atau tiga orang saja yang siap
menyampaikan materi tersebut. Saya termasuk orang yang izin *gak*
ngantor hari ini.

Sebagai salah satu petugas damkar di area kerja, awalnya saya
mendapatkan tugas untuk menyampaikan materi seputar kebakaran. Untuk
menebus dosa absen, saya coba berkontribusi dengan menulis tulisan ini.

> *Tau gak sih apa penyebab kebakaran?*

Jawabannya: **API**.

Tapi *tau gak sih* apa yang menyebabkan api?

Secara teori, api itu dibangun oleh beberapa unsur,
yakni:

![api](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Kebakaran/SmartSelect_20200119-203521_Chrome.jpg)

Semua unsur itu harus menyatu agar bisa menghasilkan api. *So*, secara
teori, saat kita menghilangkan salah satu dari ketiga unsur itu, maka
api bisa dikendalikan atau dipadamkan.

> Ada gak sih data yang menghimpun informasi seputar kebakaran di
> Jakarta?

Ternyata situs open data Jakarta memuat data yang saya inginkan. Namun
hanya tersedia data di tahun 2018 saja.

Percaya atau tidak, berdasarkan data yang saya himpun dari situs
[data.jakarta.go.id](http://data.jakarta.go.id/dataset/data-rekapitulasi-kejadian-kebakaran-di-provinsi-dki-jakarta-tahun-2018/resource/7d595666-39bd-4803-aecc-801ac60014a9),
sepertinya hampir setiap hari terjadi kebakaran di Jakarta pada tahun
2018.

![a1](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Kebakaran/2020-1-18-kebakaran-jakarta_files/figure-gfm/unnamed-chunk-2-1.png)

Sebagaimana musibah lainnya, kebakaran memberikan banyak sekali kerugian
bagi kita semua. Pada tahun 2018, tercatat kerugian secara materiil
diperkirakan menembus angka `180.26` Milyar Rupiah\!

Sebuah angka yang fantastis menurut
saya.

![a2](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Kebakaran/2020-1-18-kebakaran-jakarta_files/figure-gfm/unnamed-chunk-3-2.png)

Sebenarnya dari mana sih sumber api kebakaran terbanyak? Berdasarkan
data yang ada, **korsleting listrik** menjadi sumber penyebab kebakaran
terbanyak di Jakarta.

Hal ini sudah sepatutnya membuat kita *aware* dengan potensi bahaya
kebakaran terkait dengan listrik dan
komponen-komponennya.

![a3](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Kebakaran/2020-1-18-kebakaran-jakarta_files/figure-gfm/unnamed-chunk-4-1.png)

Objek apa saja yang
terbakar?

![v4](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Kebakaran/2020-1-18-kebakaran-jakarta_files/figure-gfm/unnamed-chunk-5-1.png)

Bagaimana dengan banyaknya korban jiwa?

Pada tahun 2018, tercatat:

  - 159 orang mendapatkan luka ringan.
  - 23 orang mendapatkan luka berat.
  - 25 orang dinyatakan meninggal dunia.

*So*, semoga dari data ini kita bisa memetik pelajaran dan mengambil
langkah konkrit untuk sama-sama mencegah terjadinya kebakaran
bersama-sama.
