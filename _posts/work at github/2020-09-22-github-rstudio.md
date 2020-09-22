---
date: 2020-09-22T08:00:00-04:00
title: "Tutorial: Menggunakan Github pada R Studio"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Tutorial
  - Github
  - R Studio
---


Pandemi COVID-19 yang melanda dunia ini sedikit banyak mengubah tatanan
dunia kerja menuju lebih digital. Beruntung bagi saya, perusahaan tempat
saya bekerja sudah lebih dulu mengusung tema `digital` dan `remote
working`. Isu mengenai impelementasi *WFH* sudah selesai dibahas bahkan
sejak saya pertama kali kerja di sana (tahun 2012).

Jadi *WFH* sekarang ini bukanlah barang baru bagi kami.

> *Concerns* mengenai cara kerja dan produktivitas sudah *case closed*\!

Sebagai seorang yang bekerja *rely on data and analytics*, sebenarnya
saya cukup membutuhkan laptop atau komputer saja. Kebetulan juga saya
selalu mengerjakan setiap *project data science* sendirian, jadi
koordinasi yang dilakukan biasanya memang langsung ke klien internal
kantor saja. Tidak perlu repot-repot mengurusi administrasi apa-apa.

-----

Untuk urusan laptop, saya sudah pernah menulis mengenai
[Ubuntu](https://ikanx101.com/blog/review-ubuntu/) dan
[ChromeOS](https://ikanx101.com/blog/laptop-chromium/). Jadi sebenarnya
*gak* masalah mau pakai OS apa saja, yang penting **R Studio** harus
bisa digunakan di **OS** tersebut. Namun, sekarang saya lebih memilih
Ubuntu sebagai *daily driver* saya.

*Nah*, setelah mulai *WFH*, timbul beberapa masalah baru:

1.  Saya menggunakan `2` laptop untuk bekerja, oleh karena itu saya
    membutuhkan satu media penyimpanan *files* yang bisa digunakan untuk
    memindah-mindahkan *files* dari satu laptop ke laptop lainnya.
    Awalnya saya menggunakan *USB drive* untuk melakukan hal tersebut.
    Tapi kadang saya jadi *keder* sendiri. Puncaknya adalah saat saya
    lupa *file* mana yang memiliki *version* terbaru. Akibatnya
    pekerjaan saya hilang karena tertimpa dengan file yang lebih rendah
    *version*-nya.
2.  Saya dan beberapa rekan kantor menginisiasi *training* **R**, oleh
    karena itu kadang-kadang diperlukan media untuk bisa
    mengkolaborasikan *script* dan materi *training* dengan efisien
    antar *trainer* dan *trainee*.

Jadi muncul kebutuhan akan satu media yang bisa diandalkan untuk
memindahkan *files* dan memudahkan kolaborasi. Media *cloud* seperti
*One Drive* atau *Google Drive* menurut saya kurang tepat digunakan
untuk bekerja dengan *R Studio*.

> Berhubung saya sudah menggunakan *Github* sebagai *back bone* membuat
> situs ini, maka kenapa tidak saya maksimalkan saja untuk urusan
> kerjaan?

Begitu pikir saya.

-----

### Bagaimana menyambungkan Github ke R Studio?

Saya membuat beberapa *repository* yang kemudian saya hubungkan ke *R
Studio*. Bagaimana caranya?

#### Pertama

Buat dulu *repository* di *Github*, lalu cari bagian *code*, *copy*
alamat yang tertera pada *section* `https` tersebut.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/work%20at%20github/skrinsut 1.png" width="833" style="display: block; margin: auto;" />

#### Kedua

Buka *R Studio*, pilih `File` -\> `New Project` -\> `Version Control`
-\> `Git`. *Paste* alamat dari github ke kolom yang ada.

<img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/work%20at%20github/r1.png" width="479" style="display: block; margin: auto;" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/work%20at%20github/r2.png" width="480" style="display: block; margin: auto;" /><img src="https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/work%20at%20github/r3.png" width="479" style="display: block; margin: auto;" />

#### Ketiga

*R Studio* secara otomatis melakukan *cloning* *folders* dan *files*
dari *Github* ke *local disk*. Sekarang kita bisa memodifikasi semua
*file* tersebut secara *offline*. Saat nanti ada perubahan (penambahan,
pengurangan, atau modifikasi), kita bisa *synchronize* dengan melakukan
*commit*, *push*, dan *pull* dari *R Studio*.

-----

### Jadi apa saja yang saya lakukan dalam memaksimalkan Github saat *WFH*?

#### 1\. Membuat *public repository* untuk wadah *training*

Hal yang pertama kali saya lakukan adalah membuat *public repository*
untuk wadah *training R* di kantor. Kemudian saya menghubungkan
*repository* tersebut ke *R Studio*. Jadi setiap *script* yang saya
*share* dan tunjukkan kepada *trainee* bisa diakses *real time*.

#### 2\. Membuat *private repository* untuk *daily jobs*

Seperti yang saya kemukakan sebelumnya, bekerja dengan `2` laptop
membutuhkan satu manajemen *files* yang mumpuni dan *gak bikin bingung*.
Dengan membuat *private repository* (supaya tidak ada yang bisa
*ngintip*), saya bisa menyimpan *files* kerjaan di satu tempat saja.
