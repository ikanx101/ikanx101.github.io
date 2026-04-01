---
date: 2026-04-01T15:54:00-04:00
title: "Mencoba library(senseR) untuk Menyelesaikan Masalah Bisnis terkait Data Sales"
categories:
  - Blog
tags:
  - Market Riset
  - Artificial Intelligence
  - Machine Learning
  - BPS
  - Statistik
  - R
  - Uji hipotesis
  - Komunitas
  - Sales
  - Bisnis
---


Bulan lalu, saya bergabung dengan komunitas **BelajaR**. Suatu komunitas
yang berisi orang-orang yang punya satu tujuan yang sama, yakni belajar
**R programming**. Ternyata di grup tersebut ada beberapa rekan-rekan
*statisticians* di BPS, salah satunya adalah Mas [Joko Ade
Nursiyono](https://www.linkedin.com/in/jokoade/?originalSubdomain=id)
sang *founder* komunitas ini.

Singkat cerita, setelah *googling* sana-sini, saya mendapati bahwa
[**beliau aktif membuat**](https://github.com/jokoadenur) beberapa
*libraries* di **R**, seperti:

1.  `library(jatimuseR)`; *library* **R** untuk mengakses dataset publik
    Provinsi Jawa Timur yang bersumber dari Badan Pusat Statistik
    Provinsi Jawa Timur.
2.  `library(sarimasnap)`; *library* **R** yang membantu Anda membuat
    model **SARIMA** secara otomatis. SARIMA adalah metode statistik
    untuk meramalkan data deret waktu yang memiliki pola musiman
    (seperti data penjualan bulanan atau data cuaca tahunan).
3.  `library(numspellR)`; *library* **R** ini membantu menganalisis data
    angka yang berubah seiring waktu dengan mencari pola-pola di mana
    angka tersebut “bertahan” atau “menempel” pada nilai tertentu dalam
    waktu lama, seperti harga yang tidak berubah selama beberapa bulan
    atau tingkat pengangguran yang stabil dalam periode tertentu, yang
    penting untuk memahami stabilitas ekonomi dan efektivitas kebijakan.
4.  `library(segmonR)`; *library* **R** ini adalah alat untuk membuat
    diagram lingkaran yang tidak statis, tetapi memiliki segmen-segmen
    yang bisa bergerak atau beranimasi sesuai dengan pengaturan yang
    Anda buat. Anda bisa mengatur bagaimana setiap bagian diagram (yang
    mewakili kategori atau variabel dalam data) tampil dan bergerak,
    sehingga menghasilkan visualisasi data yang lebih hidup dan
    interaktif dibanding diagram lingkaran biasa.

**dan masih banyak lagi**.

Nah, pada tulisan ini saya akan membahas salah satu *library* buatan
beliau bernama `library(senseR)` yang menurut saya bisa berguna pada
*business case* di bidang *sales*.

# Penjelasan Tentang `library(senseR)`

`senseR` adalah sebuah *library* **R** sebagai alat diagnostik statistik
untuk mengevaluasi apakah **indikator proksi** dapat **secara andal
mewakili konstruk dasar** yang tidak dapat diamati atau diukur secara
langsung. Metode yang digunakan adalah dengan memeriksa tujuh
karakteristik penting:

1.  Apakah indikator bergerak searah dengan fenomena (*monotonicity*)?
    - *Monotonicity* dihitung menggunakan korelasi *rank Spearman*
      antara *proxy* dan target.
    - Tidak seperti korelasi *Pearson*, korelasi *Spearman* tidak
      mengasumsikan linearitas.
2.  Seberapa banyak informasi yang dibawa (konten informasi)?
    - *Information content* bisa dihitung dengan proporsi varians yang
      dijelaskan (*R-squared*).
3.  Seberapa tersebar nilainya (dispersi)?
4.  Apakah cenderung stagnan (stagnasi)?
5.  Apakah ada batasan atas yang menghambat (efek plafon)?
6.  Seberapa konsisten performanya dari waktu ke waktu (stabilitas)?
    - Mengukur konsistensi hubungan antara proksi dan target di berbagai
      *subset* data atau periode waktu.
7.  Seberapa cepat merespon perubahan (responsivitas)?

## Konsep *Proxy Indicators*

*Proxy indicators* adalah variabel yang digunakan sebagai pengganti
(*proxy*) untuk variabel target yang sulit atau tidak mungkin diukur
secara langsung.

## Kemudahan `library(senseR)`

Keunggulan *library* ini adalah *output*-nya yang mudah dimengerti.
*Output* `senseR` menyediakan:

1.  Tabel metrik untuk setiap komponen.
2.  Skor akhir dan klasiﬁkasi.
3.  Interpretasi naratif dalam bahasa pilihan.
4.  Rekomendasi untuk penggunaan *proxy*.

Namun bukan berarti *library* ini tidak memiliki limitasi. Berikut
beberapa limitasi yang perlu diperhatikan agar kita tidak salah dalam
mengambil kesimpulan dari hasil yang diberikan:

1.  Asumsi Linearitas: Meskipun menggunakan Spearman untuk
    *monotonicity*, beberapa komponen masih mengasumsikan hubungan
    linear.
    - Menurut saya, asumsi linearitas adalah asumsi yang paling dasar
      dan **tetap bisa digunakan** dalam konteks bisnis. Benar jika
      dunia ini bekerja secara non linear **tapi banyak masalah bisa
      dijelaskan dengan mudah menggunakan asumsi linear**.
2.  Independensi Komponen: Rata-rata sederhana dari karakteristik
    indikator mengasumsikan mereka sama pentingnya.
3.  *Threshold Arbitrer*: Batas 0.4 dan 0.7 untuk klasiﬁkasi bersifat
    *arbitrer* dan mungkin tidak optimal untuk semua konteks.

# *Study Case: Selling in vs Selling out*

Beberapa tahun lalu, salah seorang rekan saya di salah satu perusahaan
FMCG berdiskusi tentang masalah yang dia hadapi. Ada satu *business
case* yang membuat keriuhan di kantornya.

> Di perusahaan rekan saya, mereka tidak memiliki data *selling out*
> secara *real time* dan hanya memiliki data *real time selling in*.
> Biasanya, data *selling out* baru bisa diketahui 4 sampai 6 bulan
> setelah semua transaksi *closed*. *Board of directors* ingin
> mengetahui apakah data *selling in* bisa digunakan sebagai *proxy*
> pengambilan keputusan *strategic* dalam rangka meningkatkan *selling
> out*.

Data *selling out* adalah data jualan perusahaan tersebut secara *real*
ke *end customers*. Sedangkan data *selling in* merupakan data jualan
perusahaan tersebut ke *distributor* atau *outlet retail*.

Sekilas keduanya terlihat sama tapi **pada kenyataannya, *selling in*
tidak sepenuhnya terkonversi menjadi *selling out***. Misalkan:

1.  Ada kasus di mana beberapa distributor melakukan *stock* produk
    sehingga membeli dalam jumlah banyak di suatu waktu terlepas dari
    permintaan pasar.
2.  Ada kasus di mana produk-produk dari distributor di-*retur* karena
    tidak laku.
3.  Ada kasus di mana distributor membeli produk dalam jumlah banyak
    sebelum kenaikan harga barang di periode berikutnya.

**dan lain sebagainya**.

Berikut adalah data bulanan selama lima tahun dari *selling in* dan
*selling out*:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/senseR/draft_files/figure-commonmark/unnamed-chunk-1-1.png)

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/senseR/draft_files/figure-commonmark/unnamed-chunk-1-2.png)

Sekarang saya akan menguji apakah data *selling in* bisa dijadikan
*proxy* *selling out* menggunakan `library(senseR)`.

Skripnya sangat mudah, yakni:

``` r
library(senseR)
senser(df, proxy = "selling_in", target = "selling_out",lang = "indonesia") 
```


    ====================================================
     senseR STRICT - Proxy Indicator Diagnostic
    ====================================================
    Konstruk target  : selling_out 

    ----------------------------------------------------
    Proxy : selling_in 
    ----------------------------------------------------
    1. Monotonisitas (Spearman)       : 0.8118 
    2. Kandungan Informasi (R2)       : 0.5205 
    3. Elastisitas (Responsivitas)    : 0.7215 | Skor: 1 | Penalti jika < 0.1 
    4. Koefisien Variasi (KV)         : 0.326 | Skor: 1 | Penalti jika < 0.02 
    5. Rata-rata Perubahan Absolut    : 460.1525 | Skor: 1 | Penalti jika < 0.01 
    6. Rasio Efek Ceiling             : 0.4893 | Skor: 1 | Penalti jika > 0.95 
    7. Stabilitas (Konsistensi Beta)  : 0.7829 
    Kegagalan Struktural Terdeteksi   : FALSE 
    ----------------------------------------------------
    Skor Akhir Proxy (Aturan Median)  : 1 
    ----------------------------------------------------
    Proxy : selling_in 
    Score : 1 
    Status: Proxy layak 
    Interpretation:
     Proxy memiliki variabilitas, sensitivitas, dan stabilitas yang memadai. 

    ====================================================
    Referensi Ilmiah:

    [1] Spearman, C. (1904). The proof and measurement of association between two things.
        American Journal of Psychology, 15(1), 72-101.

    [2] Cohen, J. (1988). Statistical Power Analysis for the Behavioral Sciences.

    [3] Wooldridge, J. M. (2013). Introductory Econometrics: A Modern Approach.

    [4] OECD (2008). Handbook on Constructing Composite Indicators:
        Methodology and User Guide.

    [5] Hamilton, J. D. (1994). Time Series Analysis.

    [6] Chow, G. C. (1960). Tests of equality between sets of coefficients
        in two linear regressions. Econometrica.

Dari hasil di atas, bisa disimpulkan bahwa *selling in* layak dijadikan
*proxy* untuk *selling out*. Alasan dan nilai dari setiap perhitungan
juga disertakan di *output* yang diberikan `senseR`.

Dari temuan ini, saya mungkin akan menginformasikan rekan saya tersebut
untuk menggunakan *library* ini.

---
  
`if you find this article helpful, support this blog by clicking the ads.`
