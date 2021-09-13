Metode Numerik: Mencari Akar Fungsi dengan Menggunakan Golden Ratio
================

Pada dua *posts* sebelumnya, saya pernah menulis bagaimana metode
[*bisection*](https://ikanx101.com/blog/metode-bisection/) dan metode
[*Newton*](https://ikanx101.com/blog/newton_method/) untuk mencari akar
dari suatu fungsi.

Salah satu kelemahan dari metode *bisection* adalah *running time*.
Salah satu kelemahan dari metode *Newton* adalah harus mencari turunan
dari fungsi yang dikerjakan
![\\frac{d}{dx}f(x)](https://latex.codecogs.com/png.latex?%5Cfrac%7Bd%7D%7Bdx%7Df%28x%29 "\frac{d}{dx}f(x)").

> *Apakah ada metode yang cepat dan tidak memerlukan turunan?*

------------------------------------------------------------------------

# *Golden Ratio*

Kalian semua pasti pernah mendengar tentang istilah [*golden
ratio*](https://en.wikipedia.org/wiki/Golden_ratio). Konon katanya
kesempurnaan dan keseimbangan di dunia itu mengikuti aturan *golden
ratio*.

> Lantas apa hubungannya *golden ratio* dengan pendekatan numerik untuk
> mencari akar persamaan?

Ada satu metode numerik bernama *Golden Section Search* yang bisa
dipakai untuk mencari **nilai minimum global**. Prinsipnya adalah
sebagai berikut:

> Misalkan ![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)")
> disebut [*unimodal*](https://id.wikipedia.org/wiki/Modus_(statistika))
> pada selang
> ![I = \[a,b\]](https://latex.codecogs.com/png.latex?I%20%3D%20%5Ba%2Cb%5D "I = [a,b]"),
> jika terdapat sebuah titik
> ![p \\in I](https://latex.codecogs.com/png.latex?p%20%5Cin%20I "p \in I")
> sehingga ![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)")
> monoton turun murni pada
> ![\[a,p\]](https://latex.codecogs.com/png.latex?%5Ba%2Cp%5D "[a,p]")
> dan monoton naik murni pada
> ![\[p,b\]](https://latex.codecogs.com/png.latex?%5Bp%2Cb%5D "[p,b]").

Dari definisi diatas dimungkinkan suatu cara untuk mengidentifikasi
bahwa fungsi
![f(x)](https://latex.codecogs.com/png.latex?f%28x%29 "f(x)") memiliki
**minimum global tunggal** di titik
![p](https://latex.codecogs.com/png.latex?p "p"), dengan tidak secara
***eksplisit*** melibatkan turunan fungsi. Jika diperhatikan dengan
baik, diharapkan titik ![p](https://latex.codecogs.com/png.latex?p "p")
menjadi **titik terendah dari grafik fungsinya** sehingga masalah ini
menjadi **masalah minimisasi**.

Jadi proses optimisasi bisa dimodifikasi untuk menghitung akar
persamaan.

Sekarang permasalahannya adalah menentukan di mana letak titik
![p](https://latex.codecogs.com/png.latex?p "p"). Nah, si *golden ratio*
masuk di tahap ini untuk menentukan dimana letak si titik
![p](https://latex.codecogs.com/png.latex?p "p").

------------------------------------------------------------------------

# Cara Kerja *Golden Section Search*

Dari selang
![\[a,b\]](https://latex.codecogs.com/png.latex?%5Ba%2Cb%5D "[a,b]")
yang ada, akan dicari dua titik baru
![(c,d)](https://latex.codecogs.com/png.latex?%28c%2Cd%29 "(c,d)") yang
berada di dalam selang dengan menggunakan rumus:

![c = b - (b - a) / r](https://latex.codecogs.com/png.latex?c%20%3D%20b%20-%20%28b%20-%20a%29%20%2F%20r "c = b - (b - a) / r")

![d = a + (b - a) / r](https://latex.codecogs.com/png.latex?d%20%3D%20a%20%2B%20%28b%20-%20a%29%20%2F%20r "d = a + (b - a) / r")

dengan ![r](https://latex.codecogs.com/png.latex?r "r") adalah *golden
ratio*.

![r = \\frac{1 + \\sqrt5}{2} \\simeq 0.618](https://latex.codecogs.com/png.latex?r%20%3D%20%5Cfrac%7B1%20%2B%20%5Csqrt5%7D%7B2%7D%20%5Csimeq%200.618 "r = \frac{1 + \sqrt5}{2} \simeq 0.618")

Perhatikan bahwa
![a &lt; d &lt; c &lt; b](https://latex.codecogs.com/png.latex?a%20%3C%20d%20%3C%20c%20%3C%20b "a < d < c < b").
Kita perlu cek nilai
![f(a), f(c), f(d), f(b)](https://latex.codecogs.com/png.latex?f%28a%29%2C%20f%28c%29%2C%20f%28d%29%2C%20f%28b%29 "f(a), f(c), f(d), f(b)").

Perhatikan bahwa karena ![f](https://latex.codecogs.com/png.latex?f "f")
*unimodal* maka
![f(c)](https://latex.codecogs.com/png.latex?f%28c%29 "f(c)") dan
![f(d)](https://latex.codecogs.com/png.latex?f%28d%29 "f(d)")
masing-masing bernilai lebih kecil dari
![max \\{ f(a) , f(b) \\}](https://latex.codecogs.com/png.latex?max%20%5C%7B%20f%28a%29%20%2C%20f%28b%29%20%5C%7D "max \{ f(a) , f(b) \}").
Perhatikan dua kondisi berikut ini:

1.  Jika
    ![f(c) \\leq f(d)](https://latex.codecogs.com/png.latex?f%28c%29%20%5Cleq%20f%28d%29 "f(c) \leq f(d)")
    maka dari sifat *unimodal*,
    ![f](https://latex.codecogs.com/png.latex?f "f") monoton naik di
    selang
    ![\[d,b\]](https://latex.codecogs.com/png.latex?%5Bd%2Cb%5D "[d,b]")
    dan dengan demikian maka
    ![p \\in \[a,d\]](https://latex.codecogs.com/png.latex?p%20%5Cin%20%5Ba%2Cd%5D "p \in [a,d]").
2.  Jika
    ![f(c) &gt; f(d)](https://latex.codecogs.com/png.latex?f%28c%29%20%3E%20f%28d%29 "f(c) > f(d)")
    maka dari sifat *unimodal*,
    ![f](https://latex.codecogs.com/png.latex?f "f") monoton turun di
    selang
    ![\[a,c\]](https://latex.codecogs.com/png.latex?%5Ba%2Cc%5D "[a,c]")
    dan dengan demikian maka
    ![p \\in \[c,b\]](https://latex.codecogs.com/png.latex?p%20%5Cin%20%5Bc%2Cb%5D "p \in [c,b]").

Situasi di atas memungkinkan kita untuk **melakukan reduksi lebar selang
pencarian** untuk mencari titik
![p](https://latex.codecogs.com/png.latex?p "p").

Algoritma iterasinya adalah sebagai berikut:

    if f(c) <= f(d)
      b = d
      fb = fd
    else
      a = c
      fa = fc
    end
      c = a + r * (b-a) 
      fc = f(c) 
      d = a + (1-r)*(b-a) 
      fd = f(d)

Iterasi akan berhenti saat kita mendefinisikan *toleransi error max*
yang diperbolehkan.

------------------------------------------------------------------------

## Dari Optimisasi ke Mencari Akar

Terdapat hubungan antara masalah optimisasi ini dengan akar persamaan.
Persamaan
![f(x) = 0](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%200 "f(x) = 0")
memiliki solusi ![x](https://latex.codecogs.com/png.latex?x "x") jika
fungsi objektif ![F](https://latex.codecogs.com/png.latex?F "F") dari
masalah optimisasi yang didefinisikan sebagai berikut:

-   ![F(x) = (f(x))^2](https://latex.codecogs.com/png.latex?F%28x%29%20%3D%20%28f%28x%29%29%5E2 "F(x) = (f(x))^2")
    memiliki nilai minimum global sebesar
    ![0](https://latex.codecogs.com/png.latex?0 "0").
-   ![F(x) = \|f(x)\|](https://latex.codecogs.com/png.latex?F%28x%29%20%3D%20%7Cf%28x%29%7C "F(x) = |f(x)|")
    memiliki nilai minimum global sebesar
    ![0](https://latex.codecogs.com/png.latex?0 "0").
-   ![F(x) = - \\frac{1}{a+ \|f(x)\|}](https://latex.codecogs.com/png.latex?F%28x%29%20%3D%20-%20%5Cfrac%7B1%7D%7Ba%2B%20%7Cf%28x%29%7C%7D "F(x) = - \frac{1}{a+ |f(x)|}")
    memiliki nilai minimum global sebesar
    ![-1](https://latex.codecogs.com/png.latex?-1 "-1").

### Contoh

Untuk fungsi
![f(x) = x^3 - 10x^2 + 29x -20](https://latex.codecogs.com/png.latex?f%28x%29%20%3D%20x%5E3%20-%2010x%5E2%20%2B%2029x%20-20 "f(x) = x^3 - 10x^2 + 29x -20")
di
![0 \\leq x \\leq 6](https://latex.codecogs.com/png.latex?0%20%5Cleq%20x%20%5Cleq%206 "0 \leq x \leq 6"),
tentukan semua akarnya dengan metode *Golden Section Search* !

#### Jawab

Mari kita buat dulu grafik fungsinya di selang tersebut:

<img src="gss_files/figure-gfm/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Kalau kita perhatikan, akar persamaan tersebut ada di selang
![\[0,2\],\[3.5,4.5\].\[4.5,6\]](https://latex.codecogs.com/png.latex?%5B0%2C2%5D%2C%5B3.5%2C4.5%5D.%5B4.5%2C6%5D "[0,2],[3.5,4.5].[4.5,6]").

> Perlu saya ingatkan kembali, tujuan dari **GSS** adalah mencari titik
> minimum global di selang tertentu.

Oleh karena itu, jika kita ingin mencari akar, maka kita harus ubah
terlebih dahulu fungsinya mejadi
![f'(x) = \|f(x)\|](https://latex.codecogs.com/png.latex?f%27%28x%29%20%3D%20%7Cf%28x%29%7C "f'(x) = |f(x)|").
Berikut adalah grafiknya:

<img src="gss_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Sekarang kita bisa mencari akarnya di selang
![\[0,2\]](https://latex.codecogs.com/png.latex?%5B0%2C2%5D "[0,2]"),
yakni:

``` r
rm(list=ls())

# definisikan r sebagai golden ratio
r = (1 + sqrt(5))/2
tol_max = 10^(-10)

# fungsi dari soal
f_awal = function(x){x^3 - 10*x^2 + 29*x -20}
f = function(x){abs(x^3 - 10*x^2 + 29*x -20)}

# initial
a = 0
b = 2

while(abs(b - a) > tol_max){
  c = b - (b - a) / r
  d = a + (b - a) / r
  
  if(f(c) < f(d)){
    b = d
    } else{
    a = c
    }
  
}

hasil = (a+b)/2
```

Akar pada selang tersebut adalah di
![x =](https://latex.codecogs.com/png.latex?x%20%3D "x =") 1.

Sekarang saya akan bikin *function*-nya di **R** untuk bisa mencari akar
![x](https://latex.codecogs.com/png.latex?x "x") di selang lainnya.

Kita akan coba pada selang
![\[3.5,4.5\]](https://latex.codecogs.com/png.latex?%5B3.5%2C4.5%5D "[3.5,4.5]")
sebagai berikut:

``` r
golden_ss(3.5,4.5,f)
```

    ## [1] 4

Selanjutnya pada selang
![\[4.5,6\]](https://latex.codecogs.com/png.latex?%5B4.5%2C6%5D "[4.5,6]")
sebagai berikut:

``` r
golden_ss(4.5,6,f)
```

    ## [1] 5

Secara iterasi, *GSS* memiliki *processing time* yang lebih cepat.
