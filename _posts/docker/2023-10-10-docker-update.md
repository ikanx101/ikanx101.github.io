---
date: 2023-10-10T11:21:00-04:00
title: "UPDATE! Best Practice Menjalankan R Studio Server dengan Docker di Digital Ocean"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - R Studio
  - R Studio Server
  - VPS
  - Digital Ocean
  - SSH
  - Server
  - Docker
  - Tutorial
  - iPad
---


Oleh karena sesuatu hal, hari ini saya harus bekerja secara WFH tanpa
menggunakan laptop karena tertinggal di kantor. Bermodalkan *iPad 9th*,
saya harus bisa menyelesaikan beberapa pekerjaan *scripting* dan analisa
menggunakan **R Studio**.

Jika rekan-rekan pernah membaca [*blog* saya yang
ini](https://ikanx101.com/blog/docker-r/), hari ini saya berencana untuk
menggunakan **R Studio Server** yang sudah saya *Dockerized*.

Walaupun saya pernah menggunakan *dockerized* **R Studio Server** di
[**Google Cloud Run**](https://ikanx101.com/blog/docker-cloud-run/) tapi
saya lebih suka menggunakan **Digital Ocean**.

Bagaimana caranya?

------------------------------------------------------------------------

## Langkah I

Pada *dashboard* **Docker**, buat *droplet* dengan memilih `Docker`
sebagai aplikasi utama pada *tab* `Marketplace`.

Saya akan gunakan *password* sebagai proses otentifikasi.

## Langkah II

Pada iPad, saya akan *install* aplikasi bernama `Termius` sebagai alat
untuk melakukan `ssh` ke *droplet* yang telah saya buat.

Setelah berhasil ter-*install*, kita buka tab `ssh` dan melakukan
koneksi `ssh`.

    ssh root@nama.ip.address

Masukkan *password* yang telah kita buat sebelumnya.

## Langkah III

Kita lakukan *pull* dan *run* *Docker container* sebagai berikut:

    # melakukan pull request dari Docker server
    docker pull ikanx101/r-custom:latest

    # run container
    docker run --rm -p 8888:8787 -d \
               -e USER=ikanx101 \
               -e PASSWORD=ikanx101 \
               -e USERID=1001 \
               -e GROUPID=1001 \
               -v ~:/home/ikanx101 ikanx101/r-custom:latest 

*Script* di atas akan memastikan *Docker container* tersebut tetap
berjalan walau proses `ssh`-nya terhenti. Jadi aman dari masalah
konektivitas. Selain itu, *Docker* akan memiliki akses ke *home directory* saya.


## Langkah IV

Jika dibutuhkan untuk _web scraping_ menggunakan `RSelenium`, saya gunakan _Docker_ berikut:

    # docker pull dan run dari server
    docker run -d -p 4445:4444 selenium/standalone-firefox:4.8.0-20230123

    # skrip di R nya
    remote_driver = remoteDriver(remoteServerAddr = ip.address, 
                                 port             = 4445L, 
                                 browserName      = "firefox")


------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
