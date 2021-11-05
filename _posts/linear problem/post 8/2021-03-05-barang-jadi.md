---
date: 2021-03-05T16:10:00-04:00
title: "Optimization Story: Pemilihan Jalur Distribusi Barang Jadi"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Binary Linear Programming
  - Optimization Story
  - Mixed Integer Linear Programming
---

Suatu perusahaan manufaktur memiliki dua *factories* yang terpisah
jaraknya. Kedua *factories* tersebut memproduksi **barang jadi** untuk
kemudian dijual oleh *distributor*. Ada alur distribusi yang harus
dilalui **barang jadi** tersebut hingga ke tangan *distributor*.
Bagaimana alurnya?

Berikut adalah *flow*-nya:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/linear%20problem/post%208/alur.png" width="30%" style="display: block; margin: auto;" />

  - *Factory 1* **bisa** mendistribusikan **barang jadi** tersebut ke:
      - *Factory 2*,
      - *Distribution center*, dan
      - *Warehouse 1*.
  - *Factory 2* **hanya bisa** mendistribusikan **barang jadi** ke
    *distribution center*.
  - *Distribution center* **hanya bisa** mendistribusikan **barang
    jadi** ke *warehouse 2*.
  - *Warehouse 1* **bisa** saling *overflow* barang **dari dan ke**
    *warehouse 2*.
  - Distributor akan mengambil **barang jadi** jadi *warehouse 1*
    dan/atau *warehouse 2*.

*Nah*, berikut data pelengkap lainnya:

  - Produksi:
      - *Factory 1* hanya bisa menghasilkan **barang jadi** sebanyak
        `50` unit per hari.
      - *Factory 2* hanya bisa menghasilkan **barang jadi** sebanyak
        `40` unit per hari.
  - Transportasi:
      - Biaya transportasi **barang jadi** dari *Factory 1* ke *Factory
        2* adalah `Rp200`/unit. Tapi karena keterbatasan *space* yang
        ada, *transporter* hanya bisa mengangkut maksimal `10` unit per
        hari.
      - Biaya transportasi **barang jadi** dari *Factory 1* ke
        *distribution center* adalah `Rp400`/unit. Tidak ada batasan
        berapa banyak unit yang bisa diantar.
      - Biaya transportasi **barang jadi** dari *Factory 1* ke
        *warehouse 1* adalah `Rp900`/unit. Tidak ada batasan berapa
        banyak unit yang bisa diantar.
      - Biaya transportasi **barang jadi** dari *Factory 2* ke
        *distribution center* adalah `Rp300`/unit. Tidak ada batasan
        berapa banyak unit yang bisa diantar.
      - Biaya transportasi **barang jadi** dari *distribution center* ke
        *warehouse 2* adalah `Rp100`/unit. Tapi karena keterbatasan
        *space* yang ada, *transporter* hanya bisa mengangkut maksimal
        `80` unit per hari.
      - Biaya transportasi **barang jadi** dari *warehouse 1* ke
        *warehouse 2* adalah `Rp300`/unit. Sedangkan biaya transportasi
        **barang jadi** dari *warehouse 2* ke *warehouse 1* adalah
        `Rp200`/unit.Tidak ada batasan berapa banyak unit yang bisa
        diantar.
  - *Stock Level*
      - *Warehouse 1* harus memiliki `30` unit **barang jadi** dalam
        sehari untuk di-*pick up* oleh distributor.
      - *Warehouse 2* harus memiliki `60` unit **barang jadi** dalam
        sehari untuk di-*pick up* oleh distributor.
      - *Distribution center* hanya berfungsi sebagai tempat perantara
        dan *sorting center* sehingga **tidak boleh** menyimpan **barang
        jadi** sama sekali.

### *Problem*

Bagaimana jalur distribusi yang paling optimal?

Definisi optimal:

> Jalur distribusi yang memiliki *cost* paling kecil dengan tetap
> memenuhi kebutuhan distributor.

-----

## Model Matematika

Untuk memecahkan masalah *optimization* ini, saya akan buat model
matematikanya.

### Definisi variabel

Namun, saya akan mendefinisikan variabel berikut ini:

![formula](https://render.githubusercontent.com/render/math?math=x_%7Ba1-a2%7D)
: **barang jadi** yang ditransport dari titik `a1` ke titik `a2`.

### *Objective function*

Tujuan model ini adalah meminimalisir *cost*:

![formula](https://render.githubusercontent.com/render/math?math=F%20=%20200x_%7BF1-F2%7D%20%2B%20400x_%7BF1-DC%7D%20%2B%20900x_%7BF1-W1%7D%20%2B%20300x_%7BF2-DC%7D%20%2B%20100x_%7BDC-W2%7D%20%2B%20300x_%7BW1-W2%7D%20%2B%20200x_%7BW2-W1%7D)

![formula](https://render.githubusercontent.com/render/math?math=min\(F\))

### *Constraints*

Ini adalah *constraints* yang dihadapi:

*Factory 1*

![formula](https://render.githubusercontent.com/render/math?math=x_%7BF1-F2%7D%20%2B%20x_%7BF1-DC%7D%20%2B%20x_%7BF1-W1%7D%20=%2050)

*Factory 2*

![formula](https://render.githubusercontent.com/render/math?math=-x_%7BF1-F2%7D%20%2B%20x_%7BF2-DC%7D%20=%2040)

*Distribution Center*

![formula](https://render.githubusercontent.com/render/math?math=-x_%7BF1-DC%7D%20-%20x_%7BF2-DC%7D%20%2B%20x_%7BDC-W2%7D%20=%200)

*Warehouse 1*

![formula](https://render.githubusercontent.com/render/math?math=-x_%7BF1-W1%7D%20%2B%20x_%7BW1-W2%7D%20-%20x_%7BW2-W1%7D%20=%20-30)

*Warehouse 2*

![formula](https://render.githubusercontent.com/render/math?math=-x_%7BDC-W2%7D%20-%20x_%7BW1-W2%7D%20%2B%20x_%7BW2-W1%7D%20=%20-60)

*Max* transportasi *factory 1* ke *factory 2*:

  
![x\_{F1-F2}
\\leq 10](https://latex.codecogs.com/png.latex?x_%7BF1-F2%7D%20%5Cleq%2010
"x_{F1-F2} \\leq 10")  

*Max* transportasi *distribution center* ke *warehouse 2*:

  
![x\_{DC-W2}
\\leq 80](https://latex.codecogs.com/png.latex?x_%7BDC-W2%7D%20%5Cleq%2080
"x_{DC-W2} \\leq 80")  

*Min* nilai ![x](https://latex.codecogs.com/png.latex?x "x"):

  
![x \\geq 0](https://latex.codecogs.com/png.latex?x%20%5Cgeq%200
"x \\geq 0")  

-----

## Solusi

Dari *constraints* di atas, saya bisa menyelesaikannya dengan bantuan
*solver* di **R**. Sehingga solusi yang saya dapatkan adalah sebagai
berikut:

  
![x\_{F1-F2}
= 0](https://latex.codecogs.com/png.latex?x_%7BF1-F2%7D%20%3D%200
"x_{F1-F2} = 0")  

  
![x\_{F1-DC}
= 40](https://latex.codecogs.com/png.latex?x_%7BF1-DC%7D%20%3D%2040
"x_{F1-DC} = 40")  

  
![x\_{F1-W1}
= 10](https://latex.codecogs.com/png.latex?x_%7BF1-W1%7D%20%3D%2010
"x_{F1-W1} = 10")  

  
![x\_{F2-DC}
= 40](https://latex.codecogs.com/png.latex?x_%7BF2-DC%7D%20%3D%2040
"x_{F2-DC} = 40")  

  
![x\_{DC-W2}
= 80](https://latex.codecogs.com/png.latex?x_%7BDC-W2%7D%20%3D%2080
"x_{DC-W2} = 80")  

  
![x\_{W1-W2}
= 0](https://latex.codecogs.com/png.latex?x_%7BW1-W2%7D%20%3D%200
"x_{W1-W2} = 0")  

  
![x\_{W2-W1}
= 20](https://latex.codecogs.com/png.latex?x_%7BW2-W1%7D%20%3D%2020
"x_{W2-W1} = 20")  

Jika dibuat *summary*-nya:

> *Factory 1* memproduksi 50 unit **barang jadi**. Sebanyak 10 unit
> langsung dikirim ke *warehouse 1*, sisanya (40 unit) dikirim ke
> *distibution center*. Sedangkan *factory 2* 40 unit dan semuanya
> langsung dikirim ke *distribution center*. Sehingga di *distribution
> center* ada total 80 unit **barang jadi**. Semuanya lantas dikirim ke
> *warehouse 2*. Karena *warehouse 2* hanya bisa menampung 60 unit, maka
> 20 unit di-*overflow* ke *warehouse 1*.

Total *cost* yang dihasilkan adalah `Rp49.000` dan ini merupakan *cost*
yang paling kecil di antara semua alternatif yang mungkin.

-----

`if you find this article helpful, please support this blog by clicking
the ads.`
