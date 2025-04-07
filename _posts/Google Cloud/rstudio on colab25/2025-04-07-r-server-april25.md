---
date: 2025-04-07T09:09:00-04:00
title: "Update 2025: Menginstall R Studio Server ke Google Colab"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Google Cloud
  - Google Colab
  - R Studio Server
  - R
---

Pada tahun 2021 lalu, saya sempat menuliskan bagaimana cara melakukan
[instalasi R Studio Server ke dalam Google
Colab](https://ikanx101.com/blog/r-server-colab/). Sekarang saya akan
berikan *update* skrip cara terbarunya karena ada beberapa *updates*
yang terjadi di *Google Cloud*. Berikut adalah skripnya dan silakan
*copy paste* ke dalam *Google Colab* dengan *Runtime* `Python`.

## Langkah I

Definisikan *username* dan *password* untuk R Studio Server:

    !sudo useradd -m -s /bin/bash rstudio
    !echo rstudio:password | chpasswd

## Langkah II

*Update* linux dan *install* **R** versi *command line interface*.

    # melakukan update Linux
    !apt-get update

    # install R base (cli version)
    !apt-get install r-base

## Langkah III

*Install* beberapa *libraries* linux.

    # install beberapa library Linux
    !apt-get install libglpk-dev # ini khusus untuk optimisasi
    !apt-get install gdebi-core

## Langkah IV

*Install* `libssl` versi yang lebih *outdated*.

    !sudo add-apt-repository ppa:nrbrtx/libssl1
    !sudo apt update
    !sudo apt install libssl1.1
    !apt install openssl

## Langkah V

*Download* dan *install* R Studio Server.

    !wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.12.1-563-amd64.deb
    !gdebi -n rstudio-server-2024.12.1-563-amd64.deb

## Langkah VI

*Install* `localtunnel` ke dalam Google Colab.

    !npm install -g npm
    !npm install -g localtunnel

## Langkah VII

Cari tahu *ip address* dan melakukan *forwarding* *port* 8787.

    !curl https://loca.lt/mytunnelpassword
    !lt bypass-tunnel-reminder --port 8787

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
