---
date: 2022-11-16T14:42:00-04:00
title: "TUTORIAL: Mengaktifkan Github Codespaces untuk Menggunakan R secara Cloud dengan VS Code"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Training R
  - Tutorial
  - Linux
  - R IDE
  - R GUI
  - Visual Studio Code
  - Github
  - Github Codespaces
---


Beberapa waktu yang lalu, saya sempat menuliskan tutorial tentang
bagaimana meng-*install* `VS Code Server` di **Google Cloud Service**.
Tak lama setelah itu, saya mendapati info bahwa *Github* memiliki
layanan *Codespaces* (layanan *cloud computing* mirip dengan *virtual
private server* / VPS) yang bisa diakses oleh para penggunanya secara
gratis selama 60 jam dalam sebulan.

Hal ini tentu kabar yang menggembirakan mengingat dalam beberapa minggu
ini laptop saya sedang dipakai untuk mengerjakan suatu algoritma yang
harus berjalan selama 7 hari non stop. Jadi saya perlu VPS atau layanan
*cloud* yang *reliable*.

Walau saya sekarang [menyewa VPS di *Google
Cloud*](https://ikanx101.com/blog/vscode-google-cloud/), saya tetap
membutuhkan layanan *cloud* lain yang gratis. *Hehe*.

Jadi *Github* *Codespaces* bisa digunakan sebagai VPS berbasis **Visual
Studio Code** untuk berbagai bahasa pemrograman.

> Ilustrasinya adalah seperti kita memiliki **Visual Studio Code
> Server** sendiri yang bekerja di *Github Repository*.

Cara kerjanya adalah sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/nomnoml.png)<!-- -->

Syarat yang harus dipenuhi untuk mengakses layanan ini adalah:

1.  Kita harus sudah memiliki akun Github.
2.  Kita sudah memiliki *repository* (sebagai contoh pada tulisan ini
    agar lebih mudah saya menggunakan *repository* yang sudah pernah
    saya buat. Jika belum punya *repository*, kita bisa membuatnya
    langsung di *Codespaces*).

Sekarang saya akan tunjukkan cara mengaktifkan *Codespaces* agar bisa
menggunakan bahasa **R**.

------------------------------------------------------------------------

## Cara Mengaktifkan *Codespaces* untuk **R**

### Langkah ke-1

Buka halaman depan Github dengan akun kita:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_1.png)<!-- -->

### Langkah ke-2

Buka *tab* *Codespaces* sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_2.png)<!-- -->

### Langkah ke-3

Pilih *create new codespaces* dan pilih *repository* yang hendak kita
gunakan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_3.png)<!-- -->

### Langkah ke-4

Pada *machine type*, kita bisa memilih 2 spek mesin yakni:

1.  **2 Cores dan 4 GB RAM**.
2.  **4 Cores dan 8 GB RAM**.

Secara *default*, pilihan mesin yang digunakan adalah **2 cores**. Jika
kita memilih spek yang lebih tinggi, waktu *free runtime* akan lebih
cepat habis.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_4.png)<!-- -->

### Langkah ke-5

Jika berhasil, maka halaman akan berpindah ke halaman muka **Visual
Studio Code** seperti ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_5.png)<!-- -->

### Langkah ke-6

Sekarang kita perlu meng-*install* **R** ke dalam **Visual Studio Code**
tersebut. Caranya sangat mudah, yakni memanfaatkan *container* yang
sudah dibuat oleh para *developer* baik hati di luar sana.

Buka ***Manage*** yang berupa simbol roda gerigi di pojok kiri bawah.
Lalu pilih ***Command Palette***.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_6.png)<!-- -->

### Langkah ke-7

Ketik dan pilih ***Codespaces: Add Dev Container Configuration Files***.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_7.png)<!-- -->

### Langkah ke-8

Ketik dan pilih bahasa **R**. Kita bisa pilih **R** dengan
*pre-installed* `library(tidyverse)` dengan berbagai versi yang ada.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_8.png)<!-- -->

### Langkah ke-9

Jika sudah, lalu klik **OK** tanpa menambah *configuration files* yang
lain.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_9.png)<!-- -->

### Langkah ke-10

Jika berhasil, *Codespaces* akan melakukan *reload* dengan *setting*
terbaru. Ditunggu saja prosesnya sekitar 5-10 detik.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_10.png)<!-- -->

### Langkah ke-11

Jika sudah selesai, kita akan kembali ke halaman muka **Visual Studio
Code** dengan ada tambahan *folder* `.devcontainer` pada *repository*
kita.

Kita bisa mengecek apakah **R** sudah ter-*install* di **Visual Studio
Code** kita dengan mengetikkan **R** di `Terminal` dan *enter*. Hasilnya
seperti ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/tahap_11.png)<!-- -->

Kita bisa lihat bahwa sudah ter-*install* **R** versi terbaru `4.2.2`.

------------------------------------------------------------------------

Proses *setting* dan instalasi di atas cukup dilakukan sekali saja
seumur hidup. Seterusnya, *Codespaces* bisa langsung digunakan setiap
kali dibutuhkan denga mengakses halaman *Github Codespaces*.

Untuk mengetahui sejauh mana pemakaian kita, kita cukup masuk ke dalam
*Settings* di Github, lalu pilih *tab* *billing and plans*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/training%20R/Github%20Codespaces/billings.png)<!-- -->

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads`
