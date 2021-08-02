---
date: 2021-08-02T13:48:00-04:00
title: "World Happiness Report 2021: Apa yang Membuat Warga Suatu Negara Bahagia?"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Responsible AI
  - Regresi
  - Modelling
  - Interpretable Machine Learning
  - Happiness
  - Gallup
---

Di blog saya yang lama, saya pernah menuliskan tentang bagaimana [GDP
memiliki hubungan dengan level kebahagiaan suatu
negara](https://passingthroughresearcher.wordpress.com/2019/11/19/infografis-kemakmuran-vs-kebahagiaan-suatu-negara/).
Pada 2021 ini, **Gallup** telah mengeluarkan data terbaru ***World
Happiness Report***, datanya saya ambil dari situs [Kaggle berikut
ini](https://www.kaggle.com/ajaypalsinghlo/world-happiness-report-2021).

> Kali ini saya akan mencoba eksplorasi, faktor apa saja yang
> mempengaruhi kebahagiaan warga suatu negara?

------------------------------------------------------------------------

## Analisa Deskriptif dari Data

Dari data yang saya ambil tersebut, ada `124` negara yang disurvey oleh
**Gallup**. Saya mengambil `9` *variables* utama dari data tersebut,
yakni:

    ## 'data.frame':    149 obs. of  9 variables:
    ##  $ country_name                : chr  "Finland" "Denmark" "Switzerland" "Iceland" ...
    ##  $ regional_indicator          : chr  "Western Europe" "Western Europe" "Western Europe" "Western Europe" ...
    ##  $ ladder_score                : num  7.84 7.62 7.57 7.55 7.46 ...
    ##  $ logged_gdp_per_capita       : num  10.8 10.9 11.1 10.9 10.9 ...
    ##  $ social_support              : num  0.954 0.954 0.942 0.983 0.942 0.954 0.934 0.908 0.948 0.934 ...
    ##  $ healthy_life_expectancy     : num  72 72.7 74.4 73 72.4 73.3 72.7 72.6 73.4 73.3 ...
    ##  $ freedom_to_make_life_choices: num  0.949 0.946 0.919 0.955 0.913 0.96 0.945 0.907 0.929 0.908 ...
    ##  $ generosity                  : num  -0.098 0.03 0.025 0.16 0.175 0.093 0.086 -0.034 0.134 0.042 ...
    ##  $ perceptions_of_corruption   : num  0.186 0.179 0.292 0.673 0.338 0.27 0.237 0.386 0.242 0.481 ...

1.  `country_name`: nama negara.
2.  `regional_indicator`: area atau region dari negara tersebut.
3.  `ladder_score`: tingkat kebahagiaan.
4.  `logged_gdp_per_capita`: angka ***GDP per capita*** yang telah
    ditransformasi dengan fungsi *lognormal*.
5.  `social_support`: tingkat *social support* dari warga suatu negara.
6.  `healthy_life_expectancy`: angka harapan hidup.
7.  `freedom_to_make_life_choices`: tingkat seberapa bebas seseorang
    bisa mengambil keputusan terhadap kehidupannya.
8.  `generosity`: tingkat **kemurahan hati** dari warga suatu negara.
9.  `perception_of_corruption`: persepsi tingkat korupsi warga di
    negaranya.

Mari kita bedah satu-persatu.

### 10 Negara dengan Kebahagiaan Tertinggi

Apa saja 10 negara dengan kebahagiaan tertinggi?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%204/bahagia_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Ternyata didominasi oleh negara-negara Eropa.

### 10 Negara dengan Kebahagiaan Terendah

Sekarang negara mana saja yang memiliki indeks kebahagiaan terendah?

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%204/bahagia_files/figure-gfm/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

Negara-negara tersebut didominasi oleh negara Afrika dan Asia yang
memiliki sejarah konflik.

### Indonesia sebagai Negara yang Paling Murah Hati

> ***Apakah kalian pernah mendengar kalimat di atas?***

Setidaknya beberapa rekan saya di *timeline* sempat membahas hal ini.
Ternyata pernyataan tersebut berasal dari survey ***World Giving
Index*** yang dirilis oleh badan amal [***Charities Aid
Foundation***](https://www.femina.co.id/trending-topic/good-news-indonesia-dinobatkan-jadi-negara-paling-murah-hati-di-dunia).

Sekarang, dari data yang saya punya, saya akan melihat 10 negara dengan
nilai *generosity* tertinggi:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%204/bahagia_files/figure-gfm/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

Ternyata dari data ini kita bisa mendapatkan kesimpulan yang sama.

> ***Indonesia menjadi negara yang paling generous.***

### Analisa Per Region

Berikut ini adalah nilai rata-rata dari semua variabel per region:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%204/bahagia_files/figure-gfm/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

## Analisa Prediktif dari Data

Sekarang saatnya melakukan analisa kausalitas dengan cara melakukan
analisa multilinear regresi dari data yang ada.

Saya berharap mendapatkan model sebagai berikut:

![ladder \\sim gdp + social + healthy + freedom + generosity +corruption](https://latex.codecogs.com/png.latex?ladder%20%5Csim%20gdp%20%2B%20social%20%2B%20healthy%20%2B%20freedom%20%2B%20generosity%20%2Bcorruption "ladder \sim gdp + social + healthy + freedom + generosity +corruption")

Berikut ini adalah langkah-langkah yang saya lakukan:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/Explainable%20AI/post%204/nomnoml.png" width="211" style="display: block; margin: auto;" />

Untuk proses *pre-processing* data, saya melakukan normalisasi dengan
menggunakan *range*. Untuk melakukan validasi dan mengecek *goodness of
fit* dari model, saya menggunakan beberapa prinsip yang pernah saya
tuliskan di [sini](https://ikanx101.com/blog/belajar-regresi/). Saya
akan gunakan tiga parameter, yakni:
![R^2](https://latex.codecogs.com/png.latex?R%5E2 "R^2"), **RMSE** dan
**p-value**.

### Iterasi Pertama

Pada percobaan pertama, saya memasukkan semua variabel yang ada untuk
memprediksi nilai `ladder_score`, hasilnya adalah sebagai berikut:

    ## 
    ## Call:
    ## lm(formula = "ladder_score ~ .", data = data_reg_new)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.34790 -0.05645  0.01078  0.06273  0.19718 
    ## 
    ## Coefficients:
    ##                              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                   0.06091    0.06319   0.964 0.336779    
    ## logged_gdp_per_capita         0.26340    0.08183   3.219 0.001595 ** 
    ## social_support                0.24208    0.06533   3.706 0.000301 ***
    ## healthy_life_expectancy       0.16228    0.07138   2.274 0.024494 *  
    ## freedom_to_make_life_choices  0.22225    0.05470   4.063 7.98e-05 ***
    ## generosity                    0.05686    0.05012   1.134 0.258541    
    ## perceptions_of_corruption    -0.09749    0.04681  -2.083 0.039058 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1018 on 142 degrees of freedom
    ## Multiple R-squared:  0.7558, Adjusted R-squared:  0.7455 
    ## F-statistic: 73.27 on 6 and 142 DF,  p-value: < 2.2e-16

Dari hasil di atas ternyata `generosity` bukanlah variabel yang
berpengaruh signifikan terhadap kebahagiaan. Berdasarkan temuan ini,
saya akan membuat modelnya kembali tanpa variabel tersebut.

### Iterasi Kedua

Kali ini saya membuat model dengan menghilangkan variabel `generosity`,
sebagai berikut:

    ## 
    ## Call:
    ## lm(formula = "ladder_score ~ . - generosity", data = data_reg_new)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.36342 -0.05597  0.01290  0.06378  0.19234 
    ## 
    ## Coefficients:
    ##                              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                   0.08690    0.05895   1.474 0.142643    
    ## logged_gdp_per_capita         0.24876    0.08088   3.075 0.002518 ** 
    ## social_support                0.24506    0.06534   3.751 0.000256 ***
    ## healthy_life_expectancy       0.15719    0.07131   2.204 0.029095 *  
    ## freedom_to_make_life_choices  0.23576    0.05344   4.412 2.01e-05 ***
    ## perceptions_of_corruption    -0.10759    0.04600  -2.339 0.020718 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.102 on 143 degrees of freedom
    ## Multiple R-squared:  0.7536, Adjusted R-squared:  0.745 
    ## F-statistic: 87.49 on 5 and 143 DF,  p-value: < 2.2e-16

    ## [1] "RMSE: 0.0998782690892772"

Jika kita lihat parameter-parameter *goodness of fit* dari model:

1.  `Adjusted R-squared` sebesar `0.745`. Bisa saya simpulkan model
    sudah cukup baik.
2.  `p-value` sebesar
    ![2.2 \* 10^{-16} \\sim 0](https://latex.codecogs.com/png.latex?2.2%20%2A%2010%5E%7B-16%7D%20%5Csim%200 "2.2 * 10^{-16} \sim 0").
    Model menunjukkan pengaruh signifikan dari variabel prediktor
    terhadap variabel target.
3.  `RMSE` sebesar 0.0999. Nilainya sudah bagus karena kecil.

Dari ketiga parameter di atas, artinya model regresi saya sudah baik.

### Interpretasi Model Regresi

Saya dapatkan model sebagai berikut:

![ladder \\simeq 0.09 + 0.25gdp + 0.24social + 0.16healthy + 0.24freedom - 0.11corruption](https://latex.codecogs.com/png.latex?ladder%20%5Csimeq%200.09%20%2B%200.25gdp%20%2B%200.24social%20%2B%200.16healthy%20%2B%200.24freedom%20-%200.11corruption "ladder \simeq 0.09 + 0.25gdp + 0.24social + 0.16healthy + 0.24freedom - 0.11corruption")

Ternyata:

> ***Kebahagiaan itu dipengaruhi oleh 3 variabel utama, yakni:
> `gdp per capita`, `social support`, dan `freedom to make choices`.***

Ketiganya memiliki hubungan positif. Artinya semakin tinggi nilai ketiga
variabel tersebut mengakibatkan indeks kebahagiaan juga meningkat.

Sedangkan variabel lainnya seperti `healthy_life_expectancy` dan
`perceptions_of_corruption` justru memiliki pengaruh yang relatif lebih
kecil dibandingkan ketiganya.

------------------------------------------------------------------------

Selain harta, tampaknya *social support* dan kebebasan dalam hidup
adalah kunci bagi kebahagiaan berdasarkan survey ini.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
