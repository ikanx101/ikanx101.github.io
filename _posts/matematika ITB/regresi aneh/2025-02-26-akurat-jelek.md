---
date: 2025-02-26T14:07:00-04:00
title: "Saat Model Prediksi Memberikan Hasil yang Akurat Tapi Jelek"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Regresi Linear
  - Regression
  - Regresi Multivariat
  - R-Squared
  - Overfitting
---

*Nah lho?* Apakah kalian pusing membaca judul artikel ini? *Hehe*

Jadi begini ceritanya:

------------------------------------------------------------------------

Beberapa minggu belakangan ini, saya diminta melakukan analisa
kausalitas dari dua variabel ke suatu variabel tertentu. Semua variabel
yang terlibat berupa numerik. Misalkan saya berikan nama variabel
![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") dan
![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2") sebagai
*predictors* dan ![y](https://latex.codecogs.com/svg.latex?y "y")
sebagai targetnya.

Salah satu bentuk model kausalitas yang paling sederhana adalah regresi.
Jadilah saya mencoba membuat model regresi sebagai berikut:

![y \sim a \space x_1 + b \space x_2 + C](https://latex.codecogs.com/svg.latex?y%20%5Csim%20a%20%5Cspace%20x_1%20%2B%20b%20%5Cspace%20x_2%20%2B%20C "y \sim a \space x_1 + b \space x_2 + C")

Sebelum membuat regresi, tentu saya harus melihat kembali asumsi-asumsi
yang ada, seperti:

1.  **Linearitas**; Hubungan antara *predictors* dan *target* harus
    linear. Artinya, perubahan pada variabel independen harus
    menghasilkan perubahan yang proporsional pada variabel dependen.
2.  **Independensi**; Observasi atau data harus independen satu sama
    lain. Tidak boleh ada korelasi atau ketergantungan antar observasi.
3.  **Tidak Ada Multikolinearitas**; *predictors* tidak boleh
    berkorelasi tinggi satu sama lain. Multikolinearitas dapat
    menyebabkan masalah dalam estimasi koefisien regresi dan
    interpretasi hasil.

Beberapa asumsi penting lain baru akan saya hitung setelah model saya
selesai dibuat, seperti:

1.  **Normalitas Residual**; Selisih antara nilai observasi dan nilai
    prediksi harus berdistribusi normal. Asumsi ini penting untuk
    validitas uji hipotesis dan interval kepercayaan.
2.  **Homoskedastisitas**; Varians dari residual harus konstan di
    seluruh rentang nilai *predictors*.

**Singkat cerita**, saya telah selesai membuat model regresi.

Untuk menguji seberapa baik performa modelnya, saya menghitung
![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") dan *mean
absolute error* (**MAE**).

Saya mendapatkan hasil yang menarik, yakni:

1.  ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") yang saya
    dapatkan kecil.
2.  **MAE** yang saya dapatkan kecil alias *error* yang dihasilkan kecil
    sehingga bisa dibilang hasil prediksi model saya akurat.

> **Sebuah hasil yang saling bertolak belakang**.

Kenapa hal ini bisa terjadi? Mari kita telaah bersama.

## Memahami Metrik

![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") mengukur
seberapa besar proporsi varians dalam variabel terikat yang dapat
dijelaskan oleh variabel bebas dalam model.
![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") yang rendah
menunjukkan bahwa model tidak menjelaskan banyak variasi dalam data.
Sedangkan **MAE** mengukur rata-rata perbedaan antara nilai prediksi dan
nilai aktual. **MAE** yang rendah berarti prediksi model cukup akurat.

![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") dan **MAE**
fokus pada aspek yang berbeda dari kinerja model:

1.  ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") : seberapa
    baik model menjelaskan data secara keseluruhan.
2.  **MAE** : Seberapa akurat prediksi model.

## Karakteristik Data

Bisa jadi beberapa hal ini ditemukan dalam data saya:

1.  **Variabilitas Tinggi**; Jika *predictors* memiliki variabilitas
    yang tinggi, sulit untuk mencapai
    ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2") yang
    tinggi, meskipun prediksi cukup akurat (**MAE** rendah).
2.  **Hubungan Non-linear**;
    ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2")
    mengasumsikan hubungan linear. Jika hubungan antar variabel
    non-linear, ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2")
    mungkin rendah meskipun **MAE** baik.

## Apa Artinya?

Model saya mungkin:

1.  Prediktif, tetapi tidak *Explanatory*: Model dapat membuat prediksi
    yang baik, tetapi tidak serta merta menjelaskan hubungan antar
    variabel dengan baik.
2.  Baik untuk Tujuan Tertentu: Jika tujuan utama adalah prediksi yang
    akurat, ![R^2](https://latex.codecogs.com/svg.latex?R%5E2 "R^2")
    yang rendah mungkin tidak menjadi masalah selama MAE rendah.

Namun ada satu hal yang saya curigai sebagai penyebabnya, yakni:

***Overfitting***; oleh karena data yang saya miliki terbatas, saya
tidak membagi data sebagai *train* dan *test* sehingga semua data
dijadikan data *input* pembuatan model. Data yang dijadikan *input*
hanya memiliki 30-40 baris saja.

*Lho kenapa dipaksakan untuk dibuat?*

Justru saya sengaja ingin membuat model prediksi ini sebagai bentuk
pembuktian bahwa hal-hal semacam ini bisa terjadi.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
