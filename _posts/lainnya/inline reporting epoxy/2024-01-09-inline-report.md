---
title: "Tutorial R: <i>Inline Reporting</i> dengan library(epoxy)"
date: 2024-01-09T09:09:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Reporting
  - Automation
  - EPOXY
  - Coding
---


Salah satu kelebihan **R** dalam membuat *report* adalah *coding*-nya.
*Lho, kok bisa?*

> *Coding* ini memungkinkan kita membuat *report* lebih cepat daripada
> biasanya karena lebih *reproducible*!

Sebagai contoh, kita bisa membuat kalimat yang berisi informasi yang
“masih bisa berubah-ubah” karena datanya dinamis. Jadi tidak harus
menuliskan perubahannya, cukup *coding*-nya saja dan isi kalimatnya akan
berubah juga mengikuti datanya.

------------------------------------------------------------------------

# Contoh Kasus

## Data yang Digunakan

Sebagai contoh di *blog* ini, saya akan memiliki data sebagai berikut:

| nama                | merek    |  mpg | cyl |  disp |  hp | drat |    wt |  qsec |  vs |  am | gear | carb |
|:--------------------|:---------|-----:|----:|------:|----:|-----:|------:|------:|----:|----:|-----:|-----:|
| Mazda RX4           | Mazda    | 21.0 |   6 | 160.0 | 110 | 3.90 | 2.620 | 16.46 |   0 |   1 |    4 |    4 |
| Mazda RX4 Wag       | Mazda    | 21.0 |   6 | 160.0 | 110 | 3.90 | 2.875 | 17.02 |   0 |   1 |    4 |    4 |
| Datsun 710          | Datsun   | 22.8 |   4 | 108.0 |  93 | 3.85 | 2.320 | 18.61 |   1 |   1 |    4 |    1 |
| Hornet 4 Drive      | Hornet   | 21.4 |   6 | 258.0 | 110 | 3.08 | 3.215 | 19.44 |   1 |   0 |    3 |    1 |
| Hornet Sportabout   | Hornet   | 18.7 |   8 | 360.0 | 175 | 3.15 | 3.440 | 17.02 |   0 |   0 |    3 |    2 |
| Valiant             | Valiant  | 18.1 |   6 | 225.0 | 105 | 2.76 | 3.460 | 20.22 |   1 |   0 |    3 |    1 |
| Duster 360          | Duster   | 14.3 |   8 | 360.0 | 245 | 3.21 | 3.570 | 15.84 |   0 |   0 |    3 |    4 |
| Merc 240D           | Merc     | 24.4 |   4 | 146.7 |  62 | 3.69 | 3.190 | 20.00 |   1 |   0 |    4 |    2 |
| Merc 230            | Merc     | 22.8 |   4 | 140.8 |  95 | 3.92 | 3.150 | 22.90 |   1 |   0 |    4 |    2 |
| Merc 280            | Merc     | 19.2 |   6 | 167.6 | 123 | 3.92 | 3.440 | 18.30 |   1 |   0 |    4 |    4 |
| Merc 280C           | Merc     | 17.8 |   6 | 167.6 | 123 | 3.92 | 3.440 | 18.90 |   1 |   0 |    4 |    4 |
| Merc 450SE          | Merc     | 16.4 |   8 | 275.8 | 180 | 3.07 | 4.070 | 17.40 |   0 |   0 |    3 |    3 |
| Merc 450SL          | Merc     | 17.3 |   8 | 275.8 | 180 | 3.07 | 3.730 | 17.60 |   0 |   0 |    3 |    3 |
| Merc 450SLC         | Merc     | 15.2 |   8 | 275.8 | 180 | 3.07 | 3.780 | 18.00 |   0 |   0 |    3 |    3 |
| Cadillac Fleetwood  | Cadillac | 10.4 |   8 | 472.0 | 205 | 2.93 | 5.250 | 17.98 |   0 |   0 |    3 |    4 |
| Lincoln Continental | Lincoln  | 10.4 |   8 | 460.0 | 215 | 3.00 | 5.424 | 17.82 |   0 |   0 |    3 |    4 |
| Chrysler Imperial   | Chrysler | 14.7 |   8 | 440.0 | 230 | 3.23 | 5.345 | 17.42 |   0 |   0 |    3 |    4 |
| Fiat 128            | Fiat     | 32.4 |   4 |  78.7 |  66 | 4.08 | 2.200 | 19.47 |   1 |   1 |    4 |    1 |
| Honda Civic         | Honda    | 30.4 |   4 |  75.7 |  52 | 4.93 | 1.615 | 18.52 |   1 |   1 |    4 |    2 |
| Toyota Corolla      | Toyota   | 33.9 |   4 |  71.1 |  65 | 4.22 | 1.835 | 19.90 |   1 |   1 |    4 |    1 |
| Toyota Corona       | Toyota   | 21.5 |   4 | 120.1 |  97 | 3.70 | 2.465 | 20.01 |   1 |   0 |    3 |    1 |
| Dodge Challenger    | Dodge    | 15.5 |   8 | 318.0 | 150 | 2.76 | 3.520 | 16.87 |   0 |   0 |    3 |    2 |
| AMC Javelin         | AMC      | 15.2 |   8 | 304.0 | 150 | 3.15 | 3.435 | 17.30 |   0 |   0 |    3 |    2 |
| Camaro Z28          | Camaro   | 13.3 |   8 | 350.0 | 245 | 3.73 | 3.840 | 15.41 |   0 |   0 |    3 |    4 |
| Pontiac Firebird    | Pontiac  | 19.2 |   8 | 400.0 | 175 | 3.08 | 3.845 | 17.05 |   0 |   0 |    3 |    2 |
| Fiat X1-9           | Fiat     | 27.3 |   4 |  79.0 |  66 | 4.08 | 1.935 | 18.90 |   1 |   1 |    4 |    1 |
| Porsche 914-2       | Porsche  | 26.0 |   4 | 120.3 |  91 | 4.43 | 2.140 | 16.70 |   0 |   1 |    5 |    2 |
| Lotus Europa        | Lotus    | 30.4 |   4 |  95.1 | 113 | 3.77 | 1.513 | 16.90 |   1 |   1 |    5 |    2 |
| Ford Pantera L      | Ford     | 15.8 |   8 | 351.0 | 264 | 4.22 | 3.170 | 14.50 |   0 |   1 |    5 |    4 |
| Ferrari Dino        | Ferrari  | 19.7 |   6 | 145.0 | 175 | 3.62 | 2.770 | 15.50 |   0 |   1 |    5 |    6 |
| Maserati Bora       | Maserati | 15.0 |   8 | 301.0 | 335 | 3.54 | 3.570 | 14.60 |   0 |   1 |    5 |    8 |
| Volvo 142E          | Volvo    | 21.4 |   4 | 121.0 | 109 | 4.11 | 2.780 | 18.60 |   1 |   1 |    4 |    2 |

## *Summary* dari Data

Dari data di atas, saya akan buat beberapa *summary* sebagai berikut:

``` r
df_sum_all = 
  df %>% 
  summarise(banyak_data  = length(nama),
            banyak_merek = length(unique(merek)),
            mean_mpg     = mean(mpg) %>% round(2),
            range_hp     = max(hp) - min(hp)
            )

df_sum_all %>% knitr::kable()
```

| banyak_data | banyak_merek | mean_mpg | range_hp |
|------------:|-------------:|---------:|---------:|
|          32 |           22 |    20.09 |      283 |

Dari data *summary* di atas, jika saya hendak membuat satu paragraf
kesimpulan menggunakan **R**, biasanya saya menuliskannya sebagai
berikut:

------------------------------------------------------------------------

``` r
# Data tersebut memiliki `r df_sum_all$banyak_data` baris, 

# berisi `r df_sum_all$banyak_merek` buah merek mobil. 

# Rata-rata konsumsi bahan bakarnya semua mobil tersebut adalah `r df_sum_all$mean_mpg` mean per gallon. 

# Rentang horse power dari semua mobil tersebut adalah `r df_sum_all$range_hp`.
```

Hasilnya sebagai berikut:

> Data tersebut memiliki 32 baris, berisi 22 buah merek mobil. Rata-rata
> konsumsi bahan bakarnya semua mobil tersebut adalah 20.09 *mean per
> gallon*. Rentang *horse power* dari semua mobil tersebut adalah 283.

------------------------------------------------------------------------

Untuk menghasilkan tulisan seperti di atas, kita bisa menggunakan
`library(epoxy)` sebagai berikut:

``` r
# ```{epoxy .data = df_sum_all}

# Data tersebut memiliki {banyak_data} baris, 

# berisi {banyak_merek} buah merek mobil. 

# Rata-rata konsumsi bahan bakarnya semua mobil tersebut adalah {mean_mpg} *mean per gallon*. 

# Rentang *horse power* dari semua mobil tersebut adalah {range_hp}.

# ```
```

Hasilnya sebagai berikut:

Data tersebut memiliki 32 baris, berisi 22 buah merek mobil. Rata-rata
konsumsi bahan bakarnya semua mobil tersebut adalah 20.09 *mean per
gallon*. Rentang *horse power* dari semua mobil tersebut adalah 283.

------------------------------------------------------------------------

## *Another Advantages*

Salah satu kelebihan `epoxy` adalah dalam hal repetisinya. Misal saya
memiliki data *summary* sebagai berikut:

``` r
df_sum = 
  df %>% 
  group_by(merek) %>% 
  summarise(banyak_data  = length(nama),
            mean_mpg     = mean(mpg) %>% round(2)
            ) %>% 
  ungroup() %>% 
  filter(banyak_data > 1)

df_sum %>% knitr::kable()
```

| merek  | banyak_data | mean_mpg |
|:-------|------------:|---------:|
| Fiat   |           2 |    29.85 |
| Hornet |           2 |    20.05 |
| Mazda  |           2 |    21.00 |
| Merc   |           7 |    19.01 |
| Toyota |           2 |    27.70 |

Jika saya buat skrip `epoxy`-nya berikut:

``` r
# ```{epoxy .data = df_sum}
# 1. Merek mobil {merek} berisi {banyak_data} baris data dengan rata-rata konsumsi bahan 
# bakar sebesar {mean_mpg} *miles per gallon*.
# ```
```

Hasilnya berikut:

1.  Merek mobil Fiat berisi 2 baris data dengan rata-rata konsumsi bahan
    bakar sebesar 29.85 *miles per gallon*.
2.  Merek mobil Hornet berisi 2 baris data dengan rata-rata konsumsi
    bahan bakar sebesar 20.05 *miles per gallon*.
3.  Merek mobil Mazda berisi 2 baris data dengan rata-rata konsumsi
    bahan bakar sebesar 21 *miles per gallon*.
4.  Merek mobil Merc berisi 7 baris data dengan rata-rata konsumsi bahan
    bakar sebesar 19.01 *miles per gallon*.
5.  Merek mobil Toyota berisi 2 baris data dengan rata-rata konsumsi
    bahan bakar sebesar 27.7 *miles per gallon*.

Semoga berguna!

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
