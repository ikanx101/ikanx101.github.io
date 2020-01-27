---
date: 2020-1-27T13:08:00-04:00
title: "Another Puzzle: Deadly Board Game"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
---

Sudah baca *puzzles* saya sebelumnya di
[sana](https://ikanx101.github.io/blog/puzzle-usia/) dan
[sini](https://ikanx101.github.io/blog/elevator-problem/)?

Dua *puzzles* tersebut adalah beberapa contoh aplikasi simulasi **Monte
Carlo** untuk menyelesaikan masalah *real*.

Sekarang, saya punya *puzzle* lagi. Begini ceritanya:

-----

> Suatu waktu, saya mengunjungi Kerajaan Wakanda. Singkat cerita, saya
> dituduh melakukan kejahatan. Saya diberikan kesempatan untuk lolos
> dari hukuman jika mau bermain dalam *deadly board game*.

Bagaimana cara bermainnya:

  - *Board* berisi kotak bernomor dari satu hingga tiga puluh secara
    berurutan.
      - Kota nol menjadi posisi awal saya.
  - Saya diberikan:
      - Tiga koin.
      - Satu dadu.
      - Satu bidak.
  - Saya harus memilih dan menaruh tiga koin di tiga kotak berbeda.
      - Setelah menaruh koin, saya tidak diperbolehkan untuk
        mengubahnya.
  - Lalu saya diharuskan melempar dadu.
      - Saya akan memindahkan bidak sesuai dengan angka yang keluar di
        dadu.
      - Proses ini terus berulang hingga selesai tiga puluh kotak
        dilalui oleh bidak saya.
  - Seandainya dalam seluruh proses ini, bidak saya **tidak pernah sama
    sekali berhenti di kotak yang memiliki koin**, maka saya akan
    dieksekusi.
      - Kebalikannya, jika dalam seluruh prosesnya bidak saya pernah
        minimal sekali berhenti di kotak yang memiliki koin, maka saya
        selamat.

-----

## Pertanyaannya:

> Di kotak nomor berapa saja saya harus menaruh koin?

-----

## Ada yang punya ide bagaimana cara menjawabnya?

> Kita akan mencari **tiga angka** yang memiliki peluang paling tinggi
> keluar dengan kondisi seperti di atas.

Bagaimana caranya? Dengan simulasi **Monte Carlo** kembali.

Berikut adalah contoh saat saya melempar dadu satu kali putaran:

    ##   lempar_dadu posisi_bidak
    ## 1           4            4
    ## 2           4            8
    ## 3           1            9
    ## 4           2           11
    ## 5           2           13
    ## 6           6           19
    ## 7           2           21
    ## 8           6           27
    ## 9           4           31

-----

Bagaimana jika saya melempar dadu lima kali putaran?

    ## [1] "Putaran ke: 1"
    ##   lempar_dadu posisi_bidak
    ## 1           1            1
    ## 2           6            7
    ## 3           2            9
    ## 4           5           14
    ## 5           4           18
    ## 6           1           19
    ## 7           6           25
    ## 8           5           30
    ## [1] "Putaran ke: 2"
    ##   lempar_dadu posisi_bidak
    ## 1           4            4
    ## 2           2            6
    ## 3           6           12
    ## 4           5           17
    ## 5           6           23
    ## 6           2           25
    ## 7           4           29
    ## 8           1           30
    ## [1] "Putaran ke: 3"
    ##    lempar_dadu posisi_bidak
    ## 1            5            5
    ## 2            2            7
    ## 3            1            8
    ## 4            2           10
    ## 5            2           12
    ## 6            1           13
    ## 7            1           14
    ## 8            3           17
    ## 9            6           23
    ## 10           4           27
    ## 11           1           28
    ## 12           2           30
    ## [1] "Putaran ke: 4"
    ##   lempar_dadu posisi_bidak
    ## 1           6            6
    ## 2           6           12
    ## 3           6           18
    ## 4           5           23
    ## 5           4           27
    ## 6           3           30
    ## 7           1           31
    ## 8           1           32
    ## [1] "Putaran ke: 5"
    ##   lempar_dadu posisi_bidak
    ## 1           4            4
    ## 2           6           10
    ## 3           1           11
    ## 4           6           17
    ## 5           3           20
    ## 6           3           23
    ## 7           4           27
    ## 8           1           28
    ## 9           3           31

-----

> Bagaimana jika saya melempar dadu jutaan kali putaran? Lalu setiap
> angka yang keluar akan saya hitung berapa peluang muncul angka
> tersebut dari jutaan kali putaran
itu.

![peluang](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Puzzle%20Deadly%20Blocks/2020-1-25-deadly-puzzle_files/figure-gfm/unnamed-chunk-3-1.png)

Sudah ada bayangan, mau taruh koin di kotak mana saja?
