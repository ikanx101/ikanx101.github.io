---
title: "Convert File .xls ke .xlsx Menggunakan Perintah Shell di Linux"
date: 2023-10-04T09:17:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - Automation
  - Otomasi
  - Shell
  - Linux
  - Ubuntu
  - Converter
  - Excel
---


Bagi rekan-rekan yang sering mengunduh *files* *excel* dari situs BPS
atau portal pemerintah lainnya, biasanya *format file* yang akan kita
dapatkan berbentuk `.xls`. Salah satu masalah yang berpeluang muncul
adalah *file* tersebut tidak bisa terbaca oleh **R** atau **Python**
secara langsung.

Kenapa?

> Memang agak aneh, padahal sudah menggunakan `readxl` atau `openxlsx`.
> Saya menghindari *libraries* *Excel* yang bergantung pada *Java*.

Lantas bagaimana agar *file* tersebut bisa terbaca di **R**?

> Kita diharuskan membuka *file* tersebut (menggunakan *Ms. Excel* atau
> *Libreoffice* di Linux) lalu men-*save* ke dalam format `.xlsx`.

Setelah di-*convert*, baru kita bisa dengan aman mengimpor *file*
tersebut ke dalam **R**.

------------------------------------------------------------------------

Hal ini akan menjadi masalah besar jika *files* yang harus di-*convert*
banyak. Sebagai contoh, saya memiliki 35 *files* hasil unduhan dari BPS
dalam satu *folder* berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/convert%20xlsx/gbr1.png" width="75%" style="display: block; margin: auto;" />

> Lantas bagaimana cara saya untuk *convert* semua *files* ini dengan
> otomatis, cepat dan *reliable*?

*Alhamdulillah*, saya menggunakan Linux, sehingga saya bisa memanfaatkan
perintah *Shell* sederhana untuk melakukan ini. Caranya:

1.  Buka `TERMINAL`.
2.  Arahkan ke *directory folder* tempat *files* yang hendak
    di-*convert* dengan perintah `cd`.
3.  Ketik dan *run* perintah berikut:

<!-- -->

    for i  in *.xls; do  libreoffice --headless --convert-to xlsx "$i" ; done

Perintah tersebut menyuruh Linux *run* Libreoffice di *background
process* untuk membuat semua *files* bertipe `xls` dan *re-save as* ke
*files* bertipe `.xlsx` dengan tetap menggunakan nama *file* asalnya.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
