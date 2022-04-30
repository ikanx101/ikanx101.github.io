---
title: "Review Samsung Chromebook 4 untuk Data Science"
date: 2022-04-30T07:14:00-04:00
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Samsung
  - Android
  - Chrome OS
  - Chromebook
  - Huawei
  - Linux
  - Ubuntu
---


Tahun lalu, saya sempat membeli sebuah laptop [lokal murah untuk
dijadikan alternatif *daily driver* untuk
bekerja](https://ikanx101.com/blog/laptop-chromium/). Setahun berselang,
laptop tersebut sudah saya coba oprek maksimal dengan mengganti OS-nya
ke [POP OS](https://ikanx101.com/blog/pop-os/). Sekarang, laptop
tersebut sudah berpindah tangan ke saudara yang sedang mengerjakan
skripsinya.

Berhubung sedang ada *project* besar di kantor dan kemungkinan adanya
*side projects* besar lain di kampus menanti dalam beberapa minggu ke
depan, saya butuh satu *compute engine* yang *portable* dan *reliable*.

Biasanya saya cukup mengandalkan laptop kantor dan [tablet
Huawei](https://ikanx101.com/blog/huawei-vs-vm/) tapi kali ini saya
butuh *compute engine* yang berada di tengah-tengah keduanya.

> Lebih tinggi daripada tablet Huawei tapi tidak se-dewa spek laptop
> kantor.

Oke, sebagai gambaran berikut *jobdesc* si laptop kantor dan tablet
Huawei:

## Laptop Kantor

Saya dipinjami laptop kantor yang mumpuni, yakni *Dell Latitude* dengan
prosesor 8 *cores* dan 16 GB RAM. Saya menggunakan **Ubuntu 20.04 LTS**
untuk melakukan *high performance computing* untuk *project* kantor.
Selain itu saya bekali juga dengan *Selenium Driver* dan **R Studio**
*Server*.

Untuk keperluan *deep learning*, saya masih lebih suka menggunakan
*Tensorflow* langsung dari [*Google Colab*](colab.to/r).

Salah satu kelemahan yang saya rasakan adalah pada dimensi dan berat
laptopnya. Selain itu durasi baterainya juga menjadi hambatan yang
penting.

## Tablet Huawei

Sementara tablet saya peruntukkan untuk menulis *notes*, *meeting
online*, mengerjakan tugas kuliah dengan **R** versi *command line
interface*.

Salah satu kelemahan yang yang saya rasakan adalah kemampuannya dalam
melakukan *data carpentry* yang rumit dan pembuatan model *machine
learning* atau *deep learning* yang terlalu bergantung pada *cloud*.

## *Gadget* Ketiga

*Gadget* berikutnya harus bisa menyelesaikan permasalahan yang ada dari
kedua *gadgets* sebelumnya. Harus memiliki kemampuan komputasi yang
mumpuni, *mobile* dan ringkas, serta harus memiliki daya tahan baterai
yang sangat baik.

Pilihan saya jatuh pada **Samsung Chromebook 4**. Saya sudah pernah
menggunakan *Chromium OS*, oleh karena itu saya rasa penggunaannya akan
sama. Namun setelah seminggu saya mencobanya, saya rasakan perbedaan
yang sangat besar antara *Chromium OS* dan *Chrome OS*. Apa saja
perbedaanya? Tentunya adalah ***full support dari layanan Google dan
Android***. Konektivitas ke *smartphone* Android sangat *smooth* sekali.

Selain itu versi Linux *Debian Buster* yang ada lebih *reliable*
daripada versi di *Chromium OS*.

Menggunakan metode yang sama pada [tulisan saya
sebelumnya](https://ikanx101.com/blog/laptop-chromium/), saya berhasil
meng-*install* **R** versi `4.2.0` dan **R Studio** versi `2022.02.01`.

Pada sisi *hardware*, terlihat sekali *build quality* dari Samsung.
Konon *chromebook* ini sudah *military grade*. Harganya juga relatif
murah, “hanya” 2.4 juta saja plus ongkir *Gojek Instant*.

Lantas bagaimana cara ketiga *gadgets* ini terhubung? Saya menggunakan
*github* sebagai basisnya dan aplikasi *AnyDesk* untuk bisa saling
*remote* dan *sharing files*.
