---
date: 2022-07-05T07:37:00-04:00
title: "Menginstall R Studio Server ke Dalam Google Virtual Machines"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Server
  - Linux
  - Google
  - Virtual Machine
  - Google Cloud
  - Cloud Computing
---


Kali ini saya hendak melakukan sesuatu yang baru yakni mencoba
meng-*install* **R Studio Server** di *Google Virtual Machine* yang
sudah saya sewa sebelumnya. Salah satu *benefit* yang saya inginkan
adalah *memiliki server R Studio sendiri yang bisa diakses di manapun
dan kapanpun*. Selain itu, *server* ini bisa dijadikan *tools* untuk
*training data science*.

Ternyata langkah-langkahnya sangat mudah dan cepat. Setelah saya sadari
kembali, ternyata langkah-langkahnya merupakan rangkuman dari 4 tulisan
saya yang sebelumnya.

Bagaimana caranya? *Cekidot!*

------------------------------------------------------------------------

## Langkah I

Langkah pertama yang harus dilakukan adalah menyewa *Google Virtual
Machine* sesuai dengan kebutuhan dan melakukan instalasi **R** versi
terbaru.

Langkah-langkah detailnya bisa dicek di [tulisan berikut
ini](https://ikanx101.com/blog/vm-cloud/).

Pada langkah ini, ingat baik-baik nama *instances* dari VM yang kita
buat.

Proses ini memakan waktu 5-10 menit.

## Langkah II

Setelah berhasil meng-*install* **R** versi CLI, saatnya kita mengunduh
dan meng-*install* *R Studio Server*.

Langkah yang perlu dilakukan adalah gabungan dari [tulisan
ini](https://ikanx101.com/blog/rstudio-server/) dan [tulisan
itu](https://ikanx101.com/blog/r-server-colab/).

Ketikkan perintah berikut ini di *command line* SSH VM kita:

    # saya berikan penjelasan setiap baris codesnya ya
    # dua baris ini adalah untuk membuat user di Linux
    # secara default saya buat sebagai berikut:
      # user : rstudio
      # pass : password
    # feel free untuk mengganti ATAU menambahkan multi user
    # ingatlah bahwa compute engine ini milik Google
    # jadi siapa tahu bisa dirun paralel untuk multi user
    sudo useradd -m -s /bin/bash rstudio
    sudo echo rstudio:password | chpasswd

    # melakukan update Linux
    sudo apt-get update

    # install beberapa library Linux
    sudo apt-get install libglpk-dev # ini khusus untuk optimisasi
    sudo apt-get install gdebi-core # untuk instalasi menggunakan Gdebi

    # download installer R studio server dari situs resmi
    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb

    # proses instalasi R studio server
    sudo gdebi -n rstudio-server-1.4.1103-amd64.deb

Prosesnya memakan waktu 3-5 menit saja.

## Langkah III

Langkah terakhir yang perlu kita lakukan yakni *setting firewall* agar
*IP public* **port 8787** dari VM kita bisa diakses. Caranya kita bisa
gunakan *cloud shell*. Cara membuka *cloud shell* bisa dibaca di
[tulisan saya yang ini](https://ikanx101.com/blog/cloud-shell/).

Ketikkan perintah ini di *cloud shell*:

    # set firewall rules
    gcloud compute firewall-rules create allow-rstudio-server \
        --allow tcp:8787 \
        --target-tags rstudio-server
        
    # meng-apply firewall rules ke VM kita
    # masukkan nama instances dari langkah I
    gcloud compute instances add-tags [INSTANCE_NAME] --tags rstudio-server

------------------------------------------------------------------------

## SELAMAT!

Jika sudah selesai, artinya R Studio Server kita bisa langsung dipakai.
Caranya cukup membuka *IP public* **port 8787** di *browser* *gadget*
manapun. Misalkan:

`101.0.0.0:8787`

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads`
