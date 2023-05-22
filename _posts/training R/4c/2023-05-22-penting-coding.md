---
date: 2023-05-22T08:42:00-04:00
title: "Pentingnya Kita Memahami Cara Kerja Algoritma di R (atau Python)"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Training R
---

Dulu ketika pertama kali belajar **R** dan *Python*, hal yang saya
lakukan adalah membuat “kamus” sendiri terkait semua perintah dan
algoritma yang akan sering saya gunakan dalam pekerjaan saya di *market
research* dan data sains. Saking bersemangatnya, saya menuliskan “kamus”
tersebut di salah satu *binder*. Setelah itu baru saya tulis ulang
“kamus” tersebut di *Google Keep* agar lebih mudah bagi saya untuk
mencarinya dengan fitur *search* yang ada.

Selain menuliskan algoritmanya, salah satu bagian penting dari “kamus”
tersebut adalah menuliskan cara kerja dari algoritma tersebut.

> Sebenarnya tidak harus menuliskan cara kerja yang detail karena bisa
> jadi kita belum terlalu paham seperti apa.

Oleh karena itu, minimal saya menuliskan **tiga bagian penting** dari
masing-masing algoritma tersebut. Apa itu?

1.  *Input*,
    - Saya menaruh banyak catatan penting pada bagian ini. *Input* suatu
      algoritma sangatlah penting karena menentukan apakah algoritma
      yang telah kita tulis bisa berjalan dengan sempurna atau tidak.
    - Sebagai contoh, untuk membuat model *machine learning* berbasis
      `caret`, diperlukan *input* berupa `data.frame`. Sedangkan jika
      kita membuat model *deep learning* di `keras` dan `tensorflow`,
      kita memerlukan input berupa `matrix`.
    - Beberapa algoritma lain bahkan memiliki input berupa `list` atau
      `vector` biasa.
2.  *Process*,
    - Mengenai *process*, sebaiknya kita memahami proses matematis atau
      statistika yang berjalan.
    - Seandainya tidak (atau tidak mau. *hehe*) sebaiknya kita paham
      tujuan dari algoritma ini apa.
    - Dengan demikian kita bisa memadu-madankan dengan tujuan dari
      analisa kita ini apa.
    - Contoh sederhana: misal kita hendak menentukan dari produk `A`,
      `B` dan `C` mana yang memiliki rata-rata penjualan harian
      terbesar. Maka kita tidak akan memilih analisa *Annova*. Lebih
      baik kita menggunakan analisa *t-test* dengan menghitung
      signifikansi dari semua pasang sampel yang ada.
3.  *Output*.
    - Pada bagian ini, kita sebaiknya paham apa barang yang dihasilkan
      dari algoritma ini, dalam hal:
      - Tipe data yang dihasilkan, apakah berbentuk `list`, `vector`,
        `matrix`, atau `data.frame`.
      - Cara membaca atau menginterpretasikan hasil algoritma.

Semoga tips dan trik di atas bisa berguna buat rekan-rekan semua.
