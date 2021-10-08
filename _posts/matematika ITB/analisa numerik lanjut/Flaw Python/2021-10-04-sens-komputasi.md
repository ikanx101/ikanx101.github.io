---
date: 2021-10-04T10:32:00-04:00
title: "Sensitivitas Komputasi"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - Computational Science
  - Sains Komputasi
  - Matematika
  - Kuliah
  - ITB
  - Analisa Numerik Lanjut
  - Komputasi
  - Aproksimasi
---

Di suatu perkuliahan, dosen saya menyuruh kami untuk membuka Python:

> Coba kamu buka Python dan execute perintah ini: 3 * 0.1

Setelah saya _execute_, detik itu juga hati saya bersorak gembira sekaligus bertanya-tanya dalam hati.

> Kenapa bisa begitu? Mungkin sudah tepat bagi saya untuk tidak menggunakan Py. _hehe_

---

Tulisan di atas bukan bentuk _black campaign_ terhadap Python. Justru hal tersebut terjadi di mata kuliah yang membahas dalam tentang Python. Lantas apa tujuan dari dosen saya bertindak seperti itu?

Beliau berujar:

> Komputer itu bodoh. Dia hanya bisa menjalankan komputasi yang kita perintahkan, menghitung dari input yang kita berikan. Kita sebagai manusia harus punya sensitivitas komputasi.

___Apa itu sensitivitas komputasi?___

___Apakah ini hanya berlaku buat Python saja?___

___Apakah rekan-rekan master Excel aman dari hal-hal seperti ini?___

---

Setiap komputasi yang dilakukan oleh komputer didasari setidaknya oleh dua hal:

1. Inputnya apa?
1. Prosesnya bagaimana?

Komputer jika dikasih input angka berapapun, disuruh menghitung bagaimanapun, dia akan mengeluarkan hasilnya. Tapi apakah hasilnya sudah sesuai secara kaidah analisa yang benar?

---

## INPUT

Buat rekan-rekan yang sudah mulai banyak _ngoprekin_ data. Baik memakai Excel, R, Py, ataupun _tools_ lainnya. Saya sarankan untuk meluangkan waktu untuk mundur sedikit.

Cek kembali data kita itu seperti apa tipenya, karakteristiknya, sifatnya, dll.

Dulu saya pernah mengingatkan di [_post_ ini](https://ikanx101.com/blog/mengenal-data/).

Ingat _yah_:

> Berbeda tipe datanya, berbeda pula cara kita memahami datanya.

Sebagai contoh:

Misalkan kita hendak menghitung korelasi antara _gender_ dengan _bmi_. Apakah kita bisa langsung menghitung di Excel dengan rumus `=correl(gender,bmi)` ?

Jawabannya: __tidak semudah itu Fergusso...__

Walaupun kalian sudah mengganti _gender_ menjadi angka (misal `pria = 1`, `wanita = 2`) dan di Excelnya juga sudah keluar angka korelasinya, percayalah nilai korelasi yang muncul di layar itu gak ada gunanya.

Lho kenapa? Ini berkaitan dengan:

## PROSES KOMPUTASI

Kita harus tahu bagaimana algoritma komputer itu bekerja. ___CMIIW___, rumus `correl()` yang ada di Excel sekarang itu secara _default_ adalah menghitung korelasi Pearson.
Maksudnya apa? Korelasi yang bisa dihitung itu jika datanya berupa numerik vs numerik.
Sedangkan gender bukan numerik!

Artinya apa? Tidak tepat perhitungan korelasi yang kita lakukan.

> Sebagai reminder, korelasi itu ada banyak jenisnya. Ada Pearson, Spearman, dan Kendal Tau.

---

Dari sini saya berpesan buat kita semua untuk mulai sensitif terhadap komputasi dengan cara:

1. Minimal tahu data kita itu seperti apa.
1. Tahu cara komputer melakukan komputasi seperti apa.

Jadi kita _gak_ mudah "tertipu" dengan hasil yang ditampilkan di layar komputer.

---

Kembali lagi ke kasus _flaw_ Python secara numerik. 
Tujuan lain dosen saya berbuat demikian adalah untuk menginformasikan bahwa _tools_ yang kita pakai bisa jadi memiliki kelemahan dalam hal komputasi.
Akibatnya kita perlu tahu bagaimana cara meng-_handle_ hal ini sehingga komputasi yang kita lakukan kelak masih bisa diterima hasilnya.

---

## Tambahan

Selain sensitivitas komputasi, metodologi juga penting supaya _output_ yg dihasilkan tidak keliru dan pengambilan kesimpulan serta keputusan jadi keliru juga. 
Pengambilan _sample_ sudah benar belum? 
Argumen dan dasar berpikirnya bagaimana ketika mengorelasikan dua variabel atau menguji beda suatu hal?
_That is why_, dalam analisis entah bisnis entah ilmiah, bukan hanya data dan _tools_ saja yang dibutuhkan, tapi _analyst_-nya juga _matters_.

