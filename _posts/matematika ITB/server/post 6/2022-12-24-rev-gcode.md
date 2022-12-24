---
date: 2022-12-24T21:01:00-04:00
title: "Hasil Review Penggunaan Github Codespaces"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Server
  - Linux
  - Codespaces
  - Virtual Machine
  - Github
  - Cloud Computing
---

Pada beberapa kesempatan yang lalu, saya sempat menuliskan bagaimana mengaktifkan dan mengunakan layanan ___Github Codespaces___ untuk cloud computing dengan __R__ di _link_ [berikut ini](https://ikanx101.com/blog/git-codespaces/).

Setelah mencobanya selama 2 bulan, saya cukup puas dengan performa dan kepraktisan yang ditawarkan. Tentu saja __R GUI__ yang digunakan bukanlah __Posit__ (atau __R Studio__) melainkan __VS Code__. Namun ada satu ganjalan yang saya temukan, yakni:

> _Codespaces storage_ yang selalu _overquota_ sebelum bulan berakhir. Padahal _repository_ yang saya gunakan berukuran tak lebih dari 1 GB. Sebagai catatan: kita diberikan kuota sebesar 15 GB per bulan.

Setelah _googling_ sana sini, ternyata hal ini juga dikeluhkan oleh banyak _users_ di luar sana. _Github_ juga belum merinci cara perhitungan pemakaian kuota tersebut.

Setelah saya telusur sendiri dari _activity log_ (ternyata masing-masing _user_ bisa mendapatkan _history_ pemakaian _storage_ dan _runtime_), saya menemukan satu temuan baru.

_Github_ menghitung pemakaian _storage_ secara akumulasi harian selama satu bulan. Jadi, untuk kasus saya yang _repo_-nya berukuran 0.9 GB perhitungannya sebagai berikut:

- Hari 1: pemakaian 0.9 GB
- Hari 2: pemakaian 0.9 GB $\times 2$
- Hari 3: pemakaian 0.9 GB $\times 3$ dan seterusnya hingga
- Hari 16: pemakaian 0.9 GB $\times 16$

Tepat di hari ke 16, kuota saya sudah habis.

Dari sini saya ingin _share_ tips dengan cara selalu mematikan dan menghapus _codespaces_ setiap kali kita selesai memakainya. Konsekuensinya adalah kia harus _setting_ ulang __R__ saat kembali menghidupkan _codespaces_.

Saran lain, kita bisa menggunakan _server_ untuk "menumpang" komputasi. Saya sudah sering menuliskan [tentang hal ini](https://ikanx101.com/tags/#server).