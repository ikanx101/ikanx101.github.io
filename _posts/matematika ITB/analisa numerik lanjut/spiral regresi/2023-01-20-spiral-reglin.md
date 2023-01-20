---
date: 2023-01-20T22:10:00-04:00
title: "Membuat Model Regresi Linear dengan Spiral Dynamic Optimization Algorithm"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Regresi
  - Regresi Linear
  - Spiral Optimization
  - Komputasi
  - Parallel Processing
---


Sepertinya tidak ada habisnya saya mengupas regresi linear. Mulai dari
cara membuat modelnya dengan [fungsi *base* di
**R**](https://ikanx101.com/blog/belajar-regresi/) hingga cara membuat
modelnya [dengan pendekatan
aljabar](https://ikanx101.com/blog/curve-linear/).

Kali ini saya akan membuat model regresi dengan cara lain, yakni dengan
memanfaatkan prinsip *optimization*. Saya akan membuat model regresi
linear yang meminimumkan nilai **MAE** (*mean absolute error*).

Misalkan saya memiliki data sebagai berikut:

    ##                      mpg  disp  hp
    ## Mazda RX4           21.0 160.0 110
    ## Mazda RX4 Wag       21.0 160.0 110
    ## Datsun 710          22.8 108.0  93
    ## Hornet 4 Drive      21.4 258.0 110
    ## Hornet Sportabout   18.7 360.0 175
    ## Valiant             18.1 225.0 105
    ## Duster 360          14.3 360.0 245
    ## Merc 240D           24.4 146.7  62
    ## Merc 230            22.8 140.8  95
    ## Merc 280            19.2 167.6 123
    ## Merc 280C           17.8 167.6 123
    ## Merc 450SE          16.4 275.8 180
    ## Merc 450SL          17.3 275.8 180
    ## Merc 450SLC         15.2 275.8 180
    ## Cadillac Fleetwood  10.4 472.0 205
    ## Lincoln Continental 10.4 460.0 215
    ## Chrysler Imperial   14.7 440.0 230
    ## Fiat 128            32.4  78.7  66
    ## Honda Civic         30.4  75.7  52
    ## Toyota Corolla      33.9  71.1  65
    ## Toyota Corona       21.5 120.1  97
    ## Dodge Challenger    15.5 318.0 150
    ## AMC Javelin         15.2 304.0 150
    ## Camaro Z28          13.3 350.0 245
    ## Pontiac Firebird    19.2 400.0 175
    ## Fiat X1-9           27.3  79.0  66
    ## Porsche 914-2       26.0 120.3  91
    ## Lotus Europa        30.4  95.1 113
    ## Ford Pantera L      15.8 351.0 264
    ## Ferrari Dino        19.7 145.0 175
    ## Maserati Bora       15.0 301.0 335
    ## Volvo 142E          21.4 121.0 109

Jika saya hendak membuat persamaan regresi linear dari data di atas
seperti ini:

![mpg = \\alpha \\space disp + \\beta \\space hp + \\gamma](https://latex.codecogs.com/png.latex?mpg%20%3D%20%5Calpha%20%5Cspace%20disp%20%2B%20%5Cbeta%20%5Cspace%20hp%20%2B%20%5Cgamma "mpg = \alpha \space disp + \beta \space hp + \gamma")

Menggunakan *base* di **R**, saya cukup menuliskan skrip sebagai
berikut:

``` r
model_reg = lm(mpg ~.,data = df)
model_reg
```

    ## 
    ## Call:
    ## lm(formula = mpg ~ ., data = df)
    ## 
    ## Coefficients:
    ## (Intercept)         disp           hp  
    ##    30.73590     -0.03035     -0.02484

Kita dapatkan model persamaannya. Lalu jika saya hitung nilai MAE-nya,
saya dapatkan nilainya sebesar:

``` r
MAE_hit(c(-0.03035,-0.02484,30.73590))
```

    ## [1] 2.501264

Apakah kita bisa mendapatkan persamaan yang menghasilkan MAE lebih
kecil? Jawabannya bisa dengan SDOA. Saya memvideokan prosesnya di
*channel* Youtube saya berikut [ini](https://youtu.be/FOyRxNT8T3w).

Hasilnya adalah saya mendapatkan persamaan yang memiliki MAE lebih
kecil.

![mpg = -0.03263072 \\space disp - 0.01928762 \\space hp + 29.75566125](https://latex.codecogs.com/png.latex?mpg%20%3D%20-0.03263072%20%5Cspace%20disp%20-%200.01928762%20%5Cspace%20hp%20%2B%2029.75566125 "mpg = -0.03263072 \space disp - 0.01928762 \space hp + 29.75566125")

``` r
MAE_hit(center)
```

    ## [1] 2.382554

------------------------------------------------------------------------

Ternyata SDOA bisa diandalkan untuk membuat model regresi. Jika Anda
hendak mengganti MAE dengan *metric* lain, silakan saja.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
