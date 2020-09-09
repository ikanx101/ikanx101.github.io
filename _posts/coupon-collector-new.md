Membuat Konsumen Membeli Barang Lebih Banyak dengan Sayembara
Pengumpulan Kupon
================

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

<img src="coupon-collector-new_files/figure-gfm/unnamed-chunk-3-1.png" width="672" />

### Asumsi 2:

Jika saya asumsikan hanya ada `3` jenis stik es krim **berhadiah** tapi
ketiganya tidak terdistribusi merata. Misalkan stik `A` lebih banyak
dibandingkan stik `B` dan `C`.

Contoh:

![prob\_A=\\frac{3}{5}](https://latex.codecogs.com/png.latex?prob_A%3D%5Cfrac%7B3%7D%7B5%7D
"prob_A=\\frac{3}{5}")) dan ![prob\_B = prob\_C =
\\frac{1}{5}](https://latex.codecogs.com/png.latex?prob_B%20%3D%20prob_C%20%3D%20%5Cfrac%7B1%7D%7B5%7D
"prob_B = prob_C = \\frac{1}{5}") maka hasil simulasinya sebagai
berikut:

<img src="coupon-collector-new_files/figure-gfm/unnamed-chunk-5-1.png" width="672" />

### Asumsi 3:

Jika saya asumsikan hanya ada `3` jenis stik es krim **berhadiah** dan
`1` jenis stik es krim **tak bercorak**. Lalu keempatnya terdistribusi
merata (bisa ditulis:
![prob=\\frac{1}{4}](https://latex.codecogs.com/png.latex?prob%3D%5Cfrac%7B1%7D%7B4%7D
"prob=\\frac{1}{4}")), maka hasil simulasinya sebagai berikut:

<img src="coupon-collector-new_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />

Cara perhitungan simulasi ini bisa dilihat di [tulisan saya yang
ini](https://ikanx101.com/blog/kolektor-kupon/).
