---
date: 2020-11-6T03:38:00-04:00
title: "Summary Zona Risiko COVID 19 Kabupaten Kota di Indonesia"
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
  - Risiko
---


Pandemi yang belum juga usai di Indonesia ini lama-lama membuat jenuh
juga *yah*. Walau data terbaru menunjukkan tren menurun, tapi entah
kenapa saya punya *feeling* penurunan ini erat kaitannya dengan
pelaksanaan PILKADA yang akan diselenggarakan di kemudian hari.

Tapi ini hanya *feeling* dan opini saja *yah*. Saya masih malas untuk
mengumpulkan data lalu melakukan analisanya.

-----

Kali ini saya mau berbicara mengenai data zonasi risiko di kabupaten dan
kota seluruh Indonesia. Data ini saya *scrape* dari [situs resmi
pemerintah](https://covid19.go.id/peta-risiko) per `5 November 2020`
pukul `19.54` WIB.

Setidaknya ada `514` kabupaten dan kota dari semua provinsi di Indonesia
yang ada di data ini.

<table>

<caption>

Contoh 10 Data Pertama

</caption>

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

Provinsi

</th>

<th style="text-align:left;">

Kabupaten dan Kota

</th>

<th style="text-align:left;">

Keterangan

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

NIAS BARAT

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

2

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

KOTA TANJUNG BALAI

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

KOTA TEBING TINGGI

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

PAKPAK BHARAT

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

5

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

SAMOSIR

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

6

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

TAPANULI TENGAH

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

7

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

NIAS

</td>

<td style="text-align:left;">

RISIKO RENDAH

</td>

</tr>

<tr>

<td style="text-align:right;">

8

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

PADANG LAWAS UTARA

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

9

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

LABUHANBATU SELATAN

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

<tr>

<td style="text-align:right;">

10

</td>

<td style="text-align:left;">

SUMATERA UTARA

</td>

<td style="text-align:left;">

KOTA SIBOLGA

</td>

<td style="text-align:left;">

RISIKO SEDANG

</td>

</tr>

</tbody>

</table>

-----

Zonasi Risiko daerah dihitung berdasarkan indikator-indikator kesehatan
masyarakat dengan menggunakan skoring dan pembobotan.

Indikator-indikator yang digunakan adalah sbb:

INDIKATOR EPIDEMIOLOGI:

1.  Penurunan jumlah kasus positif dan *probable* pada minggu terakhir
    sebesar `≥50%` dari puncak.
2.  Penurunan jumlah kasus suspek pada minggu terakhir sebesar `≥50%`
    dari puncak.
3.  Penurunan jumlah meninggal kasus positif dan *probable* pada minggu
    terakhir sebesar `≥50%` dari puncak.
4.  Penurunan jumlah meninggal kasus suspek pada minggu terakhir sebesar
    `≥50%` dari puncak.
5.  Penurunan jumlah kasus positif dan *probable* yang dirawat di RS
    pada minggu terakhir sebesar `≥50%` dari puncak.
6.  Penurunan jumlah kasus suspek yang dirawat di RS pada minggu
    terakhir sebesar `≥50%` dari puncak.
7.  Persentase kumulatif kasus sembuh dari seluruh kasus positif dan
    *probable*.
8.  Laju insidensi kasus positif per `100.000` penduduk.
9.  *Mortality rate* kasus positif per `100.000` penduduk.
10. Kecepatan laju insidensi per `100.000` penduduk.

INDIKATOR SURVEILANS KESEHATAN MASYARAKAT

1.  Jumlah pemeriksaan sampel diagnosis meningkat selama 2 minggu
    terakhir.
2.  *Positivity rate* rendah (target `≤5%` sampel positif dari seluruh
    orang yang diperiksa).

INDIKATOR PELAYANAN KESEHATAN

1.  Jumlah tempat tidur di ruang isolasi RS Rujukan mampu menampung
    hingga `>20%` jumlah pasien positif COVID-19 yang dirawat di RS.
2.  Jumlah tempat tidur di RS Rujukan mampu menampung hingga `>20%`
    jumlah ODP, PDP, dan pasien positif COVID-19 yang dirawat di RS.

-----

Sekarang mari kita lihat kondisi resiko kabupaten dan kota per provinsi
di Indonesia:

Kita mulai dari *summary* berikut ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/daerah%20resiko/blog-post_files/figure-gfm/unnamed-chunk-2-1.png" width="864" />

Kita lihat versi *real number*-nya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/daerah%20resiko/blog-post_files/figure-gfm/unnamed-chunk-3-1.png" width="864" />

Oke, saya akan buat grafik di atas dalam bentuk proporsi. Berikut
hasilnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/daerah%20resiko/blog-post_files/figure-gfm/unnamed-chunk-4-1.png" width="864" />

Ternyata ada beberapa temuan yang menarik menurut saya:

1.  `DKI Jakarta` tidak semenyeramkan yang ada di media. Awalnya saya
    menduga bahwa mayoritas kota di `DKI Jakarta` berisiko tinggi. Tapi
    kenyataannya tidak ada sama sekali.
2.  Justru `Aceh` yang memiliki kabupaten kota yang berisiko tinggi.
    Padahal kita tahu bahwa pada pemberitaan media-media, `Aceh`
    diposisikan sebagai provinsi yang aman dari COVID 19.
3.  `Riau`, `Kalimantan Timur`, dan `Jawa Tengah` pada saat ini memiliki
    proporsi risiko tinggi yang tertinggi.
4.  Sedangkan `Jawa Timur` yang sempat memiliki zona hitam beberapa
    bulan lalu, justru kondisinya membaik.

-----

## Semoga saja pandemi ini segera berakhir *yah*.
