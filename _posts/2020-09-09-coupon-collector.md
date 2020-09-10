---
date: 2020-09-09T05:08:00-04:00
title: "Membuat Konsumen Membeli Barang Lebih Banyak dengan Sayembara Pengumpulan Kupon"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
  - Kupon
  - Puzzle
---


Banyak cara yang dilakukan perusahaan-perusahaan di luar sana untuk bisa
meningkatkan *sales omzet*. Salah satunya dengan membuat `sayembara`
pengumpulan kupon hadiah.

Sebenarnya bentuknya tidak perlu kupon. Bisa jadi tutup botol, stiker,
kemasan, sampai stik es krim. Percaya atau tidak, dengan perhitungan
yang matang dan iming-iming hadiah yang besar, perusahaan bisa “memaksa”
konsumen untuk membeli produk lebih banyak agar dapat mengumpulkan kupon hadiah
tersebut.

-----

# Contoh Kasus:

Pernahkah kalian mengumpulkan stik es krim bergambar seperti di bawah
ini?

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/coupon-collector-new_files/urban%20mama.png)<!-- -->

Jika kita berhasil mengumpulkan `3` jenis gambar seperti di atas, kita
berhak mendapatkan hadiah yang menarik.

## Pertanyaannya:

> Berapa banyak es krim yang harus kita beli agar bisa mendapatkan `3`
> jenis gambar tersebut?

Untuk menjawabnya, saya akan membuat beberapa kondisi sebagai berikut:

### Asumsi 1:

Jika saya asumsikan hanya ada `3` jenis stik es krim dan ketiganya
terdistribusi merata (bisa ditulis:
![prob=\\frac{1}{3}](https://latex.codecogs.com/png.latex?prob%3D%5Cfrac%7B1%7D%7B3%7D
"prob=\\frac{1}{3}")), maka hasil simulasinya sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/coupon-collector-new_files/figure-gfm/unnamed-chunk-3-1.png" width="768" />

### Asumsi 2:

Jika saya asumsikan hanya ada `3` jenis stik es krim **berhadiah** tapi
ketiganya tidak terdistribusi merata.

Misalkan:

Stik `A` lebih banyak dibandingkan stik `B` dan `C`.
![prob\_A=\\frac{5}{7}](https://latex.codecogs.com/png.latex?prob_A%3D%5Cfrac%7B5%7D%7B7%7D
"prob_A=\\frac{5}{7}") dan ![prob\_B = prob\_C =
\\frac{1}{7}](https://latex.codecogs.com/png.latex?prob_B%20%3D%20prob_C%20%3D%20%5Cfrac%7B1%7D%7B7%7D
"prob_B = prob_C = \\frac{1}{7}") maka hasil simulasinya sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/coupon-collector-new_files/figure-gfm/unnamed-chunk-5-1.png" width="768" />

### Asumsi 3:

Jika saya asumsikan hanya ada `3` jenis stik es krim **berhadiah** dan
`1` jenis stik es krim **tak bercorak**. Lalu keempatnya terdistribusi
merata (bisa ditulis:
![prob=\\frac{1}{4}](https://latex.codecogs.com/png.latex?prob%3D%5Cfrac%7B1%7D%7B4%7D
"prob=\\frac{1}{4}")), maka hasil simulasinya sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/coupon-collector-new_files/figure-gfm/unnamed-chunk-7-1.png" width="768" />

### Asumsi 4:

Jika saya asumsikan hanya ada `3` jenis stik es krim **berhadiah** dan
`1` jenis stik es krim **tak bercorak**. Lalu keempatnya tidak
terdistribusi merata.

Misalkan:

Stik tak bercorak memiliki proporsi lebih banyak dibandingkan `3` jenis
stik berhadiah.

![prob\_{takbercorak}=\\frac{6}{10}](https://latex.codecogs.com/png.latex?prob_%7Btakbercorak%7D%3D%5Cfrac%7B6%7D%7B10%7D
"prob_{takbercorak}=\\frac{6}{10}"),
![prob\_A=\\frac{2}{10}](https://latex.codecogs.com/png.latex?prob_A%3D%5Cfrac%7B2%7D%7B10%7D
"prob_A=\\frac{2}{10}") dan ![prob\_B = prob\_C =
\\frac{1}{10}](https://latex.codecogs.com/png.latex?prob_B%20%3D%20prob_C%20%3D%20%5Cfrac%7B1%7D%7B10%7D
"prob_B = prob_C = \\frac{1}{10}")

Maka hasil simulasinya sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/coupon-collector-new_files/figure-gfm/unnamed-chunk-9-1.png" width="768" />

# Kesimpulan

Dalam dunia *real*, proporsi stik berhadiah mungkin dibuat lebih kecil
agar konsumen bisa lebih seru lagi mencarinya.

# *Remarks*

  - Penggunaan poster merek es krim di atas hanya sebagai ilustrasi saja
    ya. Semua perhitungan dan asumsi yang digunakan adalah murni contoh
    saja.
  - Cara perhitungan simulasi ini bisa dilihat di [tulisan saya yang
    ini](https://ikanx101.com/blog/kolektor-kupon/).
