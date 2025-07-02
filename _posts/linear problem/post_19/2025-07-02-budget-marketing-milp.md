---
date: 2025-07-02T11:22:00-04:00
title: "Optimization Story: Optimisasi Alokasi Budget Marketing Perusahaan"
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

Kemarin ada seorang rekan kerja dari departemen yang berbeda bertanya
kepada saya:

> *“Kang, kamu familiar dengan MILP?”*

Say tentu jawab: **iya**. Tesis saya merupakan contoh kasus MILP dan
hampir semua *post* dengan *tag* [*optimization
story*](https://ikanx101.com/tags/#optimization-story) merupakan
contoh-contoh kasus *mixed integer linear programming*. Kali ini saya
mau *share* contoh kasus MILP sederhana dalam dunia *marketing*.

------------------------------------------------------------------------

Sebuah perusahaan ingin mengalokasikan *marketing budget* ke tiga jenis
promosi:

1.  iklan TV,
2.  Sosial Media, dan
3.  *Email*.

Ketiga jenis promosi ini bertujuan untuk memaksimalkan total omset.
Namun perlu diperhatikan bahwa perusahaan pasti memiliki keterbatasan
*budget* dan harus memilih minimal satu jenis promosi berbayar berupa TV
atau sosial media. Perusahaan memiliki *budget* maksimum sebesar Rp 10
juta.

Jadi jenis promosi apa yang harus dipilih? Kita akan mencarinya
menggunakan optimisasi matematika.

Pertama-tama kita akan memformulasikan masalah di atas menjadi bahasa
optimisasi berikut ini:

### **Variabel Keputusan**

Kita akan mendefinisikan *decision variable* (variabel keputusan), yakni
inti keputusan yang akan diambil kelak.

- ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") : *Budget*
  untuk iklan TV (dalam juta rupiah). Nilai
  ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") kita
  definisikan bertipe **continuous**.
- ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2") : *Budget*
  untuk iklan sosial media (dalam juta rupiah), variabel ini juga kita
  definisikan bertipe **continuous**.
- ![x_3](https://latex.codecogs.com/svg.latex?x_3 "x_3") : *Budget*
  untuk iklan melalui *email marketing*, variabel ini jugat
  didefinisikan bertipe **continuous**.
- ![y](https://latex.codecogs.com/svg.latex?y "y") : *Binary* (1 jika
  memilih *email marketing* atau 0 jika tidak).

### **Parameter**

Setiap *known values* dari masalah ini disebut dengan **parameter**.
Pada kasus ini, kita memiliki informasi berikut ini:

- **ROI** (*Return on Investment*) setiap jenis promosi:
  - TV: 3x (setiap Rp1 *spending* iklan menghasilkan Rp3 penjualan).  
  - Sosial Media: 2x  
  - *Email*: 5x (tetapi hanya aktif jika
    ![y = 1](https://latex.codecogs.com/svg.latex?y%20%3D%201 "y = 1")).  
- *Budget* total: Rp10,000,000.
- Biaya tetap untuk *email marketing*: Rp2,000,000 (jika dipilih).
- Minimal alokasi untuk TV atau Sosial Media: Rp3,000,000.

### **Formulasi Matematika**

Tujuan masalah ini adalah memaksimalkan ROI dari *spending* promosi.

**Fungsi Tujuan (Maksimalkan Penjualan)**

Berikut adalah *objective function* dari masalah ini.

![\max{\text{(omset)}}= 3x_1 + 2x_2 + 5 x_3 \cdot y](https://latex.codecogs.com/svg.latex?%5Cmax%7B%5Ctext%7B%28omset%29%7D%7D%3D%203x_1%20%2B%202x_2%20%2B%205%20x_3%20%5Ccdot%20y "\max{\text{(omset)}}= 3x_1 + 2x_2 + 5 x_3 \cdot y")

**Batasan (Constraints):**

1.  **Budget Total:**

    ![x_1 + x_2 + y \cdot (x_3 + 2) \leq 10](https://latex.codecogs.com/svg.latex?x_1%20%2B%20x_2%20%2B%20y%20%5Ccdot%20%28x_3%20%2B%202%29%20%5Cleq%2010 "x_1 + x_2 + y \cdot (x_3 + 2) \leq 10")

    *Budget* dalam juta rupiah, biaya Email termasuk jika ia dipilih.

2.  **Minimal Alokasi TV atau Sosial Media:**

    ![x_1 + x_2 \geq 3](https://latex.codecogs.com/svg.latex?x_1%20%2B%20x_2%20%5Cgeq%203 "x_1 + x_2 \geq 3")

3.  **Email Marketing Hanya Jika Dipilih
    (![y](https://latex.codecogs.com/svg.latex?y "y")) binary):**

    ![x_3 \leq My \quad \text{(M = bilangan besar, misal 10)}](https://latex.codecogs.com/svg.latex?x_3%20%5Cleq%20My%20%5Cquad%20%5Ctext%7B%28M%20%3D%20bilangan%20besar%2C%20misal%2010%29%7D "x_3 \leq My \quad \text{(M = bilangan besar, misal 10)}")

    Jika
    ![y = 0](https://latex.codecogs.com/svg.latex?y%20%3D%200 "y = 0")
    maka
    ![x_3 = 0](https://latex.codecogs.com/svg.latex?x_3%20%3D%200 "x_3 = 0").

4.  **Non-negatif dan Binary:**

    ![x_1, x_2, x_3 \geq 0, \quad y \in \\0,1\\](https://latex.codecogs.com/svg.latex?x_1%2C%20x_2%2C%20x_3%20%5Cgeq%200%2C%20%5Cquad%20y%20%5Cin%20%5C%7B0%2C1%5C%7D "x_1, x_2, x_3 \geq 0, \quad y \in \{0,1\}")

Untuk menyelesaikan masalah ini, saya akan membuat skripnya di **R**
menggunakan `library(ompr)` sebagai berikut:

    Mixed integer linear optimization problem
    Variables:
      Continuous: 3 
      Integer: 0 
      Binary: 1 
    Model sense: maximize 
    Constraints: 3 

    <SOLVER MSG>  ----
    GLPK Simplex Optimizer 5.0
    3 rows, 4 columns, 7 non-zeros
          0: obj =  -0.000000000e+00 inf =   3.000e+00 (1)
          1: obj =   9.000000000e+00 inf =   0.000e+00 (0)
    *     3: obj =   3.400000000e+01 inf =   0.000e+00 (0)
    OPTIMAL LP SOLUTION FOUND
    GLPK Integer Optimizer 5.0
    3 rows, 4 columns, 7 non-zeros
    1 integer variable,  which is binary
    Integer optimization begins...
    Long-step dual simplex will be used
    +     3: mip =     not found yet <=              +inf        (1; 0)
    +     4: >>>>>   3.400000000e+01 <=   3.400000000e+01   0.0% (2; 0)
    +     4: mip =   3.400000000e+01 <=     tree is empty   0.0% (0; 3)
    INTEGER OPTIMAL SOLUTION FOUND
    <!SOLVER MSG> ----

Solusi yang dihasilkan adalah:

    Status: success
    Objective value: 34

Max omset yang didapatkan sebesar Rp34 juta dengan konfigurasi:

| jenis_promosi   | budget_dlm_juta |
|:----------------|----------------:|
| TV              |               3 |
| Sosial media    |               0 |
| Email marketing |               5 |

*Expected* ROI dari:

- TV: budget sebesar Rp3 juta menghasilkan omset Rp9 juta.  
- *Email marketing*: Rp5juta menghasilkan omset Rp25 juta.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
