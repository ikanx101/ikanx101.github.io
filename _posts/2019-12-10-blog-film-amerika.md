Industri Film di Dunia (baca: Amerika Serikat)
================

Dulu sewaktu kuliah, saya sempat ditanya oleh salah seorang *mentor*
saya di Salman ITB:

> *Menurut kamu apa kekuatan dari Amerika?*

Dengan lugunya, saya menjawab *ekonomi*. Lalu dia berkata bahwa China
memiliki kekuatan ekonomi yang lebih kuat. Lantas saya menjawab
*militer*. Lalu dia malah bertanya balik: *Yakin kamu?*

Dia dengan mantap menjawab:

> *Kekuatan utama dari Amerika adalah budayanya…*

Saya lantas mengamini pernyataan *mentor* saya tersebut.

Kembali ke masa sekarang. Setelah berkontemplasi dengan tenang, saya
rasa benar juga perkataan *mentor* saya tersebut. Jika kita
mengerucutkan budaya itu hanya film saja, jelas sekali bahwa Amerika
mendominasi pasar film dunia.

Mengambil data dari
[the-numbers](https://www.the-numbers.com/movies/production-countries/#tab=territory),
yuk kita lihat gimana datanya.

# Data produksi dan pemasukan film per negara

Setelah saya *scrap* dari *web* tersebut, didapatkan data sebagai
berikut:

``` r
head(data,7)
```

    ##   production_countries no_of_movies avg_prod_budget sum_wordwide_boxoffice
    ## 1        United States       17,755     $37,055,013       $571,641,790,877
    ## 2       United Kingdom        2,968     $30,308,624        $49,669,489,643
    ## 3                China        1,611     $30,897,500        $29,400,806,889
    ## 4               France        2,602     $24,049,733        $19,206,077,196
    ## 5                Japan        1,095     $29,601,538        $12,363,955,208
    ## 6              Germany        1,096     $30,723,840         $9,337,129,128
    ## 7    Republic of Korea          842     $17,418,478         $7,674,067,862

``` r
str(data)
```

    ## 'data.frame':    171 obs. of  4 variables:
    ##  $ production_countries  : chr  "United States" "United Kingdom" "China" "France" ...
    ##  $ no_of_movies          : chr  "17,755" "2,968" "1,611" "2,602" ...
    ##  $ avg_prod_budget       : chr  "$37,055,013" "$30,308,624" "$30,897,500" "$24,049,733" ...
    ##  $ sum_wordwide_boxoffice: chr  "$571,641,790,877" "$49,669,489,643" "$29,400,806,889" "$19,206,077,196" ...

Saya mendapatkan 4 variabel, yakni:

1.  `production_countries`: negara produsen film
2.  `no_of_movies`: banyaknya film yang diproduksi
3.  `avg_prod_budget`: rata-rata budget produksi per film
4.  `sum_wordwide_boxoffice`: total pemasukan film (*worldwide*)

-----

## Negara produsen film terbanyak

Untuk mengkonfirmasi jawaban *mentor* saya tersebut, mari kita lihat
grafik berikut
ini:

![](2019-12-10-blog-film-amerika_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Wah, ternyata memang benar yah. Amerika sejak dulu hingga sekarang sudah
memproduksi banyak sekali film. Jauh mengungguli negara peringkat dua
dan tiga.

Jika kita bandingkan banyaknya film yang diproduksi oleh Amerika dengan
jumlah banyaknya film semua negara selain Amerika, maka didapat *pie
chart* sebagai
berikut:

![](2019-12-10-blog-film-amerika_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

> Lebih dari 40% film yang diproduksi di dunia ini berasal dari Amerika.

-----

## Negara dengan pendapatan dari film terbesar

Mari kita lihat grafik berikut
ini:

![](2019-12-10-blog-film-amerika_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Ternyata memang industri film menjadi salah satu *money maker*-nya
Amerika yah. Sangat jauh mengungguli negara peringkat dua dan tiga.

Jika kita bandingkan secara persentase total pendapatan film yang
diproduksi oleh Amerika dengan total pendapatan film semua negara selain
Amerika, maka didapat *pie chart* sebagai
berikut:

![](2019-12-10-blog-film-amerika_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

> Hampir 75% pendapatan film di seluruh dunia dimiliki oleh Amerika.

-----

## Negara dengan biaya produksi termahal

Walaupun menjadi negara yang paling “produktif” soal film, apakah biaya
produksi rata-rata film di sana masih relatif lebih “murah” dibandingkan
beberapa negara
lain?

![](2019-12-10-blog-film-amerika_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

*Notes*:

1.  Kali ini saya akan mengabaikan konsep *time value of money* dari
    tahun produksi.
2.  Saya juga mengabaikan faktor perbedaan nilai tukar masing-masing
    mata uang terhadap *dollar* sebagai *units* yang digunakan.
3.  Menerima rata-rata sebagai satu-satunya *metric* bahasan di artikel
    ini yah. Sebagaimana kita ketahui bersama, rata-rata bisa jadi
    menipu karena adanya [*extreme
    values*](https://passingthroughresearcher.wordpress.com/2019/01/01/market-research-101-analisa-punya-point-of-view-lhoo/).

# *Any comments?*
