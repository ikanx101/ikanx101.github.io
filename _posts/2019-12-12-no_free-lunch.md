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

### Cerita pertama

Ceritanya, pada saat World Cup beberapa tahun lalu, saya mencoba membuat prediksi siapa yang akan memenangkan kompetisi tersebut. Waktu itu, dengan model yang dibangun atas __discriminant analysis__ saya memprediksi Belgia yang akan menjadi pemenang.

> Hasilnya: Perancis yang menjadi pemenang.

Kecewa sih enggak, karena saya pribadi sudah sangat puas dengan performa model saya tersebut. Tanpa menonton pertandingannya, dari model tersebut ternyata saya bisa menjelaskan kenapa Belgia sampai kalah oleh Perancis saat itu. 

> _Really! Gak bohong! hehe_

### Cerita kedua

Beberapa bulan kemudian saya ikut kompetisi [data hackhaton](https://wp.me/p6nlXw-ef) yang diselenggarakan oleh salah satu bank terbesar di Indonesia. Kala itu, ada dua kasus yang saya ikuti, yakni:

1. Fraud detection, prediksi suatu transaksi itu fraud atau bukan.
2. Credit scoring, menentukan seseorang dapat kredit bank atau tidak.

Untuk kasus pertama, saya menggunakan model __binary logistic regression__. Sedangkan untuk kasus kedua saya menggunakan __random forest__.

Sebenarnya, dalam proses menyelesaikan kedua kasus itu, saya mencoba-coba beberapa algoritma pengerjaan, seperti:

1. Lasso regression,
2. SVN machine
3. Neural Network
4. Naive Bayes
5. Logistic based tree regression
6. Earth model
7. ADAboost
8. XGboost
9. dst... (_lupa lagi apa. Yang jelas, banyak algoritma di library `caret` saya coba-coba_)

> Hasilnya: sempat masuk peringkat 5 besar, sampai turun ke 10 besar, lalu ke 15 besar.

_Gak menang sih tapi gak kecewa_. Lumayan buat _"uji nyali"_, pikir saya.

Pesan moral dari kedua cerita itu apa?

Bisa jadi satu permasalahan itu diselesaikan dengan berbagai macam algoritma pengerjaan. Algoritma terbaik akan dinilai dari parameter _goodness of fit_ dari model-model tersebut.

Bisa jadi juga beberapa masalah yang memiliki tipe yang sama tidak bisa diselesaikan dengan algoritma yang sama.

Contohnya: 

> Misalkan saya sudah pernah membuat model prediksi _World Cup_ dengan __determinant analysis__. Saat berlangsung __Euro Cup__, bisa jadi model saya gak bisa digunakan sama sekali (_Totally_ salah dalam memprediksi siapa pemenangnya).

ATAU

> Misalkan saya sudah pernah membuat model prediksi _fraud detection_ untuk Bank __Cap ABC__ dengan __binary logistic regression__. Belum tentu model yang sama akan jalan untuk Bank __Bergantung__.

ATAU

> Secara teoritis, __Convolutional Neural Network__ relatif lebih kekinian dan revolusioner. Tapi bisa jadi dalam suatu permasalah, metode klasik seperti __binary logistic regression__ lebih memberikan hasil yang lebih akurat.

## Kesimpulan

Kira-kira seperti itulah __No Free Lunch Theorem__. Kalau saya ungkapkan dengan kalimat sendiri adalah:

> _Setiap permasalahan itu unik dan butuh cara yang unik juga dalam menyelesaikannya_.

_Notes:_
Terkait _goodness of fit_ model, saya sarankan untuk membaca tulisan di blog [saya yang lama ini](https://passingthroughresearcher.wordpress.com/2015/06/29/failure-formula-overfitting-the-earthquake/)?
