---
date: 2025-03-05T12:47:00-04:00
title: "Practical Guide to Build Mixed-Marketing-Model"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - DALEX
  - Responsible AI
  - TensorFlow
  - Neural Network
  - Deep Learning
  - Regression
  - Modelling
  - Interpretable Machine Learning
  - Marketing
  - Sales
  - Mix Marketing Model
  - Business
---

Sebenarnya tulisan ini masih *nyambung* dengan tulisan saya sebelumnya
di [sini](https://ikanx101.com/blog/akurat-jelek/). *hehe*

Beberapa pekan terakhir saya sedang berkutat tentang bagaimana membuat
*mixed-marketing-model* (MMM) untuk beberapa *brand* di kantor. Apa itu
MMM?

> MMM (atau sering disebut juga sebagai *marketing mix*), adalah sebuah
> *framework* atau konsep dasar dalam pemasaran yang mengidentifikasi
> dan menggabungkan berbagai elemen pemasaran yang dapat dikendalikan
> oleh perusahaan untuk mempengaruhi konsumen dan mencapai tujuan
> pemasaran mereka. Tujuan utamanya adalah untuk menciptakan kombinasi
> elemen pemasaran yang paling efektif dan efisien dalam mencapai target
> pasar yang dituju.

Dalam konteks *mixed marketing*, kita seringkali ingin memahami
bagaimana perubahan pada elemen-elemen *marketing mix* dapat
mempengaruhi hasil pemasaran, seperti penjualan, pangsa pasar, atau
kesadaran merek. Untuk menganalisis hubungan ini secara kuantitatif,
kita dapat menggunakan teknik regresi.

**Regresi** adalah metode statistik yang digunakan untuk memodelkan
hubungan antara satu variabel dependen (variabel yang ingin dijelaskan
atau diprediksi, misalnya penjualan) dengan satu atau lebih variabel
independen (variabel yang dianggap mempengaruhi variabel dependen,
misalnya belanja iklan, harga, atau promosi).

Berdasarkan informasi di atas, kelak saya hendak membuat model yang
tujuannya adalah menghubungkan *predictors* (variabel-variabel
*marketing* berupa *spending*) terhadap nilai *sales*-nya.

Saya akan berikan salah satu *guide* sederhana untuk membuat model
tersebut. Oleh karena tak mungkin saya menggunakan data yang ada di
perusahaan saya, maka saya akan gunakan data contoh yang ada di
`library(datarium)`.

------------------------------------------------------------------------

Sebagai langkah awal, saya akan panggil *libraries* yang diperlukan:

``` r
# load libraries yang dibutuhkan

# dplyr: manipulasi data efisien (filter, sort, group)
library(dplyr)

# datarium: dataset latihan & analisis statistik dasar
library(datarium)

# PerformanceAnalytics: analisis kinerja aset keuangan & visualisasi portofolio
library(PerformanceAnalytics)

# forecast: peramalan data deret waktu (time series)
library(forecast)

# DALEX: untuk explainable AI
library(DALEX)

# ggfortify: visualisasi time series
library(ggfortify)
par(mfrow=c(1,1)) # reset to 1 chart per page
```

Berikut adalah proses memasukkan data ke dalam *environment* R:

``` r
# data(marketing) - Memuat dataset 'marketing' yang tersedia di dalam library 'datarium' (jika library sudah terinstall).
data(marketing)

# sampledf = marketing - Membuat dataframe baru bernama 'sampledf' dan mengisinya dengan data dari dataset 'marketing'.
sampledf = marketing

# str(sampledf) - Menampilkan struktur dari dataframe 'sampledf', termasuk tipe data setiap kolom dan contoh datanya.
str(sampledf)
```

    'data.frame':   200 obs. of  4 variables:
     $ youtube  : num  276.1 53.4 20.6 181.8 217 ...
     $ facebook : num  45.4 47.2 55.1 49.6 13 ...
     $ newspaper: num  83 54.1 83.2 70.2 70.1 ...
     $ sales    : num  26.5 12.5 11.2 22.2 15.5 ...

Berikut adalah sampel 10 data teratas yang saya gunakan.

``` r
#|eecho: false
sampledf %>% head(10) %>% knitr::kable()
```

| youtube | facebook | newspaper | sales |
|--------:|---------:|----------:|------:|
|  276.12 |    45.36 |     83.04 | 26.52 |
|   53.40 |    47.16 |     54.12 | 12.48 |
|   20.64 |    55.08 |     83.16 | 11.16 |
|  181.80 |    49.56 |     70.20 | 22.20 |
|  216.96 |    12.96 |     70.08 | 15.48 |
|   10.44 |    58.68 |     90.00 |  8.64 |
|   69.00 |    39.36 |     28.20 | 14.16 |
|  144.24 |    23.52 |     13.92 | 15.84 |
|   10.32 |     2.52 |      1.20 |  5.76 |
|  239.76 |     3.12 |     25.44 | 12.72 |

Kita bisa lihat bahwa ada empat variabel, yakni:

1.  `sales`: merupakan nilai penjualan yang hendak dijadikan variabel
    dependen (target prediksi model).
2.  `youtube`: merupakan nilai *spending* perusahaan saat melakukan
    *campaign* di **Youtube**.
3.  `facebook`: merupakan nilai *spending* perusahaan saat melakukan
    *campaign* di **Facebook**.
4.  `newspaper`: merupakan nilai *spending* perusahaan saat melakukan
    *campaign* di **koran**.

Satu baris data ini merepresentasikan satu pekan. Total saya mendapatkan
200 baris (pekan) buah data.

Perhatikan bahwa saya tidak memiliki data aktivitas kompetitor saat
membuat MMM ini.

Sekarang kita akan cek korelasi antar variabel yang ada pada data:

``` r
chart.Correlation(sampledf, histogram = TRUE, pch=19)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-5-1.png)

Kita bisa lihat dari grafik di atas bahwa *spending youtube* memiliki
korelasi positif yang kuat terhadap *sales*. Sedangkan dua variabel
lainnya memiliki korelasi yang sedang (*spending facebook*) dan lemah
(*spending* koran).

*Nah*, sebelum membuat model regresinya, setidaknya ada dua hal yang
harus kita lakukan yakni:

1.  Menghitung *adstock*.
2.  Melakukan dekomposisi terhadap *sales*.

Mari kita bahas satu-persatu.

## *Adstock*

**Definisi** ***Adstock***:

*Adstock*, dalam konteks *marketing* dan terutama MMM, adalah sebuah
teknik transformasi yang digunakan untuk memodelkan efek jangka panjang
atau efek kumulatif dari iklan atau aktivitas *marketing* terhadap
perilaku konsumen. Secara sederhana, *adstock* mencoba untuk
merepresentasikan bagaimana efek iklan tidak langsung hilang sepenuhnya
setelah iklan tersebut berhenti ditayangkan. Sebaliknya, efeknya bisa
bertahan atau bahkan berakumulasi dari waktu ke waktu.

**Konsep Dasar** ***Adstock***:

Bayangkan kita melihat iklan televisi untuk sebuah produk minuman
energi. Efek iklan tersebut tidak hanya terjadi saat kita menontonnya.
Mungkin beberapa hari kemudian, saat kita berada di toko dan melihat
minuman energi tersebut, iklan yang pernah kita lihat akan kembali
teringat dan mempengaruhi keputusan kita untuk membeli.

> Inilah inti dari *adstock*: efek iklan “membekas” dan bertahan.

*Adstock* mencoba memodelkan efek “bekas” ini dengan dua parameter
utama:

1.  *Decay Rate* (Tingkat Peluruhan): Ini menggambarkan seberapa cepat
    efek iklan memudar seiring waktu. *Decay rate* biasanya
    direpresentasikan sebagai nilai antara 0 dan 1.
    - Nilai *decay rate* tinggi (mendekati 1): Menunjukkan efek iklan
      bertahan lama dan memudar dengan sangat lambat. Efek iklan hari
      ini masih akan sangat terasa di hari-hari mendatang.
    - Nilai *decay rate* rendah (mendekati 0): Menunjukkan efek iklan
      cepat memudar. Efek iklan hari ini hampir hilang sepenuhnya dalam
      waktu singkat.
2.  *Lag* (Keterlambatan): Ini menggambarkan seberapa cepat efek iklan
    mulai terasa setelah iklan ditayangkan. *Lag* merepresentasikan
    penundaan waktu antara paparan iklan dan efek yang dihasilkan.
    - *Lag* tinggi (misalnya, 2 minggu): Menunjukkan efek iklan baru
      akan signifikan setelah beberapa waktu (dalam contoh ini, 2
      minggu) setelah penayangan iklan. Ini bisa terjadi untuk produk
      yang pembeliannya memerlukan pertimbangan lebih lama.
    - *Lag* rendah (misalnya, 0 atau 1 minggu): Menunjukkan efek iklan
      hampir langsung terasa atau dengan keterlambatan yang sangat
      singkat. Ini mungkin terjadi untuk produk yang pembeliannya
      impulsif atau segera dibutuhkan.

**Bagaimana** ***Adstock*** **Bekerja secara Matematis (Konsep
Sederhana)**:

Secara matematis, *adstock* mengubah input iklan mentah (misalnya,
*spending* iklan mingguan) menjadi output iklan yang “di-adstock” yang
merepresentasikan efek kumulatif.

Rumus sederhananya adalah sebagai berikut:

![Adstocked \space Advertising_t = Advertising_t +](https://latex.codecogs.com/svg.latex?Adstocked%20%5Cspace%20Advertising_t%20%3D%20Advertising_t%20%2B "Adstocked \space Advertising_t = Advertising_t +")
![Decay \space Rate \times](https://latex.codecogs.com/svg.latex?Decay%20%5Cspace%20Rate%20%5Ctimes "Decay \space Rate \times")
![Adstocked \space Advertising\_{t-1}](https://latex.codecogs.com/svg.latex?Adstocked%20%5Cspace%20Advertising_%7Bt-1%7D "Adstocked \space Advertising_{t-1}")

Dimana:

- $Adstocked$ $Advertising_t$ : Nilai iklan yang sudah di-_adstock_ pada periode waktu $t$ (misalnya, pekan ini). Ini merepresentasikan efek kumulatif iklan hingga periode $t$.

- $Advertising_t$ : Nilai iklan mentah pada periode waktu $t$ (misalnya, _spending_ iklan minggu ini).

- $Decay \space Rate$ : Tingkat peluruhan (nilai antara 0 dan 1).

- $Adstocked$ $Advertising_{t-1}$ : Nilai iklan yang sudah di-_adstock_ pada periode waktu sebelumnya ($t-1$, misalnya, minggu lalu).

**Contoh Ilustrasi**

Misalkan *decay rate* adalah 0.8 dan *lag* adalah 0.

| Minggu ke- | Pengeluaran Iklan Mentah | Iklan yang Di-Adstock (Efek Kumulatif) |
|:-----------|:-------------------------|:---------------------------------------|
| 1          | 100                      | 100                                    |
| 2          | 200                      | 200 + (0.8 \* 100) = 280               |
| 3          | 0                        | 0 + (0.8 \* 280) = 224                 |
| 4          | 0                        | 0 + (0.8 \* 224) = 179.2               |
| 5          | 150                      | 150 + (0.8 \* 179.2) = 293.36          |

**Mengapa** ***Adstock*** **Penting dalam MMM?**

Untuk memahami bagaimana berbagai *channel* *marketing* (TV, digital,
*print*, dll.) berkontribusi terhadap penjualan atau metrik *marketing*
lainnya. Jika kita hanya menggunakan data pengeluaran iklan mentah, kita
mungkin **meremehkan efek jangka panjang** iklan dan membuat keputusan
yang kurang optimal.

*Adstock* membantu mengatasi masalah ini dengan:

- **Memodelkan Efek Jangka Panjang:** *Adstock* memungkinkan model untuk
  menangkap efek iklan yang bertahan lama dan efek kumulatif.
- **Alokasi Anggaran yang Lebih Akurat:** Dengan memahami efek jangka
  panjang, pemasar dapat membuat keputusan alokasi anggaran yang lebih
  baik antar saluran *marketing*. Misalnya, jika iklan TV memiliki
  *decay rate* yang tinggi, mungkin investasi di TV perlu
  dipertimbangkan untuk efek jangka panjangnya.
- **Pengukuran ROI yang Lebih Realistis:** *Adstock* membantu menghitung
  *Return on Investment* (ROI) yang lebih akurat karena memperhitungkan
  efek jangka panjang dari investasi *marketing*.

**Tantangan dan Pertimbangan dalam Menggunakan** ***Adstock***:

- **Pemilihan Parameter *Decay Rate* dan *Lag*:** Menentukan nilai
  *decay rate* dan *lag* yang tepat adalah tantangan. Ini sering
  dilakukan melalui analisis statistik, optimasi model, atau pengetahuan
  domain (pemahaman tentang industri dan perilaku konsumen). Nilai yang
  salah dapat menghasilkan model yang kurang akurat.
- **Penyederhanaan Realitas:** Adstock adalah penyederhanaan dari efek
  iklan yang kompleks di dunia nyata. Efek iklan bisa dipengaruhi oleh
  banyak faktor lain (konteks iklan, kreativitas, pesan, kondisi pasar,
  dll.) yang tidak secara langsung dimasukkan dalam model adstock
  sederhana.
- **Interpretasi:** Meskipun adstock membantu memodelkan efek jangka
  panjang, interpretasi parameter *decay rate* dan *lag* harus dilakukan
  dengan hati-hati dan berdasarkan konteks bisnis.

## Kembali ke MMM Saya

Sekarang saya akan definisikan *decay rate* dan *lag* dari masing-masing
*spending*:

### *Adstock Spending Facebook*

Misalkan *rate* dan *lag* sebagai berikut:

``` r
# set adstock fb rate
set_rate_fb    = 0.15
set_memory     = 3
get_adstock_fb = rep(set_rate_fb, set_memory+1) ^ c(0:set_memory)

# adstocked fb
ads_fb = stats::filter(c(rep(0, set_memory), sampledf$facebook), 
                       get_adstock_fb,
                       method="convolution")
ads_fb = ads_fb[!is.na(ads_fb)]
#plot
plot(seq(1,length(sampledf$facebook)), 
     sampledf$facebook, type="h", 
     main = "Adstocked Facebook",
     xlab="Time (Weeks)", ylab="Facebook", 
     ylim=c(0, max(c(sampledf$facebook, ads_fb))), 
     frame.plot=FALSE)
lines(ads_fb, col="blue")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-6-1.png)

Warna *bar* abu-abu itu adalah *spending* aslinya sedangkan garis biru
adalah *adstock*-nya.

### *Adstock Spending Youtube*

Misalkan *rate* dan *lag* sebagai berikut:

``` r
# set adstock youtube rate
set_rate_yt         = 0.25
set_memory          = 2
get_adstock_youtube = rep(set_rate_yt, set_memory+1) ^ c(0:set_memory)

# adstocked youtube
ads_youtube <- stats::filter(c(rep(0, set_memory), 
                               sampledf$youtube), 
                             get_adstock_youtube, 
                             method="convolution")
ads_youtube <- ads_youtube[!is.na(ads_youtube)]
#plot
plot(seq(1,length(sampledf$youtube)), sampledf$youtube, type="h", 
     main = "Adstocked Youtube", 
     xlab="Time (Weeks)", ylab="Youtube", 
     ylim=c(0, max(c(sampledf$youtube, ads_youtube))), 
     frame.plot=FALSE)
lines(ads_youtube, col="blue")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-7-1.png)

Warna *bar* abu-abu itu adalah *spending* aslinya sedangkan garis biru
adalah *adstock*-nya.

### *Adstock Spending* Koran

Misalkan *rate* dan *lag* sebagai berikut:

``` r
# set adstock koran
set_rate_news    = 0.2
set_memory       = 1
get_adstock_news = rep(set_rate_news, set_memory+1) ^ c(0:set_memory)

#adstocked newpaper
ads_news <- stats::filter(c(rep(0, set_memory), sampledf$newspaper), 
                          get_adstock_news, 
                          method="convolution")
ads_news <- ads_news[!is.na(ads_news)]
#plot
plot(seq(1,length(sampledf$newspaper)), sampledf$newspaper, type="h", 
     main = "Adstocked Newspaper",
     xlab="Time (Weeks)", ylab="Newspaper", 
     ylim=c(0, max(c(sampledf$newspaper, ads_news))), 
     frame.plot=FALSE)
lines(ads_news, col="blue")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-8-1.png)

Warna *bar* abu-abu itu adalah *spending* aslinya sedangkan garis biru
adalah *adstock*-nya.

**Catatan:** Perlu diingat bahwa besaran *decay rate* dan *lag* ini
merupakan justifikasi subjektif saya pribadi.

Kelak nilai ketiga *adstock* ini akan dijadikan *predictors* pada model
saya. *Nah*, saya masih belum bisa membuat modelnya karena ada
dekomposisi yang harus dilakukan.

Saya jelaskan dulu ya:

## Dekomposisi

**Apa itu Dekomposisi *Time Series*?**

Dekomposisi *time series* adalah sebuah teknik statistik yang bertujuan
untuk **memisahkan suatu deret waktu menjadi beberapa komponen dasar
yang mendasarinya.** Ide utama di balik dekomposisi adalah bahwa banyak
deret waktu dipengaruhi oleh berbagai jenis pola yang bekerja secara
bersamaan. Dengan memisahkan deret waktu menjadi komponen-komponen ini,
kita dapat memahami perilaku data dengan lebih baik, melakukan peramalan
(*forecasting*) yang lebih akurat, dan mengidentifikasi faktor-faktor
utama yang memengaruhi data tersebut.

**Komponen-Komponen dalam Dekomposisi *Time Series***

Secara umum, deret waktu dapat diuraikan menjadi empat komponen utama:

1.  **Tren (*Trend*) (T):**
    - **Definisi:** Tren adalah **arah jangka panjang pergerakan data**.
      Ini merepresentasikan kecenderungan data untuk naik atau turun
      secara bertahap selama periode waktu yang panjang.
    - **Karakteristik:** Tren bisa linear (garis lurus), non-linear
      (kurva), atau bahkan tidak ada tren sama sekali (stasioner).
2.  **Musiman (*Seasonality*) (S):**
    - **Definisi:** Musiman adalah **pola berulang yang terjadi dalam
      periode waktu tetap (kurang dari satu tahun)**. Pola ini teratur
      dan dapat diprediksi.
    - **Karakteristik:** Periode musiman bisa harian, mingguan, bulanan,
      kuartalan, atau bahkan jam-jaman, tergantung pada data.
3.  **Residu/Irreguler (*Residual/Irregular*) (R atau I):**
    - **Definisi:** Residu atau irreguler adalah **fluktuasi acak atau
      sisa** dalam deret waktu yang tidak dapat dijelaskan oleh tren dan
      musiman. Ini adalah komponen yang “tersisa” setelah
      komponen-komponen lainnya dihilangkan.
    - **Karakteristik:** Residu bersifat **acak, tidak berpola, dan
      tidak dapat diprediksi**. Mereka bisa disebabkan oleh kejadian tak
      terduga, *noise* acak dalam data, atau faktor-faktor lain yang
      tidak sistematis.

**Model Dekomposisi: Aditif vs. Multiplikatif**

Ada dua model dasar untuk menggabungkan komponen-komponen ini dalam
dekomposisi *time series*:

1.  **Model Aditif:**
    - **Asumsi:** Model aditif mengasumsikan bahwa komponen-komponen
      **beroperasi secara independen dan saling menambah** untuk
      membentuk deret waktu asli. Besarnya variasi musiman dan siklikal
      diasumsikan **konstan** sepanjang waktu (tidak bergantung pada
      tingkat tren).
    - **Rumus:**
      ![Y_t = T_t + S_t + R_t](https://latex.codecogs.com/svg.latex?Y_t%20%3D%20T_t%20%2B%20S_t%20%2B%20R_t "Y_t = T_t + S_t + R_t"),
      dimana:
      - ![Y_t](https://latex.codecogs.com/svg.latex?Y_t "Y_t") adalah
        nilai deret waktu pada waktu
        ![t](https://latex.codecogs.com/svg.latex?t "t").
      - ![T_t](https://latex.codecogs.com/svg.latex?T_t "T_t") adalah
        komponen tren pada waktu
        ![t](https://latex.codecogs.com/svg.latex?t "t").
      - ![S_t](https://latex.codecogs.com/svg.latex?S_t "S_t") adalah
        komponen musiman pada waktu
        ![t](https://latex.codecogs.com/svg.latex?t "t").
      - ![R_t](https://latex.codecogs.com/svg.latex?R_t "R_t") adalah
        komponen residu pada waktu
        ![t](https://latex.codecogs.com/svg.latex?t "t").
    - **Kapan Menggunakan:** Model aditif cocok digunakan **ketika
      variasi musiman cenderung konstan** sepanjang waktu. Jika
      amplitudo fluktuasi musiman tampak sama dari tahun ke tahun, model
      aditif mungkin lebih tepat.
2.  **Model Multiplikatif:**
    - **Asumsi:** Model multiplikatif mengasumsikan bahwa
      komponen-komponen **berinteraksi secara perkalian** untuk
      membentuk deret waktu asli. Besarnya variasi musiman dan siklikal
      diasumsikan **proporsional dengan tingkat tren**. Artinya,
      fluktuasi musiman menjadi lebih besar seiring dengan meningkatnya
      tren.
    - **Rumus:**
      ![Y_t = T_t \times S_t \times R_t](https://latex.codecogs.com/svg.latex?Y_t%20%3D%20T_t%20%5Ctimes%20S_t%20%5Ctimes%20R_t "Y_t = T_t \times S_t \times R_t").
      Dalam praktiknya, seringkali residu dianggap aditif setelah
      komponen perkalian tren dan musim dihitung:
      ![Y_t = T_t \times S_t + R_t](https://latex.codecogs.com/svg.latex?Y_t%20%3D%20T_t%20%5Ctimes%20S_t%20%2B%20R_t "Y_t = T_t \times S_t + R_t").
      Dalam banyak implementasi, logaritma seringkali digunakan untuk
      mengubah model multiplikatif menjadi aditif agar lebih mudah
      diolah:
      ![\log Y_t = \log  T_t + \log  S_t + \log R_t](https://latex.codecogs.com/svg.latex?%5Clog%20Y_t%20%3D%20%5Clog%20%20T_t%20%2B%20%5Clog%20%20S_t%20%2B%20%5Clog%20R_t "\log Y_t = \log  T_t + \log  S_t + \log R_t")

**Metode Dekomposisi *Time Series***

Ada berbagai metode untuk melakukan dekomposisi *time series*, beberapa
yang umum digunakan adalah:

- **Metode *Moving Average* (Rata-Rata Bergerak):** Metode klasik yang
  menggunakan rata-rata bergerak untuk menghaluskan deret waktu dan
  memperkirakan komponen tren dan siklikal. Perbedaan antara data asli
  dan tren yang dihaluskan dapat digunakan untuk memperkirakan komponen
  musiman dan residu.
- **Dekomposisi Klasik (*Classical Decomposition*):** Metode tradisional
  yang secara iteratif memperkirakan tren, musiman, dan residu, biasanya
  menggunakan *moving average*.
- **Dekomposisi X-12-ARIMA dan X-13ARIMA-SEATS:** Metode yang lebih
  canggih dan kompleks yang dikembangkan oleh biro statistik pemerintah.
  Metode ini menggunakan model ARIMA untuk memperkirakan komponen dan
  melakukan penyesuaian musiman yang lebih baik.
- **STL Decomposition (*Seasonal-Trend decomposition using Loess*):**
  Metode yang fleksibel dan non-parametrik yang menggunakan *Loess
  smoothing* untuk memperkirakan komponen tren dan musiman. STL sangat
  *robust* dan dapat menangani berbagai jenis pola musiman dan tren.

Saya biasa menggunakan metode dekomposisi **STL** dalam membuat model
ini.

## Kembali ke MMM Saya

Sekarang saya kembali ke MMM saya. Saya akan lakukan dekomposisi **STL**
berikut ini:

``` r
# menjadikan data sale sebagai data time series
ts_sales = ts(sampledf$sales, start = 1, frequency = 52)

# proses dekomposisi
ts_sales_comp = decompose(ts_sales)

# membuat plot hasil dekomposisi
plot(ts_sales_comp)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-9-1.png)

*Nah*, kita bisa langsung memasukkan **tren** dan ***seasonal*** ke
dalam formula regresi dengan memanfaatkan regresi *time series* berikut:

``` r
mmm = tslm(ts_sales ~ trend + season + ads_youtube + ads_fb + ads_news)
```

Berikut adalah modelnya:

``` r
summary(mmm)
```


    Call:
    tslm(formula = ts_sales ~ trend + season + ads_youtube + ads_fb + 
        ads_news)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -6.6705 -1.2561  0.1645  1.1913  5.2308 

    Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept)  4.394921   1.419739   3.096 0.002361 ** 
    trend       -0.001389   0.003004  -0.462 0.644491    
    season2     -3.283051   1.671006  -1.965 0.051372 .  
    season3     -4.772560   1.680490  -2.840 0.005165 ** 
    season4     -0.443229   1.675516  -0.265 0.791747    
    season5     -3.351891   1.703129  -1.968 0.050980 .  
    season6     -3.338681   1.672397  -1.996 0.047782 *  
    season7     -2.312783   1.668595  -1.386 0.167869    
    season8     -2.512588   1.675669  -1.499 0.135945    
    season9     -3.027241   1.715969  -1.764 0.079826 .  
    season10    -2.589644   1.695440  -1.527 0.128851    
    season11    -4.521732   1.675292  -2.699 0.007785 ** 
    season12    -2.901122   1.676115  -1.731 0.085619 .  
    season13    -2.735845   1.673517  -1.635 0.104278    
    season14    -2.609654   1.711382  -1.525 0.129482    
    season15    -1.518637   1.680042  -0.904 0.367543    
    season16    -1.437310   1.676105  -0.858 0.392577    
    season17    -2.224864   1.680856  -1.324 0.187717    
    season18    -1.985392   1.669729  -1.189 0.236377    
    season19    -4.082424   1.688759  -2.417 0.016882 *  
    season20    -1.705967   1.668993  -1.022 0.308422    
    season21    -3.470948   1.668128  -2.081 0.039229 *  
    season22    -3.794410   1.706138  -2.224 0.027707 *  
    season23    -5.510085   1.685307  -3.269 0.001348 ** 
    season24    -3.092446   1.690983  -1.829 0.069501 .  
    season25    -0.753341   1.695507  -0.444 0.657481    
    season26    -3.239208   1.697747  -1.908 0.058389 .  
    season27    -6.150158   1.698532  -3.621 0.000406 ***
    season28    -1.650416   1.688782  -0.977 0.330068    
    season29    -4.667271   1.674485  -2.787 0.006033 ** 
    season30    -2.682661   1.673568  -1.603 0.111135    
    season31    -3.157445   1.682497  -1.877 0.062591 .  
    season32    -3.626435   1.675122  -2.165 0.032045 *  
    season33    -3.311589   1.676387  -1.975 0.050131 .  
    season34    -3.041631   1.681903  -1.808 0.072623 .  
    season35    -3.637651   1.693921  -2.147 0.033429 *  
    season36    -2.419783   1.678537  -1.442 0.151586    
    season37    -1.221599   1.681219  -0.727 0.468641    
    season38    -1.908240   1.675577  -1.139 0.256654    
    season39    -2.436735   1.674111  -1.456 0.147697    
    season40    -0.833914   1.701813  -0.490 0.624869    
    season41    -0.866910   1.688839  -0.513 0.608516    
    season42    -2.049580   1.683668  -1.217 0.225470    
    season43    -3.171217   1.685675  -1.881 0.061953 .  
    season44    -3.853573   1.681557  -2.292 0.023375 *  
    season45    -5.381981   1.812316  -2.970 0.003494 ** 
    season46    -2.385669   1.810362  -1.318 0.189668    
    season47    -1.909030   1.814213  -1.052 0.294441    
    season48    -2.184477   1.801666  -1.212 0.227316    
    season49    -4.706593   1.828831  -2.574 0.011076 *  
    season50    -1.931106   1.823133  -1.059 0.291271    
    season51    -5.156586   1.833145  -2.813 0.005595 ** 
    season52    -4.448833   1.837067  -2.422 0.016692 *  
    ads_youtube  0.043165   0.001816  23.764  < 2e-16 ***
    ads_fb       0.181060   0.011642  15.552  < 2e-16 ***
    ads_news    -0.010976   0.007811  -1.405 0.162141    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 2.353 on 144 degrees of freedom
    Multiple R-squared:  0.8978,    Adjusted R-squared:  0.8587 
    F-statistic: 22.99 on 55 and 144 DF,  p-value: < 2.2e-16

Perhatikan bahwa muncul 51 buah variabel `seasonal` secara otomatis dari
model. Kenapa hal tersebut terjadi? Berikut adalah penjelasannya:

> When using the “seasonal” variable within the tslm() function in R, it
> automatically generates multiple variables representing each distinct
> season within your data (like months in a year or quarters),
> essentially acting as dummy variables to capture the unique seasonal
> effects on your time series, which is why you see many “season”
> variables in the model summary; each variable corresponds to a
> different season.

Berikut adalah kesimpulannya:

1.  Seberapa bagus model bisa dilihat dari *Adjusted*
    ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2"), yakni
    sebesar
    ![0.8587](https://latex.codecogs.com/svg.latex?0.8587 "0.8587").
    Sebuah nilai yang lebih dari cukup (*menurut saya*).
2.  Jika dilihat, hanya *spending* di *Youtube* dan *Facebook* yang
    menghasilkan efek positif terhadap nilai *sales*.
3.  Variabel *seasonal* pada **3, 11, 23, 27, 29, 45, dan 51** bernilai
    negatif serta signifikan (ditandai dengan `***` di *output* **R**).
    Artinya *seasonal* pada pekan tersebut menurun sebesar konstanta
    masing-masing variabel dibanding pekan pertama.

## Implikasi MMM

Setelah kita berhasil membuat model ini, lantas apa implikasinya? Kita
bisa melakukan prediksi untuk data *spending* yang berbeda.

Misalkan saya menyakini bahwa model tersebut benar, bagaimana jika pada
periode sebelumnya saya pindahkan *budget* *spending* koran ke
*Facebook* sebesar 70% dan *Youtube* sebesar 30%. Berapa nilai *sales*
yang terjadi?

``` r
# pindahkan budget dari koran ke Facebook
fb_spend           = as.data.frame(ads_fb)
names(fb_spend)[1] = "ads_fb"
fb_spend$ads_fb    = fb_spend$ads_fb + (ads_news*0.7)

# pindahkan budget dari koran ke Youtube
yt_spend             = as.data.frame(ads_youtube)
names(yt_spend)[1]   = "ads_youtube"
yt_spend$ads_youtube = yt_spend$ads_youtube + (ads_news*0.3)

# spending untuk koran habis
final_news_spend           = as.data.frame(ads_news * 0)
names(final_news_spend)[1] = "ads_news"

# kita gabungkan menjadi satu data frame baru
new_spends = cbind(yt_spend, fb_spend,final_news_spend)

# membuat prediksi
forecast_new_spends <- forecast(mmm, newdata=new_spends)

# membuat visualisasinya
ggplot2::autoplot(forecast_new_spends, 
                  ts.colour = 'black', 
                  size= 0.5, 
                  predict.size = 0.7, 
                  predict.colour = 'blue', 
                  conf.int = TRUE, 
                  conf.int.fill = 'blue', 
                  main = "Biru Prediksi - Hitam Existing")
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-12-1.png)

Secara visual kita bisa lihat bahwa terjadi kenaikan besaran *sales*
secara keseluruhan. Tentunya kita bisa menghitung berapa besaran
*spending* yang optimal dari model tersebut untuk masing-masing
*marketing channel*.

------------------------------------------------------------------------

## Catatan

Cara yang saya tulis ini adalah satu dari sekian banyak cara untuk
membangun MMM. Tentunya kita bisa menggunakan model regresi lain seperti
*ridge regression* untuk mengakali *multicollinearity*. Jika saya tak
salah, regresi menggunakan *TensorFlow* merupakan *ridge regression*.
Kita juga bisa membuat model non linear lain dan bisa di-*explain*
dengan `DALEX.`

------------------------------------------------------------------------

## Alternatif Model untuk MMM

Saya akan mencoba membuat MMM menggunakan model regresi multivariat
polinom dan menjelaskannya menggunakan `library(DALEX)`.

Berikut adalah skrip untuk membuat modelnya:

``` r
seasonal = ts_sales_comp$seasonal %>% as.numeric()
tren     = ts_sales_comp$trend %>% as.numeric()

tren[is.na(tren)] = 0

df_input = data.frame(sales = sampledf$sales,
                      tren,seasonal,ads_youtube,ads_fb,ads_news)

mmm_2 = lm(sales ~ poly(tren,3) + poly(seasonal,3) + poly(ads_youtube,3) +
                   poly(ads_fb,3) + poly(ads_news,3),
           data = df_input)
```

Mari kita lihat performa model dengan cara membuat *explainer* dari
`DALEX`:

``` r
explainer_mmm = DALEX::explain(model = mmm_2,
                               data  = df_input,
                               y     = df_input$sales,
                               type  = "regression",
                               label = "MMM Regression",
                               colorize = FALSE)
```

    Preparation of a new explainer is initiated
      -> model label       :  MMM Regression 
      -> data              :  200  rows  6  cols 
      -> target variable   :  200  values 
      -> predict function  :  yhat.lm  will be used (  default  )
      -> predicted values  :  No value for predict function target column. (  default  )
      -> model_info        :  package stats , ver. 4.4.2 , task regression (  default  ) 
      -> model_info        :  type set to  regression 
      -> predicted values  :  numerical, min =  1.379737 , mean =  16.827 , max =  28.39422  
      -> residual function :  difference between y and yhat (  default  )
      -> residuals         :  numerical, min =  -5.684697 , mean =  -2.60239e-15 , max =  5.100158  
      A new explainer has been created!  

``` r
performa_model = model_performance(explainer_mmm)
performa_model
```

    Measures for:  regression
    mse        : 4.35231 
    rmse       : 2.086219 
    r2         : 0.8884122 
    mad        : 1.459815

    Residuals:
             0%         10%         20%         30%         40%         50% 
    -5.68469654 -2.60340244 -1.65185871 -1.19602457 -0.53560198  0.09104982 
            60%         70%         80%         90%        100% 
     0.57693674  1.04047269  1.77166132  2.49011437  5.10015835 

Kita bisa melihat bahwa
![R^2 = 0.8884122](https://latex.codecogs.com/svg.latex?R%5E2%20%3D%200.8884122 "R^2 = 0.8884122"),
yakni lebih tinggi dibandingkan model linear di awal. Mari kita lihat
*variable importance*:

``` r
var_importante  = model_parts(explainer_mmm)
plot_importance = plot(var_importante,show_boxplots = FALSE)
plot_importance
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-15-1.png)

Kita mendapatkan temuan yang serupa dengan temuan sebelumnya di mana
*spending* di *Youtube* dan *Facebook* memiliki tingkat pengaruh yang
lebih tinggi dibandingkan koran. Sekarang kita akan lihat pengaruh
detail per variabel:

``` r
mp_mmm = model_profile(explainer_mmm, 
                        variable =  c("ads_youtube","ads_fb","ads_news"), 
                        type = "accumulated")
plot(mp_mmm)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-16-1.png)

Kita bisa lihat bahwa:

1.  *Facebook Spending* memiliki hubungan yang positif walau sempat ada
    penurunan di *range* nilai kecil.
2.  *Spending* koran justru memiliki hubungan negatif. Semakin besar,
    justru hasilnya tidak memperbaiki *sales*.
3.  *Youtube Spending* memiliki hubungan yang positif dengan peningkatan
    yang signifikan. Namun perlu dilihat bahwa peningkatan signifikan
    ini hanya berlaku pada nilai *spending* yang lebih besar
    dibandingkan kedua *channel marketing* lainnya.

Sekarang saya akan coba lihat dua kondisi *sales*:

1.  Saat *sales* tertinggi.
2.  Saat *sales* terendah.

Apa yang menjadi penyebabnya?

### Saat *Sales* Tertinggi

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-17-1.png)

### Saat *Sales* Terendah

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-18-1.png)

Kita bisa lihat bahwa *spending Youtube* menjadi hal yang krusial. Saat
*spending*-nya rendah, ternyata efeknya malah menurunkan *sales*. Oleh
karena itu, **kita perlu menjaga agar** ***spending*** **Youtube selalu
berada di level tertinggi**.

Bagaimana jika perusahaan tidak memiliki *budget spending*?

``` r
df_in = data.frame(tren = 0,seasonal = 0,ads_youtube = 200,ads_fb = 0,ads_news = 0)
ronaldo = predict_parts(explainer_mmm, df_in)
plot(ronaldo)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/practical%20mmm/post_files/figure-commonmark/unnamed-chunk-19-1.png)

Perusahaan masih bisa mendapatkan *sales* dan ternyata koran
menghasilkan hasil yang positif saat tidak ada *spending*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
