---
date: 2025-06-10T09:50:00-04:00
title: "Mengakses Internet Via Command Line Interface Menggunakan Lynx"
categories:
  - Blog
tags:
  - Browser
  - Lynx
  - Web Scrape
---

Untuk mengakses suatu situs di internet, kita memerlukan *browser*. Kita
mengenal beberapa *browsers* yang populer seperti **Google Chrome,
Mozilla Firefox, Microsoft Edge, Safari, dan Opera**. Chrome dikenal
dengan kecepatan dan integrasinya dengan layanan **Google**, sementara
**Firefox** dihargai karena privasi dan kebebasan penggunaannya.
**Edge**, yang berbasis **Chromium**, menawarkan optimasi untuk
*Windows* dan fitur produktivitas. *Browsers* ini terus diperbarui untuk
meningkatkan keamanan dan pengalaman pengguna, sehingga menjadi pilihan
utama bagi banyak orang.

Di sisi lain, ada *browsers* yang kurang dikenal atau jarang digunakan
karena berbagai alasan, seperti fitur yang terbatas, antarmuka yang
kurang menarik, atau kurangnya dukungan pengembang. Contohnya adalah
**SeaMonkey, Pale Moon, atau Lynx**. **SeaMonkey** dan **Pale Moon**
lebih ditujukan untuk pengguna spesifik yang mengutamakan kesederhanaan
atau nostalgia, sementara **Lynx** adalah *browser* berbasis teks yang
digunakan untuk keperluan teknis. Meskipun memiliki pengguna setia,
*browsers* ini kalah bersaing dalam hal popularitas dan jarang menjadi
pilihan utama bagi kebanyakan pengguna internet.

Pada tulisan ini, saya akan membahas satu *browser* unik bernama
**Lynx**.

------------------------------------------------------------------------

**Sejarah Lynx**

**Lynx** adalah salah satu *browser web* tertua yang masih ada, pertama
kali dikembangkan pada tahun 1992 oleh sekelompok mahasiswa dan staf di
**University of Kansas**. Awalnya, **Lynx** dibuat sebagai proyek
eksperimen untuk menavigasi dokumen *hypertext* sebelum *World Wide Web*
menjadi populer. Karena dirancang untuk sistem **Unix**, **Lynx** cepat
diadopsi oleh pengguna yang mengutamakan efisiensi dan aksesibilitas
melalui antarmuka berbasis teks. Meskipun teknologi *web* telah
berkembang pesat, **Lynx** tetap dipertahankan sebagai alat yang berguna
dalam lingkungan teknis tertentu.

**Fitur Utama Lynx**

Sebagai *browser* berbasis teks, **Lynx** tidak mendukung gambar, video,
atau elemen multimedia modern. Namun, keunggulannya terletak pada
kecepatan, konsumsi sumber daya yang minimal, dan kemampuan mengakses
konten *web* dalam bentuk teks murni. **Lynx** sangat berguna untuk
pengguna dengan koneksi internet lambat, tunanetra yang mengandalkan
*screen reader*, atau administrator sistem yang perlu menelusuri web
melalui terminal. Selain itu, **Lynx** mendukung protokol internet
seperti HTTP, HTTPS, FTP, dan Gopher, menjadikannya alat serbaguna untuk
navigasi dasar.

**Kegunaan Modern Lynx**

Meskipun terkesan kuno, **Lynx** masih digunakan hingga hari ini,
terutama dalam pengujian aksesibilitas *website*, *crawling data*, atau
bekerja di *server* tanpa antarmuka grafis. Banyak pengembang *web*
menggunakannya untuk memeriksa apakah situs mereka dapat diakses oleh
perangkat atau jaringan dengan kemampuan terbatas. Selain itu, **Lynx**
menjadi pilihan bagi mereka yang menghargai privasi, karena tidak
menjalankan *script* atau melacak aktivitas pengguna seperti *browser*
modern. Keberadaannya membuktikan bahwa fungsionalitas sederhana tetap
relevan di era *web* yang kompleks.

**Antarmuka Lynx**

Karena **Lynx** berbasis teks, maka jangan bayangkan bentuknya seperti
**Chrome** atau *browser* lainnya. Kita bisa mengakses **Lynx**
menggunakan `terminal` alias *command line interface*.

**Proses Instalasi**

Proses instalasinya cukup mudah, di Linux silakan run skrip berikut ini:

    sudo apt install lynx

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/lynx/link1.png)

Dalam hitungan detik, **Lynx** siap digunakan.

**Cara Menggunakan**

Untuk mengakses situs, silakan ketikan `lynx nama_situs` dan tunggu
hingga *website* tampil.

Saya berikan contoh sebagai berikut ya:

    lynx google.com

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/lynx/link2.png)

Berikut adalah tampilan dari **google.com**:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/lynx/link3.png)

Berikut adalah beberapa **tombol keyboard (key)** yang memiliki fungsi
penting dalam browser **Lynx**, beserta penjelasan singkat
penggunaannya:

### **1. Navigasi Dasar**

- **↑ (Panah Atas)** / **↓ (Panah Bawah)** – Pindah ke *link*
  sebelumnya/selanjutnya.  
- **→ (Panah Kanan)** / **Enter** – Membuka *link* yang dipilih.  
- **← (Panah Kiri)** / **Backspace** – Kembali ke halaman sebelumnya.  
- **Space** / **+** – *Scroll* ke bawah (seperti *Page Down*).  
- **-** – *Scroll* ke atas (seperti *Page Up*).

### **2. Pencarian dan *Browsing* Cepat**

- **/** – Cari teks dalam halaman (mirip `Ctrl+F` di *browser*
  modern).  
- **n** – Lanjutkan pencarian ke hasil berikutnya.  
- **g** – Buka *prompt* untuk memasukkan *URL* baru.  
- **Ctrl+G** – Berhenti memuat halaman (batal *loading*).

### **3. Manajemen *Link* dan Halaman**

- **m** – Kembali ke halaman utama (*homepage*).  
- **a** – Tambahkan halaman saat ini ke *bookmark*.  
- **v** – Lihat daftar *bookmark*.  
- **d** – Unduh (*download*) *file* dari *link* yang dipilih.  
- **=** – Lihat informasi teknis halaman (*URL*, judul, dll.).

### **4. Pengaturan dan Bantuan**

- **o** – Buka menu opsi (*settings*).  
- **h** / **?** – Tampilkan layar bantuan (*help*).  
- **Ctrl+R** – Muat ulang (*refresh*) halaman.  
- **q** – Keluar (*quit*) dari **Lynx** (akan muncul konfirmasi).

Jika lupa, tekan **?** untuk melihat daftar lengkap perintah.

Coba kita akan cari blog ikanx101.com di *google* tadi.

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/lainnya/lynx/link4.png)

------------------------------------------------------------------------

## Manfaat dari **Lynx**

Dari deskripsi di atas, saya akan coba bahas manfaat dari *Lynx* untuk
melakukan *web scraping*. Ada beberapa cara yang bisa kita gunakan, saya
akan bahas satu-persatu sebagai berikut:

### 1. *Save page* ke bentuk teks

Kita bisa menyimpan teks dari suatu situs ke dalam file berformat
`.txt`. Contohnya skrip berikut ini:

    lynx -dump -nolist "https://ikanx101.com/blog/ai-riset/" > output.txt

### 2. *Save multiple pages* ke bentuk teks

Kita juga bisa menyimpan *multiple pages* ke dalam satu *file* berformat
`.txt`. Caranya adalah dengan membuat skrip *bash*. Misalkan saya buat
`skrip.sh` dengan isi berikut ini.

    #!/bin/bash
    urls=("https://ikanx101.com/blog/ai-riset/" "https://ikanx101.com/blog/mini-os/")

    for url in "${urls[@]}"; do
      lynx -dump -nolist "$url" >> scraped_data.txt
    done

Setelah itu, saya akan run skripnya di `terminal` dengan cara:

    chmod +x skrip.sh
    ./skrip.sh

### 3. *Save tables* ke bentuk `json`

Kita juga bisa *save* tabel dalam *website* ke dalam *file* format
`.json` berikut ini:

    lynx -source "https://panelharga.badanpangan.go.id/tabel-dinamis" | pup 'table tr json{}' > output.json

Bagaimana? Seru kan ya? *Hehe*

------------------------------------------------------------------------

`if you find this article helpful, support this blog by clicking the ads.`
