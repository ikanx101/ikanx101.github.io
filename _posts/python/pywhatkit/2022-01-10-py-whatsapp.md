---
date: 2022-01-10T13:47:00-04:00
title: "Mengirim Pesan WhatsApp Secara Otomatis dengan Python"
categories:
  - Blog
tags:
  - Cloud Computing
  - R
  - Machine Learning
  - Artificial Intelligence
---

Kali ini saya *posting* sesuatu yang berbeda. Mulai hari ini, saya akan
coba *posting* juga beberapa hal terkait `Python` selain **R**. Tentunya
saya hanya akan angkat beberapa *libraries* `Python` yang tidak
berkaitan dengan *data science*, statistika, dan matematika.

------------------------------------------------------------------------

Pada saat bersantai melihat beberapa akun *Instagram* yang membahas
tentang *Python Codes*, ada satu *posting* menarik tentang bagaimana ada
satu *library* di `Python` yang bisa digunakan untuk **mengirimkan pesan
WhatsApp** secara otomatis.

Nama *library*-nya adalah `pywhatkit`.

Cara kerja `pywhatkit` cukup simpel, yakni:

1.  `pywhatkit` akan membuka *browser* di komputer / laptop kita.
2.  *Browser* tersebut akan membuka situs [*WhatsApp
    Web*](https://web.whatsapp.com/).
3.  Kemudian akan dikirim pesan ke nomor atau grup yang ada di
    *WhatsApp* tersebut.

> *Cukup simpel kan?*

Proses *coding*-nya juga simpel, hanya dua baris sebagai berikut untuk
mengirimkan pesan ke nomor tertentu:

    import pywhatkit
    pywhatkit.sendwhatmsg("+6281xxxxx", "Uji coba apakah ini bisa digunakan", 12, 22)

Perintah di atas berfungsi untuk:

-   Mengirim pesan *WhatsApp* ke nomor `6281xxxxx`.
-   Pesan yang dikirim adalah: `Uji coba apakah ini bisa digunakan`.
-   Pesan akan dikirimkan pada jam `12` menit ke `22`.

------------------------------------------------------------------------

## Prasyarat

Agar semua *code* ini berjalan dengan lancar, dibutuhkan komputer atau
laptop dengan *browser* yang bisa membuka (dan sudah *login*) situs
[*WhatsApp Web*](https://web.whatsapp.com/).

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
