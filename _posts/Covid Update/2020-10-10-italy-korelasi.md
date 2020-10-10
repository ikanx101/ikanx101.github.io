---
date: 2020-10-10T10:38:00-04:00
title: "Update COVID-19: Indonesia Sudah Setara Italy dan Korelasi Antara Kasus Baru dan Sembuh Baru"
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


Tulisan ini masih tentang **COVID 19** dan ada dua hal yang ingin saya
lakukan:

1.  Bagaimana perbandingan terbaru angka *cumulative cases* `Indonesia`
    vs `Italy`?
2.  Berapa hari *sih* orang bisa sembuh dari COVID 19 di Indonesia?

-----

# *Cumulative Cases* `Indonesia` vs `Italy`

Melanjuti tulisan saya
[sebelumnya](https://ikanx101.com/blog/recovery-indo/), kali ini kita
lihat posisi terkini dari **balapan** *cumulative cases* antara `Italy`
dan `Indonesia`.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/update-9-Okt_files/figure-gfm/unnamed-chunk-1-1.png" width="768" />

Dengan penambahan kasus baru di angka `4` ribuan per hari, sepertinya
dalam beberapa hari ini `Indonesia` bisa menyalip `Italy`. Apalagi demo
yang dilakukan kemarin bisa jadi potensi *cluster* penyebaran terbaru.

> Once again, it is not a race everyone should be proud of… and it is
> not just a number\! A real life is at stake…

-----

# Berapa Hari Pasien COVID 19 Bisa Sembuh?

Sebagaimana yang kita ketahui bersama, COVID 19 sejatinya adalah *self
limiting desease* (bisa sembuh dengan sendirinya) bagi sebagian orang.
Sebagian orang lainnya memerlukan perawatan medis secara intensif. Dari
beberapa kasus yang saya temui, durasi lamanya seorang pasien bisa
sembuh cukup beragam.

> Ada yang membutuhkan waktu hingga 2 minggu. Ada yang singkat tak lebih
> dari seminggu.

Sayang sekali saya tidak memiliki data yang lengkap untuk bisa
menghitung waktu rata-rata yang dibutuhkan pasien agar bisa sembuh.

Satu-satunya data yang saya miliki adalah sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/update-9-Okt_files/figure-gfm/unnamed-chunk-2-1.png" width="768" />

Berbekal data tersebut, bisakah kita menghitung durasi hari kesembuhan?

> Salah satu pendekatan yang bisa saya lakukan adalah dengan menggunakan
> analisa [korelasi](https://ikanx101.com/blog/materi-korelasi/)\!

Bagaimana maksudnya?

Secara logika, penambahan orang sembuh berasal dari pasien yang sakit.
Oleh karena itu kedua variabel tersebut pasti berkorelasi dan seharusnya
memiliki hubungan kausal (sebab akibat). Semakin banyak orang yang sakit
akan mengakibatkan semakin banyak pula orang yang sembuh (bisa juga
terjadi kebalikannya walaupun tentu kita tidak menginginkannya sama
sekali).

> Penambahan orang yang sakit di tanggal tertentu tidak serta merta
> mengakibatkan penambahan orang yang sembuh di tanggal yang sama.

**Pasti ada jeda\!**

**Maka jeda hari yang memberikan korelasi tertinggi akan saya duga
sebagai durasi rata-rata hari kesembuhan**. Tentunya dengan asumsi:

1.  Data tersebut benar adanya (*reliable* atau bisa dipercaya).
2.  Pengumuman orang yang sembuh di hari tersebut sesuai dengan realita
    yang ada (orang sembuh diumumkan pada hari yang sama).

-----

Sebagai pengingat, korelasi hanya memperlihatkan kecenderungan linear
yang terjadi antara dua variabel. Sedangkan untuk melihat hubungan
kausal, analisa yang digunakan adalah regresi. Secara simpel, salah satu
parameter *goodness of fit* model regresi adalah
![R^2](https://latex.codecogs.com/png.latex?R%5E2 "R^2") yang merupakan
kuadrat dari korelasi (![r](https://latex.codecogs.com/png.latex?r
"r")). Nilai ![R^2](https://latex.codecogs.com/png.latex?R%5E2 "R^2")
dinilai baik jika mendekati `1`.

Maka, korelasi yang kuat akan membuat model regresi yang dihasilkan juga
bagus.

Oleh karena itu, saya hanya akan melihat angka korelasi saja untuk kasus
ini.

-----

Berikut adalah hasil perhitungan korelasi yang saya lakukan:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/update-9-Okt_files/figure-gfm/unnamed-chunk-3-1.png" width="768" />

Dari data yang ada, korelasi tertinggi didapatkan saat jeda hari = `20`
hari. Namun dari *smooth trendline* didapatkan korelasi tertinggi pada
jeda hari antara `16`-`19` hari.

Jadi sementara ini bisa saya duga dari data di Indonesia, pasien COVID
baru akan sembuh dalam rentang waktu `16`-`20` hari.

-----

## Apa sih gunanya mengetahui rentang hari kesembuhan?

Pada tulisan yang [lalu](https://ikanx101.com/blog/recovery-indo/), saya
sempat membahas tentang *recovery rate* Indonesia yang masih relatif
rendah dibandingkan negara-negara lain di dunia.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Covid%20Update/update-9-Okt_files/figure-gfm/unnamed-chunk-4-1.png" width="768" />

Tercatat ada `137` negara dari `209` negara (65.55%) yang memiliki
*recovery rate* lebih tinggi dibanding Indonesia.

Secara kasar bisa saya bilang:

> Dari semua kasus baru yang ada, peluang kesembuhan seorang pasien
> adalah sebesar `~76%` dan memakan waktu `16`-`20` hari.

-----

# Kesimpulan:

Jika kita masih abai dengan hal ini dan membiarkan penambahan kasus baru
semakin melonjak, bukan tidak mungkin Indonesia bisa melewati ambang
batas perawatan pasien di rumah sakit. Akibatnya tenaga kesehatan bisa
kewalahan.

*Stay safe, stay healthy ya.*
