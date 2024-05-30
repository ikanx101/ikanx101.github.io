---
date: 2024-05-30T22:42:00-04:00
title: "Pengaruh Cuaca terhadap Market Otomotif di Indonesia (Baca Sampai Selesai)"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Regresi
  - Regresi Polinom
  - Weather
  - Sales
---

Di siang hari yang panas, saya tetiba berpikir:

> Kalau suasana panas seperti ini, paling enak kalau bepergian naik
> mobil dibandingkan motor. *Bisa pakai AC, lebih adem*. **Begitu pikir
> saya**.

Setelah dipikirkan kembali, jangan-jangan cuaca bisa mempengaruhi
banyaknya unit mobil yang terjual. Jika begitu, saya bisa membuat model
*machine learning* sederhana untuk membuktikan dugaan tersebut.

Langsung saja saya mencari **artikel terpercaya** yang bisa saya gunakan
sebagai basis logikanya. Caranya adalah dengan bertanya ke **Gemini Bard
Google**. Begini katanya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/korelasi/Screenshot%20from%202024-05-30%2008-41-45.png"
style="width:60.0%" />

Lalu segera saya cari data utama seperti:

1.  Rata-rata suhu tahunan di Indonesia.
2.  Total unit mobil terjual di Indonesia.

Berikut adalah data suhu yang saya dapatkan dari berbagai macam sumber:

| Tahun | Suhu Rata-rata Tahunan (°C) |
|:-----:|:---------------------------:|
| 2015  |            26.6             |
| 2016  |            26.9             |
| 2017  |            26.8             |
| 2018  |            26.8             |
| 2019  |            26.9             |
| 2020  |            27.0             |
| 2021  |            27.0             |
| 2022  |            27.0             |

Berikut adalah data unit mobil terjual yang saya dapatkan dari berbagai
macam sumber:

| Tahun | Unit Mobil Terjual |
|:-----:|:------------------:|
| 2015  |      1028000       |
| 2016  |      1009000       |
| 2017  |      1079000       |
| 2018  |      1151000       |
| 2019  |      1030000       |
| 2020  |       532407       |
| 2021  |       887200       |
| 2022  |       915159       |

Pertama-tama, saya akan buat *scatterplot* berikut ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/korelasi/korelasi_files/figure-commonmark/unnamed-chunk-5-1.png)

Jika dilihat sekilas, sepertinya saya bisa membuat model *machine
learning* yang punya akurasi bagus. Untuk itu, saya akan membuat model
regresi polinomial.


    Call:
    lm(formula = sales ~ poly(suhu, 4, raw = TRUE), data = df_model)

    Residuals:
             1          2          3          4          5          6          7 
    -4.080e-08 -1.050e+04 -3.600e+04  3.600e+04  1.050e+04 -2.458e+05  1.089e+05 
             8 
     1.369e+05 

    Coefficients: (1 not defined because of singularities)
                                 Estimate Std. Error t value Pr(>|t|)
    (Intercept)                 9.190e+10  6.776e+11   0.136    0.899
    poly(suhu, 4, raw = TRUE)1 -9.238e+09  6.740e+10  -0.137    0.898
    poly(suhu, 4, raw = TRUE)2  2.612e+08  1.885e+09   0.139    0.897
    poly(suhu, 4, raw = TRUE)3         NA         NA      NA       NA
    poly(suhu, 4, raw = TRUE)4 -6.183e+04  4.371e+05  -0.141    0.894

    Residual standard error: 153200 on 4 degrees of freedom
    Multiple R-squared:  0.6281,    Adjusted R-squared:  0.3492 
    F-statistic: 2.252 on 3 and 4 DF,  p-value: 0.2245

    [1] "R square: "

    [1] 0.6281415

    [1] "MAPE: "

    [1] 0.1024251

Model polinomial orde 4 menghasilkan
![R^2 = 0.6281415](https://latex.codecogs.com/svg.latex?R%5E2%20%3D%200.6281415 "R^2 = 0.6281415")
dengan
![MAPE = 0.1024251](https://latex.codecogs.com/svg.latex?MAPE%20%3D%200.1024251 "MAPE = 0.1024251").

Saya buat grafik untuk mengecek *fitted values* dengan data *real* dari
*scatterplot* sebelumnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/korelasi/korelasi_files/figure-commonmark/unnamed-chunk-7-1.png)

Saya cukup puas dengan performa model *machine learning* yang dibuat
tersebut.

> ***Ternyata semakin panas suhu yang terjadi di Indonesia, semakin
> menurun unit mobil terjual.***

## *Epilog*

Cerita di atas adalah **cerita rekaan atau karangan** saja *yah*. Saya
terinspirasi dari kisah nyata yang saya dengar belum lama ini.

Dari proses berpikir, pencarian artikel, pengumpulan data, hingga
pembuatan model dan pengambilan kesimpulan menurut saya ada beberapa
*flaws* yang berujung fatal. Apa saja? Mari kita bahas satu per satu:

1.  Kita sebenarnya tidak bisa menghubungkan kausalitas antara **cuaca**
    dan ***sales*** mobil secara langsung. Kenapa? Secara logika,
    terlalu banyak *middle factors* bagi konsumen untuk membeli mobil.
    1.Jangan pernah bertanya seperti ini pada *Gemini*, *ChatGPT*,
    *Bing*, dan sejenisnya. Kenapa? Kalian hanya akan mendapatkan
    artikel *very optimist* yang sejatinya belum jelas kebenarannya.
    Maksudnya, kalian akan mendapatkan artikel-artikel yang bernada *Yes
    Man!* di mana semua hal yang kita tanyakan bisa dilakukan dan
    dibuat.
2.  Perhatikan banyaknya baris data saat membuat model *machine
    learning*! Jangan membuat model dengan baris data yang sedikit dan
    terbatas!
3.  Jangan tergiur untuk membuat model yang memiliki akurasi dan presisi
    yang **sempurna**! Lebih baik kita membuat model yang bisa dengan
    mudah diinterpretasikan.

Selain poin-poin di atas, apa lagi *flaws* yang bisa kalian dapatkan
dari cerita di atas?
