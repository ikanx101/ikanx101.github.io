---
date: 2021-08-29T14:45:00-04:00
title: "Metode Numerik: Metode Newton untuk Mencari Akar Persamaan"
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
  - Analisa Numerik Lanjut
  - Komputasi
  - Aproksimasi
---


Pada tulisan sebelumnya, saya sudah membahas bagaimana metode
*bisection* digunakan untuk mencari akar suatu persamaan.

Walaupun metode tersebut *powerful* tapi kalau kita ingat kembali
dibutuhkan **dua titik awal** iterasi (misal
![a](https://latex.codecogs.com/png.latex?a "a") dan
![b](https://latex.codecogs.com/png.latex?b "b")) dengan syarat wajib:
![f(a).f(b) &lt; 0](https://latex.codecogs.com/png.latex?f%28a%29.f%28b%29%20%3C%200 "f(a).f(b) < 0")
dan ![f](https://latex.codecogs.com/png.latex?f "f") kontinu di selang
![\[a,b\]](https://latex.codecogs.com/png.latex?%5Ba%2Cb%5D "[a,b]").

> ![f(a)](https://latex.codecogs.com/png.latex?f%28a%29 "f(a)") dan
> ![f(b)](https://latex.codecogs.com/png.latex?f%28b%29 "f(b)") harus
> berlawanan tanda. Salah satu harus positif dan lainnya negatif.

Kenapa harus begitu? Ingat kembali **Teorema Nilai Antara** yang saya
sebutkan juga di tulisan tersebut *yah*.

## Metode *Newton*

Metode *bisection* bukanlah satu-satunya metode numerik yang bisa
digunakan untuk mencari akar persamaan. Salah satu metode lain yang
terkenal adalah metode *Newton*.

Berbeda dengan *bisection* yang membutuhkan 2 buah titik awal iterasi,
metode *Newton* cukup menggunakan satu titik saja.

> *Lho kok bisa?*

Misalkan saya memiliki fungsi:
![f(x) = x^3 - x^2 - 70](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20x%5E3%20-%20x%5E2%20-%2070 "f(x) = x^3 - x^2 - 70")
dengan grafik sebagai berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/analisa%20numerik%20lanjut/newton/post_files/figure-gfm/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Untuk mencari akar persamaan dengan *bisection*, kita butuh selang
![\[a,b\]](https://latex.codecogs.com/png.latex?%5Ba%2Cb%5D "[a,b]")
sebagai permulaan iterasi.

Namun, dengan metode *Newton* kita bisa mengambil titik manapun dari
grafik di atas sebagai titik permulaan.

------------------------------------------------------------------------

## Bagaimana cara kerjanya?

Metode *Newton* memanfaatkan ***Deret Taylor*** (*Taylor Series*) dari
suatu fungsi. Kali ini syarat agar metode *Newton* bisa digunakan adalah
fungsinya bisa **diturunkan** (*diferensiable*).

Misalkan dari suatu fungsi
![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)") memiliki
suatu akar ![p](https://latex.codecogs.com/png.latex?p "p"). Saya ingin
menghitung suatu barisan
![x\_0,x\_1,x\_2,...,x\_n](https://latex.codecogs.com/png.latex?x_0%2Cx_1%2Cx_2%2C...%2Cx_n "x_0,x_1,x_2,...,x_n")
yang akan konvergen ke akar
![p](https://latex.codecogs.com/png.latex?p "p"). Untuk suatu nilai
![\\delta](https://latex.codecogs.com/png.latex?%5Cdelta "\delta") yang
**sangat amat kecil**:

![f(x\_n + \\delta) = f(x\_n) + \\delta f'(x\_n) + O (\\delta^2)](https://latex.codecogs.com/png.latex?f%28x_n%20%2B%20%5Cdelta%29%20%3D%20f%28x_n%29%20%2B%20%5Cdelta%20f%27%28x_n%29%20%2B%20O%20%28%5Cdelta%5E2%29 "f(x_n + \delta) = f(x_n) + \delta f'(x_n) + O (\delta^2)")

Dengan:

1.  Mengabaikan
    ![O(\\delta^2)](https://latex.codecogs.com/png.latex?O%28%5Cdelta%5E2%29 "O(\delta^2)")
    (karena si
    ![\\delta](https://latex.codecogs.com/png.latex?%5Cdelta "\delta")
    sudah kecil sehingga saat dikuadratkan juga akan lebih kecil lagi).
2.  ![f(x\_n)=0](https://latex.codecogs.com/png.latex?f%28x_n%29%3D0 "f(x_n)=0")
    karena kita ingin mencari akar persamaan.

Maka kita bisa dapatkan:

![f(x\_n) + \\delta f'(x\_n) = 0](https://latex.codecogs.com/png.latex?f%28x_n%29%20%2B%20%5Cdelta%20f%27%28x_n%29%20%3D%200 "f(x_n) + \delta f'(x_n) = 0")

Sehingga menghasilkan:

![\\delta = - \\frac{f(x\_n)}{f'(x\_n)}](https://latex.codecogs.com/png.latex?%5Cdelta%20%3D%20-%20%5Cfrac%7Bf%28x_n%29%7D%7Bf%27%28x_n%29%7D "\delta = - \frac{f(x_n)}{f'(x_n)}")

> Ingat kembali bahwa kita ingin
> ![x\_n](https://latex.codecogs.com/png.latex?x_n "x_n") **sangat dekat
> sekali dengan akar persamaan**
> ![p](https://latex.codecogs.com/png.latex?p "p").

Sehingga:

![x\_{n+1} - x\_n = \\delta \\\\ x\_{n+1} = x\_n + \\delta \\\\ x\_{n+1} = x\_n - \\frac{f(x\_n)}{f'(x\_n)}](https://latex.codecogs.com/png.latex?x_%7Bn%2B1%7D%20-%20x_n%20%3D%20%5Cdelta%20%5C%5C%20x_%7Bn%2B1%7D%20%3D%20x_n%20%2B%20%5Cdelta%20%5C%5C%20x_%7Bn%2B1%7D%20%3D%20x_n%20-%20%5Cfrac%7Bf%28x_n%29%7D%7Bf%27%28x_n%29%7D "x_{n+1} - x_n = \delta \\ x_{n+1} = x_n + \delta \\ x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}")

Persamaan terakhir ini menjadi dasar bagi algoritma pengerjaan metode
*Newton*.

## Algoritma *Newton*

![x\_{n+1} = x\_n - \\frac{f(x\_n)}{f'(x\_n)}](https://latex.codecogs.com/png.latex?x_%7Bn%2B1%7D%20%3D%20x_n%20-%20%5Cfrac%7Bf%28x_n%29%7D%7Bf%27%28x_n%29%7D "x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}")

------------------------------------------------------------------------

## Contoh Pengerjaan

Sekarang kita akan gunakan metode Newton ini untuk menyelesaikan contoh
soal sebelumnya:

![f(x) = x^3 - x^2 - 70](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20x%5E3%20-%20x%5E2%20-%2070 "f(x) = x^3 - x^2 - 70")

Berikutnya kita perlu mencari turunan dari
![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)"). Untuk
melakukan itu, kita bisa melakukannya manual dengan mencoret-coret di
kertas atau dengan bantuan `library(Ryacas)` yang pernah saya tulis
[sebelumnya](https://ikanx101.com/blog/math-r/). Sehingga didapatkan:

``` r
library(Ryacas)
eq = "x^3 - x^2 - 70"
eq %>% y_fn("D(x)") %>% yac_str()
```

    ## [1] "3*x^2-2*x"

![f'(x) = 3x^2 - 2x](https://latex.codecogs.com/png.latex?f%27%28x%29%20%3D%203x%5E2%20-%202x "f'(x) = 3x^2 - 2x")

Setelah itu, saya akan *set* titik awal iterasinya di
![x\_0 = 10](https://latex.codecogs.com/png.latex?x_0%20%3D%2010 "x_0 = 10")
(*bebas yah mau berapa saja*).

Sebagai penunjang algoritma yang saya buat, saya akan atur:

1.  Iterasi maksimum yang dijalankan adalah `50`.
2.  Tingkat akurasi atau ketelitian hasil aproksimasinya adalah
    ![10^{-2}](https://latex.codecogs.com/png.latex?10%5E%7B-2%7D "10^{-2}")
    saja.

``` r
# informasi yang dibutuhkan
x_0 = 10
f = function(x){x^3 - x^2 - 70}
df = function(x){3*x^2-2*x}
iter_max = 50
tol_max = 10^-2

# initial condition
i = 1
hasil = data.frame(n_iter = 0,
                   p = x_0)

while(i <= iter_max){
  p = x_0 - (f(x_0) / df(x_0))
  hasil[i+1,] = list(i,p)
  if(abs(p-x_0) < tol_max){break}
  x_0 = p;
  i  = i + 1
}
# print output
hasil %>% knitr::kable(align = "c")
```

| n\_iter |     p     |
|:-------:|:---------:|
|    0    | 10.000000 |
|    1    | 7.035714  |
|    2    | 5.333925  |
|    3    | 4.620209  |
|    4    | 4.487392  |
|    5    | 4.483027  |

Ternyata hanya dibutuhkan `5` kali iterasi untuk mendapatkan aproksimasi
akar persamaannya.

Sekarang saya akan coba melakukan ulang tapi dengan titik awal
![x\_0 = -7](https://latex.codecogs.com/png.latex?x_0%20%3D%20-7 "x_0 = -7").

``` r
# informasi yang dibutuhkan
x_0 = -7
f = function(x){x^3 - x^2 - 70}
df = function(x){3*x^2-2*x}
iter_max = 50
tol_max = 10^-2

# initial condition
i = 1
hasil = data.frame(n_iter = 0,
                   p = x_0)

while(i <= iter_max){
  p = x_0 - (f(x_0) / df(x_0))
  hasil[i+1,] = list(i,p)
  if(abs(p-x_0) < tol_max){break}
  x_0 = p;
  i  = i + 1
}
# print output
hasil %>% knitr::kable(align = "c")
```

| n\_iter |     p     |
|:-------:|:---------:|
|    0    | -7.000000 |
|    1    | -4.130435 |
|    2    | -1.480342 |
|    3    | 6.431152  |
|    4    | 5.040797  |
|    5    | 4.546821  |
|    6    | 4.483989  |
|    7    | 4.483022  |

Dengan nilai ![x\_0](https://latex.codecogs.com/png.latex?x_0 "x_0")
yang berbeda, didapatkan aproksimasi akar pada iterasi ke `7`.

------------------------------------------------------------------------

> ***Saya pribadi lebih menyukai metode ini karena algoritmanya sangat
> mudah dibuat.***

`if you find this article helpful, support this blog by clicking the ads.`
