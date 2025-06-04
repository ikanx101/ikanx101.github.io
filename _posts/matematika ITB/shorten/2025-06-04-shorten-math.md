---
date: 2025-06-04T10:20:00-04:00
title: "Bagaimana Matematika Bisa Membantu Memperpendek URL Suatu Situs"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Matematika
  - URL Shortener
  - Numerik
  - String
  - Algoritma
---

Saya kira rekan-rekan semua sudah familiar dengan
[bit.ly](https://bitly.com/) atau [tinyurl](https://tinyurl.com/). Suatu
situs yang berfungsi untuk memperpendek URL yang panjang sehingga mudah
untuk dibagikan di berbagai media. Selain itu, layanan URL *shortener*
menyediakan fitur pelacakan untuk membantu pemilik URL mendapatkan
informasi seperti:

- Berapa banyak klik?  
- Dari mana sumber *traffic*?  
- Perangkat yang digunakan?

Saya dulu penasaran bagaimana cara situs-situs ini memperpendek URL yang
panjang tersebut. Beberapa situs menggunakan sistem *database*
sederhana. Jadi saat *user* memasukkan URL, situs penyedia tinggal
memasangkan alamat URL yang pendek untuk di-*re-route* ke URL aslinya.

Namun, ada juga konsep matematika yang bisa digunakan untuk memperpendek
sekumpulan bilangan atau karakter (*string*). Dulu sih waktu kuliah S1,
ada mata kuliah kriptografi tapi saya tidak ikut. Entah apakah apa yang
hendak saya jelaskan berikut ini termasuk ke dalamnya atau bukan. Jadi
begini konsepnya:

------------------------------------------------------------------------

URL *shortener* menggunakan **algoritma hashing** atau **basis bilangan
tinggi** untuk mengubah URL panjang menjadi pendek. Algoritma yang
hendak dibangun menggunakan sistem basis-62 (alfanumerik). Maksudnya
karakter penyingkat yang digunakan berisikan: `A-Z, a-z, 0-9` (totalnya
ada **62 karakter**).

Sebelum masuk ke URL yang kompleks, saya akan coba jelaskan menggunakan
contoh sederhana terlebih dahulu.

## Contoh I: Menyingkat Numerik

Misalkan kita punya sekumpulan angka numerik, yakni `1010407420921004`
(kelak angka numerik ini akan saya tulis sebagai **id**). Algoritma
penyingkatannya adalah sebagai berikut:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/shorten/mermaid.png)

    1. Input: 
       - id (integer positif)
       - chars (string berisi karakter 0-9, A-Z, a-z)

    2. Inisialisasi:
       - base      = panjang(chars)
       - short_url = string kosong

    3. Selama id > 0:
       - remainder = id % base  # Hitung sisa pembagian (modulus)
       - short_url = chars[remainder] + short_url  # Tambahkan karakter sesuai indeks
       - id        = id // base  # Pembagian bilangan bulat

    4. Output: short_url

Di sini ada dua jenis pembagian yang digunakan, yakni:

1.  Operator **modulus**, maksudnya operator ini akan mengembalikan
    **sisa dari pembagian dua angka**. Misalnya, `5 %% 2` akan
    mengembalikan 1, karena sisa dari 5 dibagi 2 adalah 1
2.  Operator **pembagian bilangan bulat**. Operator ini mengembalikan
    hasil pembagian tanpa memperhatikan sisa pembagiannya, dengan
    membuang bagian desimal dari hasil pembagian. Contohnya `5 %/% 2`
    akan menghasilkan nilai 2 (bagian bulat dari bilangan 2.5).

Ini akan saya berikan gambaran iterasi prosesnya:

``` r
id = 1010407420921004

chars = c(0:9, LETTERS, letters)
base  = length(chars)

short_url = c()
id_df     = c()
remain_df = c()

while (id > 0) {
  id_df = c(id_df,id)
  
  remainder = id %% base
  remain_df = c(remain_df,remainder)
  
  short_url = c(chars[remainder + 1],short_url) 
  id        = id %/% base
}
```

berikut adalah tabel iterasinya:

| iterasi | id               | remainder | url |
|--------:|:-----------------|----------:|:----|
|       1 | 1010407420921004 |        40 | 4   |
|       2 | 16296893885822   |        42 | c   |
|       3 | 262853127190     |        36 | u   |
|       4 | 4239566567       |        57 | m   |
|       5 | 68380105         |        57 | v   |
|       6 | 1102904          |        48 | v   |
|       7 | 17788            |        56 | a   |
|       8 | 286              |        38 | g   |
|       9 | 4                |         4 | e   |

Hasil dari semua iterasi tersebut bahwa `id = 1010407420921004` bisa
disingkat menjadi `4cumvvage`.

Dari skrip iterasi di atas, saya buat *function*-nya dalam bahasa **R**
berikut:

``` r
id_to_shorturl = function(id) {
  # Karakter yang digunakan (0-9, A-Z, a-z)
  chars = c(0:9, LETTERS, letters)
  base  = length(chars)  # 62
  
  short_url = ""
  
  # Konversi ID ke basis-62
  while (id > 0) {
    remainder = id %% base
    short_url = paste0(chars[remainder + 1], short_url) 
    id        = id %/% base
  }
  
  return(short_url)
}
```

Berikut ini adalah hasilnya:

``` r
id        = 1010407420921004
short_url = id_to_shorturl(id)
print(paste("Short URL:", short_url)) 
```

    [1] "Short URL: 4cumvvage"

> Pertanyaannya, apakah hasil singkatan ini bisa di-*reverse* kembali ke
> id numerik?

Tentu saja bisa *donk*. Tinggal kita balik saja *function*-nya:

``` r
shorturl_to_id <- function(short_url) {
  chars = c(0:9, LETTERS, letters)
  base  = length(chars)  # 62
  
  id = 0
  
  # Konversi setiap karakter ke nilai desimal
  for (i in 1:nchar(short_url)) {
    char  = substr(short_url, i, i)
    value = which(chars == char) - 1  # -1 karena indeks R dimulai dari 1
    id    = id * base + value
  }
  return(id)
}
```

Kita coba kembalikan hasil singkatan yang sudah ada tadi:

``` r
original_id = shorturl_to_id("4cumvvage")
print(paste("id hasil:", original_id))
```

    [1] "id hasil: 1010407420921004"

Untuk kasus sederhana berupa id numerik, prosesnya relatif mudah. Namun
bagaimana untuk id berupa gabungan numerik dan karakter?

Untuk itu, kita perlu mengubah karakter tersebut menjadi **nilai
numerik** terlebih dahulu (misal dengan *hashing*), lalu menerapkan
konversi basis-62. Namun perlu diperhatikan bahwa *hash* yang dihasilkan
harusnya *unique* sehingga `id` yang berbeda tidak menghasilkan *short*
URL yang sama.

Berikut adalah modifikasi skrip di **R** untuk mengubah id numerik dan
karakter menjadi id numerik kemudian menyingkat idnya:

``` r
library(digest)

# Fungsi baru dengan hash MD5
hash_to_shorturl = function(text) {
  # Hasilkan hash hex (contoh: "d077f..."), lalu ambil 6 digit pertama
  hash     = digest(text, algo = "md5", serialize = FALSE)
  hash_num = strtoi(substr(hash, 1, 6), 16L)  # Hex to integer
  return(id_to_shorturl(hash_num))
}

# Contoh
hash_to_shorturl("ikanx101com")
```

    [1] "HsEK"

``` r
hash_to_shorturl("HariIniCerahSekaliYaa")
```

    [1] "aAV8"

Apakah hasil *short* URL ini bisa di-*reverse*?

> **Ternyata TIDAK!**

Khusus untuk id numerik dan karakter kita tidak bisa membuat *function*
untuk melakukan *reverse* *shortener*. Lantas yang perlu dilakukan
adalah membuat *database* antara id asli dengan *short* URL.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
