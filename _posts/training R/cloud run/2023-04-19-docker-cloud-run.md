---
date: 2023-04-19T12:12:00-04:00
title: "Menjalankan Docker Container untuk R Studio di Google Cloud RUN"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Training R
  - Docker
  - VPS
  - Server
  - Google
  - Google Cloud
  - Linux
---

Dulu saat memulai petualangan di dunia data sains, saya *gak* peduli
dengan aspek *hardware* sama sekali. Kenapa? Karena tim IT kantor saya
tentunya akan memberikan saya komputer dengan spek sesuai kebutuhan.

Nah, sepanjang perjalanan, akhirnya saya mulai rewel dengan aspek
*hardware*. Apalagi saat Windows udh mulai tidak *friendly* dengan
kebutuhan kerja saya.

> Lho kok hardware tp yg disalahin Windows?

Ibarat kata, bekerja di data sains dengan `Windows` seperti bekerja
dengan satu tangan terikat (ini berdasarkan pglaman saya ya).

Jadi ini adalah contoh bahwa *hardware* itu trnyata bukan *root-cause*
nya, tapi justru OS adalah *root-cause* nya.

Maka dari itu, sejak pandemi saya hijrah pakai linux-based laptop, yakni
Ubuntu atau ChromeOS. Seketika performanya meningkat. Core CPU nya “bisa
naik dobel” dan kemampuan untuk *parallel processing* bisa digunakan
(ini setau saya baik `Py` atau `R` memang hanya bisa di Linux ya).
Catatan: *parallel* selain butuh OS yang *support* juga butuh paradigma
*ngoding* yang berbeda dg kebiasaan selama ini.

Lalu timbul tantangan baru di akhir tahun lalu. Saya punya
*mega-project* untuk melakukan *webscraping* terhadap banyak data
publik. Untuk menyelesaikannya tepat waktu, saya tidak mungkin hanya
mengandalkan satu laptop saja. Menurut perhitungan, dibutuhkan minimal 5
laptop/PC yang jalan bareng selama 24 jam.

Setelah dapat PC pinjaman, muncul masalah baru. Apa itu? Saya harus
ketemu dg Windows lagi. Masalahnya adalah beberapa PC tiba-tiba dengan
anehnya tidak “*support*” ini itu. Makin puyeng karena masalah ini tidak
ditemukan di mayoritas PC lainnya.

Lantas saya berpikir: \> “Bagaimana caranya agar R Studio yg ada di
laptop Ubuntu saya bisa di-copy-paste di PC2 Windows ini?”

Karena saya menganggap R Studio *setting*-an saya adalah yg “terbaik”.

Lalu berkenalanlah saya dengan suatu *software* bernama DOCKER.

Cara kerjanya sederhana, yakni dengan meng-*contain* R Studio di Ubuntu
saya sehingga bisa di-docking di PC lain (apapun OSnya). Alhamdulillah,
masalah saya bisa selesai dg baik. Buat yg mw tau proses
meng-contain-nya, bisa cek di [tulisan saya
ini](https://ikanx101.com/blog/docker-r/).

Lantas apa lagi kelebihan Docker ini?

Jadi, saat laptop saya sedang dipakai *webscraping*, tentu saya tidak
mau mengganggu proses pada laptop tersebut. Jadi saya coba eksperimen
untuk kerja pakai Tablet (android atau iPad).

Nah, tablet berjalan di struktur ARM sehingga tidak mungkin juga saya
meng-*install* R di sana. Jadi kita bisa gunakan *cloud computing*. Bisa
pakai Google Cloud atau Digital Ocean.

Berikut ini saya coba buat [video](https://youtu.be/MBvd2D5Xp8c),
bagaimana dalam waktu 2 menit saja saya “*hosting*” R Studio docker saya
di layanan Google Cloud Run. Tidak perlu memikirkan spek servernya,
karena Google sendiri yang akan menentukan yang terbaik sesuai dengan
kebutuhan.

Cukup 2 menit dan R Studio settingan Ubuntu saya sudah bisa dijalankan
secara *cloud*.

Sekarang saya bisa gunakan R Studio di mana aja, pakai gadget apa aja
(asal ada browser dan koneksi internet). Berbekal cloud computing, bisa
jadi ke depannya tidak perlu komputer spek dewa untuk melakukan
komputasi yang berat yah. Cukup sewa dan pakai saja.
