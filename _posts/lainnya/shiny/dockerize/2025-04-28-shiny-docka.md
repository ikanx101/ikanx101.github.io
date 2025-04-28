---
title: "Dockerize Quarto Shiny Apps"
date: 2025-04-28T14:47:00-04:00
categories:
  - Blog
tags:
  - Docker
  - Server
  - R Studio
  - Shiny
  - Railway
---

Salah satu *disadvantage* pengguna **R** yang sering dikonsultasikan
kepada saya adalah **kesulitan untuk mengubah model/algoritma ke versi
*production***. Hal tersebut yang justru menjadi *advantage* pengguna
*Python*. Sebenarnya kita bisa menyiasatinya dengan menggunakan
`plumber` yang mengubah model dalam **R** menjadi **API-based**.

Namun jika algoritma yang kita miliki bukan berupa model prediksi /
klasifikasi, maka akan sulit untuk menjadikannya **API-based**. Sebagai
contoh, algoritma optimisasi tentang [penjadwalan tatap muka
terbatas](https://ikanx101.com/blog/ptmt/). Akan susah bagi saya untuk
mengkonversikannya ke dalam `plumber` tapi akan lebih mudah bagi saya
membuatkan *Shiny Apps*.

Dalam pekerjaan kantor, saya seringkali membuat *Shiny Apps* untuk
keperluan *dashboard* dan *RPA* *converter*.

Masalahnya adalah *Shiny Apps* memerlukan *Shiny Server* untuk di-*run*
secara independen dari **R**. Sedangkan *Shiny Server* gratisan dari
situs [Shinyapps.io](https://www.shinyapps.io/) punya beberapa
keterbatasan.

Saya sendiri sudah hampir setahun menggunakan layanan *server* dari
situs [Railway.app](https://railway.com/). Alangkah baiknya jika saya
bisa **menaruh** *Shiny Apps* buatan saya di sana.

## *Dockerize* *Shiny Apps*

Salah satu solusi yang bisa dicoba adalah dengan membuat *docker*
*container* dari *Shiny Apps* yang ada. Setelah itu, saya tinggal
menempelnya di *server* manapun termasuk di
[Railway.app](https://railway.com/). Bagaimana caranya? Begini caranya:

### Langkah I

Siapkan *Shiny Apps* yang kita buat di `Quarto`. Perhatikan bahwa kita
bekerja di satu *working directory*. Pada kasus ini, saya membuat satu
*dashboard* visualisasi Quarto dari data `mtcars`. Artinya saya hanya
memiliki satu *file* berformat `.qmd` saja di *working directory* (tidak
ada *files* lainnya).

*Shiny Apps* ini saya beri nama `index.qmd`.

### Langkah II

Setelah itu, kita akan buat dua *files*, yakni:

1.  **Dockerfile** yang akan berisi skrip yang akan meng-*contain*
    *Shiny Apps* tersebut.
2.  **shiny-server.conf** yang akan berisi konfigurasi sederhana tentang
    bagaimana *working directory* dan *port* yang digunakan.

### Langkah III

Silakan buat satu file bernama **shiny-server.conf** dengan isi berikut
ini:

    run_as shiny;

    server {
      listen 3838;

      location / {
        site_dir /srv/shiny-server/dashboard;
        log_dir /var/log/shiny-server;
      }
    }

### Langkah IV

Silakan buat **Dockerfile** dengan isi berikut ini:

    # shiny server dari base rocker
    FROM rocker/shiny

    # update dan upgrade versi linux
    RUN apt-get update && apt-get install -y --no-install-recommends \
        pandoc \
        curl \
        gdebi-core \
        && rm -rf /var/lib/apt/lists/*

    # install quarto versi terbaru
    RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.42/quarto-1.6.42-linux-amd64.deb
    RUN gdebi --non-interactive quarto-1.6.42-linux-amd64.deb

    # install libraries yang diperlukan
    RUN R -e "install.packages(c('shiny', 'quarto'))"
    RUN Rscript -e "install.packages(c('dplyr','tidyr','ggplot2'));"

    # membuat working directory yang diperlukan
    RUN mkdir -p /srv/shiny-server/dashboard && \
        chown -R shiny:shiny /srv/shiny-server

    # kita copy server configuration ke dalam working directory
    COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

    # membuat working directory yang diperlukan
    RUN mkdir -p /var/log/shiny-server && \
        chown -R shiny:shiny /var/log/shiny-server

    # kita copy shiny apps ke dalam working directory
    COPY index.qmd /srv/shiny-server/dashboard/index.qmd

    # set working directory
    WORKDIR /srv/shiny-server/dashboard/

    # run quarto
    RUN quarto render index.qmd

    USER shiny
    CMD ["/usr/bin/shiny-server"]

### Langkah V

Jika semua persiapan sudah dilakukan, kita bisa membuat langsung
*container*-nya dengan perintah sebagai berikut:

    # build dan berikan nama dashiny
    docker build -t ikanx101/dashiny . 

Sebenarnya pada tahap ini, *container* sudah selesai kita buat. Jika
kita hendak menaruhnya ke *cloud* atau *docker hub*.

### Langkah VI

Kita bisa *run* containernya langsung dengan perintah ini:

    docker run -d --name sini ikanx101/r-shiny

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
