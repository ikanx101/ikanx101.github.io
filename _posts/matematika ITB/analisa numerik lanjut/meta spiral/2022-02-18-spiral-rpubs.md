---
date: 2022-02-18T11:54:00-04:00
title: "Berkenalan dengan Spiral Dynamic Optimization Algorithm"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - Algoritma
  - Komputasi
  - Aproksimasi
  - Meta Heuristic
  - Spiral Optimization
---


## Pendahuluan

Di blog saya ini, saya seringkali membahas bagaimana matematika bisa
digunakan untuk memodelkan masalah *real* terkait dengan
[optimisasi](https://ikanx101.com/tags/#optimization-story), yakni
pencarian suatu nilai solusi yang bisa memaksimalkan atau meminimalkan
suatu kondisi. Namun jika kalian menyadari, hal yang saya bahas masih
terbatas pada masalah *mixed integer linear programming* saja.

Sejatinya masalah optimisasi yang ada pada dunia matematika sangatlah
luas. Mulai dari bentuk *objective function* yang non linear sampai
masalah yang tidak memiliki *constraints* sama sekali.

Masalah optimisasi ini lebih panjang sejarahnya dibandingkan optimisasi
yang berkaitan dengan *operational research*, yakni sejak zaman kalkulus
dikembangkan (masalah pencarian titik maksimal atau minimal).

Hal yang menarik bagi saya adalah, ternyata metode pencarian titik
maksimum atau minimum ini bisa dikembangkan untuk mencari solusi dari
berbagai tipe permasalahan seperti pencarian akar persamaan dengan hanya
memodifikasi bentuk *objective function* asalnya.

Untuk menyelesaikan suatu permasalahan optimisasi, setidaknya ada dua
pendekatan yang bisa kita lakukan. Yakni:

1.  Metode eksak,
2.  Metode *meta heuristic*.

Permasalahannya tidak semua dari kita memahami bagaimana cara melakukan
metode eksak karena membutuhkan pengetahuan matematis yang ekstra.
Selain itu beberapa permasalahan kadang tidak memiliki solusi secara
eksak.

Oleh karena itu banyak orang berlomba-lomba untuk mengembangkan metode
numerik lain yang lebih mudah dikerjakan dan secara intuitif bisa
digunakan untuk menyelesaikan permasalahan tersebut. Metode-metode ini
terinspirasi dari kejadian alam seperti: pergerakan kawanan hewan,
pergerakan benda angkasa, persilangan gen, dan lainnya. Metode ini
dikenal dengan nama *meta heuristic*.

## *Spiral Dynamic Optimization Algorithm*

Salah satu algoritma *meta heuristic* yang saya pelajari selama kuliah
di semester kemarin adalah *spiral dynamic optimization algorithm* yang
pertama kali diperkenalkan dua ilmuwan asal Jepang pada 2011. Kemudian
dua orang matematikawan ITB menyempurnakannya dengan menambahkan
algoritma *SOBOL sequence* agar pencarian solusi bisa lebih sempurna.

SDOA ini bisa digunakan untuk berbagai macam tipe permasalahan.

Saya ingin sekali menulisnya di blog ini, tapi sayangnya terbentur pada
notasi-notasi matematika yang terbatas di *github pages*. Oleh karena
itu saya telah menulis **empat tulisan** spesial terkait SDOA.

## Tulisan I

Pada tulisan pertama ini, saya jelaskan bagaimana prinsip utama dari
SDOA dan bagaimana cara kerjanya beserta skrip **R** yang dibuat sendiri
untuk itu.

Pada tulisan ini juga saya memberatkan penggunaan SDOA untuk masalah
pencarian akar persamaan dan akar sistem persamaan. Baik untuk variabel
kontinu atau diskrit.

Silakan menuju [*link* ini](https://rpubs.com/QRA_NFI/spiral).

## Tulisan II

Pada tulisan ini saya menggunakan SDOA untuk menyelesaikan masalah
*mixed integer programming*. Baik untuk masalah linear atau non linear.

Ini merupakan kabar gembira karena `library(ompr)` yang selama ini saya
gunakan untuk menyelesaikan masalah optimisasi tidak bisa memproses
*objective function* berbentuk non linear.

Silakan menuju [*link* ini](https://rpubs.com/QRA_NFI/SOA_2).

## Tulisan III

Pada tulisan ini saya menggunakan SDOA untuk mencari model *machine
learning* terbaik melalui *feature selection*. Walaupun saya menggunakan
model regresi tapi prinsipnya sama dengan model *machine learning*
klasifikasi.

Silakan menuju [*link* ini](https://rpubs.com/QRA_NFI/SOA_3).

## Tulisan IV

Pada tulisan ini saya menggunakan SDOA bersama dengan algoritma
*travelling salesperson problem* (TSP) untuk melakukan pengelompokkan
(*clustering*) dari data yang berisi variabel-variabel *binary*.

Silakan menuju [*link* ini](https://rpubs.com/QRA_NFI/SOA_4).

# Penutup

Penggunaan SDOA ini sangat luas sekali dan cenderung mudah dilakukan.
Tergantung dari kreativitas kita dalam menentukan *objective function*
dari setiap permasalahan tersebut.

Batasan permasalahan yang saya temui hanya pada jumlah variabel
keputusan yang tidak bisa lebih dari 200 variabel. Karena matriks rotasi
dengan ukuran lebih dari 200 × 200 akan berat secara komputasi.
