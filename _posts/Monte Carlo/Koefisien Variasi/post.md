Menentukan Apakah Suatu Data Fluktuatif atau Tidak?
================

#### Pada pagi hari ini:

*Salesperson* : *“Mas, bagaimana ya caranya agar saya bisa menentukan
suatu data itu fluktuatif atau tidak?”*

*Saya* : *“Fluktuatif yang kamu maksud itu variability?”*

*Salesperson* : *“Bukan tentang sebaran data.”*

*Saya* : *“Lantas bagaimana maksudnya?”*

*Salesperson* : *“Misalkan saya punya data *sales* harian selama 2
bulan. Produk A rata-ratanya 150 *pcs* dan standar deviasinya juga 100
*pcs*. Lalu produk B dengan rata-rata 1000 *pcs* dan standar deviasinya
juga 100 *pcs*. Produk A kan seharusnya lebih fluktuatif yah dibanding
produk B?”*

*Saya* : *“Ooh, saya mengerti maksudnya. Jadi begini…..”*

------------------------------------------------------------------------

Begitu kira-kira percakapan antara saya dan salah seorang rekan kerja
yang berasal dari divisi *sales*. Untuk menyelesaikan permasalahan
tersebut, mari kita lihat terlebih dahulu dua konsep sederhana dalam
statistika yakni:

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

Awalnya saya menjawab hanya dengan mengandalkan *variability*. Namun
setelah saya pikirkan kembali, saya akan kehilangan informasi yang
sangat penting jika semata hanya mengandalkan *variability*. Oleh karena
itu saya harus menyandingkannya dengan di mana data tersebut terpusat.

Sebagai contoh, saya akan gunakan data
![A](https://latex.codecogs.com/png.latex?A "A") dan
![B](https://latex.codecogs.com/png.latex?B "B") ilustrasi yang
diberikan teman saya berikut ini:

### Ilustrasi

Misalkan saya memiliki data *sales* harian dua produk selama 2 bulan
berdistribusi normal:

1.  Produk ![A](https://latex.codecogs.com/png.latex?A "A"):
    ![\mu = 150, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%20150%2C%20%5Csigma%20%3D%20100 "\mu = 150, \sigma = 100").
2.  Produk ![B](https://latex.codecogs.com/png.latex?B "B"):
    ![\mu = 1000, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%201000%2C%20%5Csigma%20%3D%20100 "\mu = 1000, \sigma = 100").

| hari_ke |     A |      B |
|--------:|------:|-------:|
|       1 | 383.6 | 1018.3 |
|       2 |  49.4 | 1014.5 |
|       3 |  12.1 |  844.1 |
|       4 |  46.4 |  920.9 |
|       5 | 163.7 | 1064.2 |
|       6 |  16.9 | 1006.1 |
|       7 |  85.7 | 1035.3 |
|       8 | 174.8 | 1012.2 |
|       9 |  78.0 | 1090.9 |
|      10 | 249.5 | 1155.0 |
|      11 | 186.1 | 1018.0 |
|      12 | 128.7 | 1063.5 |
|      13 | 109.7 | 1118.9 |
|      14 | 103.1 | 1234.4 |
|      15 | 371.2 | 1113.9 |
|      16 | 155.8 |  839.1 |
|      17 |  41.4 |  967.6 |
|      18 | 168.4 |  989.2 |
|      19 |  86.1 |  933.4 |
|      20 | 158.9 |  823.9 |
|      21 |  78.6 |  871.5 |
|      22 |   7.4 |  915.9 |
|      23 | 235.3 |  906.8 |
|      24 | 174.9 |  979.2 |
|      25 | 225.4 |  976.8 |
|      26 | 294.3 | 1005.9 |
|      27 | 106.8 | 1087.4 |
|      28 | 273.8 |  953.2 |
|      29 | 107.7 |  904.6 |
|      30 | 308.8 |  892.4 |
|      31 | 199.7 | 1078.6 |
|      32 | 158.9 |  986.0 |
|      33 | -25.2 |  996.1 |
|      34 |  84.8 |  925.7 |
|      35 | 159.5 | 1024.0 |
|      36 | 272.8 |  878.6 |
|      37 | 212.0 | 1062.6 |
|      38 | -26.5 | 1175.4 |
|      39 |  98.4 |  960.5 |
|      40 | 160.3 |  836.1 |
|      41 | 120.1 |  969.9 |
|      42 |  81.0 | 1038.5 |
|      43 | 107.5 |  894.9 |
|      44 |  16.9 |  841.2 |
|      45 | 218.3 |  893.3 |
|      46 | -22.1 |  937.1 |
|      47 | 135.6 |  991.7 |
|      48 | 171.3 |  911.7 |
|      49 | 167.2 |  996.6 |
|      50 |  97.2 |  879.8 |
|      51 | 117.4 | 1038.8 |
|      52 | 246.0 | 1051.0 |
|      53 | 111.6 | 1027.6 |
|      54 | 253.5 | 1013.5 |
|      55 | 148.0 |  934.5 |
|      56 | 217.1 | 1056.4 |
|      57 | 210.1 |  994.5 |
|      58 | 163.2 | 1049.5 |
|      59 |  47.4 |  973.7 |
|      60 | 216.6 | 1193.0 |

Jika saya gambarkan dalam bentuk *density plot*, kita dapatkan bentuk
seperti ini:

![](post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Terlihat dari *plot* di atas, keduanya punya *variability* yang sama.
Lantas bagaimana saya menentukan mana yang lebih fluktuatif? Kalau saya
buatkan dalam bentuk *linechart* sebagai berikut apakah sudah lebih
terlihat?

![](post_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Masih belum terlihat juga ya? Oke kalau saya modifikasi kembali menjadi
bentuk seperti ini:

![](post_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->
