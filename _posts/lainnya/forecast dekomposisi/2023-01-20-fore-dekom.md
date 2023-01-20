---
title: "Membuat Forecast Sales yang Menghemat 8 Miliar Rupiah!"
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

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/forecast%20dekomposisi/decomposition.png" width="500" style="display: block; margin: auto;" />

Sumber gambar: [https://otexts.com/fpp2/stl.html#ref-Cleveland1990](https://otexts.com/fpp2/stl.html#ref-Cleveland1990)

---

## _Workflow_

Jadi cara kerja algoritma saya adalah sebagai berikut:

```
STEP 1
  Mengubah data jualan harian menjadi jualan bulanan.
  Cek sebaran data.
  Apakah ada pencilan?
    Jika Ada 
      Ganti dengan median
    Jika Tidak ada
      Lanjut

STEP 2
  Mengecek apakah data produk stasioner atau bukan.
  Jika stasioner
    Lanjut
  Jika tidak stasioner
    Hitung lag
    Gunakan lag untuk membuat time series baru (transformasi)

STEP 3
  Lakukan dekomposisi.
  Ambil nilai trend.
  Nilai forecast = mean(trend 6 bulan terakhir)
  Bandingkan nilai forecast dengan rata-rata sales 3 bulan terakhir
  Persentase selisih > 50%
    Jika Ya
      Apakah ada pencilan?
        Jika Ada 
            Ganti dengan median
        Jika Tidak ada
            Cek nilai max atau min data
      Ulangi STEP 3
    Jika tidak
        Lanjut

STEP 4
  Lakukan untuk semua produk
```

Sederhana bukan?

Mungkin kalian bertanya-tanya, kenapa saya harus menghilangkan pencilan atau bahkan nilai max atau min (walau bukan pencilan). Karena setelah dilakukan pre-analisis, ada beberapa kejadian pada saat pandemi di mana nilai _sales_ produk-produk menjadi sangat amat tinggi akibat adanya _special transaction order_ dari lembaga-lembaga tertentu.

---

## Hasil Akhir dan Implikasi

Setelah algoritma ini dijalankan secara resmi pada Q4 2022, kami melakukan _review_ pada Januari 2023 ini. Hasilnya cukup menggembirakan:

1. _Service level_ tetap terjaga di atas 92%. Artinya, hampir semua barang _ready_ di gudang _provider_ saat ada tarikan _sales_ konsumen. 
1. Penghematan biaya _overstock_ di gudang sebesar Rp 8 Miliar lebih! Ternyata setelah ditelaah, angka _forecast_ hasil algoritma kami bisa menekan banyaknya stok yang ada di gudang. Jika selama ini tim biasa membanjiri gudang dengan banyak barang sehingga biaya penyimpanan menjadi besar, kini barang yang disimpan sudah lebih "sedikit" namun tetap terjaga.

---

Sebuah perjalanan panjang yang luar biasa.

_Next_-nya kami hendak mencari faktor penyebab sebagian kecil produk-produk yang memiliki _service level_ di bawah 90%.