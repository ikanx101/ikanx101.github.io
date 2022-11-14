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
yang berasal dari divisi *sales*. Sebuah pertanyaan yang tidak mudah,
pikir saya.

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

Awalnya saya menjawab hanya dengan mengandalkan *variability*. Namun
setelah saya pikirkan kembali, saya akan kehilangan informasi yang
sangat penting jika semata hanya mengandalkan *variability*. Oleh karena
itu saya harus menyandingkannya dengan di mana data tersebut terpusat.

Sebagai contoh, saya akan gunakan data *sales* produk *A* dan *B*
ilustrasi yang diberikan teman saya berikut ini:

### Ilustrasi

Misalkan saya memiliki data *sales* harian dua produk selama 2 bulan
berdistribusi normal:

1.  Produk *A*:
    ![\mu = 150, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%20150%2C%20%5Csigma%20%3D%20100 "\mu = 150, \sigma = 100").
2.  Produk *B*:
    ![\mu = 1000, \sigma = 100](https://latex.codecogs.com/png.latex?%5Cmu%20%3D%201000%2C%20%5Csigma%20%3D%20100 "\mu = 1000, \sigma = 100").

| hari_ke |     A |      B |
|--------:|------:|-------:|
|       1 | 164.9 | 1088.2 |
|       2 |  36.7 | 1098.5 |
|       3 | 146.7 |  784.8 |
|       4 | 257.8 |  996.7 |
|       5 | -14.2 |  996.7 |
|       6 | 111.8 | 1198.5 |
|       7 | 148.0 | 1008.4 |
|       8 | 277.3 | 1111.6 |
|       9 | 132.6 | 1040.2 |
|      10 | -56.6 |  914.1 |
|      11 | 127.7 | 1085.8 |
|      12 | 164.8 |  805.6 |
|      13 |  87.8 |  931.8 |
|      14 | 177.0 |  949.4 |
|      15 | 215.9 |  810.0 |
|      16 | 104.5 |  888.7 |
|      17 | 253.9 |  980.5 |
|      18 |  21.0 | 1038.0 |
|      19 |  79.2 |  976.7 |
|      20 |  55.0 | 1146.7 |
|      21 | 209.8 | 1033.8 |
|      22 | 183.3 |  953.5 |
|      23 | 224.8 |  942.3 |
|      24 | 127.4 | 1084.1 |
|      25 | 173.9 | 1140.1 |
|      26 | 192.5 |  959.3 |
|      27 | 185.7 | 1066.1 |
|      28 |  52.2 | 1042.8 |
|      29 | 179.5 | 1109.3 |
|      30 | 218.7 |  945.1 |
|      31 |  17.0 |  994.6 |
|      32 |  99.1 |  961.8 |
|      33 |  29.7 | 1016.8 |
|      34 |  95.5 |  910.2 |
|      35 |  95.4 |  840.3 |
|      36 |  35.8 | 1069.9 |
|      37 | 176.3 | 1102.1 |
|      38 | -24.3 | 1163.5 |
|      39 | 126.5 |  792.3 |
|      40 | 151.6 | 1002.6 |
|      41 |  85.0 | 1001.2 |
|      42 | 151.2 | 1165.1 |
|      43 |  25.6 |  868.0 |
|      44 | 130.2 |  984.8 |
|      45 | 239.1 | 1124.8 |
|      46 | 316.0 |  993.5 |
|      47 | 111.6 | 1069.1 |
|      48 |   4.8 | 1052.8 |
|      49 | 322.1 | 1085.1 |
|      50 | 218.9 |  765.7 |
|      51 |  12.4 |  946.3 |
|      52 |  94.1 |  998.7 |
|      53 | 179.6 | 1035.1 |
|      54 | -15.6 |  987.4 |
|      55 | 119.1 |  947.9 |
|      56 | 180.7 | 1025.3 |
|      57 |  18.2 |  846.9 |
|      58 | 163.7 | 1069.4 |
|      59 | 245.5 |  970.2 |
|      60 | 330.3 |  814.2 |

Jika saya gambarkan dalam bentuk *density plot*, kita dapatkan bentuk
seperti ini:

![](post_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Terlihat dari *plot* di atas, keduanya punya *variability* yang sama.
Jika hanya bermodalkan informasi tersebut, saya hanya akan mengatakan
bahwa kedua produk tersebut memiliki fluktuasi yang sama.

Namun saat saya melihat kembali data tersebut dalam bentuk *linechart*
sebagai berikut:

![](post_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Saya kembai berpikir, jangan-jangan keduanya tidak berfluktuasi dengan
tingkat yang sama. Kenapa? Pada produk *A* kita dapati bahwa nilai
*sales*-nya bergerak naik dan turun secara “ekstrim”. Sedangkan produk
*B*, walaupun bergerak naik dan turun dalam *range* yang sama dengan
produk *A*, tapi rata-rata *sales*-nya masih “aman”.

![](post_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Koefisien Variasi

Beberapa saat kemudian, saya mulai mengingat kembali salah satu rasio
yang biasa digunakan dalam statistika yang berguna untuk melihat sebaran
data dari rata-rata hitungnya. Rasio tersebut disebut sebagai
**koefisien variasi**.

Formulanya adalah sebagai berikut:

![kv = \frac{\sigma}{\mu} \times 100 \\%](https://latex.codecogs.com/png.latex?kv%20%3D%20%5Cfrac%7B%5Csigma%7D%7B%5Cmu%7D%20%5Ctimes%20100%20%5C%25 "kv = \frac{\sigma}{\mu} \times 100 \%")

Semakin kecil rasio koefisien variasi, maka kita bisa sbeut bahwa data
semakin homogen. Sementara sebaliknya, semakin besar nilai rasionya maka
data akan semakin heterogen.

Kembali ke masalah rekan saya ini, sepertinya bisa diselesaikan dengan
menghitung koefisien variasi.
