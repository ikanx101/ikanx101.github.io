---
date: 2021-03-31T20:41:00-04:00
title: "Mengatasi Error 403 dan 404 Saat Melakukan Web Scraping"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Web Scrap
  - rvest
  - error
---


*Data science* bukan hanya berkisah tentang *data carpentry*, *data
analysis*, dan *machine learning* tapi juga berkisah tentang *data
acquisition*.

Salah satu contoh nyata *data acquisition* yang sering dilakukan adalah
*web scraping*.

Saya telah menuliskan beberapa tulisan terkait [*web
scraping*](https://ikanx101.com/tags/#web-scrap). Namun saya belum
pernah menuliskan terkait **resiko** yang sering dihadapi saat melakukan
*web scraping*.

Apa itu?

> ***Kemungkinan terjadinya ERROR.***

Kita bisa menemukan banyak tipe kode *error* tapi yang paling sering
saya temukan adalah **error 403** dan **error 404**.

Sejatinya *errors* tersebut sudah sewajarnya terjadi saat *web link*
yang kita tuju memang tidak ditemukan.

Tapi ada kondisi di mana *web link*-nya *exist* tapi **R** menampilkan
pesan *error* tersebut. Biasanya saya sering mengalami hal ini saat saya
melakukan *loop web scraping* pada ratusan hingga ribuan *web links*.

Mengapa hal ini bisa terjadi?

> ***Saya pribadi tidak mengetahui pasti alasan pastinya. Namun saya
> menduga*** `robots.txt` ***dari web tersebut memutuskan koneksi
> sebagai bentuk perlindungan.*** *cmiiw yah*.

## Solusi

Salah satu solusi yang biasa dilakukan para *web scraper* di **R**
adalah dengan menuliskan tambahan *function* `tryCatch()` pada saat
membuat algoritma *scraper*-nya.

Hal ini menurut saya hanyalah solusi jangka pendek karena saya tidak
ingin *web* yang sebenarnya *exist* namun *error* saat dibaca menjadi
di-*skip*.

> ***Saya ingin memaksa R untuk mencoba terus web tersebut beberapa kali
> sampai akhirnya skip saat benar-benar tidak bisa di-scrape***.

### Bagaimana caranya?

Misalkan saya tuliskan suatu *object* bernama `links` sebagai *array*
berisi ratusan *links* yang akan saya *scrape*.

``` r
str(link)
```

    ##  chr [1:500] "https://detik.com/1" "https://detik.com/2" ...

Berikut adalah *function* untuk melakukan *web scraping* yang saya akan
gunakan:

``` r
scrape_donk = function(url){
  x = html_session(url)
  x1 = read_html(x) %>% html_nodes("a") %>% html_text()
  x2 = read_html(x) %>% html_nodes("b") %>% html_text()
  return(data.frame(x1,x2))
}
```

Kemudian saya akan membuat *object* bernama `hasil` dengan struktur data
berupa *list* sebagai rumah bagi hasil *scrape* dari *function*
`scrape_donk()`.

``` r
hasil = vector("list", length(link))
```

Sekarang saya akan menuliskan *looping* untuk melakukan *web
scraping*-nya. Langkah-langkah yang saya lakukan adalah:

1.  Menentukan batas berapa kali percobaan *scrape* per *link* jika
    terjadi *error*. Misalkan saya *set* di angka `5` kali.
2.  Membuat *loop* besar dari `link[1]` hingga *link* terakhir
    (`link[500]`).
3.  Menggunakan *function* `tryCatch()` untuk melihat apakah muncul
    *errors* atau tidak. Jika muncul *error*, maka akan dipaksa
    melakukan *scrape* ulang hingga batas scrape yang ditentukan dengan
    *function* `while()`.

Berikut adalah algoritmanya:

    # menentukan batas percobaan
    batas = 5

    for (i in 1:length(link)) {
      if (!(link[i] %in% names(hasil))) {
        cat(paste("Scraping", link[i], "..."))
        ok = FALSE
        counter = 0
        while (ok == FALSE & counter <= batas) {
          counter = counter + 1
          out = tryCatch({                  
            scrape_donk(link[i])
          },
          error = function(e) {
            Sys.sleep(2)
            e
          }
          )
          if ("error" %in% class(out)) {
            cat(".")
          } else {
            ok = TRUE
            cat(" Done.")
          }
        }
        cat("\n")
        hasil[[i]] = out
        names(hasil)[i] = link[i]
      }
    } 

Selamat mencoba.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads shown.`
