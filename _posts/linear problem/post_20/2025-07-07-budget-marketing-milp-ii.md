---
date: 2025-07-07T11:29:00-04:00
title: "Optimization Story: Optimisasi Alokasi Budget Marketing Perusahaan II"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Optimization Story
  - Mixed Integer Linear Programming
  - Budget
  - Marketing
  - Campaign
---

Masih melanjutkan *post* saya [sebelumnya terkait pemilihan alokasi
*budget* *marketing*](https://ikanx101.com/blog/budget-marketing-milp/).
Kali ini saya akan menuliskan kembali kasus kedua terkait optimisasi
perusahaan saat mengalokasikan *budget marketing*-nya.

------------------------------------------------------------------------

## **Latar Belakang**

Sebuah perusahaan ingin memilih kombinasi promosi dari tiga *channel*
berikut ini:

1.  Radio,
2.  Koran,
3.  Spanduk.

Dengan biaya seminimal mungkin tapi harus menjangkau (*reach*) minimal
**150.000 orang pelanggan**. Setiap *channel* memiliki *fixed cost*
(jika dipilih) dan memiliki tingkat jangkauan berbeda-beda.

| Channel | Biaya Tetap (\$) | Biaya per Unit (\$) | Jangkauan per Unit (ribu pelanggan) |
|----|----|----|----|
| Radio | 500 | \- | 40 |
| Koran | 300 | \- | 25 |
| Spanduk | 100 | 50 | 10 (per spanduk) |

Berbeda dengan radio dan koran, spanduk memiliki dua jenis biaya yakni
**biaya tetap** dan **biaya per unit** (karena bisa ditaruh di beberapa
tempat yang berbeda-beda).

Agar bisa melakukan formulasi model matematikanya, saya perlu menuliskan
beberapa hal berikut ini:

### **Variabel Keputusan:**

- ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") : *Binary* (1
  jika memilih radio, 0 jika tidak).
- ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2") : *Binary* (1
  jika memilih koran, 0 jika tidak).
- ![x_3](https://latex.codecogs.com/svg.latex?x_3 "x_3") : *Binary* (1
  jika memilih spanduk, 0 jika tidak).
- ![y](https://latex.codecogs.com/svg.latex?y "y") : Jumlah unit spanduk
  (integer ≥ 0) *(karena Spanduk bisa dipasang lebih dari satu lokasi)*

### **Formulasi Matematika:**

*Objective function* bisa dituliskan sebagai berikut:

![\min{\text{budget}} = 500x_1 + 300x_2 + 100x_3 + 50y](https://latex.codecogs.com/svg.latex?%5Cmin%7B%5Ctext%7Bbudget%7D%7D%20%3D%20500x_1%20%2B%20300x_2%20%2B%20100x_3%20%2B%2050y "\min{\text{budget}} = 500x_1 + 300x_2 + 100x_3 + 50y")

Yakni meminimumkan *budget* *marketing* dengan *constraints*:

1.  **Target Jangkauan Pelanggan:**
    ![40x_1 + 25x_2 + 10y \>= 150](https://latex.codecogs.com/svg.latex?40x_1%20%2B%2025x_2%20%2B%2010y%20%3E%3D%20150 "40x_1 + 25x_2 + 10y >= 150").
2.  **Spanduk Hanya Digunakan Jika Dipilih
    (**![x_3 = 1](https://latex.codecogs.com/svg.latex?x_3%20%3D%201 "x_3 = 1")):
    Maka untuk menghubungkan
    ![x_3](https://latex.codecogs.com/svg.latex?x_3 "x_3") dan
    ![y](https://latex.codecogs.com/svg.latex?y "y") kita bisa
    menggunakan hubungan sebagai berikut:
    ![y \leq M x_3 \quad \text{(M = bilangan besar, misal 100)}](https://latex.codecogs.com/svg.latex?y%20%5Cleq%20M%20x_3%20%5Cquad%20%5Ctext%7B%28M%20%3D%20bilangan%20besar%2C%20misal%20100%29%7D "y \leq M x_3 \quad \text{(M = bilangan besar, misal 100)}").
3.  **Non-negatif dan Integer:**
    ![x_1, x_2, x_3 \in \\0,1\\, \quad y \in \mathbb{Z}^+](https://latex.codecogs.com/svg.latex?x_1%2C%20x_2%2C%20x_3%20%5Cin%20%5C%7B0%2C1%5C%7D%2C%20%5Cquad%20y%20%5Cin%20%5Cmathbb%7BZ%7D%5E%2B "x_1, x_2, x_3 \in \{0,1\}, \quad y \in \mathbb{Z}^+").

Model tersebut akan saya *solve* menggunakan **R** sebagai berikut:

    Mixed integer linear optimization problem
    Variables:
      Continuous: 0 
      Integer: 1 
      Binary: 3 
    Model sense: minimize 
    Constraints: 2 

    <SOLVER MSG>  ----
    GLPK Simplex Optimizer 5.0
    2 rows, 4 columns, 5 non-zeros
          0: obj =   0.000000000e+00 inf =   1.500e+02 (1)
          4: obj =   1.233500000e+03 inf =   0.000e+00 (0)
    *     6: obj =   7.650000000e+02 inf =   0.000e+00 (0)
    OPTIMAL LP SOLUTION FOUND
    GLPK Integer Optimizer 5.0
    2 rows, 4 columns, 5 non-zeros
    4 integer variables, 3 of which are binary
    Integer optimization begins...
    Long-step dual simplex will be used
    +     6: mip =     not found yet >=              -inf        (1; 0)
    +     7: >>>>>   8.500000000e+02 >=   8.500000000e+02   0.0% (1; 0)
    +     7: mip =   8.500000000e+02 >=     tree is empty   0.0% (0; 1)
    INTEGER OPTIMAL SOLUTION FOUND
    <!SOLVER MSG> ----

    Status: success
    Objective value: 850

**R** menghasilkan *total spending budget* sebesar 850\$ saja dengan
cara:

| channel | decision |
|:--------|---------:|
| Radio   |        0 |
| Koran   |        0 |
| Spanduk |        1 |

     y 
    15 

Hanya menggunakan spanduk dan menggunakan 15 unit spanduk saja agar
tepat *reach* 150.000 orang pelanggan.

Perlu diperhatikan bahwa tujuan dari masalah ini adalah meminimumkan
*budget* *marketing* sehingga mendapatkan *reach* yang pas dengan
*constraint* tidaklah mengapa.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
