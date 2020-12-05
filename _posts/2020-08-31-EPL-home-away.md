---
date: 2020-08-31T05:00:00-04:00
title: "Sport Science: Premier League 2019/2020 Mitos Home vs Away"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Sport Science
  - Soccer
  - Football
  - t-Test
  - 2-proportion test
  - Premier League
  - R
---

Dalam sepakbola, seringkali saya mendengar mitos bahwa laga kandang
membawa keberuntungan dan *advantage(s)* bagi sebuah tim di **Premier
League** dibandingkan berlaga di tandang tim lawan. Dukungan fans yang
militan dengan jarak lapangan dengan *bench* yang relatif kecil membuat
tim tandang pastinya *jiper*.

Berbekal data yang dihimpun dari situs
[**football-data**](http://www.football-data.co.uk/englandm.php), saya
akan coba ulik datanya untuk membuktikan mitos *home vs away* tersebut.
Setidaknya ada dua cara saya membuktikan mitos tersebut, yakni:

1.  Membandingkan berapa banyak kemenangan yang diraih tim kandang vs
    tim tandang.
2.  Membandingkan goal yang dicetak tim kandang vs tim tandang.

## Data yang Digunakan

Berikut adalah data **English Premier League** musim 2019/2020:

| Div | Date       | Time  | HomeTeam       | AwayTeam         | FTHG | FTAG | FTR | HTHG | HTAG | HTR | Referee  | HS | AS | HST | AST | HF | AF | HC | AC | HY | AY | HR | AR | B365H | B365D | B365A |   BWH |  BWD |   BWA |   IWH |  IWD |   IWA |   PSH |  PSD |   PSA |   WHH | WHD |   WHA |   VCH | VCD |   VCA |  MaxH |  MaxD |  MaxA |  AvgH | AvgD |  AvgA | B365.2.5 | B365.2.5.1 | P.2.5 | P.2.5.1 | Max.2.5 | Max.2.5.1 | Avg.2.5 | Avg.2.5.1 |    AHh | B365AHH | B365AHA | PAHH | PAHA | MaxAHH | MaxAHA | AvgAHH | AvgAHA | B365CH | B365CD | B365CA |  BWCH | BWCD |  BWCA |  IWCH | IWCD |  IWCA |  PSCH |  PSCD |  PSCA |  WHCH | WHCD |  WHCA |  VCCH | VCCD |  VCCA | MaxCH | MaxCD | MaxCA | AvgCH | AvgCD | AvgCA | B365C.2.5 | B365C.2.5.1 | PC.2.5 | PC.2.5.1 | MaxC.2.5 | MaxC.2.5.1 | AvgC.2.5 | AvgC.2.5.1 |   AHCh | B365CAHH | B365CAHA | PCAHH | PCAHA | MaxCAHH | MaxCAHA | AvgCAHH | AvgCAHA |
| :-- | :--------- | :---- | :------------- | :--------------- | ---: | ---: | :-- | ---: | ---: | :-- | :------- | -: | -: | --: | --: | -: | -: | -: | -: | -: | -: | -: | -: | ----: | ----: | ----: | ----: | ---: | ----: | ----: | ---: | ----: | ----: | ---: | ----: | ----: | --: | ----: | ----: | --: | ----: | ----: | ----: | ----: | ----: | ---: | ----: | -------: | ---------: | ----: | ------: | ------: | --------: | ------: | --------: | -----: | ------: | ------: | ---: | ---: | -----: | -----: | -----: | -----: | -----: | -----: | -----: | ----: | ---: | ----: | ----: | ---: | ----: | ----: | ----: | ----: | ----: | ---: | ----: | ----: | ---: | ----: | ----: | ----: | ----: | ----: | ----: | ----: | --------: | ----------: | -----: | -------: | -------: | ---------: | -------: | ---------: | -----: | -------: | -------: | ----: | ----: | ------: | ------: | ------: | ------: |
| E0  | 09/08/2019 | 20:00 | Liverpool      | Norwich          |    4 |    1 | H   |    4 |    0 | H   | M Oliver | 15 | 12 |   7 |   5 |  9 |  9 | 11 |  2 |  0 |  2 |  0 |  0 |  1.14 | 10.00 | 19.00 |  1.14 | 8.25 | 18.50 |  1.15 | 8.00 | 18.00 |  1.15 | 9.59 | 18.05 |  1.12 | 8.5 | 21.00 |  1.14 | 9.5 | 23.00 |  1.16 | 10.00 | 23.00 |  1.14 | 8.75 | 19.83 |     1.40 |       3.00 |  1.40 |    3.11 |    1.45 |      3.11 |    1.41 |      2.92 | \-2.25 |    1.96 |    1.94 | 1.97 | 1.95 |   1.97 |   2.00 |   1.94 |   1.94 |   1.14 |   9.50 |  21.00 |  1.14 |  9.0 | 20.00 |  1.15 | 8.00 | 18.00 |  1.14 | 10.43 | 19.63 |  1.11 |  9.5 | 21.00 |  1.14 | 9.50 | 23.00 |  1.16 | 10.50 | 23.00 |  1.14 |  9.52 | 19.18 |       1.3 |        3.50 |   1.34 |     3.44 |     1.36 |       3.76 |     1.32 |       3.43 | \-2.25 |     1.91 |     1.99 |  1.94 |  1.98 |    1.99 |    2.07 |    1.90 |    1.99 |
| E0  | 10/08/2019 | 12:30 | West Ham       | Man City         |    0 |    5 | A   |    0 |    1 | A   | M Dean   |  5 | 14 |   3 |   9 |  6 | 13 |  1 |  1 |  2 |  2 |  0 |  0 | 12.00 |  6.50 |  1.22 | 11.50 | 5.75 |  1.26 | 11.00 | 6.10 |  1.25 | 11.68 | 6.53 |  1.26 | 13.00 | 6.0 |  1.24 | 12.00 | 6.5 |  1.25 | 13.00 |  6.75 |  1.29 | 11.84 | 6.28 |  1.25 |     1.44 |       2.75 |  1.49 |    2.77 |    1.51 |      2.77 |    1.48 |      2.65 |   1.75 |    2.00 |    1.90 | 2.02 | 1.90 |   2.02 |   1.92 |   1.99 |   1.89 |  12.00 |   7.00 |   1.25 | 11.00 |  6.0 |  1.26 | 11.00 | 6.10 |  1.25 | 11.11 |  6.68 |  1.27 | 11.00 |  6.5 |  1.24 | 12.00 | 6.50 |  1.25 | 13.00 |  7.00 |  1.29 | 11.14 |  6.46 |  1.26 |       1.4 |        3.00 |   1.43 |     3.03 |     1.50 |       3.22 |     1.41 |       2.91 |   1.75 |     1.95 |     1.95 |  1.96 |  1.97 |    2.07 |    1.98 |    1.97 |    1.92 |
| E0  | 10/08/2019 | 15:00 | Bournemouth    | Sheffield United |    1 |    1 | D   |    0 |    0 | D   | K Friend | 13 |  8 |   3 |   3 | 10 | 19 |  3 |  4 |  2 |  1 |  0 |  0 |  1.95 |  3.60 |  3.60 |  1.95 | 3.60 |  3.90 |  1.97 | 3.55 |  3.80 |  2.04 | 3.57 |  3.90 |  2.00 | 3.5 |  3.80 |  2.00 | 3.6 |  4.00 |  2.06 |  3.65 |  4.00 |  2.01 | 3.53 |  3.83 |     1.90 |       1.90 |  1.96 |    1.96 |    2.00 |      1.99 |    1.90 |      1.93 | \-0.50 |    2.01 |    1.89 | 2.04 | 1.88 |   2.04 |   1.91 |   2.00 |   1.88 |   1.95 |   3.70 |   4.20 |  1.95 |  3.6 |  3.90 |  1.97 | 3.55 |  3.85 |  1.98 |  3.67 |  4.06 |  1.95 |  3.6 |  3.90 |  2.00 | 3.60 |  4.00 |  2.03 |  3.70 |  4.20 |  1.98 |  3.58 |  3.96 |       1.9 |        1.90 |   1.94 |     1.97 |     1.97 |       1.98 |     1.91 |       1.92 | \-0.50 |     1.95 |     1.95 |  1.98 |  1.95 |    2.00 |    1.96 |    1.96 |    1.92 |
| E0  | 10/08/2019 | 15:00 | Burnley        | Southampton      |    3 |    0 | H   |    0 |    0 | D   | G Scott  | 10 | 11 |   4 |   3 |  6 | 12 |  2 |  7 |  0 |  0 |  0 |  0 |  2.62 |  3.20 |  2.75 |  2.65 | 3.20 |  2.75 |  2.65 | 3.20 |  2.75 |  2.71 | 3.31 |  2.81 |  2.70 | 3.2 |  2.75 |  2.70 | 3.3 |  2.80 |  2.80 |  3.33 |  2.85 |  2.68 | 3.22 |  2.78 |     2.10 |       1.72 |  2.17 |    1.77 |    2.20 |      1.78 |    2.12 |      1.73 |   0.00 |    1.92 |    1.98 | 1.93 | 2.00 |   1.94 |   2.00 |   1.91 |   1.98 |   2.70 |   3.25 |   2.90 |  2.65 |  3.1 |  2.85 |  2.60 | 3.20 |  2.85 |  2.71 |  3.19 |  2.90 |  2.62 |  3.2 |  2.80 |  2.70 | 3.25 |  2.90 |  2.72 |  3.26 |  2.95 |  2.65 |  3.18 |  2.88 |       2.1 |        1.72 |   2.19 |     1.76 |     2.25 |       1.78 |     2.17 |       1.71 |   0.00 |     1.87 |     2.03 |  1.89 |  2.03 |    1.90 |    2.07 |    1.86 |    2.02 |
| E0  | 10/08/2019 | 15:00 | Crystal Palace | Everton          |    0 |    0 | D   |    0 |    0 | D   | J Moss   |  6 | 10 |   2 |   3 | 16 | 14 |  6 |  2 |  2 |  1 |  0 |  1 |  3.00 |  3.25 |  2.37 |  3.20 | 3.20 |  2.35 |  3.10 | 3.20 |  2.40 |  3.21 | 3.37 |  2.39 |  3.10 | 3.3 |  2.35 |  3.20 | 3.3 |  2.45 |  3.21 |  3.40 |  2.52 |  3.13 | 3.27 |  2.40 |     2.20 |       1.66 |  2.23 |    1.74 |    2.25 |      1.74 |    2.18 |      1.70 |   0.25 |    1.85 |    2.05 | 1.88 | 2.05 |   1.88 |   2.09 |   1.84 |   2.04 |   3.40 |   3.50 |   2.25 |  3.30 |  3.3 |  2.25 |  3.40 | 3.30 |  2.20 |  3.37 |  3.45 |  2.27 |  3.30 |  3.3 |  2.25 |  3.40 | 3.30 |  2.25 |  3.55 |  3.50 |  2.34 |  3.41 |  3.37 |  2.23 |       2.2 |        1.66 |   2.22 |     1.74 |     2.28 |       1.77 |     2.17 |       1.71 |   0.25 |     1.82 |     2.08 |  1.97 |  1.96 |    2.03 |    2.08 |    1.96 |    1.93 |

Sampel Data EPL musim 2019/2020

-----

### 1\. Membandingkan Kemenangan Tim Kandang vs Tim Tandang

Hasil akhir suatu pertandingan sepak bola adalah kemenangan, kekalahan,
atau seri. Dari `380` laga yang terjadi selama musim 2019/2020, mari
kita lihat siapa yang menjadi pemenang dari laga home dan away:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-2-1.png" width="672" />

Ternyata `45.3%` dari laga yang ada pada musim lalu dimenangkan oleh tim
kandang. Jika kita cek menggunakan *2-proportion test*, maka:

Uji hipotesis:

1.  ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0"):
    ![proporsi\_{home} =
    proporsi\_{away}](https://latex.codecogs.com/png.latex?proporsi_%7Bhome%7D%20%3D%20proporsi_%7Baway%7D
    "proporsi_{home} = proporsi_{away}").
2.  ![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1"):
    ![proporsi\_{home} \\neq
    proporsi\_{away}](https://latex.codecogs.com/png.latex?proporsi_%7Bhome%7D%20%5Cneq%20proporsi_%7Baway%7D
    "proporsi_{home} \\neq proporsi_{away}").
3.  Jika
    ![p\_{-value}\< 0.05](https://latex.codecogs.com/png.latex?p_%7B-value%7D%3C%200.05
    "p_{-value}\< 0.05"), tolak
    ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0").

<!-- end list -->

    ## 
    ##  2-sample test for equality of proportions with continuity correction
    ## 
    ## data:  c(172, 116) out of c(380, 380)
    ## X-squared = 16.912, df = 1, p-value = 3.915e-05
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  0.07655688 0.21817996
    ## sample estimates:
    ##    prop 1    prop 2 
    ## 0.4526316 0.3052632

    ## [1] "Tolak H0"

Didapatkan nilai
![p\_{-value}](https://latex.codecogs.com/png.latex?p_%7B-value%7D
"p_{-value}") sebesar 410^{-5}. Oleh karena
![p\_{-value}\< 0.05](https://latex.codecogs.com/png.latex?p_%7B-value%7D%3C%200.05
"p_{-value}\< 0.05") artinya kita akan tolak
![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0").

> Kemenangan yang dirain tim kandang lebih banyak signifikan
> dibandingkan kemenangan yang diraih tim tandang (bahkan jika
> dibandingkan dengan seri).

-----

### 2\. Membandingkan Goal yang Dicetak Tim Kandang vs Tim Tandang.

Dari data di atas, jika saya kumpulkan dan hitung berapa banyak gol yang
dicetak masing-masing tim saat berlaga kandang dan tandang didapatkan
tabel sebagai berikut:

| teams            | home\_goal | away\_goal | total\_goals |
| :--------------- | ---------: | ---------: | -----------: |
| Man City         |         57 |         45 |          102 |
| Liverpool        |         52 |         33 |           85 |
| Chelsea          |         30 |         39 |           69 |
| Leicester        |         35 |         32 |           67 |
| Man United       |         40 |         26 |           66 |
| Tottenham        |         36 |         25 |           61 |
| Arsenal          |         36 |         20 |           56 |
| Southampton      |         21 |         30 |           51 |
| Wolves           |         27 |         24 |           51 |
| West Ham         |         30 |         19 |           49 |
| Everton          |         24 |         20 |           44 |
| Burnley          |         24 |         19 |           43 |
| Aston Villa      |         22 |         19 |           41 |
| Bournemouth      |         22 |         18 |           40 |
| Brighton         |         20 |         19 |           39 |
| Sheffield United |         24 |         15 |           39 |
| Newcastle        |         20 |         18 |           38 |
| Watford          |         22 |         14 |           36 |
| Crystal Palace   |         15 |         16 |           31 |
| Norwich          |         19 |          7 |           26 |

Perbandingan Goal Tim Saat Bermain Kandang dan Tandang

Tabel di atas jika disajikan dalam bentuk grafik, maka:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-5-1.png" width="672" />

Sekarang kita akan hitung, dari 20 tim liga Inggris tersebut, ada berapa
banyak tim yang:

  - Memiliki goal kandang lebih banyak daripada goal tandang.
  - Memiliki goal kandang yang lebih sedikit daripada goal tandang.
  - Memiliki goal kandang yang sama dengan goal tandang.

Lalu didapatkan grafik sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-6-1.png" width="672" />

Dari proporsi di atas, jika kita uji dengan *2-proportion test*
didapatan kesimpulan bahwa tim yang memiliki goal terbanyak saat laga
kandang `lebih banyak signifikan` dibandingkan dengan tim yang memiliki
goal terbanyak saat laga tandang.

> Bisa disimpulkan sementara bahwa mayoritas tim yang berlaga di kandang
> lebih tajam mencetak goal.

Sekarang mari kita bandingkan sebaran gol semua tim saat laga kandang
dan tandang:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-7-1.png" width="672" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-7-2.png" width="672" />

| Jenis Laga | Rata-Rata Goal | Standar Deviasi |
| :--------- | -------------: | --------------: |
| Away       |       1.205263 |        1.200252 |
| Home       |       1.515789 |        1.248646 |

Perbandingan Goal EPL

Terlihat bahwa laga kandang memiliki rata-rata goal lebih tinggi. Apakah
signifikan? Kita coba cek dengan **t-Test**.

Uji hipotesis:

1.  ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0"):
    ![mean(home) =
    mean(away)](https://latex.codecogs.com/png.latex?mean%28home%29%20%3D%20mean%28away%29
    "mean(home) = mean(away)").
2.  ![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1"):
    ![mean(home) \\neq
    mean(away)](https://latex.codecogs.com/png.latex?mean%28home%29%20%5Cneq%20mean%28away%29
    "mean(home) \\neq mean(away)").
3.  Jika
    ![p\_{-value}\< 0.05](https://latex.codecogs.com/png.latex?p_%7B-value%7D%3C%200.05
    "p_{-value}\< 0.05"), tolak
    ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0").

<!-- end list -->

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  data$fthg and data$ftag
    ## t = 3.495, df = 756.82, p-value = 0.0005016
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  0.1361081 0.4849446
    ## sample estimates:
    ## mean of x mean of y 
    ##  1.515789  1.205263

    ## [1] "Tolak H0"

Hasil **t-Test** menunjukkan bahwa rata-rata goal tim kandang lebih
besar signifikan dibandingkan rata-rata goal tim tandang.

Dengan adanya dua fakta ini, maka bisa dengan tegas disimpulkan bahwa:

> Tim kandang lebih tajam dibandingkan tim tandang.

-----

# Kesimpulan

Dari hasil analisa data yang ada, maka saya bisa simpulkan bahwa mitos
tim kandang memiliki performa lebih baik adalah benar.

### *Bell Curve* pada Data Selisih Goal?

*By the way*, ada hal yang menarik *nih*. Jika saya buat selisih antara
![\\sum{Goals\_{Home}} -
\\sum{Goal\_{Away}}](https://latex.codecogs.com/png.latex?%5Csum%7BGoals_%7BHome%7D%7D%20-%20%5Csum%7BGoal_%7BAway%7D%7D
"\\sum{Goals_{Home}} - \\sum{Goal_{Away}}"), saya dapatkan grafik
seperti ini:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/EPL/2020-08-28-EPL-home-away_files/figure-gfm/unnamed-chunk-9-1.png" width="672" />

> Bentuknya seperti *bell curve* sempurna *yah*.

Kalau sudah menemukan fakta ini, enaknya diapakan lagi *yah*?

---

Dukung selalu _blog_ ini agar bisa terus bertumbuh dengan cara klik iklan selepas Kamu membaca setiap tulisan yang ada _yah_.
