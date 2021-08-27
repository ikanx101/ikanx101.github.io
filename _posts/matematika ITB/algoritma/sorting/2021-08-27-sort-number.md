---
date: 2021-08-27T11:55:00-04:00
title: "Belajar Membuat Algoritma: Sorting Number atau Mengurutkan Bilangan"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Algoritma
---


Pagi ini giliran saya belajar matakuliah **Algoritma dan Rancangan
Perangkat Lunak**. Tujuan utama dari kuliah ini adalah membuat para
mahasiswanya memiliki *mathematical thinking* dan bisa menuangkan logika
serta langkah-langkah komputasinya dalam suatu algoritma.

Pada awalnya saya berpikir:

> ***It’s okay, I got this…!***

Ternyata tidak semudah itu *Ferguso*…

Saya (atau kita semua) mungkin sadar bahwa selama ini kita sudah
terbiasa menggunakan *basic function* yang tersedia di suatu bahasa
pemrograman. Tapi apa pernah kita mencoba untuk membuat *basic function*
itu sendiri?

> Jangan-jangan kita belum bisa menuliskan algoritma dari *basic
> function* tersebut?

------------------------------------------------------------------------

## SOAL

> Buatlah algoritma (atau *function*) yang bertugas untuk mengurutkan
> barisan bilangan: 5, 8, 6, 1, 3, 1, 2,  − 5, 2, 2,  − 4 !

Masalah tersebut bisa diselesaikan dengan mudah menggunakan fungsi
*base* di **R**, yakni `sort()`. *Nah*, pertanyaannya adalah apakah kita
bisa membuat fungsi `sort()` sendiri? Bagaimana algoritma dibalik fungsi
tersebut?

> Apakah memungkinkan kita membuat fungsi yang berdasarkan hanya pada
> *conditional*, *looping*, dan *sequence*?

Dalam algoritma setidaknya ada **tiga** jenis *control structure*.

<div class="figure" style="text-align: center">

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/algoritma/sorting/post_files/figure-gfm/unnamed-chunk-1-1.png" alt="Control Structure" width="672" />
<p class="caption">
Control Structure
</p>

</div>

------------------------------------------------------------------------

## Solusi Awal

Saya menawarkan solusi algoritma sebagai berikut:

-   **Step 1**: *INPUT* *vector* berupa numerik yang tidak berurut,
    misal dinotasikan sebagai *a* dengan *n* buah elemen.
-   **Step 2**: Akan saya buat *vector* *b* dengan panjang *n* elemen.
-   **Step 3**: *b*<sub>1</sub> akan saya isi dengan angka terendah dari
    *a*. Setelah dipindahkan, *a* kini memiliki elemen sebanyak *n* − 1.
-   **Step 4**: Ulang **step 3** hingga semua elemen *a* dipindahkan ke
    *b*.

Salah satu *tricky parts* dalam algoritma di atas adalah jika ada elemen
vector terkecil yang *multiple*. Dari soal yang ada:
5, 8, 6, 1, 3, 1, 2,  − 5, 2, 2,  − 4, terlihat ada beberapa elemen yang
berulang.

Jadi saat melakukan **step 3**, saya harus memindahkan semua elemen yang
berulang tersebut. Begini kira-kira fungsi di **R**-nya:

``` r
urut_donk = function(input){
  # set initial condition
  a = input
  n = length(input)
  
  # siapkan vector kosong
  b = c()
  
  # repetition dengan syarat a masih ada
    # dilihat dari panjang n yang masih > 0
  while(n > 0){
    # mengambil elemen terkecil dari a
    min = min(input)
    n_min = length(which(input == min))
    # memindahkan elemen tersebut ke dalam b
    b = c(b,
          rep(min,n_min)
          )
    # menghapus elemen a yang sudah dipindahkan
    input = input[!input %in% b]
    n = length(input)
  }
  
  output = list(`Data asli` = a,
                `Hasil terurut` = b)
  return(output)
}
```

Sekarang kita lihat hasilnya dan berapa lama komputasi yang diperlukan
dengan `library(tictoc)`.

``` r
# soal
soal = c(5,8,6,1,3,1,2,-5,2,2,-4)

library(tictoc)
tic("Runtime process fungsi I: ")
urut_donk(soal)
```

    ## $`Data asli`
    ##  [1]  5  8  6  1  3  1  2 -5  2  2 -4
    ## 
    ## $`Hasil terurut`
    ##  [1] -5 -4  1  1  2  2  2  3  5  6  8

``` r
toc()
```

    ## Runtime process fungsi I: : 0.064 sec elapsed

Tapi jika saya perhatikan lebih baik, terlalu banyak *basic function*
yang saya gunakan. Saya menggunakan `min()` dan `rep()`.

> Bisakah saya membuat *function* lainnya yang lebih sedikit menggunakan
> *basic function* yang ada?

------------------------------------------------------------------------

## Solusi Lainnya

Saya akan buat algoritma yang mungkin lebih simpel cara kerjanya, yakni
dengan melakukan perbandingan secara repetitif.

-   **Step 1**: *INPUT* *vector* berupa numerik yang tidak berurut,
    misal dinotasikan sebagai *a* dengan *n* buah elemen.
-   **Step 2**: Bandingkan *a*<sub>1</sub> dengan elemen di sebelahnya,
    misal *a*<sub>2</sub>. Jika *a*<sub>1</sub> &gt; *a*<sub>2</sub>
    maka tukar posisi.
-   **Step 3**: Lanjutkan perbandingan *a*<sub>1</sub> dengan elemen
    selanjutnya hingga elemen ke-*n* dengan syarat tukar posisi pada
    **step 2**.
-   **Step 4**: Lanjutkan perbandingan untuk elemen kedua dan seterusnya
    hingga *a*<sub>*n*</sub>.

Begini kira-kira *function*-nya:

``` r
urut_lagi_donk = function(a){
  # set initial condition
  input = a
  n = length(a)

  # looping
  for(i in 1:(n-1)){
    for(j in (i+1):n){
      temp1 = a[i] # temporary
      temp2 = a[j]  # temporary
      if(temp1 > temp2){
        # proses penukaran
        a[i] = temp2
        a[j] = temp1
        }
      }
    }
  # menulis hasilnya
  hasil = list(
    `Data asli` = input,
    `Hasil terurut` = a
  )
  # print output
  return(hasil)
}
```

*Function* baru di atas hanya menggunakan **satu** *basic function*
saja, yakni `length()`. Sekarang kita lihat hasilnya dan berapa lama
komputasi yang diperlukan.

``` r
# soal
soal = c(5,8,6,1,3,1,2,-5,2,2,-4)

tic("Runtime process fungsi II: ")
urut_lagi_donk(soal)
```

    ## $`Data asli`
    ##  [1]  5  8  6  1  3  1  2 -5  2  2 -4
    ## 
    ## $`Hasil terurut`
    ##  [1] -5 -4  1  1  2  2  2  3  5  6  8

``` r
toc()
```

    ## Runtime process fungsi II: : 0.014 sec elapsed

------------------------------------------------------------------------

### *Summary*

Ada banyak cara melakukan suatu komputasi. Kita bisa memilih mana yang
lebih baik, cepat, dan nyaman di penulisan skripnya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
