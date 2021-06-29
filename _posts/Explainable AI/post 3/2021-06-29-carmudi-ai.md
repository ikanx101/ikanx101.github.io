---
date: 2021-06-29T08:48:00-04:00
title: "Explainable AI: Prediksi Harga Mobil yang Dijual di Situs Carmudi"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - DALEX
  - Responsible AI
  - TensorFlow
  - KERAS
  - Neural Network
  - Deep Learning
  - Regresi
  - Modelling
  - Carmudi
  - Otomotif
  - Mobil
  - Interpretable Machine Learning
---


Pada saat menikah dulu, tidak pernah terbersit di kepala saya bahwa
memiliki mobil adalah suatu kebutuhan primer hingga anak saya yang
sulung lahir. Beberapa kali ada kondisi yang mengharuskan saya harus
memiliki mobil sebagai sarana transportasi keluarga. Pada saat itu, uang
saya tidak cukup untuk membeli mobil baru secara tunai. Akhirnya saya
dan istri mencari-cari mobil bekas di salah satu *dealer* mobil bekas
milik Astra.

Waktu itu, kami dijodohkan dengan mobil sedan Honda City warna hitam
tahun 2003 yang *body*-nya masih *gres*. Kilometernya juga baru 100
ribuan (mengingat sudah 10 tahunan mobil itu berada di jalanan).
Akhirnya dengan harga tak sampai 100 juta, kami pinang mobil tersebut.

Jika ditanyakan kepada saya:

> Apakah harga tersebut kemahalan atau tidak?

Saya akan langsung menjawab: **“tidak tahu”**.

------------------------------------------------------------------------

Saya sendiri tidak terlalu mengerti apa yang menjadi patokan harga mobil
bekas. Beberapa faktor yang saya duga berpengaruh penting adalah:

1.  *Brand*, dan
2.  Kilometer tempuh.

Sabtu lalu, saya sempat membuat *polling* kecil-kecilan di instagram
mengenai hal ini.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/tanya.jpg" style="display: block; margin: auto;" />

Beberapa teman saya telah menjawabnya.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/jawab.jpg" width="30%" style="display: block; margin: auto;" />

------------------------------------------------------------------------

Untuk menjawab rasa penasaran saya, saya akan mencoba membuat model yang
bisa memprediksi harga mobil bekas dari beberapa *predictors*.

Saya mengambil data mobil bekas dengan cara *web scraping* 500 data
mobil bekas yang *listed* di situs [Carmudi](https://www.carmudi.co.id/)
pada Sabtu, 26 Juni 2021. Cara *scrape*-nya sudah pernah saya tulis di
[sini](https://ikanx101.com/blog/blog-post-terios/).

Saya mengambil data sebagai berikut:

1.  Harga mobil.
    -   Saya melakukan transformasi pada data ini dengan cara melakukan
        operasi *log natural* (*ln()*).
    -   Tujuannya adalah agar data lebih *compact* dan tidak lebar
        *range*-nya.
    -   Tipe data ini adalah numerik.
2.  *Brand*.
    -   Tipe data ini berupa kategorik.
3.  Status: *new car* dan *used car*.
    -   Ternyata ada sebagian kecil dari *listed car* di Carmudi yang
        merupakan *new car*.
    -   Tipe data ini berupa kategorik.
4.  Tahun.
    -   Tipe data ini adalah numerik.
5.  *Seat*.
    -   Tipe data ini adalah numerik.
6.  *Mileage*.
    -   Tipe data ini adalah numerik.
7.  Kapasitas *cc* mesin.
    -   Tipe data ini adalah numerik.

Tujuan saya adalah membuat model sebagai berikut:

harga ∼ brand + status + tahun + seat + mileage + cc

Oleh karena `brand` dan `status` memiliki tipe kategorik, saya akan
lakukan *preprocessing* berupa *one hot encoding* agar menjadi numerik
*binary*.

------------------------------------------------------------------------

## Model Regresi Linear

Untuk membuat model regresi linearnya, saya menggunakan *deep learning*
via **Tensorflow** dan **Keras**.

Langkah kerjanya adalahh sebagai berikut:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/nomnoml.png" alt="Gambar 1. Langkah Kerja" width="246" />
<p class="caption">
Gambar 1. Langkah Kerja
</p>

</div>

Berikut ini adalah performa modelnya yang saya hitung dengan *test
dataset*:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/post_files/figure-gfm/unnamed-chunk-4-1.png" alt="Gambar 2. Performa Model (loss dan MAE) dengan Epoch=200"  />
<p class="caption">
Gambar 2. Performa Model (loss dan MAE) dengan Epoch=200
</p>

</div>

Berikut adalah *summary* dari performa modelnya:

    ## Measures for:  regression
    ## mse        : 0.008530676 
    ## rmse       : 0.09236166 
    ## r2         : 0.7348903 
    ## mad        : 0.04116692
    ## 
    ## Residuals:
    ##           0%          10%          20%          30%          40%          50% 
    ## -0.178693546 -0.053080665 -0.031336341 -0.009975249  0.013205092  0.024046387 
    ##          60%          70%          80%          90%         100% 
    ##  0.037722285  0.048109418  0.079803492  0.189394098  0.285663537

Dari performa model di atas, saya cukup puas dengan model regresinya
karena angka *M**S**E* → 0 dan *R*<sup>2</sup> &gt; 0.7.

Sekarang tinggal mendeskripsikan modelnya saja. Karena saya menggunakan
*deep learning* (***ANN***) untuk membuat modelnya, maka saya
membutuhkan `DALEX` untuk membantu saya mendeskripsikan modelnya.

### *Feature Importance*

![Gambar 2. Feature
Importance](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/post_files/figure-gfm/unnamed-chunk-6-1.png)

Dari **data yang terbatas ini** saya dapatkan bahwa `cc mesin` dan
`brand Toyota` merupakan variabel terpenting dan paling berpengaruh
terhadap harga mobil yang *listed* di Carmudi.

Beberapa variabel lain seperti `tahun` dan `mileage` juga cukup
berpengaruh.

> Bagaimana bentuk pengaruhnya?

Mari kita lihat *model profile* berikut ini.

### *Model Profile*

![Gambar 3. Accumulated Dependence
Profile](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%203/post_files/figure-gfm/unnamed-chunk-7-1.png)

Ada hal yang menarik dari grafik di atas. Saya bisa kategorikan beberapa
variabel menjadi dua:

1.  Variabel yang membuat harga semakin mahal.
    -   `cc mesin` : semakin besar kapasitas dari mesin akan membuat
        harga mobil menjadi lebih mahal.
    -   `tahun` : semakin muda tahunnya, mobil akan semakin mahal.
    -   Jika dibandingkan antara `cc mesin` dan `tahun`, variabel yang
        paling *ngefek* memberikan peningkata harga terbesar adalah
        `cc mesin`.
2.  Variabel yang membuat harga semakin murah.
    -   `mileage` : semakin besar jarak tempuh, mobil akan semakin
        murah.
    -   `brand` : Di antara brand berikut: Toyota, Daihatsu, Honda,
        Mitsubishi, dan Suzuki kita bisa simpulkan: - `Toyota` memiliki
        penurunan yang relatif lebih landai dibandingkan mobil merek
        lainnya. - *Brand* mobil yang memiliki penurunan harga terbesar
        jika saya urutkan adalah: `Daihatsu`, `Suzuki`, `Mitsubishi`,
        `Honda`, dan `Toyota`.

------------------------------------------------------------------------

### *Notes*

Analisa ini berdasarkan data terbatas yang saya kumpulkan dari situs
Carmudi. Jika ada data lebih banyak, misalkan:

1.  *Service history* per *listed* mobil.
2.  Kualitas *after service* masing-masing *brand* yang bisa
    dikuantifikasi.
3.  Estetik interior dan exterior yang bisa dikuantifikasi.
4.  dan lainnya.

Bisa jadi model ini akan lebih akurat.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
