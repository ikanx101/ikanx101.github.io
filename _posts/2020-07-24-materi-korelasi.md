---
date: 2020-07-24T09:10:00-04:00
title: "Materi Training: Korelasi"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Korelasi
---

# Apa itu Korelasi?

## Definisi

Secara definisi statistika, korelasi adalah:

> **Linear strength and direction** of a relationship between two
> variables.

Ada tiga *keywords* yang penting pada definisi tersebut, yakni:

1.  *Variables*, yakni dua variabel yang ingin dicek hubungannya.
2.  *Linear Strengh*, menandakan seberapa kuat kedua variabel tersebut
    secara linear.
3.  *Direction*, menandakan arah dari hubungan kedua variabel tersebut.

Kita akan bahas satu-persatu yah.

### *Variables*

Ada hal penting yang perlu diperhatikan saat kita hendak melakukan
analisa korelasi. Apa itu?

1.  Pastikan kedua variabel yang akan kita uji secara logis dapat
    dihubungkan.
2.  Kedua variabel tersebut harus berupa numerik.

Masih ingat dengan tipe-tipe data?

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-07-24-materi-korelasi_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Jadi, hanya data kuantitatif saja yang bisa dihitung korelasinya.

-----

#### Variabel dengan tipe data kualitatif

Jadi jika saya memiliki data kualitatif, apakah tidak bisa dihitung
korelasinya?

> Jawabannya: tetap bisa

Namun tidak menggunakan metode yang selama ini umum digunakan. Karena
saat kita berbicara mengenai korelasi, sebenarnya kita hanya
membicarakan hubungan dari dua data kuantitatif saja.

Korelasi dengan data kualitatif akan saya jelaskan di kemudian hari yah.

-----

### *Linear Strengh*

Korelasi adalah suatu nilai yang berada di selang angka `-1` hingga `1`.
Nilai mutlak dari korelasi menandakan seberapa kuat hubungan kedua
variabel secara linear.

Apa sih maksudnya?

Jika kita buat grafik sumbu x vs sumbu y, kekuatan kedua variabel
`(x,y)` secara visual dapat dilihat dari seberapa mudah titik-titik yang
ditimbulkan dibuat garis lurus. Semakin membentuk garis lurus sempurna,
kita bisa katakan bahwa kedua variabel memiliki korelasi kuat. Begitupun
sebaliknya.

Coba lihat kembali gambar di awal halaman\!

Semakin menuju ke angka `1` atau `-1` (ingat, yang dilihat nilai
mutlaknya yah\!), kedua variabel dalam sumbu kartesian membentuk garis
lurus sempurna.

Pengelompokan kekuatan korelasi:

1.  Low : `0.1` - `0.3`
2.  Medium : `0.3` - `0.5`
3.  High : `0.5` - `1.0`

### *Direction*

Kalau kita lihat kembali, nilai korelasi bisa bernilai **positif** atau
**negatif**. `+/-` itu menunjukan arah hubungan kedua variabel tersebut.

  - Jika bernilai positif maka hubungan kedua variabel tersebut itu
    berbanding lurus. Contoh: `x` naik maka `y` juga naik.
  - Jika bernilai negatif maka hubungan kedua variabel tersebut itu
    berbanding lurus. Contoh: `x` naik maka `y` juga turun.

-----

## Cara Menghitung Korelasi

Sebagaimana kita ketahui, perhitungan statistik itu ada dua macam.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/2020-07-24-materi-korelasi_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Hal ini juga mempengaruhi cara kita menghitung korelasi.

  - Pearson, menggunakan parametrik.
  - Spearman, menggunakan non parametrik.

Secara *default*, **Ms. Excel** menggunakan cara perhitungan parametrik
(**Pearson**). Oleh karena itu harap kita perhatikan saat kita hendak
menghitung korelasi di **Ms. Excel**.

-----

## Hasil dari Perhitungan Korelasi

Sebenarnya selain angka korelasi, ada satu angka lagi yang perlu
diperhatikan saat melakukan analisa korelasi.

Apa itu?

**Signifikansi**

Langkah yang *proper* adalah menghitung signifikansi terlebih dahulu.
Jika hasilnya signifikan, maka kita baru bisa menghitung nilai korelasi.

Jika sebaliknya, kita dapatkan tidak signifikan, maka tidak perlu
dihitung angka korelasinya.
