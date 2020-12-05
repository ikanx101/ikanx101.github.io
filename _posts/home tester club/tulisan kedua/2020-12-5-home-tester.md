---
date: 2020-12-5T11:40:00-04:00
title: "Text Analysis: Review Konsumen Pemanis Rendah Kalori"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Web Scrape
  - Home Tester
  - Market Research
  - Konsumen
  - Review Konsumen
  - Research
  - RVest
---


Melanjutkan [tulisan pertama](https://ikanx101.com/blog/review-htci/)
saya terkait *hometesterclub Indonesia*, kali ini saya akan coba membuat
analisa sederhana dari data *review* konsumen terhadap dua buah produk
pemanis rendah kalori yang ada di pasaran.

Apa saja?

1.  Tropicana Slim Stevia.
2.  Diabetasol Sweetener.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

Data *review* saya *scrape* pagi ini (`3 Desember 2020 9.46 WIB`).

-----

## Bagaimana cara *scrape*-nya?

Seperti biasa, saya menggunakan **R** untuk membuat algoritma *web
scraping* dengan memanfaatkan `library(rvest)`.

``` r
scrape_komen = function(url){
  read_html(url) %>% 
  html_nodes(".review-user_comment") %>% 
  html_text()
}
```

Cukup aplikasikan *function* di atas ke halaman *review* produk di situs
*hometesterclub Indonesia*.

Data yang saya dapatkan adalah sebagai berikut:

    ## [1] "10 data pertama hasil scrape"

    ##    id    produk
    ## 1   1 TS Stevia
    ## 2   2 TS Stevia
    ## 3   3 TS Stevia
    ## 4   4 TS Stevia
    ## 5   5 TS Stevia
    ## 6   6 TS Stevia
    ## 7   7 TS Stevia
    ## 8   8 TS Stevia
    ## 9   9 TS Stevia
    ## 10 10 TS Stevia
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            komen
    ## 1                                                                                                                                                                                                                                                                                                                                                                                                                                 bagus untuk di semua usia tropicana slim stevia pengganti gula
    ## 2                                                                                                                                                                      meskipun rasanya lebih manis daripada gula tebu namun tropicana slim stevia sweetener lebih rendah kalori bisa dijadikan sebagai alternatif pemanis untuk penderita diabetes dan bagi yang sedang diet. kasan sachet jadi lebih mudah dalam takarannya dan praktis dibawa. tapi efeknya jadi lebih banyak produksi samoah
    ## 3                                                                                                                                                                                                                                                                                                                                                                            dgnkalori yg rendah aman dikonsumsi setiap hari. menjaga gula darah dan g bikin gemuk.aqpun konsumsi setiap hari. .
    ## 4                                                                                                                                                                                                                                                                                                                                                                                      gula teraman untuk menjaga agar terhindar dari penyakit diabetes jd tetap bisa minum manis tanpa khawatir
    ## 5                                                                                                                                                                                                                                                                                                                                                                                                                                             gak buat aneh minuman yang kita minumharus dicobaa
    ## 6                                                                                                                                                                                                                                                                                                   saya mengkonsumsi stevia ini karna saya dalam proses pola hidup sehat saya mengganti gula biasa dengan stevia karna stevia tidak tinggi gula dan kandungan yang sehat terdapat pada stevia. 
    ## 7  jadi aku kalau hangout makan bareng temen temen di luar pasti nggak pernah lupa bawa tropicana slim stevia . produk tropicana slim mana sih yg mengecewakan ? nggak ada ! . kenapa stevia ? karena menurut aku  stevia itu rasanya lebih gurih  cocok buat minuman apalagi masakan . bikin makanan rasanya makin mantap . coba deh bandingin masak pakai gula biasa dan stevia pasti beda banget rasanya. aku kalau pesan minuman pasti no sugar karna gulanya aku bawa sendiri dari rumah . 
    ## 8                                                                                                                                                                                                                                                 di keluarga nenek sebagian besar punya penyakit diabet. aku coba tropicana slim stevia pengganti gula mumpung masih muda mulai dijaga dan diatur pola makan. sehat itu mahal. lebih baik mencegah daripda mengobati. stay safe and healthy ya 
    ## 9                                                                                                                                                                                                                                                                                                   semenjak pake gula ini sedikit tenang karna safe buat diabetes pake satu bungkus juga udah manis banget jadi cocok buat dipake ngeteh. berguna juga kalo mau diet tapi tetep mau yang manis2
    ## 10                                                                                                                                                                                                                                                                                                                                      hanya satu bungkus sudah sangat manis dan tidak takut diabetes. biasa saya hanya menggunakan setengah bungkus karena saya tidak terlalu suka rasa manis.

Kali ini saya akan membandingkan *review* *member* terhadap kedua produk
yang *head to head* di pasaran. Ada beberapa analisa yang hendak saya
lakukan untuk membandingkannya, yakni:

1.  *Wordcloud*,
2.  *Bigrams*,
3.  *Topic modelling*,
4.  *Crosswords*,
5.  *Log odds ratio*.

-----

## *Pre-Processing*

Hal standar yang harus dilakukan setiap kali melakukan *text analysis*
adalah dengan membersihkan data terlebih dahulu dari tanda baca dan
*stopwords*. Kali ini sengaja saya tidak melakukan *stemming* karena
saya masih belum mendapatkan algoritma terbaik untuk melakukan
*stemming* dalam Bahasa Indonesia.

*List stopwords* Bahasa Indonesia saya ambil dari
[sini](https://raw.githubusercontent.com/stopwords-iso/stopwords-id/master/stopwords-id.txt).

Hasilnya sebagai berikut:

    ## [1] "10 data pertama hasil pre processing"

    ## # A tibble: 10 x 3
    ##       id produk     komen                                                       
    ##    <int> <chr>      <chr>                                                       
    ##  1     1 Diabetasol diabetasol sweeter cocok banget alternatif gula penderita d…
    ##  2     1 Diabetasol enak tidak meninggalkan pahit diseduh panas                 
    ##  3     1 TS Stevia  bagus usia tropicana slim stevia pengganti gula             
    ##  4     2 Diabetasol menjaga mengobati diabetasol aman dikonsumsi penderita diab…
    ##  5     2 TS Stevia  manis gula tebu tropicana slim stevia sweetener rendah kalo…
    ##  6     2 TS Stevia  kasan sachet mudah takarannya praktis dibawa                
    ##  7     2 TS Stevia  efeknya produksi samoah                                     
    ##  8     3 Diabetasol sikecil manis gulanya tidak gula                            
    ##  9     3 Diabetasol papa pakai sachet gelas manis kalo pakai gula sendok makan …
    ## 10     3 Diabetasol recommend

-----

## *Wordcloud*

Saya mulai dari yang paling mudah dahulu, yakni *wordcloud*. Saya akan
hitung frekuensi dari kata-kata yang sering muncul di *review* *member*.

    ## [1] "Wordcloud Review Diabetasol"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

    ## [1] "Wordcloud Review TS Stevia"

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

Sekilas kedua wordclouds ini menghasilkan kata-kata yang mirip. Untuk
mengukur perbedaannya, saya akan gunakan *crosswords analysis*.

-----

## *Crosswords*

Prinsip dari analisa ini adalah melihat kesamaan frekuensi dari semua
kata yang muncul dari semua *reviews*.

Jika *reviews* yang diberikan kepada dua produk itu sama, maka akan ada
[korelasi](https://ikanx101.com/blog/materi-korelasi/) positif yang
kuat.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-7-1.png" width="672" />

Walaupun tidak sama persis, tapi ada tren kesamaan *reviews* dari kedua
produk tersebut. Dari hasil di atas, sekarang akan saya tentukan kata
mana saja yang lebih identik dengan Diabetasol atau Tropicana Slim
dengan menghitung [*log odds
ratio*](https://ikanx101.com/blog/artikel-HBR/#log-odds-ratio).

-----

## *Log Odds Ratio*

Frekuensi kata dari kedua *reviews* akan dihitung nilai `logratio`-nya
dengan rumus:

  
![logratio =
ln(\\frac{freq\_{kel1}}{freq\_{kel2}})](https://latex.codecogs.com/png.latex?logratio%20%3D%20ln%28%5Cfrac%7Bfreq_%7Bkel1%7D%7D%7Bfreq_%7Bkel2%7D%7D%29
"logratio = ln(\\frac{freq_{kel1}}{freq_{kel2}})")  
Mari kita lihat kata apa saja yang identik dengan masing-masing kelompok
*review*\!

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-8-1.png" width="672" />

Ada beberapa temuan yang menarik:

  - Kata-kata yang lebih sering dipakai di *review* Diabetasol:
      - `sweetener`
      - `diabetes`
      - `rumah`
      - `mama`
      - `manis`
      - `gula`
      - `kopi`
  - Kata-kata yang lebih sering dipakai di *review* Tropicana Slim:
      - `makanan`
      - `minuman`
      - `penyakit`
      - `diet`
      - `papa`
      - `pemanis`

Selesai bermain-main dengan kata-kata, sekarang saatnya kita melihat
dari segi konteks.

Karena tidak memungkinkan bagi saya membaca ratusan *reviews* di kedua
produk, maka saya akan mempercepatnya dengan hanya melihat pola
terbanyak yang terjadi.

-----

## *Bi-Grams*

*Bi gram* adalah pasangan kata yang muncul secara berurutan. Mari kita
lihat *bi gram* apa saja yang sering muncul pada *review* Diabetasol.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-9-1.png" width="672" />

Berikutnya adalah *bi gram* yang sering muncul pada *review* Tropicana
Slim Stevia:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/home%20tester%20club/tulisan%20kedua/tulisan-kedua_files/figure-gfm/unnamed-chunk-10-1.png" width="672" />

Secara garis besar ada kesamaan *review* antara kedua produk ini, yakni
sama-sama `pengganti gula darah bagi penderita diabetes` dan `suka minum
manis`. Namun satu *bi gram* yang hanya muncul di Diabetasol, yakni:
`hidup sehat`. Sementara ada satu *bi gram* yang hanya muncul di
Tropicana Slim Stevia, yakni: `cocok banget`.

-----

## *Topic Modelling*

Analisa lain terkait konteks yang akan saya lakukan adalah *topic
modelling* dari data *reviews* dua produk tersebut.

Untuk itu, saya akan buat `5` *topics* yang mungkin bisa muncul dari
masing-masing produk.

    ## [1] "5 Topics dari Reviews Diabetasol"

    ##         term                             
    ## Topic 1 "coba, gula, diabetasol"         
    ## Topic 2 "gula, diabetasol, produk"       
    ## Topic 3 "diabetes, penderita, diabetasol"
    ## Topic 4 "manis, semoga, pengen"          
    ## Topic 5 "nyobain, testernya, diabetasol"

    ## [1] "5 Topics dari Reviews Tropicana Slim Stevia"

    ##         term                     
    ## Topic 1 "stevia, diabetes, manis"
    ## Topic 2 "stevia, slim, tropicana"
    ## Topic 3 "gula, manisnya, suka"   
    ## Topic 4 "gula, diabetes, stevia" 
    ## Topic 5 "gula, tropicana, slim"

Dari hasil di atas, sepertinya masih susah untuk menarik kesimpulan
konsteks dari *reviews* produk tersebut.

-----

## *What’s Next?*

Selanjutnya saya akan buat *sentiment analysis*. Nantikan di tulisan
berikutnya ya.
