---
date: 2023-04-14T14:26:00-04:00
title: "Tutorial Clustering Menggunakan R"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Clustering
  - K-Means Clustering
  - Hierachical Clustering
  - DBScan
  - Matematika
  - Jarak
  - Similarity
  - Euclidean
  - Manhattan
  - Chebishev
---

Dalam beberapa kesempatan, saya pernah menuliskan beberapa penerapan
*unsupervised machine learning*, yakni *clustering analysis*. Kali ini
saya akan berikan beberapa *showcases* penerapan metode *clustering*
dengan **R**. Setidaknya ada tiga metode *clustering* yang terkenal dan
biasa digunakan, yakni:

1.  *K-means clustering*,
2.  *Hierarchical clustering*, dan
3.  *DBScan clustering*.

Mari kita bahas satu-persatu.

# *K-Means Clustering*

*K-means clustering* adalah metode *clustering* yang paling terkenal di
antara metode *clustering* yang lainnya. Metode ini paling cocok
digunakan untuk tipe data yang berbentuk *centroid* atau terkumpul di
suatu titik tertentu.

Algoritma pengerjaannya cukup sederhana, yakni:

1.  Kita harus menentukan terlebih dahulu berapa banyak *cluster*
    (menentukan nilai ![k](https://latex.codecogs.com/png.latex?k "k")).
2.  Penentuan nilai ![k](https://latex.codecogs.com/png.latex?k "k")
    bisa dilakukan dengan cara:
    - Melihat secara visual grafik yang muncul.
    - Menggunakan *elbow method* atau *silhouette method*.
3.  Hitung *k-means clustering* dengan nilai
    ![k](https://latex.codecogs.com/png.latex?k "k") yang telah
    diketahui.

Misalkan saya memiliki kasus-kasus sebagai berikut:

## Contoh Kasus I

``` r
# import data
df = read.csv("~/Live-Session-Nutrifood-R/LEFO Market Research/LEFO MR 2023/Unsupervised/k means/compact disks.csv") %>% 
     janitor::clean_names() %>%
     select(-x) %>%
     rename(x = x_2)

# kita bikin visualisasinya terlebih dahulu
plt = 
  df %>%
  ggplot(aes(x,y)) +
  geom_point() + 
  coord_equal()
plt 
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />

Jika melihat langsung data di atas, kita sudah bisa pastikan bahwa ada
![k = 4](https://latex.codecogs.com/png.latex?k%20%3D%204 "k = 4") buah
*cluster*.

> Namun bagaimana jika kita gunakan *elbow method* dan *silhouette
> method* untuk menentukan berapa banyaknya
> ![k](https://latex.codecogs.com/png.latex?k "k")?

### *Elbow Method*

``` r
elbow = fviz_nbclust(df, kmeans, method = "wss")
plot(elbow)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### *Silhouette Method*

``` r
siluet = fviz_nbclust(df, kmeans, method = "silhouette")
plot(siluet)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Kesimpulan Sementara

Kita bisa melihat bahwa nilai
![k](https://latex.codecogs.com/png.latex?k "k") hasil *elbow method*
dan *silhouette method* tidak sama dengan 4. Hasil ini berpotensi
menjadi *miss leading*. Akan saya berikan visualnya dengan berbagai
nilai ![k](https://latex.codecogs.com/png.latex?k "k") yang kita sudah
ketahui dari analisa sebelumnya.

#### Jika ![k=5](https://latex.codecogs.com/png.latex?k%3D5 "k=5")

``` r
# k-means clustering
final = kmeans(df, 5, nstart = 25)

# center dari masing-masing cluster
final$centers
```

    ##             x           y
    ## 1  0.04097999  9.98130971
    ## 2 10.04097999  9.98130971
    ## 3  0.04097999 -0.01869029
    ## 4 10.50025161 -0.39974068
    ## 5  9.53552463  0.40067802

``` r
# save hasil cluster ke data awal
data_kmeans = df
data_kmeans$cluster = final$cluster

# berapa banyak isi dari cluster
table(data_kmeans$cluster)
```

    ## 
    ##   1   2   3   4   5 
    ## 376 376 376 197 179

``` r
plt = 
  data_kmeans %>%
  ggplot(aes(x,y)) +
  geom_point(aes(color = as.factor(cluster))) +
  coord_equal()
plt
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

#### Jika ![k=6](https://latex.codecogs.com/png.latex?k%3D6 "k=6")

``` r
# k-means clustering
final = kmeans(df, 6, nstart = 25)

# center dari masing-masing cluster
final$centers
```

    ##             x           y
    ## 1  0.04097999 -0.01869029
    ## 2 10.50025161  9.60025932
    ## 3 10.50025161 -0.39974068
    ## 4  9.53552463  0.40067802
    ## 5  9.53552463 10.40067802
    ## 6  0.04097999  9.98130971

``` r
# save hasil cluster ke data awal
data_kmeans = df
data_kmeans$cluster = final$cluster

# berapa banyak isi dari cluster
table(data_kmeans$cluster)
```

    ## 
    ##   1   2   3   4   5   6 
    ## 376 197 197 179 179 376

``` r
plt = 
  data_kmeans %>%
  ggplot(aes(x,y)) +
  geom_point(aes(color = as.factor(cluster))) +
  coord_equal()
plt
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Mari kita bandingkan dengan **jawaban yang benar**.

### Jawaban yang Benar

Seharusnya ![k=4](https://latex.codecogs.com/png.latex?k%3D4 "k=4").

``` r
# k-means clustering
final = kmeans(df, 4, nstart = 25)

# center dari masing-masing cluster
final$centers
```

    ##             x           y
    ## 1  0.04097999 -0.01869029
    ## 2 10.04097999  9.98130971
    ## 3 10.04097999 -0.01869029
    ## 4  0.04097999  9.98130971

``` r
# save hasil cluster ke data awal
data_kmeans = df
data_kmeans$cluster = final$cluster

# berapa banyak isi dari cluster
table(data_kmeans$cluster)
```

    ## 
    ##   1   2   3   4 
    ## 376 376 376 376

``` r
plt = 
  data_kmeans %>%
  ggplot(aes(x,y)) +
  geom_point(aes(color = as.factor(cluster))) +
  coord_equal()
plt
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

> Lantas bagaimana jika kita tidak bisa menentukan banyaknya
> ![k](https://latex.codecogs.com/png.latex?k "k") secara visual dan
> hanya bisa mengandalkan *elbow* dan *silhouette method*?

**Sabar, saya akan menjawabnya pada tulisan selanjutnya**.

## Contoh Kasus II

Kita akan beralih ke contoh selanjutnya seperti ini:

``` r
# import data
df = read.csv("~/Live-Session-Nutrifood-R/LEFO Market Research/LEFO MR 2023/Unsupervised/k means/dual disks.csv") %>% 
     janitor::clean_names() %>%
     select(-x) %>%
     rename(x = x_2)

# kita bikin visualisasinya terlebih dahulu
plt = 
  df %>%
  ggplot(aes(x,y)) +
  geom_point() +
  coord_equal()
plt
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-9-1.png" width="672" style="display: block; margin: auto;" />

Jika melihat langsung data di atas, kita sudah bisa pastikan bahwa ada
![k = 2](https://latex.codecogs.com/png.latex?k%20%3D%202 "k = 2") buah
*cluster*.

> Namun bagaimana jika kita gunakan *elbow method* dan *silhouette
> method* untuk menentukan berapa banyaknya
> ![k](https://latex.codecogs.com/png.latex?k "k")?

### *Elbow Method*

``` r
elbow = fviz_nbclust(df, kmeans, method = "wss")
plot(elbow)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

### *Silhouette Method*

``` r
siluet = fviz_nbclust(df, kmeans, method = "silhouette")
plot(siluet)
```

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

Kedua metode tersebut konklusif menyatakan
![k=2](https://latex.codecogs.com/png.latex?k%3D2 "k=2"). Hal ini juga
sama dengan temuan secara visual. Kita akan masukkan nilai
![k](https://latex.codecogs.com/png.latex?k "k") ke algoritma dan buat
visualisasinya kembali:

``` r
# k-means clustering
final = kmeans(df, 2, nstart = 25)

# center dari masing-masing cluster
final$centers
```

    ##            x           y
    ## 1 0.04054186 0.003287305
    ## 2 3.01638486 0.018651232

``` r
# save hasil cluster ke data awal
data_kmeans = df
data_kmeans$cluster = final$cluster

# berapa banyak isi dari cluster
table(data_kmeans$cluster)
```

    ## 
    ##    1    2 
    ## 1763 1381

``` r
plt = 
  data_kmeans %>%
  ggplot(aes(x,y)) +
  geom_point(aes(color = as.factor(cluster))) +
  coord_equal()
plt
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-12-1.png" width="672" style="display: block; margin: auto;" />

Terlihat bahwa ada beberapa titik data yang *overlap* masuk ke *cluster*
lainnya. Hal ini seharusnya tidak boleh terjadi. Sehingga bisa kita
simpulkan sementara bahwa **tidak semua bentuk data yang**
***centroid*** **bisa digunakan** ***k-means clustering***.

------------------------------------------------------------------------

# *Hierarchical Clustering*

Metode *clustering* selanjutnya adalah *hierarchical clustering*.
Algoritmanya sederhana, yakni:

1.  Dari sekumpulan data yang ada, hitung jarak antar titik data.
2.  Buat *cluster* dari dua titik yang memiliki jarak terdekat tersebut.
3.  Hitung kembali jarak antar titik data dengan *cluster* yang
    terbentuk dijadikan satu kesatuan titik.
4.  Ulangi langkahnya hingga semua titik berhasil dikelompokkan.

Hal yang krusial pada metode ini adalah penentuan jarak suatu *cluster*
dengan titik (atau *cluster* lainnya). Kita bisa pilih apakah akan
menggunakan metode:

1.  *Single link*,
2.  *Max*,
3.  *Average*, dll.

Misalkan saya punya contoh sebagai berikut:

## Contoh I

``` r
rm(list=ls())
df = read.csv("~/Live-Session-Nutrifood-R/LEFO Market Research/LEFO MR 2023/Unsupervised/hierarchical/donat.csv") %>% 
     janitor::clean_names() %>%
     select(x_2,y) %>%
     rename(x = x_2)

# membuat grafik
plt = 
  df %>%
  ggplot(aes(x,y)) +
  geom_point() +
  coord_equal()
plt
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-13-1.png" width="672" style="display: block; margin: auto;" />

``` r
# Finding distance matrix
distance_mat = dist(df, method = 'euclidean')
```

Secara visual, kita bisa simpulkan ada 3 buah cluster yang ada pada data
di atas. Metode perhitungan mana yang bisa memberikan hasil yang
terbaik?

Mari kita lihat satu-persatu:

### *Single Link*

Perhitungan dengan metode *single link*.

``` r
# Fitting Hierarchical clustering Model
set.seed(240)  # Setting seed
Hierar_cl = hclust(distance_mat, method = "single")

plot(Hierar_cl)

# Pemecahan menjadi 3 cluster
fit = cutree(Hierar_cl, k = 3)
table(fit)
```

    ## fit
    ##    1    2    3 
    ##  229 1560 2541

``` r
plot(Hierar_cl)
rect.hclust(Hierar_cl, k = 3, border = "red")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-14-1.png" width="672" style="display: block; margin: auto;" />

``` r
# save hasil cluster ke data awal
data_hc = df
data_hc$cluster = fit

# berapa banyak isi dari cluster
hie_plot = 
  data_hc %>%
  ggplot(aes(x,y,color = as.factor(cluster))) +
  geom_point() +
  coord_equal()
hie_plot
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-14-2.png" width="672" style="display: block; margin: auto;" />

### *Max / Complete Link*

Perhitungan dengan *max* atau *complete link*.

``` r
# Fitting Hierarchical clustering Model
set.seed(240)  # Setting seed
Hierar_cl = hclust(distance_mat, method = "complete")

plot(Hierar_cl)

# Pemecahan menjadi 3 cluster
fit = cutree(Hierar_cl, k = 6)
table(fit)
```

    ## fit
    ##   1   2   3   4   5   6 
    ## 767 824 814 594 834 497

``` r
plot(Hierar_cl)
rect.hclust(Hierar_cl, k = 6, border = "red")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-15-1.png" width="672" style="display: block; margin: auto;" />

``` r
# save hasil cluster ke data awal
data_hc = df
data_hc$cluster = fit

# berapa banyak isi dari cluster
hie_plot = 
  data_hc %>%
  ggplot(aes(x,y,color = as.factor(cluster))) +
  geom_point() +
  coord_equal()
hie_plot
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-15-2.png" width="672" style="display: block; margin: auto;" />

### *Average Link*

Perhitungan dengan *average link*.

``` r
# Fitting Hierarchical clustering Model
set.seed(240)  # Setting seed
Hierar_cl = hclust(distance_mat, method = "average")

plot(Hierar_cl)

# Pemecahan menjadi 3 cluster
fit = cutree(Hierar_cl, k = 4)
table(fit)
```

    ## fit
    ##    1    2    3    4 
    ## 1632 1168  732  798

``` r
plot(Hierar_cl)
rect.hclust(Hierar_cl, k = 4, border = "red")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-16-1.png" width="672" style="display: block; margin: auto;" />

``` r
# save hasil cluster ke data awal
data_hc = df
data_hc$cluster = fit

# berapa banyak isi dari cluster
hie_plot = 
  data_hc %>%
  ggplot(aes(x,y,color = as.factor(cluster))) +
  geom_point() +
  coord_equal()
hie_plot
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-16-2.png" width="672" style="display: block; margin: auto;" />

### Kesimpulan

Untuk kasus ini, perhitungan dengan metode *single link* menghasilkan
hasil *cluster* yang terbaik.

## Contoh II

Mari kita lihat kasus berikut seperti ini:

``` r
rm(list=ls())
df = read.csv("~/Live-Session-Nutrifood-R/LEFO Market Research/LEFO MR 2023/Unsupervised/hierarchical/hi.csv") %>% 
     janitor::clean_names() %>%
     select(x_2,y) %>%
     rename(x = x_2)

# membuat grafik
plt = 
  df %>%
  ggplot(aes(x,y)) +
  geom_point() +
  coord_equal()
plt
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-17-1.png" width="672" style="display: block; margin: auto;" />

``` r
# Finding distance matrix
distance_mat = dist(df, method = 'euclidean')
```

Pada kasus ini, terlihat ada dua buah *cluster*. Saya pun langsung hanya
akan menggunakan metode *single link* pada perhitungannya.

### *Single Link*

``` r
# Fitting Hierarchical clustering Model
set.seed(240)  # Setting seed
Hierar_cl = hclust(distance_mat, method = "single")

plot(Hierar_cl)

# Pemecahan menjadi 2 cluster
fit = cutree(Hierar_cl, k = 2)
table(fit)
```

    ## fit
    ##    1    2 
    ## 2223 6717

``` r
plot(Hierar_cl)
rect.hclust(Hierar_cl, k = 2, border = "red")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-18-1.png" width="672" style="display: block; margin: auto;" />

``` r
# save hasil cluster ke data awal
data_hc = df
data_hc$cluster = fit

# berapa banyak isi dari cluster
hie_plot = 
  data_hc %>%
  ggplot(aes(x,y,color = as.factor(cluster))) +
  geom_point() +
  coord_equal()
hie_plot
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-18-2.png" width="672" style="display: block; margin: auto;" />

------------------------------------------------------------------------

# *DBScan*

Metode *clustering* yang terakhir ini merupakan metode perhitungan
*density based*. Sangat berguna untuk data yang memiliki *noise*.
Misalkan saya memiliki contoh sebagai berikut:

## Contoh I

``` r
rm(list=ls())

# ambil data
df = read.csv("~/Live-Session-Nutrifood-R/LEFO Market Research/LEFO MR 2023/Unsupervised/dbscan/donat density.csv") %>%
     janitor::clean_names() %>% 
     select(-x) %>% rename(x = x_2)

df |>
  ggplot(aes(x,y)) +
  geom_point() +
  coord_equal()
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-19-1.png" width="672" style="display: block; margin: auto;" />

Bagaimana agar kita bisa mendapatkan *cluster* yang terbaik? 

Langkah pertama adalah mendefinisikan terlebih dahulu `k` _Nearest Neighbor_ untuk membantu kita menentukan standar _density_ suatu _cluster_. Berikutnya adalah menentukan `h` yang teroptimal saat grafik `NN distance`-nya meningkat tinggi.

Sebaga contoh, saya akan ambil nilai `30` sebagai patokan _nearest neighbor_. 

``` r
dbscan::kNNdistplot(df, k = 30)
abline(h = .25, lty = 2, col = "red")
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-20-1.png" width="672" style="display: block; margin: auto;" />

Kita akan pilih `h = .25`.

``` r
# membuat clustering DBScan
# set sed agar reproducible
set.seed(20921004)
Dbscan_cl = dbscan(df, eps = 0.25, minPts = 5)

# menambahkan cluster ke dalam dataset
df$cluster_new = Dbscan_cl$cluster

df |>
  ggplot(aes(x,y)) +
  geom_point(aes(color = as.factor(cluster_new)),
             size = 2) +
  coord_equal()
```

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/clustering/Readme_files/figure-gfm/unnamed-chunk-21-1.png" width="672" style="display: block; margin: auto;" />
