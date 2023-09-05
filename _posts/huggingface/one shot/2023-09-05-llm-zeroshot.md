---
date: 2023-09-05T14:41:00-04:00
title: "Mencoba LLM Huggingface: Zero-Shot Classification"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Huggingface
  - Zero-Shot
  - Text Analysis
  - R Studio
  - Python
  - Deep Learning
---


Pada tulisan sebelumnya, saya telah menuliskan hasil [*sentiment
analysis*](https://ikanx101.com/blog/sentimen-llm/) menggunakan
*pre-trained model* yang di-*listing* di situs **Huggingface**. Secara
pribadi, saya relatif puas dengan hasil model tersebut.

Kali ini, saya akan mencoba satu *large language model* pada
*Huggingface* bernama [***Zero-Shot
Classification***](https://huggingface.co/tasks/zero-shot-classification).
Jika pada tulisan sebelumnya saya membuat algoritmanya menggunakan
bahasa **R**, kali ini mau tidak mau saya harus membuat algoritmanya
dengan bahasa *Python* karena saya masih belum berhasil membuatnya di
**R**. Sebagaimana tulisan sebelumnya, proses “perhitungannya” sendiri
dilakukan secara *local* karena modelnya sendiri diunduh ke laptop saya
sendiri.

Apa yang dimaksud dengan **Zero-Shot Classification**?

> *Zero-shot text classification is a task in natural language
> processing where a model is trained on a set of labeled examples but
> is then able to classify new examples from previously unseen classes.*

Jadi kita bisa melakukan klasifikasi tanpa harus melakukan proses *model
training* menggunakan “kalimat” dan “label” yang kita inginkan.

Sebagai contoh, saya akan gunakan kalimat berikut ini:

> **iPhone 15 series diprediksi akan meluncur dengan port USB-C
> menggantikan port Lightning. Dengan perubahan ini, Apple pun akan
> terpaksa menjilat ludahnya sendiri.**

Dengan pilihan label berikut ini:

|  No | Label      |
|----:|:-----------|
|   1 | Smartphone |
|   2 | Teknologi  |
|   3 | Berita     |

Algoritma atau skripnya sendiri relatif sangat simpel, yakni dengan
memanggil `transformers` dari **Huggingface** lalu memasukkan *text* dan
*candidate labels*.

Hasilnya bagaimana? Berikut adalah hasilnya:

| Teks                                                                                                                                                                |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ‘iPhone 15 series diprediksi akan meluncur dengan port USB-C menggantikan port Lightning. Dengan perubahan ini, Apple pun akan terpaksa menjilat ludahnya sendiri.’ |

|  id | Label      | Probability |
|----:|:-----------|------------:|
|   1 | smartphone |   0.9227989 |
|   2 | teknologi  |   0.0422263 |
|   3 | berita     |   0.0349748 |

Hasilnya cukup memuaskan *yah*.

------------------------------------------------------------------------

# Eksperimen dengan Kalimat Lainnya

Sekarang kita akan melakukan eksperimen dengan beberapa kalimat lainnya
dengan label yang bermacam-macam.

## Eksperimen I

| Teks                                                               |
|:-------------------------------------------------------------------|
| ‘I have a problem with my laptop that needs to be resolved asap!!’ |

|  id | Label      | Probability |
|----:|:-----------|------------:|
|   1 | urgent     |   0.5521957 |
|   2 | computer   |   0.4420827 |
|   3 | not urgent |   0.0026916 |
|   4 | tablet     |   0.0015924 |
|   5 | phone      |   0.0014375 |

## Eksperimen II

| Teks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ‘Indonesia terdiri dari berbagai suku bangsa, bahasa, dan agama. Berdasarkan rumpun bangsa, Indonesia terdiri atas bangsa asli pribumi yakni Austronesia dan Melanesia di mana bangsa Austronesia yang terbesar jumlahnya dan lebih banyak mendiami Indonesia bagian barat. Dengan suku Jawa dan Sunda membentuk kelompok suku bangsa terbesar dengan persentase mencapai 57% dari seluruh penduduk Indonesia.\[22\] Semboyan nasional Indonesia, “Bhinneka Tunggal Ika” (Berbeda-beda tetapi tetap satu), bermakna keberagaman sosial-budaya yang membentuk satu kesatuan negara. Selain memiliki penduduk yang padat dan wilayah yang luas, Indonesia memiliki alam yang mendukung tingkat keanekaragaman hayati terbesar ke-2 di dunia.’ |

|  id | Label     | Probability |
|----:|:----------|------------:|
|   1 | agama     |   0.3593048 |
|   2 | bahasa    |   0.3540428 |
|   3 | informasi |   0.1814017 |
|   4 | artikel   |   0.1052508 |

## Eksperimen III

| Teks                                                                                                                                                                                                                                                                                                                                                     |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ‘Ada banyak cara untuk mengembangkan integritas. Salah satunya adalah dengan menetapkan nilai-nilai yang ingin kita pegang teguh. Setelah itu, kita harus berusaha untuk konsisten dalam menerapkan nilai-nilai tersebut dalam kehidupan sehari-hari. Kita juga perlu belajar untuk menghadapi godaan dan tantangan yang dapat menguji integritas kita.’ |

|  id | Label      | Probability |
|----:|:-----------|------------:|
|   1 | integritas |   0.7118617 |
|   2 | kolaborasi |   0.1486283 |
|   3 | inovasi    |   0.1395100 |

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
