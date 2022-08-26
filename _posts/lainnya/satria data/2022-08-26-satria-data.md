---
title: "Menjadi Creator dan Dewan Juri Kompetisi Big Data Challenge"
date: 2022-08-26T08:11:00-04:00
categories:
  - Blog
tags:
  - ITB
  - Matematika
  - Big Data
  - Machine Learning
  - Deep Learning
---

Setiap tahun, **Pusat Prestasi Nasional** (Puspresnas) Kemendikbud
selalu mengadakan kompetisi bagi para mahasiswa S1 se-Indonesia yang
diberi judul **Satria Data**.

ITB secara *official* belum pernah mengirimkan wakilnya ke dalam
kompetisi tersebut. Oleh karena itu Ditmawa ITB dan FMIPA ITB membentuk
kepanitiaan dari dosen dan profesional untuk membuat kompetisi kecil
skala kampus untuk menjaring mahasiswa/i yang akan menjadi wakil resmi
di kompetisi nasional Puspresnas.

Kompetisi “kecil” ini sendiri dibagi menjadi 4 kategori sesuai dengan
kompetisi aslinya, yakni:

1.  *Statistic Competition*,
2.  *Essay Statistitc Competition*,
3.  *Infographic Competition*, dan
4.  *Big Data Challenge* (BDC).

Saya didapuk menjadi penanggung jawab bagi kompetisi BDC. Tugasnya itu
membuat soal dan menjadi salah satu dewan juri saat fase final nanti.

Karena tidak ada bocoran sama sekali bagaimana kompetisi Satria Data
tahun lalu, maka saya membuat soal sendiri dari data publik. Hal yang
penting adalah data yang digunakan bukan data sintetis. Karena tidak
mungkin juga saya menggunakan data dari perusahaan tempat saya bekerja,
maka kasusnya saya ambil (*web scrape*) dari situs OLX Autos, yakni:

> ***Melakukan prediksi harga mobil bekas dari informasi yang
> tersedia.***

Agar menantang, sengaja data yang saya berikan benar-benar *raw*.
Peserta diberikan keleluasaan sebesar-besarnya untuk mengekstrak
*features* dari data tersebut. Sekalian menguji kemampuan *data
pre-processing* mereka. Parameter yang digunakan untuk menentukan
kualitas akurasi dari prediksi harga tersebut adalah **MAPE** (*mean
absolute percentage error*).

Kompetisinya saya buat di *platform* **Kaggle** sehingga *workload* saya
menjadi *less effort* (karena proses perhitungan dan penentuan nilai
setiap tim dilakukan secara otomatis). Kompetisinya sendiri baru resmi
dimulai pada Senin pagi kemarin.

Total ada 17 tim mahasiswa yang mengikuti kemudian akan disaring menjadi
10 finalis yang kelak akan diberikan kesempatan untuk mempresentasikan
model *machine learning* (atau *deep learning*) yang mereka buat.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/satria%20data/satria.jpg" style="display: block; margin: auto;" />
