---
date: 2026-03-12T11:59:00-04:00
title: "Membangun Bayesian Mixed Marketing Model dengan R"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Regression
  - Modelling
  - Interpretable Machine Learning
  - Marketing
  - Sales
  - Mix Marketing Model
  - Business
  - STAN
  - Marketing Campaign
---

Dalam dua tahun terakhir, salah satu pekerjaan saya adalah membuat
*mixed marketing models* untuk beberapa *brands* dan *sub brands* di
kantor. Hal ini juga sudah pernah saya tuliskan dalam [beberapa artikel
di *blog*](https://ikanx101.com/tags/#mix-marketing-model). Jika
biasanya saya menggunakan *framework* **Robyn** buatan **META**, kali
ini saya akan gunakan pendekatan **Bayesian Mixed Marketing Model
(Bayesian MMM)** untuk membuat modelnya. Bagaimana caranya? *Yuk* kita
mulai.

------------------------------------------------------------------------

## **R** dan *Stan*

Saya akan menggunakan `library(brms)` di **R** untuk membuat *Bayesian
MMM*. Singkatnya, brms (singkatan dari *Bayesian Regression Models using
‘Stan’*) adalah *library* di **R** yang memungkinkan kita membangun
model statistik kompleks menggunakan logika *Bayesian* dengan *code*
yang simpel dan familiar. Oleh karena `brms` melakukan simulasi
(*MCMC*), proses *running* model biasanya memakan waktu lebih lama
(beberapa detik hingga hitungan jam) dibandingkan fungsi `lm()` yang
instan.

*Stan* adalah bahasa pemrograman tersendiri (berbasis **C++**) yang
dirancang khusus untuk mendefinisikan model statistik. Ia tidak hanya
digunakan di **R**, tapi juga di Python, Julia, dan MATLAB. Saat kita
menjalankan model di **R** menggunakan *Stan*, kode tersebut sebenarnya
dikompilasi menjadi program **C++** yang efisien. Inilah alasan mengapa
proses *running* model *Bayesian* seringkali membutuhkan waktu (karena
ada proses “memasak” kode terlebih dahulu).

## Contoh Kasus

Misalkan suatu *brand* melakukan tiga jenis *campaign*, yakni:

1.  TV *campaign*,
2.  *Social media* / *digital* *campaign*, dan
3.  *Offline campaign*.

Ketiga jenis campaign tersebut dicatat berapa besar *spending*-nya per
pekan dan dikumpulkan selama setahun (52 minggu). Kemudian data tersebut
disandingkan dengan data penjualan (*sales*) per pekan. Berikut adalah
datanya:

| week | tv_spend | digital_spend | offline_spend |    sales |
|-----:|---------:|--------------:|--------------:|---------:|
|    1 | 215.0310 |     249.73121 |      82.77731 | 1957.652 |
|    2 | 415.3221 |      80.47482 |     135.74553 | 1801.225 |
|    3 | 263.5908 |     190.23700 |     138.87696 | 1903.291 |
|    4 | 453.2070 |     101.63285 |      99.13555 | 1896.503 |
|    5 | 476.1869 |      81.88291 |      73.38967 | 1816.310 |
|    6 | 118.2226 |     238.32697 |      39.12231 | 1801.201 |
|    7 | 311.2422 |     273.76134 |     141.58897 | 2160.141 |
|    8 | 456.9676 |     143.61569 |      59.15976 | 1971.317 |
|    9 | 320.5740 |     216.27880 |      27.89367 | 2002.543 |
|   10 | 282.6459 |      73.71017 |     143.20450 | 1659.773 |
|   11 | 482.7333 |     145.99241 |     113.67752 | 2018.906 |
|   12 | 281.3337 |     118.59591 |      38.49826 | 1722.329 |
|   13 | 371.0283 |     253.66001 |      91.40701 | 2202.185 |
|   14 | 329.0534 |     162.12909 |     144.03186 | 1942.832 |
|   15 | 141.1699 |     252.51609 |      96.11284 | 1889.521 |
|   16 | 459.9300 |     253.09738 |      72.58634 | 2211.333 |
|   17 | 198.4351 |     248.58558 |     104.22615 | 2011.000 |
|   18 | 116.8238 |     159.95792 |      61.57668 | 1559.332 |
|   19 | 231.1683 |     238.61879 |      60.00360 | 2031.318 |
|   20 | 481.8015 |     207.30528 |      48.56979 | 2211.911 |
|   21 | 455.8157 |     227.54560 |      68.03355 | 2158.485 |
|   22 | 377.1214 |      50.15619 |     147.94850 | 1644.974 |
|   23 | 356.2027 |     168.82914 |      40.04630 | 1846.033 |
|   24 | 497.7079 |     105.02972 |      31.83572 | 1898.137 |
|   25 | 362.2823 |     144.95413 |      38.44790 | 1815.548 |
|   26 | 383.4122 |     203.19275 |     109.70092 | 2038.460 |
|   27 | 317.6264 |     137.94948 |     100.50334 | 1758.847 |
|   28 | 337.6568 |      77.78386 |     135.88124 | 1706.101 |
|   29 | 215.6639 |     110.90487 |     107.48988 | 1582.806 |
|   30 | 158.8455 |     217.01390 |     115.82011 | 1742.408 |
|   31 | 485.2097 |     154.41169 |      87.74764 | 2019.468 |
|   32 | 460.9196 |     247.04896 |     105.77900 | 2301.299 |
|   33 | 376.2821 |      75.71616 |     126.83471 | 1713.529 |
|   34 | 418.1870 |     158.72319 |     122.21660 | 2026.804 |
|   35 | 109.8455 |     296.23924 |     147.37685 | 1909.420 |
|   36 | 291.1184 |     273.26278 |      77.12610 | 2091.422 |
|   37 | 403.3838 |     271.61727 |      60.52129 | 2237.491 |
|   38 | 186.5632 |      93.76316 |      73.23174 | 1531.927 |
|   39 | 227.2724 |      82.67392 |      21.36072 | 1501.784 |
|   40 | 192.6503 |     213.27548 |      43.90044 | 1767.454 |
|   41 | 157.1200 |     135.87912 |     129.55481 | 1589.400 |
|   42 | 265.8185 |     214.18953 |      50.05103 | 1843.290 |
|   43 | 265.4897 |     130.09331 |      51.08299 | 1690.570 |
|   44 | 247.5382 |      96.92278 |      29.96985 | 1515.955 |
|   45 | 160.9779 |     245.57358 |      51.94408 | 1824.135 |
|   46 | 155.5224 |      73.39875 |     115.17758 | 1449.461 |
|   47 | 193.2136 |     166.69476 |     130.16891 | 1844.921 |
|   48 | 286.3850 |     177.87636 |      84.67854 | 1823.498 |
|   49 | 206.3891 |     199.99724 |      70.42817 | 1815.772 |
|   50 | 443.1311 |     133.20589 |      52.03837 | 1910.301 |
|   51 | 118.3325 |     172.15326 |      34.44254 | 1551.843 |
|   52 | 276.8800 |     288.61846 |      70.69928 | 2106.796 |

Berikut adalah grafik analisa deskriptif yang sudah dibuat:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/bayes_mmm/draft_files/figure-commonmark/unnamed-chunk-3-1.png)

Berikut adalah beberapa *summary statistics*:


    === SUMMARY STATISTICS ===

    Total Observations: 52 weeks


    Average Weekly Spending:

      TV: 303.79 

      Digital: 173.75 

      Offline: 84.69 

      Total: 562.22 


    Average Weekly Sales: 1865.94 

    Average Spend-to-Sales Ratio: 0.2983 


    Correlation Matrix:

                      tv_spend digital_spend offline_spend total_spend      sales
    tv_spend       1.000000000    -0.1905557   0.005208681   0.8206443 0.54720112
    digital_spend -0.190555687     1.0000000  -0.105231512   0.3247129 0.68798351
    offline_spend  0.005208681    -0.1052315   1.000000000   0.2444641 0.03853708
    total_spend    0.820644251     0.3247129   0.244464071   1.0000000 0.88044320
    sales          0.547201116     0.6879835   0.038537080   0.8804432 1.00000000

Temuan dari matriks korelasi:

- **Sales vs Digital**: 0.688 (korelasi kuat).
- **Sales vs TV**: 0.547 (korelasi sedang).
- **Sales vs Offline**: 0.039 (korelasi sangat lemah).

Untuk membangun model *Bayesian* MMM, saya akan menggunakan *Bayesian
linear regression*. Salah satu pembeda utama dari regresi ini
dibandingkan regresi linear biasa adalah **kita bisa memasukkan
informasi *prior* saat membangun model regresinya**.

Pada kasus ini, saya akan memasukkan *prior* sebagai berikut:

1.  *Intercept* atau nilai konstanta regresi berada pada rentang 100 -
    1000.
2.  Koefisien atau bobot masing-masing *campaign* dalam formula regresi
    berdistribusi lognormal.

**Rumus Model**: `sales ~ tv_spend + digital_spend + offline_spend`

Berikut adalah model MMM yang dihasilkan:

     Family: gaussian 
      Links: mu = identity 
    Formula: sales ~ tv_spend + digital_spend + offline_spend 
       Data: data_mmm (Number of observations: 52) 
      Draws: 4 chains, each with iter = 2000; warmup = 1000; thin = 1;
             total post-warmup draws = 4000

    Regression Coefficients:
                  Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
    Intercept       972.90     28.82   916.51  1029.59 1.00     4116     2282
    tv_spend          1.26      0.05     1.16     1.37 1.00     4213     2795
    digital_spend     2.59      0.09     2.42     2.77 1.00     4559     2686
    offline_spend     0.66      0.15     0.37     0.96 1.00     3991     2164

    Further Distributional Parameters:
          Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
    sigma    41.74      4.56    33.94    52.04 1.00     4196     2484

    Draws were sampled using sampling(NUTS). For each parameter, Bulk_ESS
    and Tail_ESS are effective sample size measures, and Rhat is the potential
    scale reduction factor on split chains (at convergence, Rhat = 1).

Sebelum membahas interpretasi dari model, saya akan bahas terlebih
dahulu *goodness of fit* dari model ini.

### Konvergensi Model (Diagnostik MCMC)

#### **R-hat Values (Semua *spending campaign* memberikan nilai 1.00)**

- **Interpretasi**: **Sempurna!**.
- **Implikasi**: Keempat *chain* *MCMC* telah konvergen ke distribusi
  *posterior* yang sama
- **Standar**: R-hat \< 1.1 dianggap konvergen; 1.00 adalah hasil ideal.

#### **Effective Sample Size (ESS)**

- **Bulk ESS**: Semua \> 3991 (sangat tinggi).
- **Tail ESS**: Semua \> 2164 (cukup tinggi).
- **Interpretasi**: Sample size efektif sangat memadai untuk estimasi
  yang *reliable*.
- **Rekomendasi**: ESS \> 400 per *chain* (kita punya \> 1000 per
  *chain*).

Setelah mengetahui bahwa model *Bayesian* MMM yang dihasilkan sudah
sangat baik performanya, berikut adalah interpretasi modelnya:

### Parameter Model yang Dihasilkan

#### **Intercept (972.90)**

- **Interpretasi**: Ketika semua pengeluaran marketing = 0, *baseline
  sales* adalah sekitar **973 unit**
- **Credible Interval 95%**: \[916.51, 1029.59\]. Dengan probabilitas
  95%, *baseline sales* berada dalam rentang ini.
- **Stabilitas**: **Rhat = 1.00** menunjukkan konvergensi sempurna.

#### **Koefisien Marketing Mix**

**a. Social Media / Digital Spending (2.59)**

- **Interpretasi**: Setiap **\$1** peningkatan pengeluaran digital
  menghasilkan peningkatan **2.59 unit** *sales*.
- **Efektivitas**: **Paling efektif** di antara semua *campaign*
  (koefisien tertinggi).
- **Credible Interval 95%**: \[2.42, 2.77\] - Efeknya sangat konsisten
  dan positif.
- **ROI Implisit**: Jika harga per unit diketahui, bisa dihitung ROI
  spesifik.

**b. TV Spending (1.26)**

- **Interpretasi**: Setiap **\$1** peningkatan pengeluaran TV
  menghasilkan peningkatan **1.26 unit** *sales*.
- **Efektivitas**: Peringkat kedua setelah digital.
- **Credible Interval 95%**: \[1.16, 1.37\] - Efek positif dan
  signifikan.

**c. Offline Spending (0.66)**

- **Interpretasi**: Setiap **\$1** peningkatan pengeluaran offline
  menghasilkan peningkatan **0.66 unit** *sales*.
- **Efektivitas**: **Paling rendah** di antara semua channel.
- **Credible Interval 95%**: \[0.37, 0.96\] - Rentang lebih lebar
  menunjukkan ketidakpastian lebih tinggi.

### Perbandingan Efektivitas Jenis *Campaign*

Berdasarkan koefisien:

1.  **Digital**: 2.59 (paling efektif)
2.  **TV**: 1.26 (efektivitas sedang)
3.  **Offline**: 0.66 (paling rendah)

***Digital campaign* 2x lebih efektif** daripada TV *campaign*, dan **4x
lebih efektif** daripada *offline campaign* dalam menghasilkan *sales*
per *spending* yang diinvestasikan.

### Error Term pada Model (sigma = 41.74)

- **Interpretasi**: Standar deviasi residual adalah **41.74 unit**.
- **Credible Interval 95%**: \[33.94, 52.04\].
- **Implikasi**: Model memiliki ketidakpastian sekitar ±41.74 unit dalam
  memprediksi *sales*.

### *Predictive Performance*

#### **Rata-rata Penjualan vs Prediksi**

- Rata-rata *actual sales* dari data 1865.94 unit.
- Rata-rata *predicted sales* bisa dihitung dari formula regresi yang
  dihasilkan, yakni dengan menghitung **Intercept + efek rata-rata
  spending**:
  - TV: 303.79 × 1.26 = 382.77
  - Digital: 173.75 × 2.59 = 450.01
  - Offline: 84.69 × 0.66 = 55.89
  - **Total prediksi**: 972.90 + 382.77 + 450.01 + 55.89 = **1861.57**
- Sehinga menghasilkan ***error* prediksi sebesar**: 1865.94 - 1861.57 =
  **4.37 unit** (hanya **0.23% *error***).

#### **Standard Error vs Variabilitas Data**

- **SD actual sales**: 212.44
- **SD residual (sigma)**: 41.74
- **Proporsi variabilitas yang dijelaskan**:
  - Variabilitas total: 212.44² = 45130
  - Variabilitas residual: 41.74² = 1742
  - **R² implisit**: 1 - (1742/45130) = **0.961** atau **96.1%**
  - **Interpretasi**: Model menjelaskan **96.1% variabilitas** dalam
    data penjualan.

Sekarang saya akan membuat simulasi untuk menghitung berapa peluang
*digital spend* **lebih efektif dalam menghasilkan *sales***
dibandingkan TV *spend*.

``` r
posterior_samples <- as_draws_df(model_mmm)

prob_digital_vs_tv <- mean(posterior_samples$b_digital_spend > posterior_samples$b_tv_spend)

print(paste0("Probabilitas Digital lebih efektif dari TV: ", prob_digital_vs_tv * 100, "%"))
```

    [1] "Probabilitas Digital lebih efektif dari TV: 100%"

Perhitungan tersebut mengkonfirmasi bukti yang sangat kuat untuk
mengalokasikan *budget* ke digital.

Beberapa strategi yang bisa dilakukan antara lain:

- **Prioritaskan Digital**: Alokasi terbesar karena ROI tertinggi.
  - **Digital** memiliki resiko rendah yang terlihat dari *credible
    interval* yang sempit (2.42-2.77).
- **Pertahankan TV**: Efektif tapi kurang dari digital.
- **Evaluasi Offline**: Pertimbangkan mengurangi atau mengoptimalkan.
  - **Offline** memiliki resiko tinggi yang terlihat dari *credible
    interval* yang lebar (0.37-0.96).


---
  
`if you find this article helpful, support this blog by clicking the ads.`

