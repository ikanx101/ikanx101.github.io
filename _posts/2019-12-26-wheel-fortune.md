---
date: 2019-12-26T09:08:00-04:00
title: "Menguji Keacakan dari Wheel of Fortune"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - FINDX
  - R
  - Gambling
---

# ITB, Bandung, 2005.

Pada saat perkuliahan **Statistika Matematika** di tingkat II, kami
dibagi menjadi beberapa kelompok kecil untuk mengerjakan tugas membuat
simulasi **Monte Carlo**.

Tugasnya selesai dengan baik tapi saya masih tidak mengerti apa faedah
dari simulasi tersebut.

-----

# Tel-U, Bandung, November 2019.

Saat mengikuti pelatihan *big data analytics* di Universitas Telkom,
salah satu dosen menjelaskan kembali mengenai simulasi *Monte Carlo*.
Kali ini saya paham apa faedah dari simulasi ini.

Simulasi ini juga bisa untuk menyelesaikan permasalahan mengenai peluang
mikroba yg sempat [saya tulis
dulu](https://passingthroughresearcher.wordpress.com/2019/08/09/mencari-peluang-kegagalan-dari-data-yang-tak-pernah-gagal/).

-----

# Rawabali, Jakarta, Desember 2019

Setelah saya menyelesaikan sesi **FINDX** kemarin, ada pengundian *door
prize* penonton. Dua orang penonton yang beruntung akan mendapatkan
hadiah berupa *tumbler* dan *powerbank*.

![alt
text](https://d1h3r4b5gluug.cloudfront.net/wp-content/uploads/2018/05/GAM18_WHEEL_OF_FORTUNE_stock_options-HR-03.jpg
"chart")

Pengundian dilakukan menggunakan *digital wheel of fortune*. Jadi semua
penonton yang datang di sesi tersebut akan mendaftarkan namanya secara
online. Dari sekian nama tersebut akan diacak untuk mendapatkan
pemenangnya.

Dua orang pertama yang muncul ternyata berasal dari divisi HR.

> Kebetulan yang *mencurigakan* ini. *heeee*

Ketika saya iseng bertanya kepada panitia dan MC saat itu mengenai
*randomness* dari pengundian itu. Ternyata *wheel of fortune* yang
digunakan adalah dari *online free tools*.

-----

## Bagaimana cara mengecek keacakan dari *games* tersebut?

Dengan memanfaatkan prinsip dari simulasi **Monte Carlo** kita bisa
melihat apakah *wheel of fortune* tersebut beneran *random* atau tidak.

Bagaimana caranya?

Oke, misalkan kita punya sebuah *wheel of fortune* berisi lima nama
orang yang akan diacak. Nama orang yang pertama kali muncul otomatis
menjadi pemenang *door prize*-nya.

``` r
data
```

    ##   id               nama
    ## 1  1     Eastin, Parker
    ## 2  2    Kasvin, Jordain
    ## 3  3       Smith, Shayn
    ## 4  4         Bond, Adam
    ## 5  5 Conville, Benjamin

Secara logika, kita bisa hitung bahwa peluang masing-masing nama orang
muncul adalah `1/5` atau `20%`. Nilai peluang tersebut akan saya sebut
*exact value* karena berasal dari perhitungan logika matematis.

*Nah*, prinsip simulasi *Monte Carlo* adalah dengan melakukan *random
number generating* dalam *number of trial* yang sangat banyak.

Untuk kasus *wheel of fortune* ini, kita bisa lakukan *trial* atau
pengundian beberapa kali (sebanyak-banyaknya). Hasil dari pengundian ini
kita rekap dan nanti kita hitung berapa kali masing-masing nama orang
keluar.

Jika proses *wheel of fortune* itu murni acak, maka diharapkan nanti
hasil *simulation value* akan sama dengan *exact value*.

> Masih belum ada gambaran?

Berikut gambarannya:

-----

## Simulasi jika pengundian dilakukan 10 kali.

Berikut adalah simulasi jika dari lima nama orang tersebut saya undi
sebanyak 10 kali.

``` r
n = 10
undi = data.frame(pengundian_ke = c(1:n),
                  pemenang = sample(nama,n,replace=T))
undi
```

    ##    pengundian_ke           pemenang
    ## 1              1 Conville, Benjamin
    ## 2              2    Kasvin, Jordain
    ## 3              3         Bond, Adam
    ## 4              4    Kasvin, Jordain
    ## 5              5         Bond, Adam
    ## 6              6       Smith, Shayn
    ## 7              7         Bond, Adam
    ## 8              8       Smith, Shayn
    ## 9              9 Conville, Benjamin
    ## 10            10     Eastin, Parker

``` r
undi %>% group_by(pemenang) %>% summarise(freq_menang = n(),
                                          peluang_menang = round(freq_menang/n*100,2))
```

    ## # A tibble: 5 x 3
    ##   pemenang           freq_menang peluang_menang
    ##   <fct>                    <int>          <dbl>
    ## 1 Bond, Adam                   3             30
    ## 2 Conville, Benjamin           2             20
    ## 3 Eastin, Parker               1             10
    ## 4 Kasvin, Jordain              2             20
    ## 5 Smith, Shayn                 2             20

Ternyata kita dapatkan, untuk trial = 10 kali, peluang masing-masing
nama orang menjadi pemenang masih tidak sama.

-----

## Simulasi jika pengundian dilakukan 1000 kali.

Berikut adalah simulasi jika dari lima nama orang tersebut saya undi
sebanyak 1000 kali.

    ## # A tibble: 5 x 3
    ##   pemenang           freq_menang peluang_menang
    ##   <fct>                    <int>          <dbl>
    ## 1 Bond, Adam                 212           21.2
    ## 2 Conville, Benjamin         180           18  
    ## 3 Eastin, Parker             200           20  
    ## 4 Kasvin, Jordain            205           20.5
    ## 5 Smith, Shayn               203           20.3

Ternyata kita dapatkan, untuk trial = 1000 kali, peluang masing-masing
nama orang menjadi pemenang sudah mulai sama (mendekati `20%`).

-----

## Simulasi jika pengundian dilakukan 10.100.000 kali.

Berikut adalah simulasi jika dari lima nama orang tersebut saya undi
sebanyak 10.100.000 kali.

    ##             pemenang freq_menang peluang_menang
    ## 1     Eastin, Parker     2022668          20.03
    ## 2    Kasvin, Jordain     2017691          19.98
    ## 3       Smith, Shayn     2018745          19.99
    ## 4         Bond, Adam     2021521          20.02
    ## 5 Conville, Benjamin     2019375          19.99

Ternyata kita dapatkan, untuk trial = 10.100.000 kali, peluang
masing-masing nama orang menjadi pemenang sudah semakin sama dan mirip.

-----

## Simulasi berikutnya.

Jika kita ulang terus simulasi ini hingga banyak sekali, maka peluang
masing-masing nama orang muncul menjadi pemenang akan konvergen ke
`20%`.

> Oleh karena itu kita bisa simpulkan bahwa *wheel of fortune* tersebut
> mengundi dengan acak.

-----

# Kembali ke Kasus Kita.

*Nah*, sekarang utk membuktikan bahwa *wheel of fortune* yang digunakan
pas sesi **FINDX** itu acak atau tidak, ada yang mau jadi *volunteer*
untuk melakukan simulasi ini?

-----

# _Remarks_

Nah, ada yang menarik sebenarnya. Di awal tulisan ini, saya memberi info bahwa dua nama yang keluar pertama kali ebrasal dari divisi HR. 

> _So_, sebenarnya ada informasi lain yang seharusnya kita perhatikan.

Divisi asal penonton sesi __FINDX__ harus juga diperhatikan. Maksudnya apa?

> Divisi yang paling banyak hadir akan memiliki peluang lebih besar.

Jadi, simulasi __Monte Carlo__ ini harus diulang berdasarkan informasi asal divisi pengunjung. Karena bisa jadi simulasi __Monte Carlo__ berdasarkan nama menjadi kurang relevan hasilnya.

__ATAU__

Jangan-jangan memang gak perlu dibuktikan keacakannya? _Toh_ dari informasi yang ada sebenarnya tidak kuat argumentasi untuk mencurigai kejadian tersebut tidak acak? _Bingung gak?_
