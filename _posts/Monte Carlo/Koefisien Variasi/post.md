Menentukan Apakah Suatu Data Fluktuatif atau Tidak?
================

#### Pada pagi hari ini:

*Salesperson* : *“Mas, bagaimana ya caranya agar saya bisa menentukan
suatu data itu fluktuatif atau tidak?”*

*Saya* : *“Fluktuatif yang kamu maksud itu variability?”*

*Salesperson* : *“Bukan tentang sebaran data.”*

*Saya* : *“Lantas bagaimana maksudnya?”*

*Salesperson* : *“Misalkan saya punya data A dengan rata-rata = 100 dan
standar deviasi juga 100. Lalu saya punya data B dengan rata-rata 1000
tapi standar deviasinya juga 100. Data A kan seharusnya lebih fluktuatif
yah dibanding data B?”*

*Saya* : *“Ooh, saya mengerti maksudnya. Jadi begini…..”*

------------------------------------------------------------------------

Begitu kira-kira percakapan antara saya dan salah seorang rekan kerja
yang berasal dari divisi *sales*. Sebuah pertanyaan sederhana menurut
saya namun sangat bermanfaat dan *strategic* bagi dirinya.

Untuk menyelesaikan permasalahan tersebut, mari kita lihat terlebih
dahulu dua konsep sederhana dalam statistika yakni:

1.  Pemusatan data (*centrality*) dan
2.  Sebaran data (*variability*).

Sesuai dengan namanya, *centrality* adalah suatu pengukuran untuk
menentukan dimana data tersebut berpusat (atau berkumpul). Kita bisa
menghitung 3 *metrics* pada *centrality*, yakni *mean*, median, dan
modus.

*Variability* adalah suatu pengukuran yang menentukan seberapa data
tersebar. Ada beberapa *metric* yang bisa dihitung seperti: variansi,
standar deviasi, dan *range*.

Masalah yang ditemui oleh rekan saya itu adalah:

> Bagaimana menentukan suatu data itu fluktuatif atau tidak?

Jika saya hanya mengandalkan *variability*, bisa jadi saya akan
kehilangan informasi yang sangat penting karena *variability* semata
hanya menandakan seberapa data tersebut tersebar. Oleh karena itu saya
harus menyandingkannya dengan di mana data tersebut terpusat.

Sebagai contoh, saya akan gunakan data
![A](https://latex.codecogs.com/png.latex?A "A") dan
![B](https://latex.codecogs.com/png.latex?B "B") ilustrasi yang
diberikan teman saya berikut ini:

### Ilustrasi

Misalkan data *sales* harian produk
![A](https://latex.codecogs.com/png.latex?A "A") selama 2 bulan
berdistribusi normal dengan
![\mu = 100, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%20100%2C%20%5Csigma%20%3D%20100 "\mu = 100, \sigma = 100").
Sedangkan data *sales* harian produk
![B](https://latex.codecogs.com/png.latex?B "B") selama 2 bulan
berdistribusi normal dengan
![\mu = 1000, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%201000%2C%20%5Csigma%20%3D%20100 "\mu = 1000, \sigma = 100").

Jika saya gambarkan dalam bentuk *density plot*, kita dapatkan bentuk
seperti ini:

![](post_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Keduanya punya *variability* yang sama, tapi secara fluktuatif
sebenarnya produk ![A](https://latex.codecogs.com/png.latex?A "A") lebih
berfluktuatif. Dari *density plot* di atas mungkin tidak semua orang
bisa melihatnya. Tapi kalau data yang sama di atas saya ubah bentuknya
menjadi *linechart* seperti ini:

![](post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
