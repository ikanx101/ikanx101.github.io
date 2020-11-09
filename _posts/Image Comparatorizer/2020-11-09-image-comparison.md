---
date: 2020-11-09T08:00:00-04:00
title: "Membandingkan Kesamaan Mutlak Antara Dua Gambar"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Image Processing
  - Image Matchmaking
  - Aljabar
  - Image
  - Image Recognition
  - Matriks
---

Pada `2` tulisan sebelumnya, saya telah membahas dua topik terkait data
berupa *image* yang bisa diolah di **R**:

1.  Penggunaan [Google Vision](https://ikanx101.com/blog/google-vision/)
    untuk melakukan ekstraksi label dari suatu gambar dengan mudah
    (tanpa perlu membuat model *deep learning*).
2.  Membuat model *deep learning* dengan *TensorFlow* dan *KERAS* di
    **R** untuk menghitung *likelihood* suatu gambar masuk ke kelompok
    gambar yang mana (*supervised learning*: *image classifying*).

Sekarang saya akan membuat model yang sangat sederhana terkait
perbandingan dua gambar. Saking sederhananya, sehingga orang lebih suka
*ngoprek deep learning model* dan mengabaikan hal fundamental seperti
ini. Mirip-mirip dengan kasus seperti ini:

    ## [1] "Sumber gambar: Technoplast"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Image%20Comparatorizer/Blog-post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Misalkan diberikan dua buah gambar:

1.  `Gambar 1` adalah gambar basis yang dijadikan acuan.
2.  `Gambar 2` adalah gambar yang akan dites. Apakah sama persis dengan
    gambar basis atau tidak. Lalu jika berbeda, bagian mana yang
    berbeda?

-----

## Bagaimana proses kerjanya?

> Proses kerjanya adalah dengan membandingkan dua buah matriks yang
> dihasilkan dari kedua gambar tersebut.

Sebagai informasi, *file* gambar berekstensi `jpg` memiliki `3` *layers*
sedangkan *file* gambar berekstensi `png` memiliki `4` *layers*.

Misalkan ada suatu gambar `jpg` berdimensi `360` x `450`, maka bisa
dihasilkan matriks `3` dimensi (`360 x 450 x 3`).

> Sekarang tahu kan faedahnya belajar aljabar apa? *hehe*

Setelah kita tahu `2` matriks tersebut, kita akan bandingkan langsung
keduanya. Jika ada elemen matriks (baris dan kolom) yang berbeda di
ketiga layer, maka kita bisa bilang bahwa ada perbedaan antara kedua
gambar pada *pixel* area tersebut. *Simpel* kan?

-----

## *Case Studies*

Sekarang kita masuk ke *case studies* biar lebih terlihat.

Awalnya saya meminta si sulung untuk menggambar satu gambar menggunakan
*Galaxy Tab* yang akan dijadikan basis.

    ## [1] "Gambar basis:"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Image%20Comparatorizer/Blog-post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Lalu saya mengubah beberapa elemen gambar dan menambahkan beberapa
elemen lainnya. Perlu diperhatikan juga bahwa sebenarnya ada perubahan
di bagian *status bar* atas.

    ## [1] "Gambar yang akan dicek"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Image%20Comparatorizer/Blog-post_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Proses selanjutnya adalah kita lihat terlebih dahulu data awal dari
*images* ini:

``` r
img_1
```

    ## Image 
    ##   colorMode    : Color 
    ##   storage.mode : double 
    ##   dim          : 1920 1200 3 
    ##   frames.total : 3 
    ##   frames.render: 1 
    ## 
    ## imageData(object)[1:5,1:6,1]
    ##           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
    ## [1,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [2,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [3,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [4,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [5,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922

``` r
img_2
```

    ## Image 
    ##   colorMode    : Color 
    ##   storage.mode : double 
    ##   dim          : 1920 1200 3 
    ##   frames.total : 3 
    ##   frames.render: 1 
    ## 
    ## imageData(object)[1:5,1:6,1]
    ##           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
    ## [1,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [2,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [3,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [4,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922
    ## [5,] 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922 0.9803922

Selanjutnya saya akan *resize* kedua gambar ini. Kenapa harus
di-*resize*? Perlu diperhatikan bahwa *file* berekstensi `.jpg` memiliki
`3` buah *layers*. Sedangkan *file* berekstensi `.png` memiliki `4` buah
*layers*.

Maka jika gambar diatas memiliki *dimension* sebesar `1920 X 1200`, maka
akan dihasilkan matriks sebesar `1920` X `1200` X `3`.

*Nah*, komputer saya tidak cukup kuat untuk mengolah matriks sebesar
itu.

Maka dari itu saya akan *resize* dengan mengecilkan `20%` dari ukuran
sebenarnya.

``` r
w = 1200/5
h = 1920/5
img_1 = resize(img_1,w,h)
img_2 = resize(img_2,w,h)
```

Kemudian saya akan ekstrak matriks datanya:

``` r
gbr_1 = imageData(img_1) 
gbr_2 = imageData(img_2)
```

Buat yang penasaran gimana bentuk matriksnya, maaf saya gak bisa kasih
unjuk di blog ini karena sangat panjang. *hehe*

Kalau mau lihat, *feel free to contact me yah*.

Dari kedua buah matriks tersebut, kita sudah bisa menghitung `2` hal
sebenarnya:

### Proporsi sama vs tidak sama

``` r
prop.table(table(gbr_1 == gbr_2)) * 100
```

    ## 
    ##    FALSE     TRUE 
    ## 11.24602 88.75398

Terlihat bahwa kedua gambar tersebut `~88.75%` sama.

### Korelasi `2` matriks

Berikut adalah korelasi antara `2` matriks yang ada:

``` r
cor(gbr_1,gbr_2)
```

    ## [1] 0.7649889

``` r
plot(gbr_1,gbr_2)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Image%20Comparatorizer/Blog-post_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Dari plot di atas terlihat bahwa ada beberapa elemen matriks yang
berbeda.

> Jadi jika kedua gambar sama persis, maka semua titik akan berada di
> satu garis lurus.

-----

Sekarang kita akan ekstrak elemen dari kedua matriks yang nilainya
berbeda. Ingat *yah*, elemen yang kita ekstrak itu adalah elemen matriks
yang nilainya berbeda di `3` *layers* sekaligus\!

    ## [1] "Contoh 5 data teratas elemen matriks"

    ## # A tibble: 5 x 2
    ##    dim1  dim2
    ##   <int> <int>
    ## 1     2     3
    ## 2     2     4
    ## 3     2     5
    ## 4     2     6
    ## 5     2     7

Nah, bagian final dan yang tersulit adalah membuat *overlay* antara
gambar kedua dengan data dari `result`.

Entah kenapa skrip yang saya buat semalam dengan [*Google
Colab*](https://ikanx101.com/blog/google-colab/) harus dimodifikasi
banyak saat mau di-*run* menggunakan *R Studio*.

Ini adalah hasil akhirnya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Image%20Comparatorizer/Blog-post_files/figure-gfm/unnamed-chunk-10-1.png" width="672" />

Titik merah saya jadikan sebagai penanda area mana saja yang berbeda.

> *Gimana* hasilnya? Lumayan *yah*…
