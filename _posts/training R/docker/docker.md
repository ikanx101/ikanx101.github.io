---
date: 2023-02-01T08:02:00-04:00
title: "TUTORIAL: Membuat Docker Container untuk R Studio versi Sendiri"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Training R
  - Docker
  - VPS
  - Server
  - Chromebook
  - Linux
---

Dalam beberapa bulan terakhir ini, saya diberi mandat untuk melakukan _project web scraping_ dari salah satu situs publik secara `masif`, `terstruktur`, dan `terencana`. Untuk melakukannya, saya diberikan 6 buah PC _Windows_.

- Sebanyak 5 PC memiliki spek yang sama.
- Sementara 1 PC lainnya memiliki spek dewa.

Algoritma _web scraping_ saya tulis dengan bahasa __R__ di laptop Ubuntu saya.

Untuk mendistribusikannya, saya _install_ __R Studio__ di semua PC tersebut dan menghubungkannya ke `Github` untuk _synchronize_ semua _computing needs_.

Namun masalah timbul saat beberapa PC tidak memiliki kompatibilitas yang sama terhadap `JAVA`. Walaupun saya sudah berusaha meng-_update_ versi `JAVA` di beberapa PC tersebut, tapi tetap saja __RSelenium__ tidak bisa membuka _Google Chrome_.

