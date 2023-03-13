Mencari Simmilarity dan Dissimilarity dari Data
================

Pada tahun lalu, saya pernah menulis tentang bagaimana menemukan
persamaan dan perbedaan dari data [*phonebook* agar kita bisa menemukan
beberapa *entry* ganda yang ada](https://ikanx101.com/blog/phone-book/).
Pada tulisan tersebut, saya menggunakan algoritma yang berdasarkan
*cosine simmilarity*.

Kali ini saya akan membahas lebih detail apa yang disebut dengan
**persamaan** dan **pertaksamaan**.

------------------------------------------------------------------------

## *Simmilarity Vs Dissimilarity*

Prinsip sederhana yang digunakan untuk mengukur apakah dua data itu sama
atau tidak adalah dengan mengukur **jarak** antar kedua data tersebut.

> Data ![i](https://latex.codecogs.com/png.latex?i "i") dan
> ![j](https://latex.codecogs.com/png.latex?j "j") disebut sama jika
> jarak antar keduanya
> ![d(i,j) = 0](https://latex.codecogs.com/png.latex?d%28i%2Cj%29%20%3D%200 "d(i,j) = 0").

Pada tulisan terdahulu, saya pernah membedah [berbagai macam tipe dan
struktur data](https://ikanx101.com/blog/mengenal-data/). Masing-masing
tipe dan struktur data mmemiliki cara perhitungan jaraknya tersendiri.
Kita bahas satu-persatu berikut ini:

### Data Numerik

Misalkan saya punya dua titik numerik sebagai berikut:

![p_1 = (1,1) \text{ dan } p_2 = (3,3)](https://latex.codecogs.com/png.latex?p_1%20%3D%20%281%2C1%29%20%5Ctext%7B%20dan%20%7D%20p_2%20%3D%20%283%2C3%29 "p_1 = (1,1) \text{ dan } p_2 = (3,3)")

![](post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Untuk data numerik, ada beberapa perhitungan jarak seperti:

#### *Euclidean distance*

Yakni jarak terpendek antara dua titik. Cara perhitungannya adalah
dengan menggunakan rumus *Phytagoras*.

![d(p_1,p_2) = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}](https://latex.codecogs.com/png.latex?d%28p_1%2Cp_2%29%20%3D%20%5Csqrt%7B%28x_1%20-%20x_2%29%5E2%20%2B%20%28y_1%20-%20y_2%29%5E2%7D "d(p_1,p_2) = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}")

Dari dua titik di atas kita hitung jaraknya sebagai berikut:

![\begin{matrix}
d(p_1,p_2) & = & \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2} \\\\
 & = & \sqrt{(1 - 3)^2 + (1 - 3)^2} \\\\
 & = & \sqrt{8} \\\\
 & \approx & 2.828427
\end{matrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bmatrix%7D%0Ad%28p_1%2Cp_2%29%20%26%20%3D%20%26%20%5Csqrt%7B%28x_1%20-%20x_2%29%5E2%20%2B%20%28y_1%20-%20y_2%29%5E2%7D%20%5C%5C%0A%20%26%20%3D%20%26%20%5Csqrt%7B%281%20-%203%29%5E2%20%2B%20%281%20-%203%29%5E2%7D%20%5C%5C%0A%20%26%20%3D%20%26%20%5Csqrt%7B8%7D%20%5C%5C%0A%20%26%20%5Capprox%20%26%202.828427%0A%5Cend%7Bmatrix%7D "\begin{matrix}
d(p_1,p_2) & = & \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2} \\
 & = & \sqrt{(1 - 3)^2 + (1 - 3)^2} \\
 & = & \sqrt{8} \\
 & \approx & 2.828427
\end{matrix}")

#### *Manhattan distance*

Yakni jarak total yang dimiliki dari masing-masing dimensinya. Misalkan
dari dua titik di atas, kita akan menghitung jarak di masing-masing
sumbu ![x](https://latex.codecogs.com/png.latex?x "x") dan sumbu
![y](https://latex.codecogs.com/png.latex?y "y")-nya.

![d(p_1,p_2) = \|x_1 - x_2\| + \|y_1 - y_2\|](https://latex.codecogs.com/png.latex?d%28p_1%2Cp_2%29%20%3D%20%7Cx_1%20-%20x_2%7C%20%2B%20%7Cy_1%20-%20y_2%7C "d(p_1,p_2) = |x_1 - x_2| + |y_1 - y_2|")

Dari dua titik di atas kita hitung jaraknya sebagai berikut:

![\begin{matrix}
d(p_1,p_2) & = & \|x_1 - x_2\| + \|y_1 - y_2\| \\\\
 & = & \|1-3\| + \|1-3\| \\\\
 & = & 2 + 2 \\\\
 & = & 4
\end{matrix}](https://latex.codecogs.com/png.latex?%5Cbegin%7Bmatrix%7D%0Ad%28p_1%2Cp_2%29%20%26%20%3D%20%26%20%7Cx_1%20-%20x_2%7C%20%2B%20%7Cy_1%20-%20y_2%7C%20%5C%5C%0A%20%26%20%3D%20%26%20%7C1-3%7C%20%2B%20%7C1-3%7C%20%5C%5C%0A%20%26%20%3D%20%26%202%20%2B%202%20%5C%5C%0A%20%26%20%3D%20%26%204%0A%5Cend%7Bmatrix%7D "\begin{matrix}
d(p_1,p_2) & = & |x_1 - x_2| + |y_1 - y_2| \\
 & = & |1-3| + |1-3| \\
 & = & 2 + 2 \\
 & = & 4
\end{matrix}")

#### *Chebyshev distance*

Yakni jarak terjauh dari dua titik berdasarkan masing-masing dimensinya.
Kita hanya akan cari nilai jarak terjauh dari sumbu
![x](https://latex.codecogs.com/png.latex?x "x") atau sumbu
![y](https://latex.codecogs.com/png.latex?y "y").

![d(p_1,p_2) = \max{\|(x_1 - x_2)\|,\|(y_1 - y_2)\|}](https://latex.codecogs.com/png.latex?d%28p_1%2Cp_2%29%20%3D%20%5Cmax%7B%7C%28x_1%20-%20x_2%29%7C%2C%7C%28y_1%20-%20y_2%29%7C%7D "d(p_1,p_2) = \max{|(x_1 - x_2)|,|(y_1 - y_2)|}")

Pada kasus ini, jarak baik di sumbu
![x](https://latex.codecogs.com/png.latex?x "x") dan
![y](https://latex.codecogs.com/png.latex?y "y") adalah sama-sama
![2](https://latex.codecogs.com/png.latex?2 "2").

------------------------------------------------------------------------

Selain ketiga metode di atas, ada berbagai macam cara perhitungan jarak
lain yang bisa digunakan.

------------------------------------------------------------------------

### Data Kategorik

Jika pada bagian di atas, kita telah membahas perhitungan jarak pada
data numerik. Bagaimana jika kita memiliki data kategorik? Hal yang sama
bisa juga digunakan untuk data non-numerik seperti data teks.

Misalkan, saya hendak mencari jarak dari data berikut ini:

| orang | hobi           |
|------:|:---------------|
|     1 | masak,nonton   |
|     2 | masak,otomotif |

Seberapa mirip kedua orang tersebut? Bagaimana mengukur jarak mereka?

Kita ubah terlebih dahulu kedua data tersebut menjadi bentuk kategorik
dan *binary*. Setelah itu, kita bisa mengukur jarak antara keduanya.

Ubah datanya dalam bentuk seperti ini:

| orang | masak | nonton | otomotif |
|------:|------:|-------:|---------:|
|     1 |     1 |      1 |        0 |
|     2 |     1 |      0 |        1 |

Setelah itu, kita bisa ukur dengan beberapa cara perhitungan jarak.

``` r
# dataset yang digunakan
df_new
```

    ##   orang masak nonton otomotif
    ## 1     1     1      1        0
    ## 2     2     1      0        1

``` r
# kita simpan dulu beberapa variabel penting
hobi_1 = df_new$masak[2] - df_new$masak[1]
hobi_2 = df_new$nonton[2] - df_new$nonton[1]
hobi_3 = df_new$otomotif[2] - df_new$otomotif[1]
```

#### *Euclidean distance*

``` r
jarak_ecl = sqrt(hobi_1^2 + hobi_2^2 + hobi_3^2)
jarak_ecl
```

    ## [1] 1.414214

#### *Manhattan distance*

``` r
jarak_man = hobi_1 + hobi_2 + hobi_3
jarak_man
```

    ## [1] 0

#### *Chebyshev distance*

``` r
jarak_che = max(hobi_1,hobi_2,hobi_3)
jarak_che
```

    ## [1] 1

------------------------------------------------------------------------

Kelak perhitungan jarak ini adalah **kunci** untuk menentukan seberapa
mirip atau tidak mirip sepasang data.

Bagaimana mudah kan?

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
