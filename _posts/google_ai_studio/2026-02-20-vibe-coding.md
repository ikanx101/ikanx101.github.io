---
date: 2026-02-20T11:05:00-04:00
title: "Cara Membuat Web Apps dengan Google AI Studio, Github, dan Railway"
categories:
  - Blog
tags:
  - Vibe Coding
  - Gemini
  - Google
  - Railway
  - Github
---

*Weekend* ini, linimasa saya dipenuhi oleh pembahasan terkait *vibe
coding*. Apa *sih* yang dimaksud dengan *vibe coding*? Berikut
penjelasannya:

> *Vibe coding* adalah cara membuat *software* atau *apps* di mana kita
> tidak lagi menulis baris kode (*ngoding*) yang rumit secara manual,
> melainkan cukup menjadi **“sutradara”** yang memberikan instruksi
> kepada AI. Analoginya seperti memesan kopi di kafe yang sangat
> canggih: kita tidak perlu tahu cara kerja mesin *espreso* atau suhu
> dan tekanan air yang tepat, kita cukup mendeskripsikan *vibe* atau
> rasa kopi yang kita inginkan. Kemudian AI akan meracik seluruh resep
> serta menyajikannya untuk kita.

Fokus utama dari *vibe coding* ini adalah bukan pada penguasaan kode
pemrograman, melainkan pada kemampuan kita untuk menyampaikan ide dan
visi secara jelas agar AI bisa mewujudkannya menjadi *apps* nyata.

Sebenarnya pada awal tahun lalu saya sempat mencoba-coba melakukan *vibe
coding* dari salah satu situs yang *viral* tapi hasilnya masih bisa
dibilang jauh dari kata memuaskan. Menurut saya, saat ini **bisa jadi
layanan *vibe coding* yang ditawarkan situs-situs tersebut sudah jauh
berkembang dan *reliable***. Oleh karena itu, saya akan coba membuat
satu *web apps* yang akan saya pakai.

Ketika sedang merenung *apps* apa yang hendak saya buat, saya berpikir:

> Sebentar lagi kan bulan *Ramadhan*, kenapa *gak* bikin *web apps*
> untuk *tracking* kuantitas ibadah harian saja?

Inspirasinya berasal dari pengalaman saat sekolah SD - SMA, dimana dulu
saya (dan mungkin banyak anak-anak lainnya) disuruh mengisi lembar kerja
Ramadhan yang berisi rekap puasa, shalat, infaq, dan ibadah harian
lainnya. Lembar tersebut kemudian akan dikumpulkan setelah lebaran.

Walau sekarang sudah dewasa tapi menurut saya lembar tersebut masih
sangat berguna sebagai *tracking* ibadah agar semangat tidak lekas turun
di pertengahan hingga akhir Ramadhan. Berdasarkan ini, *bismillah* saya
coba buat *web apps*-nya.

Rencananya saya akan menggunakan tiga layanan yang berbeda sesuai dengan
peruntukannya:

1.  *Google AI Studio* untuk membuat *coding* dan *struktur* dari
    *apps*-nya.
2.  *Github* untuk menyimpan *coding*-nya.
3.  *Railway* untuk *build web apps* berdasarkan *repository* di
    *Github* tersebut.

------------------------------------------------------------------------

# Langkah I: Google AI Studio

Ada banyak situs yang menyediakan jasa *vibe coding* namun pilihan saya
awalnya jatuh kepada **Google Gemini**. Saya melihat beberapa video dan
*shorts* yang memperlihatkan kapabilitas dari Gemini untuk *build apps*.
Namun setelah saya coba, ternyata saya baru menyadari bahwa layanan
Google yang benar-benar diperuntukkan untuk *vibe coding* adalah
[**Google AI Studio**](https://aistudio.google.com/).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb1.png)

> Jadi ini adalah kali **pertama** saya menggunakan **Google AI
> Studio**.

Cukup dengan akun *Google*, kita sudah bisa mendapatkan layanan *vibe
coding* yang mumpuni. Berdasarkan pengalaman saya, layanan ini *free*
jika kita menggunakan model Gemini yang standar (bukan *pro*) dan tidak
membangun *apps* skala *enterprise*. Beberapa keunggulan *Google AI
Studio* ini adalah:

1.  *Free* untuk membuat *apps* kecil-menengah.
2.  Bisa dikoneksikan langsung ke *Github* dan dibuatkan
    *repository*-nya.
3.  Bisa dikoneksikan juga ke **Google Cloud Console** untuk langsung
    di-*deploy* di *web*.
    - Khusus untuk *deploying apps*, saya memilih untuk men-*deploy* di
      *Railway* karena sudah *familiar* dan memang berlangganan sejak
      beberapa tahun silam.

Tampilan awal setelah kita *login* (atau *getting started*) adalah
sebagai berikut ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb2.png)

Saya langsung memberikan *prompt* di *input* sebagai berikut:

    Buat program berjudul "My Ramadhan Tracker" yang berfungsi untuk memberikan jadwal imsakiyah pada bulan Ramadhan di tahun 2026 ini. Aplikasi berisi:

    1. Jadwal sholat dan tracker apakah sholat dilakukan secara jamaah atau sendiri,
    2. Lembar pengisian progress tilawah user. User bisa mengisi ayat terakhir yang dia baca. Berikan dropdown list nama surat dalam Al Quran dan numerikal input untuk ayat,
    3. Berapa banyak infaq yang dilakukan user pada hari tersebut.

    Program ini akan secara otomatis berganti tanggal setiap kali tanggal berubah.

Setelah *11 seconds*, kita sudah bisa mendapatkan tampilan *web apps*
yang (hampir) jadi. Oleh karena saya merasa secara tampilan dan fitur
masih *kureng*, kemudian saya melakukan beberapa perubahan sebagai
berikut di *prompt*:

    buat fitur berikut:

    1. buat shading berwarna lebih gelap pada menu progres tilawah
    2. buat mode agar user memilih dark atau day mode
    3. Rapikan tulisan mutiara hikmah agar tidak berformat markdown.

Hasilnya tidak serta-merta saya terima. Saya akan coba *prompt* lagi
agar si AI bisa bekerja dengan lebih baik membangun *apps* yang saya
mau:

### Iterasi I:

    berikan pilihan waktu shalat yang dinamis mengikuti lokasi user. waktu shalat mengikuti waktu resmi dari kemenag RI

### Iterasi II:

    Pada menu progress tilawah, tambahkan tombol "simpan" sehingga setelah user menekan tombolnya, histori tilawahnya baru tersimpan

### Iterasi III:

    hilangkan kebutuhan atas API apapun pada program ini

### Iterasi IV:

    tambahkan tombol simpan pada menu infaq hari ini

### Iterasi V:

    revisi awal ramadhan jadi besok tanggal 19 februari

    lalu atur waktu shalatnya menjadi urutan: maghrib, isya, subuh, dzuhur, ashar

    update pergantian hari bukan pada jam 00.00 tapi pada jam 18.00 setiap harinya

    update permulaan 1 ramadhan menjadi tanggal 18 februari jam 18.00

### Iterasi VI

    tambahkan fitur untuk melihat data historikal ibadah sejak hari pertama ramadhan. tambahkan juga fitur mendownload data tersebut ke dalam format excel!

Ternyata dibutuhkan iterasi sampai sekian kali sehingga saya bisa puas
dan bisa aman memakai *apps* ini.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb3.png)

Intinya adalah kita harus bisa mendeskripsikan apa yang kita mau kepada
si AI agar dia bisa menyelesaikan apa yang kita inginkan.

Setelah selesai, kita tinggal memindahkan *coding* yang dihasilkan ke
dalam *Github*. *Nah* kali ini saya tidak menggunakan fitur *auto
connect to Github* dari *Google AI Studio* dan memilih cara kuno yakni
dengan cara:

1.  *Download* *coding*-nya dalam format **zip**.
2.  *Unzip* ke ke dalam *repository* *Github* yang sudah disiapkan.

# Langkah II: Github

Di *Github* saya membuat satu *repository* baru.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb4.png)

Kemudian saya masukkan semua *coding* yang dihasilkan ke sana. Proses
ini sangat mudah, cukup *unzip the zipped files*, *add*, *commit*, dan
*push*. Hasilnya seperti ini:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb5.png)

# Langkah III: Railway

Saya sendiri sudah memakai *Railway* beberapa tahun belakangan ini untuk
men-*deploy* berbagai macam *apps* yang saya butuhkan dan juga
*Shinyapps* yang saya buat. Prosesnya sangat mudah, saya pernah
menuliskan [dua artikel terkait ini di
*blog*](https://ikanx101.com/tags/#railway).

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb6.png)

Saya berlangganan *hobby plan* dengan *usage* per bulan 5 USD. Sangat
*worth* bagi saya!

Oke, bagaimana cara men-*deploy* *coding* yang ada di *repository
Github*?

Pertama-tama, kita *start new project* dan hubungkan *Railway* ke
*Github*. Pastikan *Railway* mendapatkan akses ke *repository* kita.
Setelah itu tinggal klik nama *repository*-nya lalu proses *deploy* akan
berjalan secara otomatis.

Hanya ada dua *setting* yang harus dilakukan, yakni: tambahkan **PORT
8080** pada *variables*.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb7.png)

Kemudian tambahkan *custom domain* yang diarahkan ke *port* 8080.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb8.png)

Lalu klik *deploy* dan tunggu hingga selesai.

Kira-kira begini hasilnya:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/google_ai_studio/gb9.png)

Rekan-rekan bisa mencoba menggunakan *apps*-nya di situs ini:
[ramadhan.up.railway.app](https://ramadhan.up.railway.app/).

# Bagaimana terkait datanya?

Beberapa rekan mungkin bertanya, bagaimana dengan data yang saya
masukkan ke dalam *apps*? Apakah saya bisa melihat data ibadah semua
*user*?

Saya jawab: **tidak** karena data disimpan di *cache* di *local browser*
masing-masing *gadget*.

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
