Optimization Story: Sport Science - Menentukan Konfigurasi Pelari
Estafet
================

Salah satu kegunaan *artificial intelligence* dan *data science* di
bidang olahraga adalah melakukan
[prediksi](https://ikanx101.com/blog/prediksi-EPL/) terhadap suatu
kejadian. Tapi ada satu *field* lagi yang mungkin jarang orang ketahui,
yakni: ***optimization***.

Saya akan berikan contoh simpel penerapan *optimization* di bidang
olahraga, khususnya di cabang lari estafet.

-----

## Masalah

Seorang pelatih estafet hendak mendaftarkan timnya untuk mengikuti
kompetisi di suatu waktu. Pelatih tersebut harus memilih **4 dari 6**
orang pelari anak didiknya. Untuk itu, dia melakukan beberapa kali
simulasi dan mencatatkan waktunya sebagai berikut:

| Pelari     | Fraction 1 | Fraction 2 | Fraction 3 | Fraction 4 |
| :--------- | ---------: | ---------: | ---------: | ---------: |
| Sprinter 1 |      12.27 |      11.57 |      11.54 |      12.07 |
| Sprinter 2 |      11.34 |      11.45 |      12.45 |      12.34 |
| Sprinter 3 |      11.29 |      11.50 |      11.45 |      11.52 |
| Sprinter 4 |      12.54 |      12.34 |      12.32 |      11.57 |
| Sprinter 5 |      12.20 |      11.22 |      12.07 |      12.03 |
| Sprinter 6 |      11.54 |      11.48 |      11.56 |      12.30 |

> ***Hanya boleh satu pelari yang menempati satu fraction.***

Bagaimana cara si pelatih menentukan pelari mana yang harus di-*assign*?

-----

## Formulasi Masalah

Oke, untuk menyelesaikannya kita akan buat terlebih dahulu formulasi
matematikanya sebagai berikut.

Misalkan saya definisikan
![x\_{ij}](https://latex.codecogs.com/png.latex?x_%7Bij%7D "x_{ij}")
sebagai bilangan *binary*
![\[0,1\]](https://latex.codecogs.com/png.latex?%5B0%2C1%5D "[0,1]").

  
![x\_{ij} = \\left\\{\\begin{matrix}
1, \\text{ jika pelari i lari di fraction j} \\\\ 0, \\text{ pelari i
tidak dipilih pada fraction j} 
\\end{matrix}\\right.](https://latex.codecogs.com/png.latex?x_%7Bij%7D%20%3D%20%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%0A1%2C%20%5Ctext%7B%20jika%20pelari%20i%20lari%20di%20fraction%20j%7D%20%5C%5C%200%2C%20%5Ctext%7B%20pelari%20i%20tidak%20dipilih%20pada%20fraction%20j%7D%20%0A%5Cend%7Bmatrix%7D%5Cright.
"x_{ij} = \\left\\{\\begin{matrix}
1, \\text{ jika pelari i lari di fraction j} \\\\ 0, \\text{ pelari i tidak dipilih pada fraction j} 
\\end{matrix}\\right.")  

***Objective Functions***

Tujuan kita adalah meminimalkan waktu lari keseluruhan tim.

  
![\\min \\sum\_{j=1}^4 \\sum\_{i=1}^6 t\_{ij}
x\_{ij}](https://latex.codecogs.com/png.latex?%5Cmin%20%5Csum_%7Bj%3D1%7D%5E4%20%5Csum_%7Bi%3D1%7D%5E6%20t_%7Bij%7D%20x_%7Bij%7D
"\\min \\sum_{j=1}^4 \\sum_{i=1}^6 t_{ij} x_{ij}")  

Dengan ![T\_{ij}](https://latex.codecogs.com/png.latex?T_%7Bij%7D
"T_{ij}") adalah waktu lari pelari
![i](https://latex.codecogs.com/png.latex?i "i") pada *fraction*
![j](https://latex.codecogs.com/png.latex?j "j").

***Constraints***

Kendala dari masalah ini adalah:

Satu *fraction* wajib diisi satu pelari:

  
![\\sum\_{i=1}^6 x\_{ij} = 1, \\forall j, 1 \\leq j
\\leq 4](https://latex.codecogs.com/png.latex?%5Csum_%7Bi%3D1%7D%5E6%20x_%7Bij%7D%20%3D%201%2C%20%5Cforall%20j%2C%201%20%5Cleq%20j%20%5Cleq%204
"\\sum_{i=1}^6 x_{ij} = 1, \\forall j, 1 \\leq j \\leq 4")  

Satu pelari harus berlari di satu *fraction* atau tidak berlari sama
sekali:

  
![\\sum\_{j=1}^4 x\_{ij} \\leq 1, \\forall i \\in 1 \\leq i
\\leq 6](https://latex.codecogs.com/png.latex?%5Csum_%7Bj%3D1%7D%5E4%20x_%7Bij%7D%20%5Cleq%201%2C%20%5Cforall%20i%20%5Cin%201%20%5Cleq%20i%20%5Cleq%206
"\\sum_{j=1}^4 x_{ij} \\leq 1, \\forall i \\in 1 \\leq i \\leq 6")  

-----

# *Solver*

Mari kita selesaikan dengan `ompr` di **R**.

``` r
library(dplyr)
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

bin_prog = 
  MIPModel() %>%
  # menambah variabel
  add_variable(x[i,j],
           i = 1:6,
           j = 1:4,
           type = "binary",
           lb = 0) %>%
  # membuat objective function
  set_objective(sum_expr(waktu[i,j]*x[i,j],
             i = 1:6,
             j = 1:4),
        "min") %>%
  # constraint 1
  add_constraint(sum_expr(x[i,j],i = 1:6) == 1,
         j = 1:4) %>%
  # constraint 2
  add_constraint(sum_expr(x[i,j],j = 1:4) <= 1,
         i = 1:6) 
bin_prog 
```

    ## Mixed integer linear optimization problem
    ## Variables:
    ##   Continuous: 0 
    ##   Integer: 0 
    ##   Binary: 24 
    ## Model sense: minimize 
    ## Constraints: 10

``` r
hasil %>%
  get_solution(x[i,j])
```

    ##    variable i j value
    ## 1         x 1 1     0
    ## 2         x 2 1     1
    ## 3         x 3 1     0
    ## 4         x 4 1     0
    ## 5         x 5 1     0
    ## 6         x 6 1     0
    ## 7         x 1 2     0
    ## 8         x 2 2     0
    ## 9         x 3 2     0
    ## 10        x 4 2     0
    ## 11        x 5 2     1
    ## 12        x 6 2     0
    ## 13        x 1 3     0
    ## 14        x 2 3     0
    ## 15        x 3 3     1
    ## 16        x 4 3     0
    ## 17        x 5 3     0
    ## 18        x 6 3     0
    ## 19        x 1 4     0
    ## 20        x 2 4     0
    ## 21        x 3 4     0
    ## 22        x 4 4     1
    ## 23        x 5 4     0
    ## 24        x 6 4     0
