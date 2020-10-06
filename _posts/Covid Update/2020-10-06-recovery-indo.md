---
date: 2020-10-06T10:38:00-04:00
title: "Update COVID-19: Recovery Rate di Indonesia Bagus Tapi…"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Web Scrap
  - Corona Virus
  - Outbreak
  - PSBB
  - COVID
  - Our World in Data
---


Sampai saat ini belum ada tanda-tanda penurunan penyebaran COVID 19 di
Indonesia. Justru kalau kita lihat data yang dikumpulkan oleh para
relawan di situs [Kawal Covid](https://kawalcovid19.id/), ada beberapa
temuan yang menarik menurut saya.

Apa saja?

Berbekal data yang dihimpun dari situs tersebut dan [*Our World in
Data*](https://ourworldindata.org/coronavirus), *yuk* mari kita lihat
bersama\!

-----

# *Cumulative Cases*

Sama seperti beberapa tulisan saya
[sebelumnya](https://ikanx101.com/tags/#corona-virus), saya masih ingin
membandingkan total kasus (kumulatif) Indonesia dengan Italy.

> Kenapa dibandingkan dengan Italy?

Saya sudah pernah menjelaskannya di [tulisan saya
sebelumnya](https://ikanx101.com/blog/psbbt/#cumulative-confirmed-cases).

<img src="https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/Covid%20Update/update-6-Okt_files/figure-gfm/unnamed-chunk-1-1.png" width="768" />

Pada bulan lalu saya sempat menduga bahwa Indonesia akan menyalip angka
Italy dalam rentang waktu yang relatif tidak lama. Tapi sepertinya di
Italy ada gelombang kedua sehingga angkanya juga relatif meningkat
dibandingkan bulan lalu. Tentu ini hal yang tidak baik untuk kedua
negara ini.

> Analoginya seperti perlombaan tapi bukan dalam hal yang positif.

-----

# Penambahan Kasus vs Sembuh vs Meninggal (Harian) di Indonesia

Salah satu isu yang diangkat oleh pemerintah dan beberapa media beberapa
hari ini adalah tingkat kesembuhan pasien COVID 19 yang semakin naik.
Setiap harinya, banyaknya orang yang sembuh sudah semakin tinggi
dibandingkan orang yang meninggal dan angka penambahan kasus baru.

<img src="https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/Covid%20Update/update-6-Okt_files/figure-gfm/unnamed-chunk-2-1.png" width="768" />

Jika kita ingat kembali saat di awal-awal pandemi terjadi di Indonesia,
angka kematian melebihi angka kesembuhan. Namun sekarang kita bisa
melihat dari grafik di atas bahwa memang angka kesembuhan sudah relatif
meningkat. Penambahan orang sembuh setiap harinya hampir sama dengan
penambahan kasus positif COVID 19 baru.

*Recovery rate* di Indonesia per hari ini sudah mencapai angka `75.7%`.
Namun demikian, apakah angka ini sudah bagus? Mari kita bandingkan
dengan negara lainnya\!

-----

# Perbandingan *Recovery Rate* dari Seluruh Negara

Saya mengambil data dari situs
[Worldometers](https://www.worldometers.info/coronavirus/) pagi ini
pukul 04.45 WIB. Mari kita lihat dulu sebaran data *recovery rate* dari
seluruh negara di dunia.

<img src="https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/Covid%20Update/update-6-Okt_files/figure-gfm/unnamed-chunk-3-1.png" width="768" />

Ternyata, walaupun Indonesia memiliki *recovery rate* yang relatif
`tinggi` tapi masih banyak negara lain yang memiliki *recovery rate*
yang lebih tinggi (berada di *range* \> `90%`).

Negara mana saja? Berikut visualisasinya:

<img src="https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/Covid%20Update/update-6-Okt_files/figure-gfm/unnamed-chunk-4-1.png" width="768" />

Besar harapan kita agar angka ini selalu bergerak naik mengikuti
negara-negara lain.

-----

# Kasus Aktif Harian di Indonesia

Data terakhir yang ingin saya tunjukkan adalah angka kasus aktif harian.
Mari kita lihat visualisasi berikut:

<img src="https://github.com/ikanx101/ikanx101.github.io/blob/master/_posts/Covid%20Update/update-6-Okt_files/figure-gfm/unnamed-chunk-5-1.png" width="768" />

Ternyata setelah sempat melandai di masa-masa Idul Adha hingga Agustus,
kasus aktif harian di Indonesia meningkat kembali sejak September hingga
saat ini.

-----

## Kesimpulan

Melihat data-data di atas, kita masih harus waspada terhadap pandemi
ini. Jaga diri dan komunal dari COVID 19.
