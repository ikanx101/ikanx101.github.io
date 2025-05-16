---
date: 2025-05-15T10:17:00-04:00
title: "Memahami Distribusi Poisson dari Peristiwa Saat Training Karyawan Baru"
categories:
  - Blog
tags:
  - Statistik
  - Matematika
  - Poisson
  - Traning
  - Grafik
  - Nutrifood
---

Dalam rentang setahun, biasanya Nutrifood mengadakan dua sampai tiga
kali rekrutmen *management trainee* (kalau saya *gak* salah ingat ya).
Sejak dulu, saya selalu mengisi satu *session* orientasi karyawan baru
di setiap *bacth* *management trainee*. Biasanya di akhir *session* saya
membuka ruang untuk rekan-rekan *management trainee* bertanya dan
berdiskusi. Menurut ingatan saya, rata-rata ada 5 pertanyaan yang
diajukan di setiap *session*.

> Namun pada *session* di *batch* terakhir, saya mendapatkan 9
> pertanyaan.

Lantas saya memberikan *notes* kepada tim HR bahwa *batch* terakhir ini
**spesial**. Seingat saya, pernah beberapa *bacthes* yang “sepi” dari
diskusi sama sekali.

------------------------------------------------------------------------

Cerita saya di atas adalah contoh nyata suatu kejadian yang mengikuti
distribusi *Poisson*. Distribusi *Poisson* adalah salah satu distribusi
probabilitas diskrit yang digunakan untuk **memodelkan sejumlah kejadian
dalam suatu interval waktu atau area tertentu**. Distribusi ini dinamai
dengan nama matematikawan **Prancis Siméon Denis Poisson** (1781–1840).

Distribusi *Poisson* digunakan ketika:

1.  Kejadian bersifat acak dan independen (terjadinya satu kejadian
    tidak memengaruhi kejadian berikutnya).
2.  Rata-rata kejadian diketahui (λ) dan konstan dalam interval yang
    diamati.
3.  Interval dapat berupa waktu, panjang, area, atau volume (misal: per
    jam, per km², per halaman buku).
4.  Peluang lebih dari satu kejadian dalam interval sangat kecil
    (mendekati nol). Apa maksudnya?
    - Interval sangat kecil bisa berupa:
      - Waktu yang sangat singkat (misal: detik, milidetik).
      - Ruang yang sangat sempit (misal: milimeter, area mikroskopis).
    - Peluang \>1 kejadian dalam interval kecil ≈ 0 berarti:
      - Hanya ada 0 atau 1 kejadian yang mungkin terjadi dalam
        waktu/ruang yang sangat sempit.
      - Contoh:
        - Dalam 1 milidetik, hampir tidak mungkin ada 2 panggilan
          telepon sekaligus di *call center*.
        - Dalam satu detik, hampir tak mungkin ada dua pasien yang
          datang bersamaan ke dokter.

Salah satu karakteristik utamanya adalah nilai *mean* sama dengan nilai
variansinya. Keduanya diwakili oleh parameter tunggal, yaitu lambda (λ).
Penjelasan intuitifnya adalah:

1.  **Kejadian Poisson Bersifat Acak & Independen**
    - Karena kejadian terjadi secara acak, tidak ada “kecenderungan”
      kejadian saling memengaruhi atau berkelompok.
    - Contoh: Jika hari ini banyak email *spam*, *spam* di esok hari
      tidak dipengaruhi oleh hari ini.
2.  **Tidak Ada Faktor “Pengurangan” Peluang**
    - Pada distribusi *Binomial*, peluang sukses
      (![p](https://latex.codecogs.com/svg.latex?p "p")) dan gagal
      (![1-p](https://latex.codecogs.com/svg.latex?1-p "1-p"))
      mempengaruhi nilai variansi
      (![\sigma^2 = np(1-p)](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3D%20np%281-p%29 "\sigma^2 = np(1-p)")).
    - Pada distribusi *Poisson*, **tidak ada**
      (![1-p](https://latex.codecogs.com/svg.latex?1-p "1-p")) karena
      kejadian bisa terjadi berapa pun (tidak seperti *Binomial* yang
      terbatas ![n](https://latex.codecogs.com/svg.latex?n "n")
      percobaan).
3.  **Laju Kejadian**
    (![\lambda](https://latex.codecogs.com/svg.latex?%5Clambda "\lambda"))
    **Konstan**
    - Karena
      ![\lambda](https://latex.codecogs.com/svg.latex?%5Clambda "\lambda")
      tetap, sebaran data mengikuti laju ini tanpa faktor tambahan yang
      mengubah penyebarannya.

## Analogi

### Analogi I

Bayangkan kita menjatuhkan banyak biji jagung ke suatu lantai:

- Misalkan rata-rata
  (![\mu](https://latex.codecogs.com/svg.latex?%5Cmu "\mu")) sebesar 5
  biji per meter persegi
  (![\lambda = 5](https://latex.codecogs.com/svg.latex?%5Clambda%20%3D%205 "\lambda = 5")).
- Karena biji jatuh **secara acak dan tidak saling memengaruhi,
  sebarannya mengikuti rata-rata**
  (![\sigma^2 = 5](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3D%205 "\sigma^2 = 5")).
- Jika **variansi \> mean**: Berarti biji cenderung berkelompok (tidak
  acak).
- Jika **variansi \< mean**: Berarti biji terlalu teratur (jarang
  berdekatan).

Poisson selalu acak, jadi
![\mu = \sigma^2](https://latex.codecogs.com/svg.latex?%5Cmu%20%3D%20%5Csigma%5E2 "\mu = \sigma^2").

### Analogi II

Misalkan rata-rata kecelakan lalu lintas dua kali per minggu
(![\lambda = 2](https://latex.codecogs.com/svg.latex?%5Clambda%20%3D%202 "\lambda = 2")).
Apa artinya?

- Jika
  ![\sigma^2 \> \lambda](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3E%20%5Clambda "\sigma^2 > \lambda")
  (misalkan:
  ![\sigma^2 = 4](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3D%204 "\sigma^2 = 4")),
  artinya kecelakaan cenderung berkelompok (misal: hari hujan banyak
  kecelakaan, hari cerah sedikit).
- Jika
  ![\sigma^2 \< \lambda](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3C%20%5Clambda "\sigma^2 < \lambda")
  (misalkan:
  ![\sigma^2 = 1](https://latex.codecogs.com/svg.latex?%5Csigma%5E2%20%3D%201 "\sigma^2 = 1")),
  artinya kecelakaan terlalu teratur (misal: ada pengaturan lalu lintas
  yang mengurangi variasi).

------------------------------------------------------------------------

Rumus distribusi *Poisson*:

Peluang terjadinya ![k](https://latex.codecogs.com/svg.latex?k "k")
kejadian dalam interval tertentu dituliskan sebagai berikut:

![P(X=k) = \frac{e^{-\lambda}.\lambda^k}{k!}](https://latex.codecogs.com/svg.latex?P%28X%3Dk%29%20%3D%20%5Cfrac%7Be%5E%7B-%5Clambda%7D.%5Clambda%5Ek%7D%7Bk%21%7D "P(X=k) = \frac{e^{-\lambda}.\lambda^k}{k!}")

di mana:

- ![P(X=k)](https://latex.codecogs.com/svg.latex?P%28X%3Dk%29 "P(X=k)")
  menandakan peluang terjadinya
  ![k](https://latex.codecogs.com/svg.latex?k "k") kejadian.
- ![\lambda](https://latex.codecogs.com/svg.latex?%5Clambda "\lambda")
  menandakan *mean* kejadian per interval.
- ![e](https://latex.codecogs.com/svg.latex?e "e") merupakan bilangan
  *Euler*.
- ![k!](https://latex.codecogs.com/svg.latex?k%21 "k!") merupakan
  ![k](https://latex.codecogs.com/svg.latex?k "k") faktorial. Misalkan:
  ![4! = 4 \times 3 \times 2 \times 1 = 24](https://latex.codecogs.com/svg.latex?4%21%20%3D%204%20%5Ctimes%203%20%5Ctimes%202%20%5Ctimes%201%20%3D%2024 "4! = 4 \times 3 \times 2 \times 1 = 24")

Dari rumus di atas dan dari kasus *management trainee* Nutrifood, saya
bisa menghitung berapa peluang saya mendapat 9 pertanyaan pada *session*
orientasi karyawan. Begini hasilnya:

- Peluang terjadinya sesi diskusi yang “ramai”:
  1.  Peluang terjadi **persis 9 pertanyaan** dalam *session*:
      ![P(X = 9) = 3.63\\](https://latex.codecogs.com/svg.latex?P%28X%20%3D%209%29%20%3D%203.63%5C%25 "P(X = 9) = 3.63\%")
  2.  Peluang terjadi **9 pertanyaan atau lebih** dalam *session*:
      ![P(X \geq 9) = 3.18\\](https://latex.codecogs.com/svg.latex?P%28X%20%5Cgeq%209%29%20%3D%203.18%5C%25 "P(X \geq 9) = 3.18\%")
- Peluang terjadinya sesi diskusi yang “sepi”:
  1.  Peluang terjadi **persis 3 pertanyaan** dalam *session*:
      ![P(X = 3) = 14.04\\](https://latex.codecogs.com/svg.latex?P%28X%20%3D%203%29%20%3D%2014.04%5C%25 "P(X = 3) = 14.04\%")
  2.  Peluang terjadi **3 pertanyaan atau kurang** dalam *session*:
      ![P(X \leq 3) = 26.5\\](https://latex.codecogs.com/svg.latex?P%28X%20%5Cleq%203%29%20%3D%2026.5%5C%25 "P(X \leq 3) = 26.5\%")

> Dari perhitungan di atas, ternyata memang peluang terjadinya *batch*
> yang “sepi” memang jauh lebih besar dibandingkan dengan *batch* yang
> “ramai”.

Berikut adalah grafik *probability*-nya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/poisson/draft_files/figure-commonmark/unnamed-chunk-1-1.png)

------------------------------------------------------------------------

Kapan Distribusi Poisson Tidak Berlaku?

1.  Jika kejadian tidak independen (misal: gempa susulan setelah gempa
    utama).
2.  Jika λ berubah-ubah dalam interval yang diamati.
3.  Jika peluang kejadian tidak kecil (lebih baik pakai Binomial atau
    distribusi lain).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`

------------------------------------------------------------------------

## *Appendix*

**Hubungan Distribusi *Poisson* dengan Distribusi Binomial**

Distribusi Poisson dapat menjadi pendekatan untuk Binomial jika:

- ![n](https://latex.codecogs.com/svg.latex?n "n") (jumlah percobaan)
  sangat besar,
- ![p](https://latex.codecogs.com/svg.latex?p "p") (peluang sukses)
  sangat kecil,
- ![\lambda = n . p](https://latex.codecogs.com/svg.latex?%5Clambda%20%3D%20n%20.%20p "\lambda = n . p")
  (konstan).

Contoh:

- Kasus kecelakaan lalu lintas: Peluang kecelakaan per mobil sangat
  kecil, tetapi jumlah mobil sangat besar.
- Kasus cacat produksi: Peluang suatu produk cacat sangat kecil, tetapi
  jumlah produksi sangat besar.

**Siapa *Prancis Siméon Denis Poisson*?**

**Siméon Denis Poisson (1781–1840)** adalah matematikawan dan fisikawan
Prancis yang terkenal berkat kontribusinya dalam teori probabilitas dan
fisika matematika. Lahir di Pithiviers, Prancis, Poisson belajar di
*École Polytechnique* di Paris di bawah bimbingan ilmuwan ternama
seperti Pierre-Simon **Laplace** dan Joseph-Louis **Lagrange**. Karyanya
mencakup berbagai bidang, termasuk statistik, astronomi, dan elastisitas
material.

Salah satu kontribusi terbesarnya adalah **Distribusi Poisson**, sebuah
model probabilitas untuk peristiwa langka yang kini banyak digunakan
dalam analisis antrian, kedokteran, dan teknik. Selain itu, namanya juga
diabadikan dalam **Persamaan Poisson** (dalam fisika matematika) dan
**Rasio Poisson** (dalam teori elastisitas). Meski awalnya bercita-cita
menjadi dokter, kegagalannya dalam ujian kedokteran justru membawanya
menjadi salah satu matematikawan terpenting abad ke-19.

Poisson dikenal sebagai ilmuwan yang produktif namun sering terlibat
persaingan sengit dengan sesama matematikawan, seperti Augustin-Louis
**Cauchy**. Meski kurang terkenal dibanding Gauss atau Laplace,
warisannya tetap hidup melalui konsep-konsep matematika yang digunakan
hingga hari ini, seperti pemodelan kecelakaan lalu lintas, peluruhan
radioaktif, dan analisis sistem telekomunikasi.
