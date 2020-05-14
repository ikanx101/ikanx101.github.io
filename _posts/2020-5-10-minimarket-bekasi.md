---
date: 2020-5-10T15:10:00-04:00
title: "Perubahan Habit Belanja Ketika PSBB pada Suatu Wilayah di Bekasi"
categories:
  - Blog
tags:
  - Machine Learning
  - Artificial Intelligence
  - R
  - Retail Audit
  - Minimarket
  - Ggplot
  - Investigasi
  - Shopping Habit
---

Beberapa waktu yang lalu, saya *ngobrol* secara *virtual* dengan
beberapa rekan SMA saya dulu. Ternyata sudah dua tahun ini mereka
bersama-sama merintis usaha minimarket *retail* waralaba di salah satu
perumahan di daerah Bekasi. Nama waralabanya apa akan saya rahasiakan
*yah*.

Singkat cerita, mereka memberikan data *sales* harian minimarket
tersebut kepada saya untuk saya oprek-oprek.

Jangan membayangkan data yang saya terima itu sudah sangat bersih dan
rapi secara struktur *yah*. Walaupun bentuknya berformat **Microsoft
Excel** tapi bentuknya *unstructured*. Jadi harus ada *effort* untuk
merapikan datanya menggunakan **R**. Sayang sekali saya tidak bisa
memperlihatkan format *raw data*-nya. Padahal lumayan *banget* kalau
dijadikan bahan latihan *data carpentry using* **R**.

Kenapa *sih* merapikannya harus pakai **R**?

> Biar bisa *reproducible* untuk *files* selanjutnya. Jadi *gak* akan
> capek kalau ada data baru.

Data *retail audit* semacam ini memiliki informasi yang **sangat amat
kaya sekali**. Agak *lebay sih* tapi memang begitu faktanya.

Pada awalnya *blueprint* dari analisa yang hendak saya lakukan saya
tuangkan dalam bagan berikut
ini:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Ide%20Analisa.png" width="90%" />

Semua analisa pada *blueprint* saya rasa sudah cukup.

Namun karena keterbatasan waktu dan sumber daya, maka saya hanya akan
lakukan beberapa yang *menarique* dan *urgent* saja sesuai dengan
diskusi *virtual* dengan rekan-rekan saya. Salah satu analisa yang
membuat penasaran adalah:

# Apakah ada perubahan habit belanja pelanggan selama COVID-19 ini?

Awalnya saya melakukan analisa ini secara tidak sengaja saat
mengeksplorasi data yang ada. Pertama, saya coba dengan melihat total
*sales* harian sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-2-1.png" width="864" />

Kalau dilihat sekilas, total *sales* harian memiliki fluktuatif yang
cukup tinggi. Pada beberapa tanggal, kita bisa melihat total *sales*
bisa mencapai angka di atas Rp 10 juta.

Pada bulan `Februari 2020`, kita bisa lihat juga sepertinya total
*sales* yang dicapai relatif lebih rendah dibandingkan bulan lainnya.

Mari kita lihat total *sales* per bulan sebagai
berikut:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-3-1.png" width="864" />

Ternyata benar bahwa di bulan `Februari 2020` ada penurunan omset. Namun
terjadi *bounce back* sehingga ada peningkatan pada bulan-bulan
setelahnya.

## Rata-rata Sales Harian per Bulan

Jika pada bagian sebelumnya, kita telah melihat total *sales*, sekarang
mari kita lihat analisa berdasarkan `rata-rata sales per hari` di setiap
bulan.

Maksudnya *gimana*?

> Yakni berapa nominal rupiah rata-rata yang dikeluarkan pelanggan saat
> bertransaksi di minimarket setiap
bulannya?

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-4-1.png" width="864" />

*Wah*, ternyata secara `rata-rata sales harian`, angka di `Januari 2020`
hampir sama dengan angka di `Februari 2020` lalu selalu ada kenaikan di
bulan-bulan setelahnya.

Lalu apa penyebab `total sales` di `Februari 2020` turun sedangkan
`rata-rata sales harian`-nya hampir mirip dengan `Januari 2020`?

## Banyaknya Transaksi per Bulan

Mari kita lihat grafik berikut
ini:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-5-1.png" width="864" />

Ternyata ada penurunan transaksi pada bulan `Februari 2020` (turun
sebesar 387 transaksi). Ini adalah penyebab turunnya `total sales` pada
bulan tersebut.

Bagaimana dengan penurunan di bulan `Maret 2020` - `April 2020`?

> Walaupun ada penurunan `banyaknya transaksi`, tapi `rata-rata belanja
> per transaksi` di bulan `April 2020` justru meningkat tajam. Oleh
> karena itu `total sales` juga cenderung aman (tetap naik).

Namun justru ini bisa menjadi pertanyaan
tersendiri:

### Apakah konsumen di bulan `Maret 2020` tidak berbelanja lagi di bulan `April 2020`?

Jika ini yang terjadi, maka mungkin perlu dicari tahu alasannya sehingga
212 Mart bisa membuat mereka kembali berbelanja di bulan berikutnya.

Sayangnya, saya belum bisa membuktikan dugaan ini dengan data yang
ada.

**ATAU**

### Apakah konsumen di bulan `Maret 2020` menaikkan *basket size* (berbelanja lebih banyak dalam sekali waktu) di bulan `April 2020`

Bisa jadi penurunan banyaknya transaksi dikarenakan oleh perubahan
*habit* dari pelanggan dalam berbelanja.

Pelanggan yang tadinya lebih sering ke toko untuk berbelanja dengan
*basket size* kecil, sekarang berubah menjadi lebih jarang ke toko namun
sekalinya berbelanja mereka memperbesar *basket size*.

Mari kita buktikan dengan menghitung rata-rata berapa banyak *item* yang
dibeli per pelanggan disetiap
bulannya:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-6-1.png" width="864" />

Benar dugaan saya. Ada kenaikan *basket size* di bulan `April 2020`. Hal
ini mengindikasikan ada perubahan *habit* belanja pelanggan di **212
Mart**.

Sedangkan pada `Januari 2020` - `Februari 2020` *basket size* pelanggan
tetap sama. Ada apa di `Februari 2020` ya?

-----

# Analisa Lebih Lanjut Terkait Perubahan Habit Belanja

## Analisa *Basket Size* Overall

Untuk meyakinkan kembali dugaan saya pada poin sebelumnya, mari kita
lihat grafik berikut
ini:

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-7-1.png" width="864" />

Terlihat bahwa ada peningkatan *basket size* per transaksi pada bulan
`May 2020`.

## Analisa Berdasarkan Member vs Non Member

Ternyata minimarket teman saya ini memiliki program *membership*. Oleh
karena itu, kita akan lihat apakah pola kenaikan *basket size* terjadi
untuk member saja atau juga untuk non member.

### *Basket Size* Member vs Non Member

Pertama-tama, kita akan menghitung berapa banyak barang yang dibeli oleh
member dan non
member.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-8-1.png" width="864" />

### *Market Size* Member vs Non Member

Sekarang kita akan bandingkan nominal uang yang dibelanjakan oleh member
vs non
member.

<img src="https://raw.githubusercontent.com/ikanx101/belajaR/master/Bukan%20Infografis/212%20Mart/Gara-gara-covid_files/figure-gfm/unnamed-chunk-9-1.png" width="864" />

# Kesimpulan

> Adanya PSBB yang dilakukan sepertinya mengubah pola belanja pelanggan
> di minimarket teman saya.

Walaupun hanya terjadi di minimarket milik teman saya ini, tapi temuan
ini memberikan optimisme roda ekonomi masih bergerak. Semoga saja.

Aamiin.
