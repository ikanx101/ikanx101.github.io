---
title: "Forward RStudio Server Menggunakan Reverse SSH di Linux"
date: 2023-03-21T11:17:00-04:00
categories:
  - Blog
tags:
  - ssh
  - Linux
  - Ubuntu
  - R Studio
  - Server
  - Machine Learning
  - Deep Learning
---

Beberapa bulan yang lalu, saya sempat menuliskan bagaimana cara agar
**RStudio Server** (kini bernama **Posit Server**) yang kita miliki di
*local* bisa diakses dari jaringan internet melalui metode **IP**
*forwarding* menggunakan dua layanan:

- [ngrok](https://ikanx101.com/blog/ngrok-io/).
  - Plus: gratis.
  - Negatif: *link* yang digunakan berubah-ubah (jika menggunakan akun
    gratis).
- [pagekite](https://ikanx101.com/blog/page-kite/).
  - Plus: *link* bisa *customize* sesuai dengan kebutuhan.
  - Negatif: *free trial* dengan *bandwith* sebesar 2.5 Gb.

Salah satu yang saya *notice* adalah keduanya memiliki limitasi di
*bandwith*. Kadang *lag* yang ditimbulkan cukup mengganggu bagi saya.

------------------------------------------------------------------------

## Alternatif Lain

Salah satu alternatif lain yang bisa dicoba adalah dengan menggunakan
teknik *reverse ssh*. Syarat yang harus dipenuhi untuk menggunakan
metode ini adalah **kita harus memiliki VPS dengan IP publik**. VPS
tersebut tidak harus memiliki spek yang dewa. Cukup spek sederhana saja
kita bisa menggunakannya.

> Cara kerjanya simpel, yakni dengan membuat VPS mengakses **RStudio
> Server** di *local* dengan `ssh` secara kontinu.

Kali ini saya akan tunjukan caranya dengan memanfaatkan VPS dari situs
[*Digital Ocean*](https://cloud.digitalocean.com/). *Yuk* disimak.

------------------------------------------------------------------------

### Langkah I

Buat VPS (atau disebut dengan *droplet*) di situs [*Digital
Ocean*](https://cloud.digitalocean.com/).

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/reverse%20tunnel/langkah%201.png" width="80%" style="display: block; margin: auto;" />

Saya akan sewa VPS dengan spek paling kecil dan harga paling murah
(sekitar 4 USD per bulan).

Setelah selesai, kita akan memiliki satu alamat IP publik sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/reverse%20tunnel/langkah%201b.png" width="40%" style="display: block; margin: auto;" />

### Langkah II

Kita buka VPS tersebut melalui `ssh` di **terminal**.

    ssh root@143.198.200.181

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/reverse%20tunnel/langkah%202.png" width="50%" style="display: block; margin: auto;" />

Lalu kita *edit* file berikut ini `sshd_config`. Kita bisa akses di:

    sudo nano /etc/ssh/sshd_config

Ganti *setting* ke sebagai berikut:

    AllowTcpForwarding yes
    GatewayPorts yes

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/reverse%20tunnel/langkah%202b.png" width="50%" style="display: block; margin: auto;" />

Kita *restart* `ssh` nya dengan perintah:

    sudo su
    /etc/init.d/ssh restart

### Langkah III

Langkah terakhir adalah melakukan *reverse* `ssh` dari *port* `8888`
*local* saya (*RStudio Server* saya berjalan di `localhost:8888`) ke
port `8888` di VPS dengan perintah sebagai berikut:

    ssh -NR 8888:localhost:8888 root@143.198.200.181

Jika sudah selesai, kita bisa akses `143.198.200.181:8888` di *browser*
dengan menggunakan *gadget* apapun.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/reverse%20tunnel/langkah%203.png" width="60%" style="display: block; margin: auto;" />

------------------------------------------------------------------------

Bagaimana? Mudah *kan*?
