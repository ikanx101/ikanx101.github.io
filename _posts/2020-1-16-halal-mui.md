---
date: 2020-1-16T20:25:00-04:00
title: "Badan Sertifikasi Halal di Dunia"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Web Scrap
  - Halal
  - MUI
---

Sebagai negara dengan penduduk mayoritas muslim terbesar di dunia, sudah
sewajarnya setiap produk makanan dan minuman yang beredar di masyarakat
mendapatkan jaminan label **halal**.

Walaupun ada beberapa dari kita yang berpendapat bahwa label **non
halal** lebih penting untuk diterapkan di Indonesia.

> Alih-alih memberikan label halal di setiap produk makanan dan minuman
> di pasaran, tapi memberikan label **non halal** agar muslim bisa
> *notice* mana yang baik untuk mereka dan mana yang tidak.

Salah satu badan yang bisa melakukan dan memberikan sertifikasi halal di
Indonesia adalah [LPPOM MUI](http://www.halalmui.org/mui14/).

Salah satu pertanyaan yang sering ditanyakan beberapa orang adalah:

> Jika ada produk makanan atau minuman impor dari negara lain, apakah
> harus disertifikasi halal oleh LPPOM MUI juga? Atau gimana?

Ternyata jika kita cari di situs MUI [lebih
jauh](http://www.halalmui.org/mui14/main/page/list-of-halal-certification-bodies),
barang yang diimpor dari luar negeri dan sudah disertifikasi di negara
awalnya (bisa jadi) tidak perlu disertifikasi ulang. Cukup melengkapi
dokumen sertifikasi halal dari badan sertifikasi yang ada di negaranya.

Ada `45` [badan sertifikasi luar
negeri](http://www.halalmui.org/mui14/main/page/list-of-halal-certification-bodies)
yang diakui oleh LPPOM MUI. Masing-masing badan memiliki kemampuan untuk
melakukan sertifikasi halal kepada:

1.  **Cattle slaughtering**, terkait kehalalan terhadap proses
    penyembelihan hewan ternak.
2.  **Raw material**, terkait kehalalan *raw material* dari suatu
    produk.
3.  **Flavor**, terkait dengan kehalalan dari zat
perasa.

![text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Halal%20MUI/2020-1-15-halal-mui_files/figure-gfm/unnamed-chunk-2-1.png)

-----

## Apakah ada badan sertifikasi halal yang mampu melakukan sertifikasi atas ketiga kategori di atas?

Salah satu cara termudah untuk menjawab pertanyaan di atas adalah
menggunakan prinsip *set analysis* atau yang biasa dikenal dengan sebutan **Analisa Himpunan**.

Jadi kita akan bentuk himpunan - himpunan, lalu menentukan siapa saja anggota dari suatu himpunan yang juga merupakan anggota dari himpunan lainnya. Kita biasa sebut dengan istilah **irisan**.

Visualisasi paling sederhana adalah menggunakan **diagram venn**. Masih ingat?

> Alih-alih membuat **diagram venn**, saya akan membuat **upset
> diagram** untuk menjawab pertanyaan ini.



Apa itu **upset diagram**? **Upset diagram** relatif masih lebih baru di analisa himpunan. Untuk beberapa kasus yang memiliki himpunan yang banyak dan irisan yang banyak, diagram ini lebih mudah dipahami dan dimengerti dibandingkan *diagram venn*.

Bagaimana bentuknya?

*Cekidot yah*:

![text](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/Halal%20MUI/2020-1-15-halal-mui_files/figure-gfm/unnamed-chunk-3-1.png)
