---
date: 2020-1-24T15:49:00-04:00
title: "Another Math Puzzle: Elevator Problem"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
---

*Gengs*, apakah sudah menemukan cara untuk menyelesaikan [*puzzle* saya
sebelumnya](https://ikanx101.github.io/blog/puzzle-usia/)?

*Nah*, kali ini saya akan memberikan *puzzle* matematika selanjutnya.
Apa itu? Saya berikan judul **Elevator Problem**.

Begini ceritanya:

> Di suatu lift hotel berlantai 15, masuklah tiga orang ke dalam lift
> tersebut.

Pertanyaannya:

**Berapa peluang tiga lantai yang berurutan dipilih oleh para pengguna
lift?**

Misal:

  - Orang pertama memilih lantai 5
  - Orang kedua memilih lantai 7
  - Orang ketiga memilih lantai 6

Lantai yang dipilih: `5, 6, 7` disebut **berurutan**. Jadi mana dulu
yang dipilih tidak masalah asal ketiga lantai tersebut berurutan secara
angka.

_So_, permutasi tiga lantai lebih dipilih dibandingkan kombinasi tiga lantai.

-----

## Bagaimana menjawab *puzzle* ini?

*Instead of using paperwork* dan menghitung peluangnya, saya akan
menggunakan cara lain. Sama seperti cara saya menyelesaikan [*puzzle*
sebelumnya](https://ikanx101.github.io/blog/puzzle-usia/): simulasi
**Monte Carlo**.

Mungkin ada yang bertanya, apa sih simulasi **Monte Carlo**? Secara
simpel, simulasi ini menggunakan prinsip **rules of large random
number**.

Salah satu faedahnya adalah untuk mengecek keacakan dari satu
[pengundian hadiah](https://ikanx101.github.io/blog/wheel-fortune/).

### Bagaimana melakukan simulasinya?

1.  Percobaan pertama:

<!-- end list -->

  - Misal, saya akan *generate* 3 *random number* dari angka 1-15. Hal
    ini saya lakukan hanya beberapa kali. Misalkan 5 kali saja.
  - Setiap kejadian **sukses** akan saya catat. Misalkan, dari 5 kali
    *generating random number*, ada 1 kali yang memenuhi kondisi 3
    lantai berurut. Artinya, peluang munculnya adalah `1/5`.

<!-- end list -->

2.  Percobaan seterusnya:

<!-- end list -->

  - Saya akan mengulangi proses pertama tapi dengan sebanyak-banyaknya
    pengulangan. Misalkan, saya akan *generate* sebanyak 1 juta kali.
    Peluang terjadinya 3 lantai berurutan adalah berapa kali kondisi
    tersebut muncul dibagi 1 juta.

Diharapkan, semakin banyam pengulangan, hasilnya semakin konvergen ke
nilai eksak hasil *paperwork* manual.

Ilustrasi simulasi jika *generating random numbers* dilakukan satu
hingga seratus
kali:

![Percobaan Pertama](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Puzzle%20Lift/2020-1-23-elevator-problem_files/figure-gfm/unnamed-chunk-2-1.png)

Jika dihitung hingga seratus kali pengulangan, didapat peluang tiga
lantai dipilih sebesar:

    ## [1] 0.0178

Semakin banyak pengulangan, maka akan semakin akurat hasilnya.

Mari kita lakukan hingga seribu kali
pengulangan:

![Percobaan Kedua](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Puzzle%20Lift/2020-1-23-elevator-problem_files/figure-gfm/unnamed-chunk-4-1.png)

Peluangnya menjadi:

    ## [1] 0.0232

*So, any question*?
