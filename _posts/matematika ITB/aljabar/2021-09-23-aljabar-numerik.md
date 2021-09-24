---
date: 2021-09-23T23:45:00-04:00
title: "Belajar (Lagi) Aljabar Linear untuk Analisa Numerik"
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
  - Aljabar Linear
---


> Dunia ini dikendalikan oleh Algoritma!

Pernyataan tersebut seringkali saya dengar di mana-mana. Pernyataan in
juga yang membuat saya ingin berkuliah lagi mengambil studi master
**sains komputasi**.

Namun setelah mengikuti kuliah beberapa minggu belakangan, saya sadar
bahwa pernyataan itu salah sepenuhnya. Pernyataan yang tepat adalah:

> ***Dunia ini dikendalikan oleh ALJABAR!***

Tidak menyangka bahwa dalam dunia numerik, konsep-konsep di aljabar
linear **sangat amat** digunakan. Sebagai contoh, saat kita hendak
menyelesaikan suatu sistem persamaan linear berikut:

------------------------------------------------------------------------

## Sistem Persamaan Linear

Suatu sistem persamaan linear bisa dituliskan dalam bentuk aljabar
berupa matriks dan vektor sebagai berikut:

![Ax = b](https://latex.codecogs.com/png.latex?Ax%20%3D%20b "Ax = b")

**SPL** tersebut akan memiliki solusi saat
![A](https://latex.codecogs.com/png.latex?A "A") memiliki invers, yakni
![A^{-1}](https://latex.codecogs.com/png.latex?A%5E%7B-1%7D "A^{-1}").

> Bagaimana caranya menghitung
> ![A^{-1}](https://latex.codecogs.com/png.latex?A%5E%7B-1%7D "A^{-1}")
> dari ![A](https://latex.codecogs.com/png.latex?A "A")?

Pada aljabar linear elementer, kita bisa melakukan **operasi baris
elementer** (**OBE**) sebagai berikut:

![\[A \| I\] \\rightarrow \[I\|A^{-1}\]](https://latex.codecogs.com/png.latex?%5BA%20%7C%20I%5D%20%5Crightarrow%20%5BI%7CA%5E%7B-1%7D%5D "[A | I] \rightarrow [I|A^{-1}]")

------------------------------------------------------------------------

Jika ![A](https://latex.codecogs.com/png.latex?A "A") merupakan matriks
yang berukuran kecil, kita bisa menghitungnya dengan mudah. Namun saat
kita berhadapan dengan matriks berukuran **sangat amat** besar dan
kompleks, kita bisa mengandalkan metode aproksimasi.

> Ternyata metode aproksimasi juga berlandaskan konsep aljabar linear
> yang kuat!

Oleh karena itu, sebelum saya lanjut berbicara mengenai metode
aproksimasi, saya akan menuliskan beberapa materi *refreshment* terkait
aljabar linear.

------------------------------------------------------------------------

## *Refreshment* Aljabar Linear

### Teorema **SPL**

> Jika ![A](https://latex.codecogs.com/png.latex?A "A") adalah matriks
> ![n \\times n](https://latex.codecogs.com/png.latex?n%20%5Ctimes%20n "n \times n")
> *inversible*, maka untuk setiap vektor
> ![b](https://latex.codecogs.com/png.latex?b "b")
> ![1 \\times n](https://latex.codecogs.com/png.latex?1%20%5Ctimes%20n "1 \times n")
> pada sistem persamaan linear
> ![Ax = b](https://latex.codecogs.com/png.latex?Ax%20%3D%20b "Ax = b")
> memiliki tepat satu solusi. Yaitu:

![x = A^{-1}b](https://latex.codecogs.com/png.latex?x%20%3D%20A%5E%7B-1%7Db "x = A^{-1}b")

Berikut ini kita coba *review* kembali secara singkat beberapa konsep
dalam aljabar yang kelak akan membantu kita memahami bagaimana cara
penyelesaian **SPL** secara numerik.

------------------------------------------------------------------------

### Matriks Singular dan Tak Singular

Dari penjelasan sebelumnya kita telah mengenal apa itu matriks invers.
Kita akan mengingat kembali suatu konsep bernama determinan matriks. Di
**R** kita bisa menghitung determinan dari suatu matriks dengan perintah
`det(matriks)`.

> Jika suatu matriks persegi memiliki determinan = 0, maka matriks
> tersebut tidak memiliki invers. Matriks yang tidak memiliki invers
> disebut **matriks singular**.

Kebalikannya:

> Jika suatu matriks memiliki determinan
> ![\\neq 0](https://latex.codecogs.com/png.latex?%5Cneq%200 "\neq 0"),
> maka matriks memiliki invers. Matriks berinvers disebut **matriks tak
> singular**.

------------------------------------------------------------------------

### Determinan Matriks

Untuk matriks berukuran
![2 \\times 2](https://latex.codecogs.com/png.latex?2%20%5Ctimes%202 "2 \times 2"),
cara menghitung determinan matriksnya adalah sebagai berikut:

![A = \\begin{bmatrix}
a & b \\\\
c & d \\\\
\\end{bmatrix}](https://latex.codecogs.com/png.latex?A%20%3D%20%5Cbegin%7Bbmatrix%7D%0Aa%20%26%20b%20%5C%5C%0Ac%20%26%20d%20%5C%5C%0A%5Cend%7Bbmatrix%7D "A = \begin{bmatrix}
a & b \\
c & d \\
\end{bmatrix}")

![\|A\| = ad - bc](https://latex.codecogs.com/png.latex?%7CA%7C%20%3D%20ad%20-%20bc "|A| = ad - bc")

Bagaimana dengan matriks berukuran
![3 \\times 3](https://latex.codecogs.com/png.latex?3%20%5Ctimes%203 "3 \times 3")?
Berikut caranya:

Kita perlu memperlebar kolom dari matriks tersebut agar semua elemen
terkena.

![A = \\begin{bmatrix}
a & b & c\\\\
d & e & f \\\\
g & h & i \\\\
\\end{bmatrix}](https://latex.codecogs.com/png.latex?A%20%3D%20%5Cbegin%7Bbmatrix%7D%0Aa%20%26%20b%20%26%20c%5C%5C%0Ad%20%26%20e%20%26%20f%20%5C%5C%0Ag%20%26%20h%20%26%20i%20%5C%5C%0A%5Cend%7Bbmatrix%7D "A = \begin{bmatrix}
a & b & c\\
d & e & f \\
g & h & i \\
\end{bmatrix}")

![\|A\| = (aei + bfg + cdh) - (ceg + afh + bdi)](https://latex.codecogs.com/png.latex?%7CA%7C%20%3D%20%28aei%20%2B%20bfg%20%2B%20cdh%29%20-%20%28ceg%20%2B%20afh%20%2B%20bdi%29 "|A| = (aei + bfg + cdh) - (ceg + afh + bdi)")

### Sifat-Sifat Determinan Matriks

Misalkan ![A](https://latex.codecogs.com/png.latex?A "A") adalah matriks
yang memiliki determinan, maka:

1.  ![\|A^T\| = \|A\|](https://latex.codecogs.com/png.latex?%7CA%5ET%7C%20%3D%20%7CA%7C "|A^T| = |A|")
2.  ![\|A . B\| = \|A\| . \|B\|](https://latex.codecogs.com/png.latex?%7CA%20.%20B%7C%20%3D%20%7CA%7C%20.%20%7CB%7C "|A . B| = |A| . |B|")
3.  ![\|A^n\| = \|A\|^n](https://latex.codecogs.com/png.latex?%7CA%5En%7C%20%3D%20%7CA%7C%5En "|A^n| = |A|^n")
4.  ![\|A^{-1}\| = \\frac{1}{\|A\|}](https://latex.codecogs.com/png.latex?%7CA%5E%7B-1%7D%7C%20%3D%20%5Cfrac%7B1%7D%7B%7CA%7C%7D "|A^{-1}| = \frac{1}{|A|}")
5.  ![\|k \\times A\_{m \\times m}\| = k^m \\times \|A\|](https://latex.codecogs.com/png.latex?%7Ck%20%5Ctimes%20A_%7Bm%20%5Ctimes%20m%7D%7C%20%3D%20k%5Em%20%5Ctimes%20%7CA%7C "|k \times A_{m \times m}| = k^m \times |A|")

------------------------------------------------------------------------

### Nilai Eigen dan Vektor Eigen

#### Definisi

Jika ![A](https://latex.codecogs.com/png.latex?A "A") adalah matriks
![n \\times n](https://latex.codecogs.com/png.latex?n%20%5Ctimes%20n "n \times n"),
maka vektor tak nol
![x \\in \\mathbb{R}^n](https://latex.codecogs.com/png.latex?x%20%5Cin%20%5Cmathbb%7BR%7D%5En "x \in \mathbb{R}^n")
dinamakan **vektor eigen** dari
![A](https://latex.codecogs.com/png.latex?A "A") jika
![Ax](https://latex.codecogs.com/png.latex?Ax "Ax") adalah kelipatan
skalar dari ![x](https://latex.codecogs.com/png.latex?x "x"). Yakni:

![Ax = \\lambda x](https://latex.codecogs.com/png.latex?Ax%20%3D%20%5Clambda%20x "Ax = \lambda x")

untuk suatu skalar
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda")
tertentu.
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda")
disebut sebagai **nilai eigen** yang bersesuaian dengan **vektor
eigen**.

#### Teorema

Jika ![A](https://latex.codecogs.com/png.latex?A "A") adalah matriks
berukuran
![n \\times n](https://latex.codecogs.com/png.latex?n%20%5Ctimes%20n "n \times n"),
maka
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\lambda")
adalah nilai eigen dari ![A](https://latex.codecogs.com/png.latex?A "A")
jika dan hanya jika ia memenuhi persamaan:

![det(\\lambda I - A) = 0](https://latex.codecogs.com/png.latex?det%28%5Clambda%20I%20-%20A%29%20%3D%200 "det(\lambda I - A) = 0")

Persamaan di atas disebut dengan **persamaan karakterisktik**.

Vektor dan nilai eigen bisa dihitung di **R** menggunakan *function*
`eigen(matriks)`.

------------------------------------------------------------------------

### Norm Vektor

Norm vektor merupakan fungsi pemetaan dari vektor-vektor di
![x \\in \\mathbb{R}^n](https://latex.codecogs.com/png.latex?x%20%5Cin%20%5Cmathbb%7BR%7D%5En "x \in \mathbb{R}^n")
ke bilangan *real*
![\|\|x\|\|](https://latex.codecogs.com/png.latex?%7C%7Cx%7C%7C "||x||")
sehingga memenuhi:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/aljabar/Screenshot from 2021-09-23 21-45-37.png" alt="Sifat Norm Vektor" width="100%" />
<p class="caption">
Sifat Norm Vektor
</p>

</div>

### Norm Matriks

Norm matriks merupakan fungsi pemetaan dari matriks-matriks bujur
sangkar di
![\\mathbb{R}^{n \\times n}](https://latex.codecogs.com/png.latex?%5Cmathbb%7BR%7D%5E%7Bn%20%5Ctimes%20n%7D "\mathbb{R}^{n \times n}")
ke
![\\mathbb{R}](https://latex.codecogs.com/png.latex?%5Cmathbb%7BR%7D "\mathbb{R}")
sehingga memenuhi:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/aljabar/Screenshot from 2021-09-23 21-20-29.png" alt="Sifat Norm Matriks" width="60%" />
<p class="caption">
Sifat Norm Matriks
</p>

</div>

![\\forall z \\neq 0 \\text{ dan natural matrix norm } \|\|.\|\| \\text{ diperoleh } \|\|Az\|\| \\leq \|\|A\|\| . \|\|z\|\|](https://latex.codecogs.com/png.latex?%5Cforall%20z%20%5Cneq%200%20%5Ctext%7B%20dan%20natural%20matrix%20norm%20%7D%20%7C%7C.%7C%7C%20%5Ctext%7B%20diperoleh%20%7D%20%7C%7CAz%7C%7C%20%5Cleq%20%7C%7CA%7C%7C%20.%20%7C%7Cz%7C%7C "\forall z \neq 0 \text{ dan natural matrix norm } ||.|| \text{ diperoleh } ||Az|| \leq ||A|| . ||z||")

#### Cara menghitung norm matriks

Beberapa teorema dan definisi yang berguna:

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/aljabar/Screenshot from 2021-09-23 21-29-16.png" alt="Norm Matriks dan Jari-jari Spektral" width="100%" />
<p class="caption">
Norm Matriks dan Jari-jari Spektral
</p>

</div>

*Summaries*:

1.  Norm
    ![\\infty](https://latex.codecogs.com/png.latex?%5Cinfty "\infty")
    adalah nilai max sum harga mutlak baris.
2.  Norm ![1](https://latex.codecogs.com/png.latex?1 "1") adalah nilai
    max sum harga mutlak kolom.

#### Teorema Kekonvergenan

Suatu matriks ![A](https://latex.codecogs.com/png.latex?A "A") dikatakan
**konvergen ke 0** jika
![\\lim\_{k \\rightarrow \\infty} (A^k)\_{ij} = 0](https://latex.codecogs.com/png.latex?%5Clim_%7Bk%20%5Crightarrow%20%5Cinfty%7D%20%28A%5Ek%29_%7Bij%7D%20%3D%200 "\lim_{k \rightarrow \infty} (A^k)_{ij} = 0").

Pernyataan berikut ini ekivalen:

1.  ![A](https://latex.codecogs.com/png.latex?A "A") matriks yang
    **konvergen**.
2.  ![\\lim\_{k \\rightarrow \\infty} \|\|A^k\|\| = 0](https://latex.codecogs.com/png.latex?%5Clim_%7Bk%20%5Crightarrow%20%5Cinfty%7D%20%7C%7CA%5Ek%7C%7C%20%3D%200 "\lim_{k \rightarrow \infty} ||A^k|| = 0"),
    untuk suatu *natural norm*.
3.  ![\\lim\_{k \\rightarrow \\infty} \|\|A^k\|\| = 0](https://latex.codecogs.com/png.latex?%5Clim_%7Bk%20%5Crightarrow%20%5Cinfty%7D%20%7C%7CA%5Ek%7C%7C%20%3D%200 "\lim_{k \rightarrow \infty} ||A^k|| = 0"),
    untuk setiap *natural norm*.
4.  ![\\rho(A) &lt; 1](https://latex.codecogs.com/png.latex?%5Crho%28A%29%20%3C%201 "\rho(A) < 1").
5.  ![\\lim\_{k \\rightarrow \\infty} A^kx = 0, \\forall x](https://latex.codecogs.com/png.latex?%5Clim_%7Bk%20%5Crightarrow%20%5Cinfty%7D%20A%5Ekx%20%3D%200%2C%20%5Cforall%20x "\lim_{k \rightarrow \infty} A^kx = 0, \forall x").

Perhatikan baik-baik teorema di atas. Terutama pada poin `4` dimana
menjadi **kunci** kekonvergenan dari suatu skema iterasi kelak.

### Matriks Diagonal, *Upper*, dan *Lower*

Matriks diagonal adalah matriks yang hanya berisi elemen di diagonalnya
saja. Matriks *upper triangle* adalah matriks yang hanya berisi segitiga
di atas. Matriks *lower triangle* adalah matriks yang hanya berisi
segitiga di bawah.

### Matriks Diagonal Dominan Kuat

Matriks **diagonal dominan kuat** adalah matriks yang memiliki elemen
harga mutlak diagonal terbesar.

Misalkan:

    ##      [,1]  [,2]  [,3] 
    ## [1,] "a11" "a12" "a13"
    ## [2,] "a21" "a22" "a23"
    ## [3,] "a31" "a32" "a33"

Definisi **diagonal dominan kuat** adalah:

![\|a\_{ii}\| &gt; \\sum\_{i=1,j \\neq i}^n \|a\_{ij}\|](https://latex.codecogs.com/png.latex?%7Ca_%7Bii%7D%7C%20%3E%20%5Csum_%7Bi%3D1%2Cj%20%5Cneq%20i%7D%5En%20%7Ca_%7Bij%7D%7C "|a_{ii}| > \sum_{i=1,j \neq i}^n |a_{ij}|")

Contoh:

    ##      [,1] [,2] [,3]
    ## [1,]    7    2    0
    ## [2,]    3    5   -1
    ## [3,]    0    5   -6

![A](https://latex.codecogs.com/png.latex?A "A") merupakan matriks
**diagonal dominan kuat** karena:

![\|7\| &gt; \|2\| + \|0\|](https://latex.codecogs.com/png.latex?%7C7%7C%20%3E%20%7C2%7C%20%2B%20%7C0%7C "|7| > |2| + |0|")

![\|5\| &gt; \|3\| + \|-1\|](https://latex.codecogs.com/png.latex?%7C5%7C%20%3E%20%7C3%7C%20%2B%20%7C-1%7C "|5| > |3| + |-1|")

![\|-6\| &gt; \|0\| + \|-5\|](https://latex.codecogs.com/png.latex?%7C-6%7C%20%3E%20%7C0%7C%20%2B%20%7C-5%7C "|-6| > |0| + |-5|")

Matriks **diagonal dominan kuat** adalah *non singular*.

> Bagaimana jika ![A](https://latex.codecogs.com/png.latex?A "A") kita
> bukan matriks **diagonal dominan kuat**?

Kita harus lakukan *pre-processing* sehingga menjadi matriks **diagonal
dominan kuat** dengan cara:

1.  Tukar baris, atau
2.  Tukar kolom.

------------------------------------------------------------------------

### Aljabar di **R**

Dari semua konsep aljabar yang telah dijelaskan pada bagian sebelumnya,
mari kita lihat beberapa function di **R**-nya:

Misalkan saya definisikan
![v](https://latex.codecogs.com/png.latex?v "v") suatu vektor sebagai
berikut:

``` r
v = c(2,4,-1,3)
# menghitung norm 1 dari vektor v
norm_vec_1 = function(x)sum(abs(x))
norm_vec_1(v)
```

    ## [1] 10

``` r
# menghitung norm 2 dari vektor v
norm_vec_2 = function(x)sqrt(sum(abs(x)^2))
norm_vec_2(v)
```

    ## [1] 5.477226

``` r
# menghitung norm infinity dari vektor v
norm_vec_inf = function(x)max(abs(x))
norm_vec_inf(v)
```

    ## [1] 4

Misalkan saya definisikan matriks
![A](https://latex.codecogs.com/png.latex?A "A") sebagai berikut:

``` r
A = matrix(c(2,4,-1,3,1,5,-2,3,-1),ncol = 3)
A
```

    ##      [,1] [,2] [,3]
    ## [1,]    2    3   -2
    ## [2,]    4    1    3
    ## [3,]   -1    5   -1

``` r
# transpose matriks
t(A)
```

    ##      [,1] [,2] [,3]
    ## [1,]    2    4   -1
    ## [2,]    3    1    5
    ## [3,]   -2    3   -1

``` r
# inverse matriks
matlib::inv(A)
```

    ##             [,1]       [,2]       [,3]
    ## [1,]  0.22535211 0.09859155 -0.1549296
    ## [2,] -0.01408451 0.05633803  0.1971831
    ## [3,] -0.29577465 0.18309859  0.1408451

``` r
# menghitung nilai dan vektor eigen
eigen(A)
```

    ## eigen() decomposition
    ## $values
    ## [1] -5.607665  5.148415  2.459250
    ## 
    ## $vectors
    ##            [,1]      [,2]       [,3]
    ## [1,]  0.4119543 0.3651285 -0.4204609
    ## [2,] -0.5715723 0.7504594  0.4578471
    ## [3,]  0.7096469 0.5509010  0.7833190

``` r
# perkalian matriks
A %*% matlib::inv(A) %>% round()
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    0    0
    ## [2,]    0    1    0
    ## [3,]    0    0    1

``` r
# menghitung norm 1 dari matriks A
norm(A,"1")
```

    ## [1] 9

``` r
# menghitung norm 2 dari matriks A
norm(A,"2")
```

    ## [1] 6.161479

``` r
# menghitung norm infinity dari matriks A
norm(A,"i")
```

    ## [1] 8

``` r
# menghitung rho
rho = function(matriks){
  ei = eigen(matriks)
  ei = max(abs(ei$values))
  return(ei)
}
rho(A)
```

    ## [1] 5.607665

``` r
# norm 2 juga bisa dihitung dengan cara
rho(t(A) %*% A) %>% sqrt()
```

    ## [1] 6.161479

### *Key Take Points* Materi Aljabar Linear

Perhatikan betul teorema kekonvergenan matriks dan bagaimana cara
menghitung ![\\rho](https://latex.codecogs.com/png.latex?%5Crho "\rho").

------------------------------------------------------------------------

Demikian *refreshment* materi aljabar linear. Aplikasinya pada analisa
numerik akan saya tuliskan di *posts* selanjutnya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
