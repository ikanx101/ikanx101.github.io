---
date: 2025-02-18T17:37:00-04:00
title: "Simpson Paradox pada Analisa Data Market Riset (dan bagaimana cara mendeteksinya)"
categories:
  - Blog
tags:
  - Market Riset
  - Marketing
  - Statistik
  - Tabulasi
  - Analisa
  - Paradox
  - Error
---

Sebagai seorang *market researcher*, seringkali saya menemukan beberapa
hasil analisa yang berbeda (bahkan bertolak belakang) tergantung *point
of view* analisa. Sebagai contoh, saat saya melakukan analisa untuk *all
respondents*, saya mendapatkan hasilnya berupa **A**. Tapi saat dipisah
menjadi kelompok-kelompok responden tertentu, hasilnya sudah bukan **A**
lagi tapi menjadi **B** (bahkan menjadi **C**).

Kejadian di atas merupakan salah satu contoh dari **Simpson Paradox**.

## **Apa itu Simpson Paradox?**

*Simpson Paradox*, atau Paradoks Simpson, adalah sebuah fenomena yang
membingungkan dalam statistika dan probabilitas. Sederhananya, paradoks
ini terjadi ketika suatu kecenderungan atau hubungan yang terlihat dalam
beberapa kelompok data **hilang atau bahkan bertolak belakang** ketika
kelompok-kelompok data tersebut digabungkan. Paradoks ini dinamakan dari
[Edward H. Simpson](https://en.wikipedia.org/wiki/Edward_H._Simpson),
seorang statistikawan yang mendeskripsikannya pada tahun 1951, meskipun
fenomena ini sudah diketahui sebelumnya.

**Mengapa ini disebut ‘Paradoks’?**

Disebut paradoks karena bertentangan dengan intuisi kita. Secara logika,
jika dalam setiap kelompok bagian dari keseluruhan kita melihat suatu
kecenderungan, kita akan berharap kecenderungan tersebut tetap ada atau
semakin kuat ketika semua kelompok digabungkan. Namun, *Simpson Paradox*
menunjukkan bahwa hal tersebut tidak selalu benar.

## **Contoh Sederhana dalam Konteks Market Research**

Misalkan saya melakukan survey kepuasan pelanggan terhadap dua jenis
kemasan produk:

- Kemasan A dan
- Kemasan B.

Survey dilakukan di dia kota yang berbeda, yakni: **Kota Maju** dan
**Kota Berkembang**.

Berikut adalah hasil survei yang saya dapatkan:

**Kepuasan Pelanggan di Kota Maju**

| Kemasan   | Jumlah Pelanggan | Jumlah Puas | Persentase Kepuasan |
|-----------|------------------|-------------|---------------------|
| Kemasan A | 100              | 80          | 80%                 |
| Kemasan B | 200              | 140         | 70%                 |

**Kepuasan Pelanggan di Kota Berkembang**

| Kemasan   | Jumlah Pelanggan | Jumlah Puas | Persentase Kepuasan |
|-----------|------------------|-------------|---------------------|
| Kemasan A | 400              | 240         | 60%                 |
| Kemasan B | 100              | 55          | 55%                 |

**Analisis per Kota:**

- **Di Kota Maju:** Kemasan A memiliki persentase kepuasan yang lebih
  tinggi (`80%`) dibandingkan Kemasan B (`70%`).
- **Di Kota Berkembang:** Kemasan A juga masih memiliki persentase
  kepuasan yang lebih tinggi (`60%`) dibandingkan Kemasan B (`55%`).

> Sejauh ini, terlihat jelas bahwa **Kemasan A lebih unggul dalam hal
> kepuasan pelanggan di kedua kota**.

Sekarang, mari kita **gabungkan data dari kedua kota** untuk melihat
gambaran secara keseluruhan:

**Kepuasan Pelanggan Gabungan (Kota Maju + Kota Berkembang)**

| Kemasan | Jumlah Pelanggan Total | Jumlah Puas Total | Persentase Kepuasan Total |
|----|----|----|----|
| Kemasan A | 500 (100+400) | 320 (80+240) | 64% |
| Kemasan B | 300 (200+100) | 195 (140+55) | 65% |

**Analisis Data Gabungan:**

> **Secara keseluruhan (gabungan kedua kota):** Tiba-tiba, persentase
> kepuasan untuk Kemasan B (65%) **sedikit lebih tinggi** dibandingkan
> Kemasan A (64%).

**Paradoksnya Muncul!**

Bagaimana bisa ini terjadi? Dalam setiap kota secara terpisah, Kemasan A
selalu lebih unggul. Tetapi ketika datanya digabungkan, Kemasan B justru
terlihat sedikit lebih baik.

**Inilah inti dari Simpson Paradox.**

## **Penjelasan Mengapa Simpson Paradox Terjadi dalam Contoh Ini**

Paradoks ini terjadi karena adanya **variabel tersembunyi** atau
**variabel perancu** (*confounding* *variable*) yang tidak kita sadari
atau tidak kita kontrol. Dalam contoh ini, variabel perancunya adalah
**ukuran kota atau jumlah pelanggan di setiap kota**.

- **Kota Maju:** Lebih banyak pelanggan yang disurvei untuk Kemasan
  B (200) dibandingkan Kemasan A (100). Namun, secara persentase,
  kepuasan Kemasan A tetap lebih tinggi di kota ini.
- **Kota Berkembang:** Jumlah pelanggan untuk Kemasan A (400) jauh lebih
  banyak dibandingkan Kemasan B (100). Kepuasan Kemasan A juga lebih
  tinggi di kota ini secara persentase.

Karena Kota Berkembang memiliki jumlah pelanggan yang jauh lebih besar
untuk Kemasan A, dan tingkat kepuasan di Kota Berkembang secara umum
lebih rendah dibandingkan Kota Maju (mungkin karena faktor ekonomi,
demografi, dll. yang tidak kita teliti di sini), maka ketika data
digabungkan, efek dari Kota Berkembang **mendominasi** hasil
keseluruhan.

Akibatnya, meskipun Kemasan A lebih baik di setiap kota, karena proporsi
pelanggan Kemasan A yang besar berasal dari kota dengan tingkat kepuasan
yang lebih rendah, maka rata-rata kepuasan gabungan Kemasan A menjadi
sedikit lebih rendah dibandingkan Kemasan B.

## **Implikasi Simpson Paradox untuk Market Researcher**

Simpson Paradox sangat penting untuk diperhatikan oleh *market
researcher* karena dapat menyebabkan **kesimpulan yang salah atau
menyesatkan** jika kita hanya melihat data agregat (data gabungan) tanpa
mempertimbangkan subkelompok atau variabel lain yang mungkin relevan.

Dalam pekerjaan Anda, ini berarti:

1.  **Jangan hanya melihat data secara keseluruhan:** Saat menganalisis
    hasil survei atau data riset pasar lainnya, jangan hanya terpaku
    pada angka-angka agregat. Selalu pertimbangkan untuk memecah data
    menjadi subkelompok yang lebih kecil berdasarkan variabel-variabel
    penting (seperti demografi, lokasi geografis, segmen pelanggan,
    dll.).
2.  **Identifikasi dan pertimbangkan variabel perancu:** Pikirkan
    variabel-variabel lain yang mungkin mempengaruhi hasil riset Anda.
    Dalam contoh di atas, variabel perancunya adalah kota. Dalam riset
    pasar lainnya, variabel perancu bisa berupa usia, pendapatan,
    tingkat pendidikan, jenis kelamin, dan lain-lain.
3.  **Analisis data per subkelompok:** Setelah memecah data menjadi
    subkelompok, lakukan analisis secara terpisah untuk setiap
    subkelompok. Apakah pola atau tren yang Anda lihat konsisten di
    semua subkelompok? Jika tidak, mengapa?
4.  **Hati-hati dalam menarik kesimpulan:** Jika Anda menemukan Simpson
    Paradox, berhati-hatilah dalam menarik kesimpulan. Kesimpulan yang
    valid mungkin berbeda tergantung pada apakah Anda melihat data
    agregat atau data per subkelompok. Pahami konteks dan faktor-faktor
    yang menyebabkan paradoks tersebut.

**Bagaimana Menghindari Kesalahan Interpretasi Akibat Simpson Paradox?**

- **Segmentasi Data:** Langkah pertama adalah selalu melakukan
  segmentasi data berdasarkan variabel-variabel yang relevan.
- **Analisis Lebih Dalam:** Jangan hanya berhenti pada analisis
  deskriptif. Lakukan analisis inferensial dan eksploratif untuk
  memahami hubungan antar variabel dan mengidentifikasi variabel
  perancu.
- **Pertimbangkan Konteks:** Selalu pertimbangkan konteks riset Anda.
  Faktor-faktor apa saja yang mungkin mempengaruhi hasil? Apakah ada
  variabel tersembunyi yang perlu dipertimbangkan?
- **Komunikasi yang Jelas:** Saat menyampaikan hasil riset, jelaskan
  secara transparan apakah Simpson Paradox mungkin terjadi dan bagaimana
  Anda mengatasinya dalam analisis Anda. Sajikan data per subkelompok
  dan data agregat jika perlu, dan jelaskan interpretasi yang tepat.

# **Bagaimana Mendeteksi Simpson Paradox?**

Salah satu hal yang bisa kita lakukan untuk mendeteksi kemungkinan
terjadinya *Simpson Paradox* adalah dengan memperbanyak *cross* tabulasi
antar variabel pada data yang kita miliki. Namun ada cara lain yang bisa
kita lakukan, yakni dengan memanfaatkan model *machine learning* (baca:
statistika) sederhana yakni *general linear model*.

> Prinsipnya adalah seperti mencari *predictors* mana saja yang
> **signifikan** dalam suatu model prediksi.

Model *general linear model* merupakan model yang mudah
diinterpretasikan sehingga menjadi pilihan yang tepat untuk pekerjaan
ini.

Saya akan berikan contoh bagaimana regresi binomial logistik bisa
digunakan untuk mendeteksi variabel mana saja yang merupakan
*confounding variables*.

## Contoh Data Survey

Misalkan saya telah melakukan survey terhadap **365 orang** responden.

Survey dilakukan untuk mencari tahu apakah responden *aware* atau tidak
tentang suatu produk makanan dan minuman. Pertanyaan lain yang
ditanyakan adalah *gender*, *social economy status* (SES), dan kelompok
usia. Kita akan mencari di antara tiga variabel tersebut, mana yang
menjadi *confounding variable*.

Berikut adalah sampel datanya:

|     | gender | ses | usia       | aware |
|:----|:-------|:----|:-----------|:------|
| 4   | Wanita | Mid | \< 15 th   | tidak |
| 73  | Pria   | Up  | 26 - 30 th | ya    |
| 81  | Pria   | Low | 26 - 30 th | tidak |
| 225 | Wanita | Low | 16 - 20 th | tidak |
| 255 | Wanita | Mid | 26 - 30 th | tidak |
| 259 | Pria   | Mid | 21 - 25 th | ya    |
| 284 | Wanita | Mid | 16 - 20 th | tidak |
| 305 | Pria   | Low | \< 15 th   | ya    |
| 353 | Pria   | Mid | 26 - 30 th | ya    |
| 354 | Pria   | Low | 16 - 20 th | ya    |

Berikut adalah tabulasi dari demografi jika saya hitung dari *all
respondents*:

| gender |   n | percent |
|:-------|----:|:--------|
| Pria   | 193 | 52.9%   |
| Wanita | 172 | 47.1%   |

| ses |   n | percent |
|:----|----:|:--------|
| Low | 100 | 27.4%   |
| Mid | 166 | 45.5%   |
| Up  |  99 | 27.1%   |

| usia       |   n | percent |
|:-----------|----:|:--------|
| 16 - 20 th |  59 | 16.2%   |
| 21 - 25 th | 152 | 41.6%   |
| 26 - 30 th |  75 | 20.5%   |
| \< 15 th   |  45 | 12.3%   |
| \> 30 th   |  34 | 9.3%    |

Sedangkan berikut ini adalah tabulasi berapa banyak responden yang
*aware*:

| aware |   n | percent |
|:------|----:|:--------|
| tidak | 178 | 48.8%   |
| ya    | 187 | 51.2%   |

Jika dilihat, persentase responden yang *aware* sebesar `48.8%`, sedikit
lebih rendah daripada responden yang tidak *aware* (`51.2%`). Kita akan
mencoba mencari pada subkelompok apa dari demografi dimana terjadi
perbedaan persentase yang signifikan.

Saya akan membuat model regresi binomial logistik dari data tersebut.
Sebelum kita membuat model berikut ini:

![\text{aware} \sim \text{gender} + \text{ses} + \text{usia}](https://latex.codecogs.com/svg.latex?%5Ctext%7Baware%7D%20%5Csim%20%5Ctext%7Bgender%7D%20%2B%20%5Ctext%7Bses%7D%20%2B%20%5Ctext%7Busia%7D "\text{aware} \sim \text{gender} + \text{ses} + \text{usia}")

Perlu diperhatikan bahwa kita harus melakukan proses *one hot encoding*
terlebih dahulu karena variabel *gender*, SES, dan kelompok usia
merupakan variabel kategorik.

Oleh karena *gender* hanya memiliki dua nilai:

- **Pria**
- **Wanita**

Kita cukup membuat label untuk salah satu saja. Hal yang sama juga bisa
kita lakukan untuk SES. Kita cukup membuat label untuk SES `middle` dan
`lower` saja. Pun demikian untuk variabel kelompok usia.

Sementara untuk *target variable: aware*, saya buat `ya == 1` dan
`tidak == 0`.

Setelah kita buat modelnya, kita bisa langsung melihat variabel mana
saja yang **signifikan** terhadap *aware* berdasarkan model yang ada:

``` r
summary(model_logistik)
```


    Call:
    glm(formula = formula_regresi, family = "binomial", data = data_final)

    Coefficients:
                   Estimate Std. Error z value Pr(>|z|)    
    (Intercept)     0.45690    0.32722   1.396 0.162618    
    genderPria      0.26863    0.22361   1.201 0.229614    
    sesLow         -1.74139    0.31817  -5.473 4.42e-08 ***
    sesMid         -1.04796    0.27925  -3.753 0.000175 ***
    usia..15.th     0.52454    0.39901   1.315 0.188634    
    usia..30.th    -0.02286    0.43927  -0.052 0.958497    
    usia16...20.th  0.44626    0.37007   1.206 0.227873    
    usia21...25.th  0.67871    0.30258   2.243 0.024890 *  
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    (Dispersion parameter for binomial family taken to be 1)

        Null deviance: 505.78  on 364  degrees of freedom
    Residual deviance: 464.66  on 357  degrees of freedom
    AIC: 480.66

    Number of Fisher Scoring iterations: 4

Kita bisa lihat bahwa:

- **Dua variabel SES** signifikan dengan nilai koefisien negatif.
  Artinya pada SES *middle* dan *low*, peluang lebih tinggi kita
  mendapatkan responden yang **tidak** ***aware***. Oleh karena variabel
  *dummy* SES **Up** tidak ada, kita tidak bisa melihat hubungannya.
  Namun kita bisa simpulkan bahwa variabel SES merupakan salah satu
  *confounding variable*.

Saya akan coba buat *cross* tabulasi antara *aware* dengan SES berikut
ini:

| ses | tidak | ya    |
|:----|:------|:------|
| Low | 67.0% | 33.0% |
| Mid | 50.6% | 49.4% |
| Up  | 27.3% | 72.7% |

Sesuai dengan model, kita dapatkan persentase *aware* tertinggi dari
responden yang berasal dari SES **Up**. Sedangkan persentase *aware*
akan menurun sesuai dengan penurunan SES. **Ada perbedaan proporsi**
***aware*** **pada subkelompok SES**.

- **Ada variabel pada kelompok usia** yang signifikan, yakni
  `usia 21-25 th`. Nilai koefisien positif. Artinya kita bisa menduga
  bahwa pada kelompok usia ini, persentase *aware* akan lebih banyak.
  Namun pada variabel kelompok usia yang lain tidak ada yang signifikan.

Saya akan buatkan *cross* tabulasinya berikut ini:

| usia       | tidak | ya    |
|:-----------|:------|:------|
| \< 15 th   | 48.9% | 51.1% |
| \> 30 th   | 55.9% | 44.1% |
| 16 - 20 th | 50.8% | 49.2% |
| 21 - 25 th | 41.4% | 58.6% |
| 26 - 30 th | 58.7% | 41.3% |

Kita **tidak bisa simpulkan** adanya perbedaan proporsi *aware* pada
subkelompok usia.

Dari model di atas, kita tidak mendapatkan *gender* menjadi *confounding
variable*. Mari kita lihat *cross* tabulasinya:

| gender | tidak | ya    |
|:-------|:------|:------|
| Pria   | 46.6% | 53.4% |
| Wanita | 51.2% | 48.8% |

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
