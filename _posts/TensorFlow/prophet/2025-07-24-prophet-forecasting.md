---
date: 2025-07-24T20:55:00-04:00
title: "Belajar Time Series Forecasting Menggunakan Prophet Buatan Facebook (Meta)"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - TensorFlow
  - Prophet
  - Meta
  - Facebook
  - Neural Network
  - Deep Learning
  - Time Series
  - Forecast
---

Tahun 2023 yang lalu, saya pernah menuliskan bagaimana *model deep
learning* yang dibangun menggunakan *TensorFlow* bisa digunakan untuk
melakukan [*forecast* dari data *time
series*](https://ikanx101.com/blog/keras-forecast/). Kali ini saya akan
melakukan hal yang sama dengan metode yang berbeda.

Sebagaimana yang pernah saya tulis di
[sini](https://ikanx101.com/blog/meta-rob1n/), Meta memiliki beberapa
*libraries* yang bisa digunakan oleh semua *data scientist*. Salah
satunya adalah *prophet* yang biasa digunakan untuk melakukan analisa
*time series* seperti dekomposisi dan *forecast*.

------------------------------------------------------------------------

Data yang saya gunakan masih sama dengan tulisan saya yang lama.

| bulan | tahun |     omset | timeline |
|------:|------:|----------:|:---------|
|     1 |  2019 | 12.109286 | 1-2019   |
|     2 |  2019 | 11.134998 | 2-2019   |
|     3 |  2019 | 11.306951 | 3-2019   |
|     4 |  2019 | 10.627735 | 4-2019   |
|     5 |  2019 | 12.706164 | 5-2019   |
|     6 |  2019 |  8.461056 | 6-2019   |
|     7 |  2019 | 10.418129 | 7-2019   |
|     8 |  2019 | 10.693386 | 8-2019   |
|     9 |  2019 |  9.931742 | 9-2019   |
|    10 |  2019 | 10.134906 | 10-2019  |
|    11 |  2019 |  9.759191 | 11-2019  |
|    12 |  2019 |  9.220283 | 12-2019  |
|     1 |  2020 |  9.424254 | 1-2020   |
|     2 |  2020 |  9.652470 | 2-2020   |
|     3 |  2020 | 10.929961 | 3-2020   |
|     4 |  2020 | 10.522224 | 4-2020   |
|     5 |  2020 |  8.690728 | 5-2020   |
|     6 |  2020 | 11.384340 | 6-2020   |
|     7 |  2020 | 10.592765 | 7-2020   |
|     8 |  2020 |  9.446511 | 8-2020   |
|     9 |  2020 | 10.421095 | 9-2020   |
|    10 |  2020 |  9.964756 | 10-2020  |
|    11 |  2020 | 10.848913 | 11-2020  |
|    12 |  2020 | 11.337345 | 12-2020  |
|     1 |  2021 |  9.085644 | 1-2021   |
|     2 |  2021 |  9.203892 | 2-2021   |
|     3 |  2021 | 12.028427 | 3-2021   |
|     4 |  2021 | 12.540642 | 4-2021   |
|     5 |  2021 | 10.803806 | 5-2021   |
|     6 |  2021 | 11.576041 | 6-2021   |
|     7 |  2021 | 10.630560 | 7-2021   |
|     8 |  2021 | 12.123444 | 8-2021   |
|     9 |  2021 | 11.597485 | 9-2021   |
|    10 |  2021 | 11.467759 | 10-2021  |
|    11 |  2021 | 11.424983 | 11-2021  |
|    12 |  2021 | 10.390359 | 12-2021  |
|     1 |  2022 | 10.100890 | 1-2022   |
|     2 |  2022 | 10.063320 | 2-2022   |
|     3 |  2022 | 12.171718 | 3-2022   |
|     4 |  2022 | 12.967401 | 4-2022   |
|     5 |  2022 | 10.504940 | 5-2022   |
|     6 |  2022 | 11.451804 | 6-2022   |
|     7 |  2022 | 11.966286 | 7-2022   |
|     8 |  2022 | 12.137978 | 8-2022   |
|     9 |  2022 | 11.036515 | 9-2022   |
|    10 |  2022 | 11.668166 | 10-2022  |
|    11 |  2022 | 10.969599 | 11-2022  |
|    12 |  2022 | 10.536972 | 12-2022  |
|     1 |  2023 | 10.662826 | 1-2023   |
|     2 |  2023 |  9.870124 | 2-2023   |
|     3 |  2023 | 12.258235 | 3-2023   |
|     4 |  2023 |  9.736901 | 4-2023   |
|     5 |  2023 | 11.665639 | 5-2023   |

Saya memiliki 53 baris data omset bulanan mulai dari Januari 2019 hingga
Mei 2023.

Saya akan lakukan hal yang serupa, yakni melakukan *forecast* untuk
omset Januari - Mei 2023 dan kita bandingkan seberapa baik hasilnya.

Pertama-tama dari data di atas, saya akan ubah dulu menjadi bentuk
seperti ini:

| ds         |         y |
|:-----------|----------:|
| 2019-01-01 | 12.109286 |
| 2019-02-01 | 11.134998 |
| 2019-03-01 | 11.306951 |
| 2019-04-01 | 10.627735 |
| 2019-05-01 | 12.706164 |
| 2019-06-01 |  8.461056 |
| 2019-07-01 | 10.418129 |
| 2019-08-01 | 10.693386 |
| 2019-09-01 |  9.931742 |
| 2019-10-01 | 10.134906 |
| 2019-11-01 |  9.759191 |
| 2019-12-01 |  9.220283 |
| 2020-01-01 |  9.424254 |
| 2020-02-01 |  9.652470 |
| 2020-03-01 | 10.929961 |
| 2020-04-01 | 10.522224 |
| 2020-05-01 |  8.690728 |
| 2020-06-01 | 11.384340 |
| 2020-07-01 | 10.592765 |
| 2020-08-01 |  9.446511 |
| 2020-09-01 | 10.421095 |
| 2020-10-01 |  9.964756 |
| 2020-11-01 | 10.848913 |
| 2020-12-01 | 11.337345 |
| 2021-01-01 |  9.085644 |
| 2021-02-01 |  9.203892 |
| 2021-03-01 | 12.028427 |
| 2021-04-01 | 12.540642 |
| 2021-05-01 | 10.803806 |
| 2021-06-01 | 11.576041 |
| 2021-07-01 | 10.630560 |
| 2021-08-01 | 12.123444 |
| 2021-09-01 | 11.597485 |
| 2021-10-01 | 11.467759 |
| 2021-11-01 | 11.424983 |
| 2021-12-01 | 10.390359 |
| 2022-01-01 | 10.100890 |
| 2022-02-01 | 10.063320 |
| 2022-03-01 | 12.171718 |
| 2022-04-01 | 12.967401 |
| 2022-05-01 | 10.504940 |
| 2022-06-01 | 11.451804 |
| 2022-07-01 | 11.966286 |
| 2022-08-01 | 12.137978 |
| 2022-09-01 | 11.036515 |
| 2022-10-01 | 11.668166 |
| 2022-11-01 | 10.969599 |
| 2022-12-01 | 10.536972 |

Berikutnya saya akan buat model dan prediksinya dengan skrip yang
sederhana:

``` r
model        = prophet(df_)
df_2023      = make_future_dataframe(model, periods = 5, freq='month')
predict_2023 = predict(model, df_2023)
```

Ini adalah *plot* hasilnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/TensorFlow/prophet/draft_files/figure-commonmark/unnamed-chunk-5-1.png)

*Mean absolute error* yang dihasilkan adalah:

``` r
Metrics::mae(df$omset,
             predict_2023$yhat)
```

    [1] 0.5513065

Ternyata hasil MAE-nya relatif lebih rendah dari model LSTM yang saya
buat di [tulisan yang lalu](https://ikanx101.com/blog/keras-forecast/).

Berikut adalah hasil perbandingan antara hasil prediksi dan real omset
pada Januari - Mei 2023:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/TensorFlow/prophet/draft_files/figure-commonmark/unnamed-chunk-7-1.png)

Namun secara visual, kita bisa dapatkan nilai prediksinya relatif lebih
besar dibandingkan nilai *real*-nya dan pola yang dihasilkan tidak cukup
merepresentasikan pola *real*-nya.

Rekan-rekan bisa membandingkannya dengan grafik pada tulisan yang lama,
bahwa LSTM lebih baik mengenal pola *time series* pada kasus ini.

## Kesimpulan

Pada kasus ini, model yang dibangun menggunakan LSTM *deep learning* di
*TensorFlow* lebih baik dalam mengenali pola namun `prophet` menawarkan
proses skrip yang lebih mudah dan sederhana.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
