---
date: 2019-12-12T05:20:00-04:00
title: "NO FREE LUNCH Theorem for Machine Learning"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Statistics
  - Mathematics
  - Modelling
---

## Pengantar

Ceritanya, pada saat World Cup beberapa tahun lalu, saya mencoba membuat prediksi siapa yang akan memenangkan kompetisi tersebut. Waktu itu, dengan model yang dibangun atas __discriminant analysis__ saya memprediksi Belgia yang akan menjadi pemenang.

> Hasilnya: Perancis yang menjadi pemenang.

Kecewa sih enggak, karena saya pribadi sudah sangat puas dengan performa model saya tersebut. Tanpa menonton pertandingannya, dari model tersebut ternyata saya bisa menjelaskan kenapa Belgia sampai kalah oleh Perancis saat itu. 

> _Really! Gak bohong! hehe_

Beberapa bulan kemudian saya ikut kompetisi [data hackhaton](https://wp.me/p6nlXw-ef) yang diselenggarakan oleh salah satu bank terbesar di Indonesia. Kala itu, saya membuat model prediksi dengan menggunakan __random forest__.

## Goodness of fit


_Notes:_
Terkait _goodness of fit_ model, saya sarankan untuk membaca tulisan di blog [saya yang lama ini](https://passingthroughresearcher.wordpress.com/2015/06/29/failure-formula-overfitting-the-earthquake/)?
