---
date: 2021-12-22T13:06:00-04:00
title: "Menyelesaikan Integral Ganda Secara Numerik: Serial vs Parallel Processing"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Kalkulus
  - Komputasi
  - Serial Processing
  - Integral
  - Parallel Processing
---


Pada tulisan sebelumnya, saya telah menuliskan bagaimana pendekatan
numerik bisa digunakan untuk menyelesaikan perhitungan integral. Kita
bisa menggunakan:

1.  Pendekatan simulasi [Monte
    Carlo](https://ikanx101.com/blog/integral-tentu/),
2.  Perhitungan metode [*mid
    point*](https://ikanx101.com/blog/huawei-vs-vm/), dan
3.  Perhitungan metode
    [*trapezoid*](https://ikanx101.com/blog/pi-trapezoid/).

Kali ini saya akan coba menyelesaikan perhitungan integral ganda secara
numerik dengan metode *mid point*.

### Definisi

Jika kita memiliki suatu permasalahan integral berikut ini:

![\\int\_a^b \\int\_c^d f(x,y) dy dx](https://latex.codecogs.com/png.latex?%5Cint_a%5Eb%20%5Cint_c%5Ed%20f%28x%2Cy%29%20dy%20dx "\int_a^b \int_c^d f(x,y) dy dx")

Pada suatu domain
![\[a,b\] \\times \[c,d\]](https://latex.codecogs.com/png.latex?%5Ba%2Cb%5D%20%5Ctimes%20%5Bc%2Cd%5D "[a,b] \times [c,d]"),
kita bisa menyelesaikannya secara numerik dengan melakukan modifikasi
perhitungan dikritisasi sebagai berikut:

![h\_x h\_y \\sum\_{i=0}^{n\_x-1} \\sum\_{j=0}^{n\_y-1} f(a + \\frac{h\_x}{2} + i h\_x,c + \\frac{h\_y}{2} + j h\_y)](https://latex.codecogs.com/png.latex?h_x%20h_y%20%5Csum_%7Bi%3D0%7D%5E%7Bn_x-1%7D%20%5Csum_%7Bj%3D0%7D%5E%7Bn_y-1%7D%20f%28a%20%2B%20%5Cfrac%7Bh_x%7D%7B2%7D%20%2B%20i%20h_x%2Cc%20%2B%20%5Cfrac%7Bh_y%7D%7B2%7D%20%2B%20j%20h_y%29 "h_x h_y \sum_{i=0}^{n_x-1} \sum_{j=0}^{n_y-1} f(a + \frac{h_x}{2} + i h_x,c + \frac{h_y}{2} + j h_y)")

Di mana:

1.  ![h\_x](https://latex.codecogs.com/png.latex?h_x "h_x") adalah
    selang domain ![x](https://latex.codecogs.com/png.latex?x "x") yang
    telah dibagi-bagi oleh banyaknya selang
    ![n\_x](https://latex.codecogs.com/png.latex?n_x "n_x").
2.  ![h\_y](https://latex.codecogs.com/png.latex?h_y "h_y") adalah
    selang domain ![y](https://latex.codecogs.com/png.latex?y "y") yang
    telah dibagi-bagi oleh banyaknya selang
    ![n\_y](https://latex.codecogs.com/png.latex?n_y "n_y").

------------------------------------------------------------------------

Secara teori, caranya cukup mudah. Kali ini saya akan coba membuat
algoritmanya di **R**.

------------------------------------------------------------------------

## SOAL

Hitunglah:

![\\int\_0^2 \\int\_2^3 (2x + y) dy dx](https://latex.codecogs.com/png.latex?%5Cint_0%5E2%20%5Cint_2%5E3%20%282x%20%2B%20y%29%20dy%20dx "\int_0^2 \int_2^3 (2x + y) dy dx")

## JAWAB

Secara eksak, kita bisa hitung bahwa soal di atas memiliki jawaban
**9**.

Dengan mengambil
![n\_x = n\_y = 1000](https://latex.codecogs.com/png.latex?n_x%20%3D%20n_y%20%3D%201000 "n_x = n_y = 1000"),
saya akan mencoba membuat algoritmanya di **R**. Spesial kali ini saya
akan mencoba dua pendekatan, yakni dengan:

1.  *Serial processing* dengan memanfaatkan *looping*, dan
2.  *Parallel processing* dengan melakukan *multi processing* pada
    operasi vektor (`apply()`) memanfaatkan `library(parallel)`. Kenapa
    harus melakukan *parallel processing*? Karena laptop yang saya
    gunakan punya *processor*
    `Intel(R) Core(TM) i7-10610U CPU @ 1.80GHz` *8 cores* yang saya rasa
    cukup mumpuni.

> ***Sayang banget kalau gak digeber semua core-nya***.

Ini adalah *initial condition* dari soal ini:

``` r
# initial condition
a = 0
b = 2
c = 2
d = 3
nx = 10^3
ny = 10^3
f = function(x,y){2*x + y}

numCores = detectCores()
fx = function(df){2*df[1] + df[2]}
```

Berikut adalah algoritmanya di **R**:

### *Serial Processing*

``` r
int_dobel_serial = function(f,a,b,c,d,nx,ny){
    mulai = Sys.time()
    hx = (b - a)/nx
    hy = (d - c)/ny
    int = 0
    for(i in 0:(nx-1)){
        for(j in 0:(ny-1)){
            xi = a + hx/2 + i*hx
            yj = c + hy/2 + j*hy
            int = int + hx*hy*f(xi, yj)
        }
    }
    output = list("Integral f(x,y) dy dx adalah:" = int,
                  "Runtime" = Sys.time()-mulai)
    return(output)
}
```

### *Parallel Processing*

Untuk melakukan *parallel processing*, saya akan mengubah dua *looping*
yang `data.frame` dan melakukan operasi di sana. Saya akan memakai semua
*cores* yang ada dengan *function* `parallel::mclapply()`.

``` r
# paralel
int_dobel_paralel = function(dummy){
  mulai = Sys.time()
  hx = (b - a)/nx
  hy = (d - c)/ny
  x = seq((a+hx/2),b,by = hx)
  y = seq((c+hy/2),d,by = hy)
  xy = expand.grid(x,y)
  xy = as.data.frame(xy)
  int = hx*hy*sum(fx(xy))
  output = list("Integral f(x,y) dy dx adalah:" = int,
                "Runtime" = Sys.time()-mulai)
  return(output)
}
```

## *Momen of Truth*

Sekarang mari kita coba kedua algoritma di atas. Berapa nilainya dan
berapa lama *runtime* algoritmanya:

#### Serial

``` r
int_dobel_serial(f,a,b,c,d,nx,ny)
```

    ## $`Integral f(x,y) dy dx adalah:`
    ## [1] 9
    ## 
    ## $Runtime
    ## Time difference of 0.8970339 secs

#### Paralel

``` r
mclapply(100,int_dobel_paralel,mc.cores = numCores)
```

    ## [[1]]
    ## [[1]]$`Integral f(x,y) dy dx adalah:`
    ## [1] 9
    ## 
    ## [[1]]$Runtime
    ## Time difference of 0.0367713 secs

------------------------------------------------------------------------

## KESIMPULAN

*Obviously* kita bisa melihat bahwa *parallel processing* memiliki
*runtime* yang sangat cepat dibandingkan *serial processing* (walaupun
keduanya sama-sama cepat \~ memiliki waktu kurang dari 1 detik).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
