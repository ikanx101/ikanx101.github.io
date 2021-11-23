Belajar Membuat Algoritma Deret Fibonacci
================

Kali ini saya mau menulis sesuatu yang ringan-ringan dulu, yakni tentang
bagaimana membuat algoritma untuk menuliskan deret Fibonacci. Biasanya
algoritma ini menjadi latihan bagi rekan-rekan yang baru belajar membuat
algoritma dan pemrograman.

Deret Fibonacci berisi deret angka yang dimulai dari 0 dan 1, kemudian
angka berikutnya merupakan penjumlahan dari angka sebelumnya. Saya bisa
tuliskan ekspresi matematikanya sebagai berikut:

  
![F\_0 = 0](https://latex.codecogs.com/png.latex?F_0%20%3D%200
"F_0 = 0")  

  
![F\_1 = 1](https://latex.codecogs.com/png.latex?F_1%20%3D%201
"F_1 = 1")  

  
![F\_n = F\_{n-1} +
F\_{n-2}](https://latex.codecogs.com/png.latex?F_n%20%3D%20F_%7Bn-1%7D%20%2B%20F_%7Bn-2%7D
"F_n = F_{n-1} + F_{n-2}")  

-----

## Membuat Algoritma

> ***Misalkan saya ditugaskan untuk membuat deret Fibonacci ke-n.***

Bagaimana cara menuliskan algoritmanya? Berikut adalah *pseudocode*-nya:

    STEP I: 
     define
      f = (0,1)
    
    STEP II: 
     input n  
    
    STEP III:
     looping
      for(2 to n)
        fibo = f[iter-1] + f[iter-2]
        f[iter] = fibo
    
    STEP IV:
     print f

## Membuat *Function* di **R**

Sekarang saya akan buat *function* di **R** berdasarkan *pseudocode* di
atas. Namun perlu diperhatikan bahwa **R** memiliki *index* mulai dari 1
bukan dari 0.

``` r
fibo = function(n){
  f = c(0,1)
  iter = 3
  for(i in iter:(n+1)){
    fi = f[i-1] + f[i-2]
    f = c(f,fi)
    }
  return(f)
}
```

Mari kita coba *function* tersebut untuk berbagai macam nilai n.

``` r
fibo(4)
```

    ## [1] 0 1 1 2 3

``` r
fibo(10)
```

    ##  [1]  0  1  1  2  3  5  8 13 21 34 55

``` r
fibo(13)
```

    ##  [1]   0   1   1   2   3   5   8  13  21  34  55  89 144 233

Mudah kan?

-----

`if you find this article helpful, support this blog by clicking the
ads.`
