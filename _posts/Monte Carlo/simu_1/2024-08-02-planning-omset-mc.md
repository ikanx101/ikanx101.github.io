---
date: 2024-08-02T16:37:00-04:00
title: "Math and Computational Science for Business part 1: Simulasi Monte Carlo untuk Planning Target Omset"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Simulasi
  - Monte Carlo
  - Simulasi Monte Carlo
  - Omset
  - Planning
---

Sepertinya sudah lama sekali saya tidak menulis artikel di *blog*. Jika
saya pikirkan kembali, beberapa bulan belakangan pekerjaan datang
bertubi-tubi layaknya huru-hara di akhir zaman kelak. *Hehe.*

Nah, kali ini mumpung saya sedang *business trip* di luar kota dan punya
waktu luang sebelum tidur, saya akan coba buat satu topik tersendiri
tentang aplikasi matematika dan sains komputasi dalam bisnis. Tentu saja
beberapa *use cases* yang hendak saya *share* ini berasal dari
pengalaman selama ini. Jika rekan-rekan pembaca punya kesamaan *use
cases* atau bahkan punya *use cases* lain yang mau didiskusikan, *feel
free* untuk menghubungi saya melalui *telegram*.

Pada artikel pertama ini, saya hendak menuliskan tentang bagaimana
prinsip simulasi Monte Carlo bisa saya gunakan untuk menghitung dan
melakukan *planning* capaian omset di suatu cafe atau restoran.

------------------------------------------------------------------------

Di suatu cafe, omset bulanan didefinisikan sebagai total semua pembelian
yang dilakukan oleh konsumen. Jadi, jika pada bulan X diketahui ada 100
orang pelanggan, maka omsetnya adalah:

![omset_X = \sum\_{i=1}^{100}harga_i \times item sold_i](https://latex.codecogs.com/svg.latex?omset_X%20%3D%20%5Csum_%7Bi%3D1%7D%5E%7B100%7Dharga_i%20%5Ctimes%20item%20sold_i "omset_X = \sum_{i=1}^{100}harga_i \times item sold_i")

Misalkan:

1.  Pelanggan pertama, terdiri dari satu keluarga berisi empat orang.
    Masing-masing memesan menu makanan dan minuman pada harga yang sama
    (Rp50.000). Maka omset yang didapatkan adalah sebesar
    ![4 \times 50.000 = 200.000](https://latex.codecogs.com/svg.latex?4%20%5Ctimes%2050.000%20%3D%20200.000 "4 \times 50.000 = 200.000").
2.  Pelanggan kedua, terdiri dari sepasang suami istri. Suami memesan
    menu makanan dan minuman seharga Rp75.000 sedangkan istri memesan
    menu minuman dan dessert seharga Rp80.000. Maka omset yang
    didapatkan adalah sebesar
    ![75.000 + 80.000 = 155.000](https://latex.codecogs.com/svg.latex?75.000%20%2B%2080.000%20%3D%20155.000 "75.000 + 80.000 = 155.000").
3.  Dan seterusnya.

Dari data historikal yang ada selama enam bulan ke belakang, didapatkan
informasi bahwa pelanggan pada saat *weekend* lebih banyak dibandingkan
pelanggan pada saat *weekdays*. Sang *manager* mencoba mengolah data
tersebut sehingga mendapatkan informasi sebagai berikut:

Pada saat *weekend*, pelanggan yang datang berkisar antara 80-120
*tables* dengan komposisi:

1.  50% keluarga berisi 3-7 orang.
2.  30% pasangan.
3.  10% rombongan berisi 5-10 orang.
4.  10% pelanggan sendiri.

Pada saat *weekdays*, pelanggan yang datang berkisar antara 50-80
*tables* dengan komposisi:

1.  10% keluarga berisi 3-5 orang.
2.  20% pasangan.
3.  30% rombongan berisi 7-12 orang.
4.  40% pelanggan sendiri.

*Range* harga makanan dan minuman yang disediakan cukup sempit (tidak
lebar, harga hampir mirip-mirip). Besaran uang yang dibelikan per
pelanggan mengikuti kurva normal dengan *mean* Rp80.000 dan standar
deviasi Rp30.000 (artinya sekitar 66% peluang seorang pelanggan membeli
menu di kisaran harga Rp50.000-Rp110.000).

Nah, berdasarkan informasi di atas, sang *manager* mencoba membuat
simulasi Monte Carlo untuk mendapatkan persebaran omset dan distribusi
peluangnya. Asumsinya adalah satu bulan terdiri dari empat minggu dengan
satu minggu terdiri dari lima hari *weekdays* dan dua hari *weekend*.
Simulasi dijalankan sebanyak 100.000 kali.

Berikut adalah *flowchart* simulasinya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_1/IMG_0684.png" data-fig-align="center" width="300" />

Apa saja faedah dari simulasi ini? Mari kita lihat pada grafik berikut:

## **Hasil Simulasi**

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_1/Draft_files/figure-commonmark/unnamed-chunk-2-1.png)

Dari grafik di atas, kita bisa mendapatkan *density plot* dari omset
yang mungkin tercapai setiap bulannya. Analoginya seperti **Doctor
Strange** pada film **Avengers: Endgame** yang lalu, semua kemungkinan
omset yang bisa terjadi dalam 100.000 kondisi ditampilkan dalam grafik
tersebut.

Kita bisa dapatkan *expected* omset yakni *mean* omset hasil simulasi
sebesar Rp549,694,758. Sang manager langsung mencocokkan apakah angka
*expected* omset dengan rata-rata omset *real* selama enam bulan ke
belakang sudah mirip-mirip atau belum. Ternyata setelah dicek, angka
hasil simulasi mirip-mirip dengan angka *real*. Artinya formula simulasi
yang digunakan sudah bisa mendekati kondisi *real*-nya.

Bagaimana jika hasilnya berbeda dan melenceng jauh? Artinya ada
parameter yang harus diperbaiki atau asumsi cara perhitungan omset harus
diubah. Untuk kasus ini saya permudah contohnya ya. Namun pada kondisi
*real* di pekerjaan, biasanya dibutuhkan iterasi beberapa kali hingga
hasil simulasi mendekati angka *real*-nya.

Perhatikan nilai Q1 (kuartil 1) pada grafik di atas. Apa artinya? Dengan
kondisi yang ada sekarang sang manager punya peluang sebesar 75% bahwa
omset cafe selama sebulan akan mencapai minimal Rp524,712,290.

Perhatikan juga nilai Q3 (kuartil 3) pada grafik di atas. Apa artinya?
Dengan kondisi yang ada sekarang sang manager punya peluang sebesar 75%
bahwa omset cafe selama sebulan akan mencapai maksimal Rp575,941,917.

Dari simulasi ini sang *manager* juga bisa merencanakan bagaimana
caranya untuk meningkatkan omset cafe di bulan-bulan berikutnya.
Bagaimana? Dengan membuat program aktivasi yang bisa mengubah grafik
omset tersebut ke arah kanan. Selain itu, program aktivasi bisa juga
untuk mengubah grafik omset menjadi lebih pendek *range*-nya.

Berikut adalah ilustrasinya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Monte%20Carlo/simu_1/IMG_0685.jpeg" data-fig-align="center" width="300" />

Program aktivasi itu harus bisa ditranslasikan secara *real* untuk
mengubah parameter.

Misalkan pada bulan berikutnya sang *manager* membuat program sebagai
berikut:

1.  Diskon khusus pelanggan arisan pada *weekdays*. Walau besaran uang
    yang dibelikan konsumen berkurang akibat diskon tapi diharapkan
    menaikkan *traffic* per harinya.
2.  Paket spesial menu keluarga, misalkan memberikan paket menu keluarga
    sehingga secara tidak sadar menaikkan besaran uang yang dibelanjakan
    konsumen.
3.  Spesial diskon pada hari tertentu dan pada pelanggan tertentu untuk
    menaikkan *traffic*.

Kita bisa simulasikan kembali dengan mengubah parameter-parameter yang
ada. Setelah itu kita bisa melihat program mana yang bisa memberikan
kenaikan *expected* omset paling besar.

*Planning* dengan bantuan simulasi Monte Carlo memberikan kita gambaran
terhadap sensitivitas keputusan bisnis pada omset.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
