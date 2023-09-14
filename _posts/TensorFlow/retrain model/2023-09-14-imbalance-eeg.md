---
date: 2023-09-14T10:58:00-04:00
title: "Sharing Best Practice Membuat Model Deep Learning dari Data Imbalance"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - TensorFlow
  - KERAS
  - Neural Network
  - Deep Learning
  - Imbalance Dataset
---

Beberapa minggu ini, saya diberikan tugas untuk mengeksplorasi data
gelombang otak yang diambil dari alat *electroencephalogram* (EEG) dari
beberapa orang setelah diberikan stimulus tertentu. Data ini terdiri
dari banyak kolom berisi nilai numerik gelombang otak dari masing-masing
sensor di alat EEG.

Hal yang langsung terlintas di pikiran saya adalah:

> *Apakah mungkin saya mencari gelombang otak mana yang terpengaruh
> untuk stimulus tertentu?*

Berdasarkan pertanyaan tersebut, maka saya berniat untuk membuat model
*deep learning* dengan `Tensorflow` di **R**.

Salah satu permasalahan yang saya temukan adalah data stimulus yang
ternyata *imbalance*. Dari sekitar `600`-an baris data, saya memiliki
`150`-an baris dengan stimulus `1` dan `450`-an baris dengan stimulus
`0`.

Lantas bagaimana saya bisa mendapatkan model yang baik (ditandai oleh
akurasi yang baik)?

------------------------------------------------------------------------

Tentu ada beberapa teknik yang bisa dilakukan. Salah satunya dengan
melakukan *data augmentation*. Namun setelah saya pikirkan kembali, saya
ingin mencoba hal lain dengan memanfaatkan salah satu *benefit* dari
*deep learning*. Apa itu? Kapabilitas model yang bisa dilatih ulang
secara terus menerus.

Maka pada langkah awal membuat model, saya membuat *train data* yang
*balance* antara stimulus `0` dan `1`. Setelah divalidasi dengan data
*train* dan *test*, akurasinya sudah tentu **tidak baik**. Tercatat,
akurasinya hanya berada di kisaran `60%-65%`.

Namun jangan sedih dulu, karena kita akan melakukan tahapan berikutnya
dengan melakukan latih ulang. Pada tahap berikutnya, saya membuat *train
data* kedua dengan stimulus yang mulai *imbalance*. Jika sebelumnya saya
paksakan agar `50-50`, kali ini saya buat mulai bergeser ke `45-55`.

*Oh iya*, saya juga tidak mendefinisikan `set.seed()` di angka tertentu
agar pembuatan *train data* menjadi selalu *random*.

> *Hasilnya akurasinya menjadi naik sedikit ke kisaran* `67%`.

Proses ini diulang terus dengan membuat *train data* yang *imbalance*.
Jangan terburu-buru untuk membuat proporsinya menjaid mirip dengan data
aslinya. Kita harus perlahan-lahan membuat *train data*-nya.

Sebagai contoh, pada tahap selanjutnya, saya coba ubah proporsinya
menjadi `43-57`.

Setelah di-iterasi perlahan sebanyak 12 kali, saya mendapatkan model
yang lebih baik. Akurasinya sekarang berada di angka `87%`. Sebuah nilai
yang memuaskan untuk saya pribadi. Saya akan_stop\_ sampai sini agar
tidak terjadi *overfit* kelak.

------------------------------------------------------------------------

Dari model yang ada, saya baru akan membuat *exploratory model analysis*
menggunakan `DALEX`. Semoga bermanfaat.

`if you find this article helpful, support this blog by clicking the ads.`
