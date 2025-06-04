---
date: 2025-06-03T10:41:00-04:00
title: "Optimization Story: Berapa Kali Sebaiknya Kita Mencuci Handuk?"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Optimization Story
  - Kebersihan
  - Kesehatan
---

Beberapa kali saya menulis tentang [optimisasi di *blog*
ini](https://ikanx101.com/tags/#optimization-story) dengan berbagai
tema. Mulai dari industrial, olahraga, hingga politik. Kali ini saya
akan mencoba menuliskan satu tema optimisasi lain yang berhubungan
dengan keseharian. Tentunya teknik optimisasinya juga berbeda dengan
yang pernah saya tuliskan sebelumnya.

------------------------------------------------------------------------

> Mencuci handuk terlalu sering bisa boros air, energi, dan waktu tetapi
> jika mencuci terlalu jarang bisa menyebabkan penumpukan bakteri dan
> bau tidak sedap pada handuk.

Mari buat model matematika sederhana untuk **menentukan frekuensi
optimal mencuci handuk berdasarkan beberapa parameter yang kita
tentukan**.

### Variabel dan Parameter

1.  ![n](https://latex.codecogs.com/svg.latex?n "n") : Frekuensi mencuci
    handuk per minggu.
2.  ![C](https://latex.codecogs.com/svg.latex?C "C") : Biaya mencuci
    sekali (air, deterjen, listrik).
3.  ![H](https://latex.codecogs.com/svg.latex?H "H") : Tingkat
    ketidaknyamanan (skala 1-10) karena handuk kotor/bau.
4.  ![T](https://latex.codecogs.com/svg.latex?T "T") : Waktu pemakaian
    handuk sejak pencucian terakhir (hari).
5.  ![\alpha](https://latex.codecogs.com/svg.latex?%5Calpha "\alpha") :
    Faktor pertumbuhan bakteri/bau (misal: 0,5 per hari).
6.  ![\beta](https://latex.codecogs.com/svg.latex?%5Cbeta "\beta") :
    Toleransi maksimum ketidaknyamanan yang bisa diterima. Diisi secara kualitatif personal.

### Membuat Model Matematika

Mari kita definisikan beberapa formula berikut ini:

1.  ![B](https://latex.codecogs.com/svg.latex?B "B"): Biaya Total

    Biaya mencuci per minggu adalah frekuensi dikali biaya per cucian:
    ![B(n) = n \cdot C](https://latex.codecogs.com/svg.latex?B%28n%29%20%3D%20n%20%5Ccdot%20C "B(n) = n \cdot C").

2.  ![K](https://latex.codecogs.com/svg.latex?K "K") Ketidaknyamanan

    Ketidaknyamanan meningkat seiring waktu sejak pencucian terakhir.
    Misalkan:

    ![K(T) = H \cdot e^{\alpha T}](https://latex.codecogs.com/svg.latex?K%28T%29%20%3D%20H%20%5Ccdot%20e%5E%7B%5Calpha%20T%7D "K(T) = H \cdot e^{\alpha T}")

    Jika handuk dicuci ![n](https://latex.codecogs.com/svg.latex?n "n")
    kali per minggu, maka waktu antara pencucian adalah
    ![T = \frac{7}{n}](https://latex.codecogs.com/svg.latex?T%20%3D%20%5Cfrac%7B7%7D%7Bn%7D "T = \frac{7}{n}")
    hari.  
    Sehingga:

    ![K(n) = H \cdot e^{\alpha \cdot \frac{7}{n}}](https://latex.codecogs.com/svg.latex?K%28n%29%20%3D%20H%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D "K(n) = H \cdot e^{\alpha \cdot \frac{7}{n}}")

3.  *Objective function*

    Kita ingin meminimalkan total *cost*, yakni biaya cuci dan rasa
    ketidaknyamanan tetapi dengan batasan bahwa ketidaknyamanan tidak
    melebihi
    ![\beta](https://latex.codecogs.com/svg.latex?%5Cbeta "\beta").

    ![\text{Minimalkan } f(n) = B(n) + K(n) = nC + H \cdot e^{\alpha \cdot \frac{7}{n}}](https://latex.codecogs.com/svg.latex?%5Ctext%7BMinimalkan%20%7D%20f%28n%29%20%3D%20B%28n%29%20%2B%20K%28n%29%20%3D%20nC%20%2B%20H%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D "\text{Minimalkan } f(n) = B(n) + K(n) = nC + H \cdot e^{\alpha \cdot \frac{7}{n}}")

    Dengan batasan:

    ![K(n) \leq \beta \implies H \cdot e^{\alpha \cdot \frac{7}{n}} \leq \beta](https://latex.codecogs.com/svg.latex?K%28n%29%20%5Cleq%20%5Cbeta%20%5Cimplies%20H%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D%20%5Cleq%20%5Cbeta "K(n) \leq \beta \implies H \cdot e^{\alpha \cdot \frac{7}{n}} \leq \beta")

### Mencari Solusi Optimal

Kita hendak mencari nilai
![n](https://latex.codecogs.com/svg.latex?n "n") yang optimal. Pada
kasus ini, setidaknya ada dua cara untuk menentukan nilai
![n](https://latex.codecogs.com/svg.latex?n "n").


1.  Cara pertama adalah dengan mencari
    ![n](https://latex.codecogs.com/svg.latex?n "n") yang memenuhi
    batasan ketidaknyamanan.

    ![H \cdot e^{\alpha \cdot \frac{7}{n}} \leq \beta \implies n \geq \frac{7\alpha}{\ln(\beta / H)}](https://latex.codecogs.com/svg.latex?H%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D%20%5Cleq%20%5Cbeta%20%5Cimplies%20n%20%5Cgeq%20%5Cfrac%7B7%5Calpha%7D%7B%5Cln%28%5Cbeta%20%2F%20H%29%7D "H \cdot e^{\alpha \cdot \frac{7}{n}} \leq \beta \implies n \geq \frac{7\alpha}{\ln(\beta / H)}")

    Jika
    ![\beta \leq H](https://latex.codecogs.com/svg.latex?%5Cbeta%20%5Cleq%20H "\beta \leq H"),
    tidak ada solusi karena handuk sudah tidak nyaman sejak awal. Cara
    ini memastikan ![n](https://latex.codecogs.com/svg.latex?n "n") yang
    dihasilkan tak akan melanggar *constraint*.

2.  Cara kedua adalah dengan mencari solusi eksak, yakni menggunakan
    prinsip kalkulus dengan menurunkan
    ![f(n)](https://latex.codecogs.com/svg.latex?f%28n%29 "f(n)").

    Turunan pertama terhadap
    ![n](https://latex.codecogs.com/svg.latex?n "n"):

    ![f'(n) = C - \frac{7\alpha H}{n^2} \cdot e^{\alpha \cdot \frac{7}{n}}](https://latex.codecogs.com/svg.latex?f%27%28n%29%20%3D%20C%20-%20%5Cfrac%7B7%5Calpha%20H%7D%7Bn%5E2%7D%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D "f'(n) = C - \frac{7\alpha H}{n^2} \cdot e^{\alpha \cdot \frac{7}{n}}")

    Set
    ![f'(n) = 0](https://latex.codecogs.com/svg.latex?f%27%28n%29%20%3D%200 "f'(n) = 0")
    untuk titik optimal:

    ![C = \frac{7\alpha H}{n^2} \cdot e^{\alpha \cdot \frac{7}{n}}](https://latex.codecogs.com/svg.latex?C%20%3D%20%5Cfrac%7B7%5Calpha%20H%7D%7Bn%5E2%7D%20%5Ccdot%20e%5E%7B%5Calpha%20%5Ccdot%20%5Cfrac%7B7%7D%7Bn%7D%7D "C = \frac{7\alpha H}{n^2} \cdot e^{\alpha \cdot \frac{7}{n}}")

    Pencarian solusi secara eksak mungkin akan sulit dilakukan
    berdasarkan formula di atas. Ada cara yang lebih mudah yakni dengan
    melakukan pendekatan numerik sebagai berikut.

### Contoh Numerik Menggunakan Nilai-Nilai Parameter Tertentu

Misal:

- ![C = 5](https://latex.codecogs.com/svg.latex?C%20%3D%205 "C = 5")
  (biaya cuci Rp5.000 sekali),
- ![H = 1](https://latex.codecogs.com/svg.latex?H%20%3D%201 "H = 1")
  (ketidaknyamanan awal minimal),
- ![\alpha = 0.5](https://latex.codecogs.com/svg.latex?%5Calpha%20%3D%200.5 "\alpha = 0.5")
  (pertumbuhan bau/bakteri yang cepat),
- ![\beta = 5](https://latex.codecogs.com/svg.latex?%5Cbeta%20%3D%205 "\beta = 5")
  (toleransi ketidaknyamanan maksimal 5).

Maka kita bisa mencari nilai
![n](https://latex.codecogs.com/svg.latex?n "n") 


1. Langkah pertama,
    kita akan cari ![n](https://latex.codecogs.com/svg.latex?n "n") dari *constraint* ketidaknyamanan:

    ![n \geq \frac{7 \cdot 0,5}{\ln(5/1)} \approx \frac{3,5}{1,609} \approx 2,17](https://latex.codecogs.com/svg.latex?n%20%5Cgeq%20%5Cfrac%7B7%20%5Ccdot%200%2C5%7D%7B%5Cln%285%2F1%29%7D%20%5Capprox%20%5Cfrac%7B3%2C5%7D%7B1%2C609%7D%20%5Capprox%202%2C17 "n \geq \frac{7 \cdot 0,5}{\ln(5/1)} \approx \frac{3,5}{1,609} \approx 2,17")

    Karena nilai ![n](https://latex.codecogs.com/svg.latex?n "n") berupa bulangan bulat, maka kita simpulkan nilai minimal ![n = 3](https://latex.codecogs.com/svg.latex?n%20%3D%203 "n = 3"), yakni mencuci 3 kali/minggu.

2.  Sekarang kita akan cek nilai
    ![f(n)](https://latex.codecogs.com/svg.latex?f%28n%29 "f(n)") dengan
    beberapa opsi berikut:

    - ![n = 2 \implies f(2) = 10 + e^{1,75} \approx 10 + 5,75 = 15.75](https://latex.codecogs.com/svg.latex?n%20%3D%202%20%5Cimplies%20f%282%29%20%3D%2010%20%2B%20e%5E%7B1%2C75%7D%20%5Capprox%2010%20%2B%205%2C75%20%3D%2015.75 "n = 2 \implies f(2) = 10 + e^{1,75} \approx 10 + 5,75 = 15.75")
    - ![n = 3 \implies f(3) = 15 + e^{1,167} \approx 15 + 3,21 = 18.21](https://latex.codecogs.com/svg.latex?n%20%3D%203%20%5Cimplies%20f%283%29%20%3D%2015%20%2B%20e%5E%7B1%2C167%7D%20%5Capprox%2015%20%2B%203%2C21%20%3D%2018.21 "n = 3 \implies f(3) = 15 + e^{1,167} \approx 15 + 3,21 = 18.21")
    - ![n = 4 \implies f(4) = 20 + e^{0,875} \approx 20 + 2,40 = 22.40](https://latex.codecogs.com/svg.latex?n%20%3D%204%20%5Cimplies%20f%284%29%20%3D%2020%20%2B%20e%5E%7B0%2C875%7D%20%5Capprox%2020%20%2B%202%2C40%20%3D%2022.40 "n = 4 \implies f(4) = 20 + e^{0,875} \approx 20 + 2,40 = 22.40")

    Walaupun
    ![f(n = 2)](https://latex.codecogs.com/svg.latex?f%28n%20%3D%202%29 "f(n = 2)")
    memiliki nilai *objective function* yang lebih rendah, tetapi
    melanggar batasan ketidaknyamanan
    (![K(n=2) \approx 5,75 \> 5](https://latex.codecogs.com/svg.latex?K%28n%3D2%29%20%5Capprox%205%2C75%20%3E%205 "K(n=2) \approx 5,75 > 5")).
    Jadi, kita bisa memilih
    ![n = 3](https://latex.codecogs.com/svg.latex?n%20%3D%203 "n = 3")
    kali perminggu secara konklusif.

### Kesimpulan

Dari model optimisasi di atas, frekuensi optimal tergantung pada:

1.  Seberapa cepat handuk menjadi tidak nyaman
    (![\alpha](https://latex.codecogs.com/svg.latex?%5Calpha "\alpha")),
2.  Biaya mencuci (![C](https://latex.codecogs.com/svg.latex?C "C")),
3.  Toleransi ketidaknyamanan
    (![\beta](https://latex.codecogs.com/svg.latex?%5Cbeta "\beta")).

Oleh karena itu, kita bisa memberikan saran sebagai berikut:

- Jika handuk cepat bau
  (![\alpha](https://latex.codecogs.com/svg.latex?%5Calpha "\alpha")
  besar), cucilah lebih sering (2-3 kali/minggu).  
- Jika biaya cuci tinggi
  (![C](https://latex.codecogs.com/svg.latex?C "C") besar), toleransi
  ketidaknyamanan bisa dinaikkan
  (![\beta](https://latex.codecogs.com/svg.latex?%5Cbeta "\beta")).  
- Untuk kebanyakan orang, **mencuci handuk 1-2 kali/minggu** sudah cukup
  optimal.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
