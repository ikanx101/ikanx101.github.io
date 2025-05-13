---
date: 2025-05-13T13:22:00-04:00
title: "Membandingkan Multiple Regression Models dengan `mtable()`"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Regresi
  - Multiple Regression
  - Regresi Linear
  - R-Square
---

Pada tahun ini, saya sudah mengerjakan beberapa *projects* terkait model
regresi (baik linear atau tak linear). Biasanya saya agak kesulitan
dalam membuat visualisasi perbandingan dua atau lebih model regresi.

Padahal informasi yang hendak saya tampilkan cukup simpel, yakni:

1.  Seberapa bagus model tersebut. Biasanya saya cukup menampilkan nilai
    ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2").
2.  Variabel mana saja yang **signifikan** terhadap model.

Jika biasanya saya harus membuat *function* mandiri untuk menampilkan
informasi tersebut, ternyata saya bisa menggunakan *function* `mtable()`
dari `library(memisc)` di **R**.

Sebagai contoh, saya akan menggunakan data `mtcars` sebagai berikut:

``` r
# Menghapus semua objek dari lingkungan kerja (workspace) R
rm(list=ls()) 

# Membuat model regresi linear (model1) dengan mpg sebagai variabel dependen dan disp, carb, hp, dan cyl sebagai variabel independen, menggunakan dataset mtcars
model1 = lm(mpg ~ disp + carb + hp + cyl, data = mtcars) 

# Membuat model regresi linear (model2) dengan mpg sebagai variabel dependen dan disp dan carb sebagai variabel independen, menggunakan dataset mtcars
model2 = lm(mpg ~ disp + carb, data = mtcars) 

# Membuat model regresi linear (model3) dengan mpg sebagai variabel dependen dan hp dan cyl sebagai variabel independen, menggunakan dataset mtcars
model3 = lm(mpg ~ hp + cyl, data = mtcars) 

# Memuat package 'memisc' yang menyediakan fungsi untuk manajemen data dan hasil model statistik
library(memisc) 
mtable("Model 1" = model1, 
       "Model 2" = model2,
       "Model 3" = model3) 
```


    Calls:
    Model 1: lm(formula = mpg ~ disp + carb + hp + cyl, data = mtcars)
    Model 2: lm(formula = mpg ~ disp + carb, data = mtcars)
    Model 3: lm(formula = mpg ~ hp + cyl, data = mtcars)

    ================================================
                    Model 1    Model 2    Model 3   
    ------------------------------------------------
      (Intercept)  34.022***  31.153***  36.908***  
                   (2.523)    (1.264)    (2.191)    
      disp         -0.027*    -0.036***             
                   (0.011)    (0.005)               
      carb         -0.927     -0.956*               
                   (0.579)    (0.359)               
      hp            0.009                -0.019     
                   (0.021)               (0.015)    
      cyl          -1.049                -2.265***  
                   (0.784)               (0.576)    
    ------------------------------------------------
      R-squared     0.788      0.774      0.741     
      N            32         32         32         
    ================================================
      Significance: *** = p < 0.001;   
                    ** = p < 0.01; * = p < 0.05  

Tabel di atas sudah memuat cukup informasi-informasi yang penting bagi
saya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
