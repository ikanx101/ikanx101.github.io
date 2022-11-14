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

| hari_ke |      A |      B |
|--------:|-------:|-------:|
|       1 |  256.4 |  946.3 |
|       2 |  196.3 |  988.5 |
|       3 |   57.3 |  928.5 |
|       4 |  269.3 |  715.1 |
|       5 |  124.3 |  981.2 |
|       6 |   71.1 | 1075.9 |
|       7 |  170.0 | 1022.5 |
|       8 |  -61.9 | 1122.0 |
|       9 |  -36.3 | 1089.1 |
|      10 |  230.2 | 1121.6 |
|      11 |  148.2 |  993.0 |
|      12 |  -76.9 |  885.4 |
|      13 |  118.2 |  986.2 |
|      14 |  251.1 | 1104.3 |
|      15 |   55.5 | 1017.3 |
|      16 |  139.6 | 1147.7 |
|      17 |  111.8 |  943.7 |
|      18 |   31.4 | 1067.5 |
|      19 |   82.8 |  866.5 |
|      20 |  197.9 |  968.1 |
|      21 |  119.4 |  878.3 |
|      22 |   71.3 |  959.9 |
|      23 |  240.6 |  742.9 |
|      24 |  129.1 | 1079.4 |
|      25 |  -46.5 | 1096.3 |
|      26 |   22.5 |  981.8 |
|      27 |  200.4 | 1043.9 |
|      28 |   81.3 | 1082.7 |
|      29 |  149.8 |  973.1 |
|      30 |   -2.4 |  877.6 |
|      31 |  194.0 |  772.5 |
|      32 |  182.8 |  858.9 |
|      33 |  340.3 | 1166.9 |
|      34 |  320.3 |  910.2 |
|      35 |  167.9 |  955.7 |
|      36 |  306.4 |  926.9 |
|      37 |  -33.7 | 1007.5 |
|      38 |   71.8 |  946.9 |
|      39 |  167.9 | 1125.4 |
|      40 |  122.0 | 1361.3 |
|      41 |  282.8 |  862.4 |
|      42 |  153.1 |  954.2 |
|      43 |  124.3 |  897.7 |
|      44 |  145.4 | 1087.9 |
|      45 |    4.0 | 1014.4 |
|      46 |   72.4 |  907.8 |
|      47 |  249.0 | 1177.9 |
|      48 |  -45.2 | 1029.0 |
|      49 |   73.2 | 1063.5 |
|      50 |  175.1 |  905.8 |
|      51 |  105.1 |  992.1 |
|      52 |  248.1 |  933.4 |
|      53 |   62.5 |  915.5 |
|      54 |  172.2 | 1106.1 |
|      55 | -128.2 |  859.1 |
|      56 |   91.4 |  988.3 |
|      57 |   74.2 |  995.5 |
|      58 |   52.1 | 1093.7 |
|      59 |  223.5 | 1126.5 |
|      60 |  185.6 | 1036.2 |

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
