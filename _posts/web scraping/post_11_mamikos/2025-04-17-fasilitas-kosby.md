---
date: 2025-04-17T14:02:00-04:00
title: "Fasilitas Kost di Sekitar Nutrihub Surabaya dari Situs Mamikos"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrape
  - Mamikos
  - Harga
  - Surabaya
---

Masih lanjutan dari [*post* saya
sebelumnya](https://ikanx101.com/blog/mami-kosby/), kali ini saya akan
membahas tentang fasilitas apa saja yang ditawarkan oleh semua *listed*
kost yang ada di Mamikos di kota Surabaya.

> Perlu saya ingatkan sekali lagi bahwa ini adalah data yang sama dengan
> yang saya ambil pada tulisan sebelumnya.

Pertama-tama saya akan infokan berapa banyak kost yang *listed* per area
sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-2-1.png)

Hal ini luput pada tulisan sebelumnya, padahal hal ini penting dan
seharusnya saya tulis.

Oke sekarang kita akan lihat fasilitas apa saja yang ditawarkan oleh
semua *lsited* kost yang ada:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-3-1.png)

Perlu saya infokan bahwa satu *kost* bisa memberikan satu atau lebih
fasilitas (*multiple*) sehingga kalau persentase semua fasilitas
tersebut dijumlah pasti **hasilnya di atas 100%**.

Kita bisa lihat bahwa *top two facilites* yang ditawarkan adalah **kasur
dan akses 24 jam**. Sedangkan fasilitas lainnya memiliki persentase
minimal 60%. Sekarang saya akan coba *cross* per kecamatan kost yang
ada:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-4-1.png)

Ternyata jika kita *cross* berdasarkan kecamatan, fasilitas yang
ditawarkan menjadi agak berbeda urutannya.

------------------------------------------------------------------------

Secara logis, seharusnya fasilitas yang membutuhkan perangkat tertentu
atau konsumsi listrik lebih seharusnya lebih mahal. Untuk membuktikan
itu, saya membuat visualisasi sebagai berikut untuk mengecek sebaran
harga sewa berdasarkan fasilitas yang ditawarkan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-5-1.png)

Secara visual bisa dilihat bahwa kost yang menawarkan AC, kloset duduk,
dan WiFi memiliki harga sewa yang relatif lebih tinggi dibandingkan
lainnya. Untuk mengkonfirmasinya, saya coba lakukan uji Kruskal-Wallis
sebagai berikut:

``` r
df_raw %>% 
  kruskal.test(harga ~ fasilitas)
```


        Kruskal-Wallis rank sum test

    data:  .
    Kruskal-Wallis chi-squared = 2779.8, df = 4, p-value < 2.2e-16

Didapatkan nilai
![p\_{value} = 2.2 \times 10^{-16} \< \alpha](https://latex.codecogs.com/svg.latex?p_%7Bvalue%7D%20%3D%202.2%20%5Ctimes%2010%5E%7B-16%7D%20%3C%20%5Calpha "p_{value} = 2.2 \times 10^{-16} < \alpha"),
dengan
![\alpha = .05](https://latex.codecogs.com/svg.latex?%5Calpha%20%3D%20.05 "\alpha = .05")
sehingga kita bisa menyimpulkan bahwa *mean* harga sewa kost antar
fasilitas yang ditawarkan **berbeda-beda**.

Berikutnya saya akan menghitung ada berapa banyak kost berdasarkan
banyaknya fasilitas yang ditawarkan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-7-1.png)

Saya akan cek harga sewa bulanan berdasarkan berapa banyak fasilitas
yang ditawarkan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/web%20scraping/post_11_mamikos/post_files/figure-commonmark/unnamed-chunk-8-1.png)

**Hasilnya sangat masuk akal!**

Semakin banyak fasilitas yang diberikan, semakin mahal harga sewanya.
Saya tak perlu melakukan analisa Kruskal-Wallis untuk ini ya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
