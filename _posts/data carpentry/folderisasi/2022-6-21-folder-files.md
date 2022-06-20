---
date: 2022-6-21T5:30:00-04:00
title: "Beberapa Function R terkait Utak-atik File dan Folder"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Data Carpentry
---

Beberapa hari ini saya sedang mengerjakan *project* otomasi bareng
dengan salah satu divisi lain di kantor. Berbeda dengan *data science
projects* yang lain, kali ini saya diminta untuk melakukan beberapa
*data carpentry* sederhana (*filtering*), *rename files*, dan menyimpan
*files* tersebut ke berbagai *folder* yang ada.

> Hal ini mirip dengan *data science projects* saat awal-awal saya
> belajar **R**.

Tentunya saya menggunakan prinsip *tidy* (`%>%`) untuk melakukan *data
carpentry* ini. Saya sudah seringkali membahasnya di beberapa tulisan
blog saya sebelumnya.

Oleh karena itu, saya hendak membahas beberapa *functions* lain yang
saya gunakan dalam *project* ini. Saya merasa *function* ini akan sangat
berguna bagi rekan-rekan yang bekerjanya mengutak-atik *files* dan
*folder* sehari-hari.

------------------------------------------------------------------------

## Membuat *Folder*

**R** bisa digunakan untuk membuat suatu *folder*. Caranya juga mudah,
yakni:

    dir create("nama folder")

## Mengambil Nama Semua *Files* dalam Suatu *Folder*

Misalkan kita memiliki suatu *folder* tertentu (misal untuk kasus ini
kita simpan dalam *object* bernama `path`). Kita hendak menggunakan
**R** untuk mengambil nama semua *files* yang ada pada folder tersebut.
Maka kita bisa menggunakan *function*:

    list.files(path)

Jika hendak mengambil keseluruhan *path* dari *folder* dalam nama *file*
tersebut, kita tinggal tambahkan parameter:

    list.files(path,full.names = T)

Bagaimana jika kita hanya ingin mengambil *files* ber-*extension*
tertentu dari *folder* tersebut? Misalkan kita hendak mengambil *file*
berformat `.pdf` saja. Maka:

    list.files(path,
               pattern = "*.pdf",
               full.names = T)

## Mengambil Nama Semua *Folder* dalam Suatu *Folder*

Adakalanya kita perlu untuk membaca nama-nama semua folder dalam satu
*folder* (atau dalam suatu *directory* atau *drive*). Bagaimana caranya?

Jika *main directory* tersebut kita simpan dalam *object* bernama
`path`, maka:

    list.dirs(path)

Sama dengan *function* sebelumnya, jika kita hendak mengambil
keseluruhan *path* dari *folder*, kita perlu menambahkan:

    list.dirs(path,
              full.names = T)

## Menghapus *Files* dari Suatu *Folder* Tertentu

Ternyata kita bisa *lho* menghapus *files* di suatu *folder* dengan
mudahnya di **R**. Misalkan kita sudah melakukan *set working directory*
di *folder* tertentu. Untuk menghapus *files* pada *directory* tersebut:

    unlink(nama_files)

Jika *single file*, cukup isikan nama satu *file* saja.

Misal:

    nama_file = "laporan.pdf"
    unlink(nama_file)

Sedangkan jika yang ingin dihapus adalah *multiple files*, maka berikut
caranya:

    nama_files = c("laporan 1.pdf",
                   "laporan 2.pdf",
                   "laporan 3.pdf")
    unlink(nama_files)

## Melakukan *Rename File*

Salah satu tujuan utama *project* otomasi yang saya lakukan ini adalah
melakukan proses *renaming files* yang banyak sekali. Untuk itu,
*function* di **R**-nya cukup mudah, yakni:

    file.rename("nama file lama", "nama file baru")

Tentunya kita bisa menggunakan *looping* atau *parallel* seperti
`sapply()` pada prosesnya.

## *Copying Files*

Kita juga bisa mengkopi beberapa *files* dari suatu *path* tertentu ke
*path* yang lain sebagai berikut:

    file.copy(from = "list files", to = "nama folder")

## *Compress Files* dengan *Zip*

**R** juga mampu untuk mengkompres beberapa *files* sekaligus menjadi
satu *file* berformat `.zip` atau `.tar`. Caranya cukup mudah yakni:

    zip(files = "list nama file", zipfile = "nama.zip")

## Menggabungkan Beberapa Dokumen `.pdf`

Terakhir, salah satu *function* pamungkas yang saya gunakan adalah
*function* untuk menggabungkan beberapa *files* `.pdf` menjadi satu
*file* saja. Kita perlu meng-*install* `library(qpdf)`.

    pdf_combine(input = "list files", output = "nama.zip")

------------------------------------------------------------------------

Kira-kira demikianlah beberapa *functions* yang bisa digunakan dalam
urusan *management files*. Semoga bermanfaat.
