---
date: 2020-1-22T4:20:00-04:00
title: "Menjawab Puzzle dengan Monte Carlo (1)"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Simulation
  - Monte Carlo
---

*Posting* ini melanjuti *posting* saya sebelumnya mengenai [simulasi
Monte Carlo](https://ikanx101.github.io/blog/wheel-fortune/). Ternyata
**faedah** dari simulasi ini banyak juga *yah*. Salah satunya adalah
untuk menyelesaikan *puzzle* statistik. *hehe*

Setidaknya untuk menyelesaikan _puzzles_ ini ada dua cara:

1. _Exact_, menggunakan teori dan perhitungan matematika dan statistik.
2. _Numeric_, menggunakan perhitungan dari beberapa fungsi aproksimasi.
3. _Simulation_, melakukan _generating random number_ yang sesuai dengan kondisi permasalahan.

Ada beberapa _puzzle_ yang berseliweran di dunia yang bisa diselesaikan dengan simulasi. Kali ini, saya punya *puzzle* berjudul *Same Ages Puzzle*.

Konon katanya:

> Dalam setiap kelompok `n` orang, pasti ada minimal sepasang orang yang
> memiliki tanggal lahir yang sama.

Tanggal di sini maksudnya hanya tanggal dan bulannya saja yang sama.
Sedangkan tahun kelahiran kita abaikan.

Sekarang pertanyaannya:

1.  Bisakah kita buktikan pernyataan tersebut?
2.  Apakah ada `n` tertentu di mana pernyataan tersebut tidak berlaku?
3.  Pada nilai `n` berapa pernyataan tersebut selalu benar?

Sekarang, coba rekan-rekan pikirkan cara untuk menjawab ketiga
pertanyaan di atas yah.

Saya coba bantu untuk kasih kunci jawabannya tapi *thinking process*-nya
coba dicari
yah.

![test](https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/puzzles/Puzzle%20Umur/2020-1-22-puzzle-umur_files/figure-gfm/unnamed-chunk-2-1.png)
