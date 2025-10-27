---
date: 2025-10-27T10:06:00-04:00
title: "Analisa Bayesian terhadap Tren Perubahan Awareness Brand"
categories:
  - Blog
tags:
  - Market Riset
  - Artificial Intelligence
  - Machine Learning
  - Survey
  - Sequential Bayesian
  - Time Series
  - Bayesian
  - Analisa data
  - Marketing Sales
---

Pada 2024, saya melakukan *survey* kepada 100 orang *target market*
**produk X**. Saya mendapatkan **35% dari responden tersebut *aware*
dengan produk X**. Lalu pada 2025, saya melakukan *survey* kembali
kepada 100 orang *target market* yang berbeda dengan tahun 2024. Saya
mendapatkan **50% responden *aware* dengan produk X**.

> Bagaimana cara kita menjelaskan apakah peningkatan yang terjadi sudah
> baik atau tidak?

Sebagai *frequentist*, salah satu cara paling standar untuk menjawab
pertanyaan ini adalah menggunakan **uji-2-proporsi**. Langkah-langkahnya
masih sama, yakni:

1.  Tentukan ![H_0](https://latex.codecogs.com/svg.latex?H_0 "H_0") dan
    ![H_1](https://latex.codecogs.com/svg.latex?H_1 "H_1").
    - ![H_0: p\_{2024} = p\_{2025}](https://latex.codecogs.com/svg.latex?H_0%3A%20p_%7B2024%7D%20%3D%20p_%7B2025%7D "H_0: p_{2024} = p_{2025}").
      Proporsi responden *aware* pada 2024 **sama dengan** proporsi di
      2025.
    - ![H_0: p\_{2024} \neq p\_{2025}](https://latex.codecogs.com/svg.latex?H_0%3A%20p_%7B2024%7D%20%5Cneq%20p_%7B2025%7D "H_0: p_{2024} \neq p_{2025}").
      Proporsi responden *aware* pada 2024 **tidak sama dengan**
      proporsi di 2025.
2.  Hitung
    ![p\_{value}](https://latex.codecogs.com/svg.latex?p_%7Bvalue%7D "p_{value}")
    dan sandingkan dengan
    ![\alpha = 0.05](https://latex.codecogs.com/svg.latex?%5Calpha%20%3D%200.05 "\alpha = 0.05").
3.  Tolak ![H_0](https://latex.codecogs.com/svg.latex?H_0 "H_0") jika
    ![p\_{value} \< \alpha](https://latex.codecogs.com/svg.latex?p_%7Bvalue%7D%20%3C%20%5Calpha "p_{value} < \alpha").

<!-- -->


        2-sample test for equality of proportions with continuity correction

    data:  c(35, 50) out of c(100, 100)
    X-squared = 4.0102, df = 1, p-value = 0.04522
    alternative hypothesis: two.sided
    95 percent confidence interval:
     -0.295436206 -0.004563794
    sample estimates:
    prop 1 prop 2 
      0.35   0.50 

Oleh karena kita dapatkan
![p\_{value}=](https://latex.codecogs.com/svg.latex?p_%7Bvalue%7D%3D "p_{value}=")
0.045225 dan nilainya lebih kecil daripada
![\alpha](https://latex.codecogs.com/svg.latex?%5Calpha "\alpha"), maka
**Tolak ![H_0](https://latex.codecogs.com/svg.latex?H_0 "H_0")**.

> Proporsi *aware* pada 2025 **lebih besar signifikan** dibanding 2024.

------------------------------------------------------------------------

**Pertanyaan selanjutnya adalah: bagaimana jawaban seorang *Bayesian*?**

Alih-alih hanya mengatakan “50% lebih besar dari 35%”, pendekatan
Bayesian memungkinkan kita untuk menjawab pertanyaan yang jauh lebih
kuat, yakni:

> **“Berdasarkan data yang saya miliki, seberapa yakin (dalam persen)
> saya bahwa persentase *awareness* pada tahun 2025 benar-benar lebih
> tinggi daripada tahun 2024?”**

Berikut adalah langkah-langkah untuk menjelaskannya menggunakan analisis
Bayesian.

## Konsep Dasar

Pada *point of view* seorang *Frequentist*, kita memiliki **poin
estimasi** sebesar **35% dan 50%** dan kemudian menggunakan
![p\_{value}](https://latex.codecogs.com/svg.latex?p_%7Bvalue%7D "p_{value}")
untuk melihat apakah perbedaan ini **signifikan secara statistik** atau
tidak.

Dalam statistik Bayesian, kita memperlakukan *awareness rate* (misal
saya notasikan sebagai
![\theta](https://latex.codecogs.com/svg.latex?%5Ctheta "\theta"))
sebagai sesuatu yang tidak pasti dan memiliki *distribusi probabilitas*.
Data survey yang dimiliki (35 dari 100 dan 50 dari 100) digunakan untuk
*memperbarui* keyakinan kita tentang
![\theta](https://latex.codecogs.com/svg.latex?%5Ctheta "\theta").

- Keyakinan awal kita disebut **Prior**.
- Keyakinan yang telah diperbarui setelah melihat data disebut
  **Posterior**.

Tujuan kita adalah membandingkan distribusi **Posterior** untuk
![\theta\_{2024}](https://latex.codecogs.com/svg.latex?%5Ctheta_%7B2024%7D "\theta_{2024}")
dengan distribusi **Posterior** untuk
![\theta\_{2025}](https://latex.codecogs.com/svg.latex?%5Ctheta_%7B2025%7D "\theta_{2025}").

Kita bisa melakukan dua cara analisa:

1.  Membuat **posterior 2024** dan **posterior 2025** **independen**,
    atau
2.  Membuat **posterior 2025** sebagai *sequential* dari **posterior
    2025**.

Saya akan melakukan analisa kedua karena saya meyakini ada hubungan
antar tahun.

### Langkah 1: Menentukan Model (*Prior* dan *Likelihood*)

Kita memodelkan jumlah orang yang *aware* sebagai data yang mengikuti
distribusi Binomial, karena setiap responden adalah “sukses” (*aware*)
atau “gagal” (tidak *aware*).

- **Likelihood 2024:**
  ![P(\text{data}\_{2024} \| \theta\_{2024}) \sim \text{Binomial}(n=100, k=35)](https://latex.codecogs.com/svg.latex?P%28%5Ctext%7Bdata%7D_%7B2024%7D%20%7C%20%5Ctheta_%7B2024%7D%29%20%5Csim%20%5Ctext%7BBinomial%7D%28n%3D100%2C%20k%3D35%29 "P(\text{data}_{2024} | \theta_{2024}) \sim \text{Binomial}(n=100, k=35)")
- **Likelihood 2025:**
  ![P(\text{data}\_{2025} \| \theta\_{2025}) \sim \text{Binomial}(n=100, k=50)](https://latex.codecogs.com/svg.latex?P%28%5Ctext%7Bdata%7D_%7B2025%7D%20%7C%20%5Ctheta_%7B2025%7D%29%20%5Csim%20%5Ctext%7BBinomial%7D%28n%3D100%2C%20k%3D50%29 "P(\text{data}_{2025} | \theta_{2025}) \sim \text{Binomial}(n=100, k=50)")

Untuk **Prior**, karena kita tidak memiliki informasi sebelumnya tentang
*awareness rate* sebelum survei 2024, kita akan menggunakan ***prior
yang tidak informatif***. Pilihan standar untuk proporsi adalah
![\text{Beta}(1, 1)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%281%2C%201%29 "\text{Beta}(1, 1)"),
yang pada dasarnya adalah distribusi *uniform* yang menyatakan bahwa
semua *awareness rate* dari 0% hingga 100% sama-sama mungkin terjadi
*sebelum* kita melihat data.

### Langkah 2: Menghitung Distribusi *Posterior*

Dengan menggunakan *conjugate prior*, matematika Bayesian memberi tahu
kita bahwa:

Jika *prior*
![\sim \text{Beta}(\alpha, \beta)](https://latex.codecogs.com/svg.latex?%5Csim%20%5Ctext%7BBeta%7D%28%5Calpha%2C%20%5Cbeta%29 "\sim \text{Beta}(\alpha, \beta)")
dan *likelihood*
![\sim \text{Binomial}(n, k)](https://latex.codecogs.com/svg.latex?%5Csim%20%5Ctext%7BBinomial%7D%28n%2C%20k%29 "\sim \text{Binomial}(n, k)"),
maka *posterior*
![\sim \text{Beta}(\alpha + k, \beta + n - k)](https://latex.codecogs.com/svg.latex?%5Csim%20%5Ctext%7BBeta%7D%28%5Calpha%20%2B%20k%2C%20%5Cbeta%20%2B%20n%20-%20k%29 "\sim \text{Beta}(\alpha + k, \beta + n - k)").

**Untuk Tahun 2024:**

- Prior:
  ![\text{Beta}(1, 1)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%281%2C%201%29 "\text{Beta}(1, 1)")
- Data:
  ![k_1 = 35](https://latex.codecogs.com/svg.latex?k_1%20%3D%2035 "k_1 = 35"),
  ![n_1 = 100](https://latex.codecogs.com/svg.latex?n_1%20%3D%20100 "n_1 = 100")
  \*-**Posterior 2024:**
  ![\text{Beta}(1 + 35, 1 + 100 - 35) = \textbf{Beta}(36, 66)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%281%20%2B%2035%2C%201%20%2B%20100%20-%2035%29%20%3D%20%5Ctextbf%7BBeta%7D%2836%2C%2066%29 "\text{Beta}(1 + 35, 1 + 100 - 35) = \textbf{Beta}(36, 66)")

Distribusi ini mewakili keyakinan kita tentang *awareness rate* 2024.
Puncaknya ada di sekitar
![\frac{36}{36+66} \approx 35.3\\](https://latex.codecogs.com/svg.latex?%5Cfrac%7B36%7D%7B36%2B66%7D%20%5Capprox%2035.3%5C%25 "\frac{36}{36+66} \approx 35.3\%").

**Untuk Tahun 2025:**

- Prior:
  ![\text{Beta}(36, 66)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%2836%2C%2066%29 "\text{Beta}(36, 66)")
- Data:
  ![k_2 = 50](https://latex.codecogs.com/svg.latex?k_2%20%3D%2050 "k_2 = 50"),
  ![n_2 = 100](https://latex.codecogs.com/svg.latex?n_2%20%3D%20100 "n_2 = 100")
- **Posterior 2025:**
  ![\text{Beta}(36 + 50, 66 + 100 - 50) = \textbf{Beta}(86, 116)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%2836%20%2B%2050%2C%2066%20%2B%20100%20-%2050%29%20%3D%20%5Ctextbf%7BBeta%7D%2886%2C%20116%29 "\text{Beta}(36 + 50, 66 + 100 - 50) = \textbf{Beta}(86, 116)")

Distribusi ini mewakili keyakinan kita tentang *true awareness rate*
2025. Puncaknya simetris tepat di
![\frac{86}{66+50} \approx 74\\](https://latex.codecogs.com/svg.latex?%5Cfrac%7B86%7D%7B66%2B50%7D%20%5Capprox%2074%5C%25 "\frac{86}{66+50} \approx 74\%").

### Langkah 3: Membandingkan Kedua Distribusi *Posterior*

Sekarang kita memiliki dua distribusi probabilitas yang *uncertain*:

- ![\theta\_{2024} \sim \text{Beta}(36, 66)](https://latex.codecogs.com/svg.latex?%5Ctheta_%7B2024%7D%20%5Csim%20%5Ctext%7BBeta%7D%2836%2C%2066%29 "\theta_{2024} \sim \text{Beta}(36, 66)")
- ![\theta\_{2025} \sim \text{Beta}(86, 116)](https://latex.codecogs.com/svg.latex?%5Ctheta_%7B2025%7D%20%5Csim%20%5Ctext%7BBeta%7D%2886%2C%20116%29 "\theta_{2025} \sim \text{Beta}(86, 116)")

Kita ingin tahu: **“Apa probabilitas
![\theta\_{2025} \> \theta\_{2024}](https://latex.codecogs.com/svg.latex?%5Ctheta_%7B2025%7D%20%3E%20%5Ctheta_%7B2024%7D "\theta_{2025} > \theta_{2024}")?”**

Cara termudah untuk menghitung ini adalah dengan simulasi Monte Carlo:

1.  Kita ambil ribuan (atau jutaan) sampel acak dari
    ![\text{Beta}(36, 66)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%2836%2C%2066%29 "\text{Beta}(36, 66)")
    (mari kita sebut `sampel_2024`).
2.  Kita ambil jumlah sampel yang sama dari
    ![\text{Beta}(86, 116)](https://latex.codecogs.com/svg.latex?%5Ctext%7BBeta%7D%2886%2C%20116%29 "\text{Beta}(86, 116)")
    (mari kita sebut `sampel_2025`).
3.  Kita hitung berapa persen dari sampel tersebut di mana
    `sampel_2025 > sampel_2024`.

### Hasil dan Interpretasi

Berikut adalah skrip untuk melakukan simulasinya:

``` r
# Install package jika diperlukan
# install.packages(c("ggplot2", "dplyr", "bayesAB"))

rm(list=ls())

# Load libraries
library(ggplot2)
library(dplyr)
library(bayesAB)

# Data
n_2024 <- 100
aware_2024 <- 35
prop_2024 <- aware_2024/n_2024

n_2025 <- 100
aware_2025 <- 50
prop_2025 <- aware_2025/n_2025
```

    Proporsi Awareness:

    2024: 0.35 ( 35 / 100 )

    2025: 0.5 ( 50 / 100 )

``` r
# Prior non-informatif Beta(1,1)
alpha_prior <- 1
beta_prior <- 1

# Posterior distributions
alpha_2024 <- alpha_prior + aware_2024
beta_2024 <- beta_prior + (n_2024 - aware_2024)

alpha_2025 <- alpha_2024 + aware_2025
beta_2025 <- beta_2024 + (n_2025 - aware_2025)
```


    Posterior Parameters:

    2024: Beta( 36 , 66 )

    2025: Beta( 86 , 116 )

``` r
# Set seed untuk reproducibility
set.seed(123)

# Jumlah samples
n_samples <- 100000

# Sample dari posterior distributions
samples_2024 <- rbeta(n_samples, alpha_2024, beta_2024)
samples_2025 <- rbeta(n_samples, alpha_2025, beta_2025)

# Hitung perbedaan
difference <- samples_2025 - samples_2024

# Probabilitas peningkatan
prob_increase <- mean(samples_2025 > samples_2024)
prob_meaningful_5pct <- mean(difference > 0.05)
prob_meaningful_10pct <- mean(difference > 0.10)
```

Setelah menjalankan simulasi ini, Saya dapatkan hasil berikut ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-7-1.png)


    Probabilitas Bayesian:

    P(2025 > 2024): 0.8914 

    P(Peningkatan > 5%): 0.6525 

    P(Peningkatan > 10%): 0.3252 

Berdasarkan simulasi, **probabilitas *awareness rate* pada tahun 2025
selalu berada di atas *awareness rate* tahun 2024** adalah sebesar
**89%**, dengan rincian:

- Probabilitas kenaikan *awareness rate* di atas 5% adalah sebesar
  **65%**.
- Probabilitas kenaikan *awareness rate* di atas 10% adalah sebesar
  **32% - 33%**.

Ini adalah bukti yang **sangat kuat** sehingga kita bisa sangat yakin
bahwa peningkatan yang terjadi bukanlah kebetulan melainkan cerminan
dari peningkatan *awareness* nyata di pasar.

Selanjutnya, kita bisa menghitung seberapa besar peningkatan *awareness*
pada tahun 2025 dengan melihat *distribusi perbedaan*
(![\delta = \theta\_{2025} - \theta\_{2024}](https://latex.codecogs.com/svg.latex?%5Cdelta%20%3D%20%5Ctheta_%7B2025%7D%20-%20%5Ctheta_%7B2024%7D "\delta = \theta_{2025} - \theta_{2024}")).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-8-1.png)

      Metric       Value
    1   Mean  0.07263989
    2 Median  0.07315058
    3     SD  0.05855509
    4   2.5% -0.04338048
    5  97.5%  0.18551077

*Expected value* peningkatan *awareness rate*-nya adalah di sekitar
**7%**.

------------------------------------------------------------------------

# BAGAIMANA JIKA DATANYA *TRACKING* TAHUNAN?

Kasus di atas adalh contoh jika saya hanya punya dua titik data saja.
Bagaimana jika kasusnya adalah mirip dengan [tulisan saya sebelumnya
ini](https://ikanx101.com/blog/bayes-loyal/)? Jika pada tulisan tersebut
saya menyelesaikannya dengan regresi *Bayesian*, sekarang saya akan
gunakan analisa *Bayesian sequential* seperti di atas.

Misalkan saya punya data seperti ini:

| year | respondents | aware | proportion |
|-----:|------------:|------:|-----------:|
| 2020 |         100 |    20 |       0.20 |
| 2021 |         100 |    25 |       0.25 |
| 2022 |         100 |    28 |       0.28 |
| 2023 |         100 |    23 |       0.23 |
| 2024 |         100 |    35 |       0.35 |
| 2025 |         100 |    31 |       0.31 |

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-9-1.png)

Terlihat ada penurunan *awareness rate* di tahun 2023 dan 2025.
Bagaimana analisa *Bayesian* terhadap perubahan angka *awareness rate*
ini? Bagaimana *Bayesian* melihat penurunan ini?

Pertama-tama, saya akan menghitung *prior* dan *posterior* lalu saya
sajikan dalam bentuk tabel berikut ini:

| year | aware | respondents | proportion | alpha_prior | beta_prior | alpha_post | beta_post |
|-----:|------:|------------:|-----------:|------------:|-----------:|-----------:|----------:|
| 2020 |    20 |         100 |       0.20 |           1 |          1 |         21 |        81 |
| 2021 |    25 |         100 |       0.25 |          21 |         81 |         46 |       156 |
| 2022 |    28 |         100 |       0.28 |          46 |        156 |         74 |       228 |
| 2023 |    23 |         100 |       0.23 |          74 |        228 |         97 |       305 |
| 2024 |    35 |         100 |       0.35 |          97 |        305 |        132 |       370 |
| 2025 |    31 |         100 |       0.31 |         132 |        370 |        163 |       439 |

Saya akan membuat *density plot* dari tabel hasil perhitungan di atas.
Berikut adalah hasilnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-11-1.png)

Kita bisa lihat secara visual semua distribusi *posterior* berada di
sebelah kanan dari distribusi *prior*. Kita lihat pada grafik
sebelumnya, ada penurunan di 2023 dan 2025, namun *posterior*-nya
relatif masih sama atau lebih tinggi dibandingkan *prior*-nya.

> **Hal inilah yang membedakan *Bayesian* dengan *Frequentist*. Kita
> menggunakan *posterior* tahun sebelumnya menjadi *prior* pada tahun
> itu. Sehingga penurunan *awareness rate* yang terjadi pada tahun itu
> tidak serta merta menurunkan distribusi *posterior*.**

Kita **bisa melihat dan menghitung probabilitas terjadinya perubahan
*awareness rate*** (baik kenaikan atau penurunan). Sehingga kita bisa
menentukan **apakah variasi yang terjadi sebenarnya masih berada di area
yang *aman atau tidak***.

Untuk itu, saya menggunakan **simulasi Monte Carlo** dari informasi
tabel sebelumnya. Berikut hasil perhitungannya:

| year_from | year_to | prob_increase | mean_increase |   ci_lower |  ci_upper |
|----------:|--------:|--------------:|--------------:|-----------:|----------:|
|      2020 |    2021 |       0.67798 |     0.0220628 | -0.0781814 | 0.1162835 |
|      2021 |    2022 |       0.68052 |     0.0175621 | -0.0590190 | 0.0922593 |
|      2022 |    2023 |       0.45746 |    -0.0037749 | -0.0677451 | 0.0601192 |
|      2023 |    2024 |       0.77306 |     0.0216000 | -0.0352697 | 0.0777651 |
|      2024 |    2025 |       0.61818 |     0.0080082 | -0.0442391 | 0.0600947 |

Perhatikan tabel di atas dengan seksama. Ternyata hampir setiap tahun,
*probability awareness rate increase* selalu berada di atas **60%**
kecuali pada tahun 2022 ke 2023.

- Pada 2020 ke 2021, ada peluang **67%** *awareness rate* meningkat
  dengan *expected* peningkatan sebesar **2.2%**.
- Pada 2021 ke 2022, ada peluang **68%** *awareness rate* meningkat
  dengan *expected* peningkatan sebesar **1.7%**.
- Pada 2022 ke 2023, ada peluang **45%** *awareness rate* meningkat
  dengan *expected* perubahan sebesar **-0.3%**.
  - Pada tahun 2022 ke 2023, kita bisa menyimpulkan bahwa *awareness
    rate* stagnan (tidak berubah).
- Pada 2023 ke 2024, ada peluang **77%** *awareness rate* meningkat
  dengan *expected* peningkatan sebesar **2.1%**.
  - Pada tahun 2023 ke 2024 terjadi peluang peningkatan *awareness rate*
    yang besar.
- Pada 2024 ke 2025, ada peluang **61%** *awareness rate* meningkat
  dengan *expected* peningkatan sebesar **0.8%**.
  - Pada tahun 2024 ke 2025, kita bisa menyimpulkan bahwa *awareness
    rate* stagnan (tidak berubah).

Berikut jika saya tampilan dalam bentuk grafik:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-13-1.png)

Kita bisa melihat bahwa 2023 ke 2024, peningkatan *awareness rate* yang
terjadi berada di luar *credible interval*. Sedangkan penurunan pada
2023 dan 2025 masih masuk ke dalam *credible interval*.

Berikutnya saya akan lakukan analisa peningkatan *awareness rate* secara
kumulatif dari 2020 ke 2025.

    === IMPROVEMENT 2020-2025 ===
    Absolute Increase:
    Mean: 0.065 
    95% CI: [ -0.025 , 0.146 ]
    P(Increase > 0): 0.9243 

    Relative Increase:
    Mean: 1.368 x
    95% CI: [ 0.911 , 2.067 ]x

    Probabilitas Melebihi Threshold:
    P(Increase > 0.10): 0.2147
    P(Increase > 0.15): 0.0197
    P(Increase > 0.20): 0.0001
    P(Increase > 0.25): 0.0000

Kita bisa lihat bahwa *expected value* untuk peningkatan *awareness
rate* 2020 ke 2025 sebesar **6.5%** dengan peluang terjadi peningkatan
sebesar **92.43%**.

*Expected value* perubahan relatifnya sebesar **1.368 kali**.

> Artinya rata-rata *awareness rate* pada tahun 2025 adalah 1.368 kali
> dar *awareness rate* 2020.

- Peluang peningkatan *awareness rate* melebihi 10% adalah sebesar
  **21%**.
- Peluang peningkatan *awareness rate* melebihi 15% adalah sebesar
  **1.9%**.
- Peluang peningkatan *awareness rate* melebihi 20% ke atas adalah
  sebesar **0%**.
  - Artinya kecil kemungkinan *awareness rate* 2020 - 2025 naik melebihi
    20% ke atas.

## Bagaimana untuk *Forecast* 2026?

Dengan menggunakan *posterior* 2025 sebagai *prior* 2026, saya bisa
menghitung *expected value* untuk *awareness rate* di tahun 2026. Lalu
apakah mungkin kita memberikan *target* *awareness rate* 2026 sebesar
50%?

Berikut analisanya:

    === FORECAST 2026 ===
    Expected Awareness: 0.271 
    95% Predictive Interval: [ 0.236 , 0.307 ]

    Probabilitas Mencapai Target 2026:
    P(Awareness > 0.10): 1.0000
    P(Awareness > 0.25): 0.8752
    P(Awareness > 0.30): 0.0563
    P(Awareness > 0.40): 0.0000
    P(Awareness > 0.50): 0.0000

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayesian_survey/draft_files/figure-commonmark/unnamed-chunk-15-1.png)

*Awareness rate* pada 2026 diperkirakan sebesar **27.1%** dengan
*predictive interval* antara **23.6% - 30.7%**.

- Peluang *awareness rate* 2026 berada di atas 10% adalah 100%.
  - Artinya model sangat yakin bahwa *awareness rate* pada 2026 minimal
    mencapai 10%.
- Peluang *awareness rate* 2026 berada di atas 25% adalah 87%.
  - Artinya besar peluang *awareness rate* 2026 berada di atas 25%.
- Peluang *awareness rate* 2026 berada di atas 30% adalah 5%.
- Peluang *awareness rate* 2026 berada di atas 40% adalah 0%.

> **Tidak mungkin *awareness rate* 2026 mencapai 50%**.


---
  
`if you find this article helpful, support this blog by clicking the ads.`
