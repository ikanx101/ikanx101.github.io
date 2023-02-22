---
date: 2023-02-23T21:05:00-04:00
title: "Agent Based Modelling: Simulasi Model Ekonomi Sederhana"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Agent Based Modelling
  - Ekonomi
  - Simulasi
---



Pada semester ini, saya akhirnya mengambil mata kuliah bernama *Agent
Based Modelling* (permodelan berbasis agen).

Sebagai informasi, di jurusan Sains Komputasi ITB ada dua kuliah
**utama** terkait *modelling*, yakni:

1.  *Agent based modelling*, dan
2.  *Particle based modelling*.

Karena *pinisirin*, saya akhirnya mengambil salah satu di antara
keduanya.

------------------------------------------------------------------------

## Belajar apa?

> Kuliah ini belajar apa ya?

Jika pada kuliah di S1, saya biasa belajar memodelkan **suatu sistem**
menggunakan formula matematis. Jadi yang saya modelkan ada
**sistem**-nya.

Sebagai contoh, pada Maret 2020 lalu saya sempat membuat [model
penyebaran COVID dengan pendekatan
SIR](https://ikanx101.com/blog/sir-covid/).

Nah, pada **ABM** yang dimodelkan bukanlah sistemnya, tapi *agent* yang
berada pada sistem. Sebagai contoh, jika pada kasus COVID di atas, yang
dimodelkan adalah individu-individu yang berada di sistem dan bagaimana
mereka berperilaku dan berinteraksi.

> Seru kan yah…!

------------------------------------------------------------------------

## Contoh dalam Ekonomi

Beralih dari contoh COVID, saya akan berikan satu contoh sederhana model
**ABM** di bidang ekonomi. Model ini biasa disebut dengan *simple
economy model*.

Begini ceritanya:

> Misalkan dalam suatu area, ada 500 orang yang diberi modal (atau
> “kekayaan”) yang sama (misalkan uang sebesar 100\$). Dalam setiap unit
> waktu, setiap orang tersebut akan memberikan uangnya ke orang lain
> secara *random*. Jumlah total uang yang ada adalah tetap, sehingga
> jika ada pemain yang uangnya sudah habis, pemain tersebut baru akan
> memiliki uang kembali saat ada pemain lain yang memberikan uangnya
> kepada pemain tersebut.

Pertanyaannya:

> *By the end of the time*, bagaimana penyebaran kekayaan dalam area
> tersebut?

------------------------------------------------------------------------

### Menebak Hasilnya

Saat mendengarkan cerita di atas, yang terlintas dalam pikiran saya
adalah ada dua kemungkinan penyebaran kekayaaan di area tersebut, yakni:

1.  **Kemungkinan pertama**: kekayaan akan tersebar merata. ATAU
2.  **Kemungkinan kedua**: kekayaan akan tersebar mengikuti distribusi
    normal (berbentuk *bell curve*). *Konon katanya (hampir) semua data
    alamiah di dunia ini terdistribusi normal kan?*

------------------------------------------------------------------------

### Hasil Simulasi

Biar *gak* makin *pinisirin*, saya coba *run* modelnya.

#### Kondisi Awal (t=0)

<img src="https://raw.githubusercontent.com/ikanx101/209_ITB/main/Semester%20IV/Agent%20Based%20Modelling/Tugas/Tugas%201/wealth%20awal.png" height="60%" />

Pada kondisi awal (t=0), semua orang memiliki uang yang sama. Saya akan
*run* hingga waktu tertentu.

#### Kondisi Saat t=182

<img src="https://raw.githubusercontent.com/ikanx101/209_ITB/main/Semester%20IV/Agent%20Based%20Modelling/Tugas/Tugas%201/wealth%20182.png" height="60%" />

Terlihat bahwa kekayaan sudah terdistribusi secara normal. Mayoritas
orang masih memiliki uang di kisaran 100 USD. Ada beberapa orang yang
“miskin” dan “kaya”, namun jumlahnya masih sedikit.

Saya akan *run* lagi hingga waktu tertentu.

#### Kondisi Saat t=1117

<img src="https://raw.githubusercontent.com/ikanx101/209_ITB/main/Semester%20IV/Agent%20Based%20Modelling/Tugas/Tugas%201/wealth%201117.png" height="60%" />

Terlihat bahwa “kekayaan” masih terdistribusi normal. Namun kalau
dilihat grafik yang paling bawah:

> Kekayaan orang-orang yang termasuk `top 10%`, memiliki tren
> kenaikan.Sedangkan kekayaan orang-orang yang termasuk `bottom 50%`
> memiliki tren penurunan.

Saya akan lanjut *run* lagi.

#### Kondisi Saat t=16347

<img src="https://raw.githubusercontent.com/ikanx101/209_ITB/main/Semester%20IV/Agent%20Based%20Modelling/Tugas/Tugas%201/wealth%2016347.png" height="60%" />

Saat saya lanjutkan simulasi modelnya, terlihat bahwa “kekayaan” sudah
tidak berdistribusi normal. Kekayaan orang-orang yang `top 10%` juga
sudah melebihi “orang-orang kebanyakan” (`bottom 50%`).

> Menarik yah…

Sekarang saya coba lanjut *run* lagi hingga waktu yang lebih besar.

#### Kondisi Saat t Besar Sekali

<img src="https://raw.githubusercontent.com/ikanx101/209_ITB/main/Semester%20IV/Agent%20Based%20Modelling/Tugas/Tugas%201/wealth%20akhir.png" height="60%" />

Ternyata saat waktunya dilanjutkan, kita dapatkan hasil yang menarik.

> Akan ada segilintir orang-orang **tajir melintir** yang kekayaannya
> melebihi kebanyakan orang jika digabung.

Dugaan saya, jika dilanjutkan terus bentuk distribusi kekayaannya akan
berdistribusi pareto.

------------------------------------------------------------------------

## Epilog

Simulasi ini memberikan pemahaman baru kepada saya terkait perilaku
ekonomi dalam model *simple economy*.

> Menurut kamu *relate* dengan kondisi *real* *gak*?

Beberapa saat lalu saya merekam proses simulasi dan menyimpannya di
[*channel* **Youtube** saya berikut ini](https://youtu.be/-CiJsVwYeCI).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
