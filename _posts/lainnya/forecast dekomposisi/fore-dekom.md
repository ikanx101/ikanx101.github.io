---
title: "Membuat Forecast yang Menghemat 8 Miliar dalam 3 Bulan"
date: 2023-01-20T14:41:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Forecast
  - Time Series
  - Decomposition
---

Pada akhir 2021 lalu, saya diminta oleh salah seorang rekan saya di pabrik untuk membantunya mengerjakan algoritma _auto replenishment_ untuk semua gudang yang di-_provide_ oleh perusahaan saya se-Indonesia.

Hal ini dia perlukan karena proses yang _existing_ saat itu sangat melelahkan baginya dan tim.

## _Existing Process_

Setiap pagi, rekan saya dan timnya harus mengambil berbagai data dari beberapa portal aplikasi internal untuk kemudian memutuskan produk mana yang harus dikirim, berapa dan kapan.

Oleh karena produk yamg kami produksi sangat banyak dan gudang _provider_ (begitu kami menyebutnya) juga ada di tiap kota besar, maka proses ini sangat melelahkan. Tidak jarang ditemukan kesalahan karena faktor _human_.

---

## Algoritma _Auto Replenishment_

Setelah mencari tahu bagaimana _business process_ di _workcenter_ rekan saya tersebut, saya coba memulai untuk membuat algoritma. Ternyata, 90% dari porsi total pengerjaan ini adalah:

> ___Bagaimana membuat forecast produk yang akurat?___

Jadi tujuannya sekarang berubah. Pada awalnya adalah __otomasi__, sekarang jadi ___forecasting___. 

Lantas bagaimana cara saya membuat algoritmanya?

## Membuat Algoritma

Saya memiliki data jualan harian per-masing-masing gudang _provider_ sejak tahun 2018. _Fyi_, produk yang saya kerjakan ada sekitar 200 buah produk.

Dari data tersebut, sudah jelas bahwa data ini termasuk ke dalam data _time series_. Oleh karena itu _forecast_-nya pun harus menggunakan teknik-teknik yang ada pada _time series_.

Berbagai model seperti ARIMA, _exponential smoothing_, _TBATS_, dan sebagainya saya coba untuk melakukan _forecast_. Namun hasilnya tidak memuaskan. Ada produk-produk yang bagus _forecast_-nya, ada juga produk-produk yang tidak bagus _forecast_-nya.

Lantas, salah seorang rekan tim saya memberikan ide yang brilian:

> _Bagaimana jika kita menggunakan prinsip time series decomposition? Tapi berdasarkan data yang sudah dihilangkan pencilannya. Kelak kita akan gunakan nilai trend sebagai basis angka forecast_

Sebuah ide "liar" yang menurut saya layak dicoba. Dengan proses ini, menurut saya hasilnya kelak akan lebih cocok karena perlakukan untuk masing-masing produk jadinya lebih _customize_ dan sesuai.

Bagi rekan-rekan yang belum tahu, prinsip dari _time series decomposition_ adalah memecah data time series menjadi 3 komponen:

1. _Trend_,
1. _Seasonal_,
1. _Random noise_.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/price%20elasticity/post%201/post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" style="display: block; margin: auto;" />
