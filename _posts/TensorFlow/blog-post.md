Menghitung Probabilitas Kesamaan Packaging Dua Produk Minuman
Menggunakan Algoritma Deep Learning di R
================

# *Prolog*: 2013

Pada tahun `2013` lalu, saya dan beberapa rekan kerja berdiskusi seru
mengenai adanya satu produk *low calorie sweetener* yang memiliki
*packaging* yang `mirip` dengan *brand* yang diproduksi perusahaan saya.
Jika dilihat sekilas, tidak tampak ada perbedaan berarti. Apalagi
pemilihan warna dan *layout* gambarnya hampir mirip.

> Jika kita bisa membuktikan bahwa kejadian ini membuat konsumen
> bingung, kita bisa membawanya ke ranah hukum.

Begitu celetuk salah seorang rekan saya.

Sempat kami berpikir untuk melakukan suatu studi dan survey yang bisa
membuktikan bahwa konsumen menjadi bingung tapi survey ini harus
benar-benar *robust* sehingga tidak bisa dipatahkan di meja hijau.

Walau akhirnya studi tersebut tidak dilaksanakan tapi kasus seperti ini
saya yakin akan berulang di masa mendatang.

-----

# 2020

Sudah menjadi hal lumrah bagi setiap *brand* untuk mengikuti *brand*
yang menjadi *market leader* dalam kategorinya. Mereka bisa menjadi
*follower* dalam hal *marketing*, *campaign* iklan, profil rasa, sampai
tema *packaging* produk.

Beberapa hari belakangan ini, saya melihat sebuah iklan dari produk
minuman bermerek `Herbalice` di televisi. Jika saya lihat sekilas
*packaging* yang ditampilkan di dalam iklan tersebut, rupa
*packaging*-nya mirip dengan *brand* minuman terkenal `NutriSari`.

Berikut gambar yang saya dapatkan di internet:

<img src="blog-post_files/figure-gfm/unnamed-chunk-1-1.png" width="50%" />

Bagaimana menurut kalian? Mirip *gak sih*?

Tapi yang menjadi pertanyaan adalah:

1.  Seberapa mirip?
2.  Apakah ada cara mengkuantifikasi kemiripan tersebut?

Kalau mengandalkan jawaban manusia, saya kira hasilnya bisa *debatable*.
Oleh karena itu saya akan mencoba menghitung peluang kesamaannya dengan
membuat algoritma *deep learning* menggunakan **TensorFlow** dan
**Keras** di **R**.

> Seharusnya dengan algoritma, hasilnya bisa *less debatable* jika saya
> melakukannya dengan benar.

## Metode

Saya akan membuat algoritma *supervised learning* dengan metode *deep
learning* untuk mengklasifikasi gambar `NutriSari` dan `non NutriSari`.
Kemudian algoritma akan disuruh membaca gambar `Herbalice` tersebut.

Masih bingung? Saya jelaskan di bagan di bawah ini:

![](blog-post_files/figure-gfm/bagan-1.png)<!-- -->

> Saya mengumpulkan `16` poto *packaging* NutriSari dan `15` poto
> *packaging* minuman buah selain NutriSari. Kemudian saya membuat
> algoritma yang `belajar` untuk mengidentifikasi poto mana yang masuk
> ke NutriSari, poto mana yang bukan termasuk NutriSari. Setelah
> performa algoritmanya sudah baik, saya akan masukkan poto Herbalice
> dan melihat hasil pembacaan dari algoritmanya.

Saya akan melihat berapa angka probabilitas hasil klasifikasinya\!
Apakah *packaging* tersebut lebih diklasifikasikan ke `NutriSari`? Atau
diklasifikasikan ke `non NutriSari`?

![](blog-post_files/figure-gfm/potoset-1.png)<!-- -->

-----

## *Deep Learning*

Apa sih yang dimaksud *deep learning*? Apa bedanya dengan *machine
learning*? Lalu apa bedanya dengan *artificial intelligence*?

    ## [1] "Sumber gambar: smartcityindo.com"

<img src="blog-post_files/figure-gfm/unnamed-chunk-2-1.png" width="50%" />

Secara simpel, saya bisa katakan bahwa:

  - *Artificial intelligence* merupakan *umbrella terms* dari disiplin
    ilmu seperti *applied science*, *engineering*, dan *computer
    science*.
  - *Machine learning* merupakan kumpulan metode atau algoritma untuk
    melakukan baik analisa *supervised learning* dan *unsupervised
    learning*.
  - *Deep Learning* merupakan algoritma *machine learning* yang dibuat
    dengan metode *Neural Network*.

Lalu apa lagi itu *Neural Network*?

par(mfrow=c(2,4)) for(i in 1:8) plot(train\[\[i\]\])
