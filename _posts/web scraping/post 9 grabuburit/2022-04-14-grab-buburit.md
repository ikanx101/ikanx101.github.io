---
date: 2022-04-14T05:54:00-04:00
title: "Ngabuburit Sambil Web Scrape GrabFood di Sekitar Rumah"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - Grab
  - Puasa
  - Makanan
---

Sore kemarin, sambil menunggu buka puasa, saya penasaran sudah sebanyak
apa *merchant* makanan dan minuman yang berada di sekitar rumah saya
yang sudah ter-*listing* di layanan **GrabFood**. Menggunakan teknik
yang saya [tulis kemarin](https://ikanx101.com/blog/selenium-rvest/)
saya akan coba mengambil sebanyak-banyaknya data *merchants* dan
melakukan analisa sederhana.

Kira-kira, menu buka puasa apa yang ada di sekitar rumah saya?

------------------------------------------------------------------------

Proses *webscraping*-nya sendiri memakan waktu sekitar `20` menit dan
saya berhasil mendapatkan `251` buah data *merchants* di sekitar rumah
saya di Bekasi Timur. Saya mencarinya menggunakan fitur *nearby* yang
ada pada GrabFood.

Pertama-tama, saya akan coba mencari tahu kategori *merchant* apa saja
yang ada di dekat rumah saya. Kategori ini adalah berdasarkan kategori
yang ada pada halaman masing-masing *merchant* pada GrabFood.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%209%20grabuburit/post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Ternyata *snack*, *beverages*, dan *chicken* adalah tiga kategori yang
mendominasi. Saya baru sadar, setelah dipikir-pikir lagi memang tempat
nongkrong seperti kedai kopi dan cemilan sedang menjamur di sekitar
rumah. Sekarang bahkan sudah menggeser tempat makan “tradisional”
seperti rumah makan padang, soto, bakso, dan mie ayam.

Mari kita lihat sebaran *rating* dari 3 kategori teratas tersebut.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%209%20grabuburit/post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Sebenarnya ketiga kategori tersebut mendapatkan *rating* yang bagus
berdasarkan nilai *summary* yang ada. Tapi kalau saya boleh berpendapat,
saya rasa *beverages* adalah kategori yang paling terbaik di antara
ketiganya.

Sekarang saya akan membandingkan harga dari setiap menu yang ada pada
ketiga kategori tersebut. Agar perbandingan ini menjadi *fair*, saya
hanya akan menggunakan satu harga per *merchant*. Harga yang saya
gunakan adalah median harga dari semua menu yang ada pada setiap
*merchant*.

Ilustrasi: misalkan *merchant* ABC memiliki 10 buah menu dengan harga
yang berbeda-beda. Maka harga yang saya ambil sebagai harga final
*merchant* ABC adalah median harga dari 10 menu tersebut.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post%209%20grabuburit/post_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Jika dilihat sekilas, ketiga kategori ini berada pada level harga yang
mirip. Tentunya jika ingin lebih pasti, kita perlu mengujinya dengan
annova atau Kruskal-Wallis.

Lantas saya jadi bertanya:

> Apakah ketiga kategori ini menjadi populer dan menjamur karena
> harganya yang relatif masih masuk kantong kebanyakan kita-kita? Atau
> ada alasan lain?
