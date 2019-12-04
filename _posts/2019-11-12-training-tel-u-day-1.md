---
date: 2019-11-12T05:00:00-04:00
title: "Oleh-oleh Pelatihan di Telkom University"
categories:
  - Blog
---

Ceritanya dalam seminggu ini, saya diberi tugas dari kantor untuk mengikuti pelatihan _Big Data_ yang diselenggarakan oleh Kementrian Perindustrian di Universitas Telkom Bandung. Alhamdulillah, saya sudah pernah melakukan semua hal yang ada di silabusnya. Trus kalau sudah pernah, kenapa masih ikutan? Sebenarnya penasaran aja sih.

> Apakah benar semua materi itu akan diberikan dalam waktu 4 hari kerja? Yakin nih?

Soalnya untuk beberapa analisa, saya pribadi butuh waktu harian untuk bisa menguasainya.

Hari pertama ini, _trainee_ dijejali oleh dasar teori statistika. Mirip-mirip dengan materi orientasi yang sering saya bawakan di kantor untuk anak baru. Tapi, ada beberapa informasi yang baru saya ketahui di sini. Berikut saya rangkum di bawah ini yah. _Happy reading gengs…_

## Uji Kenormalan

Seperti yang kita ketahui, untuk menguji apakah suatu data berdistribusi normal atau tidak, kita bisa menggunakan setidaknya dua metode. Yakni: Kolmogorov-Smirnov dan Shapiro-Wilk.

Jika n < 50 gunakan Shapiro-Wilk sedangkan saat n > 50 gunakan Kolmogorov-Smirnov.

## Goodness of Fit dari STRUCTURAL EQUATION MODEL (SEM)

Saya sudah menulis beberapa artikel mengenai SEM di blog saya yang [lama](https://passingthroughresearcher.wordpress.com/tag/sem/). _So, kindly check and read them all_ dulu yah.

Ada satu hal yang sebenarnya mengganjal saat kita membuat SEM. Apa itu? Penentuan seberapa bagus dari model tersebut. Sebagaimana yang kita tahu, ada banyak sekali parameter _goodness of fit_ dari SEM. Pengajar di Telkom Univ menyebutkan bahwa ada 20 parameter.

Seringkali kita menemukan, dari sekitar 20 parameter tersebut, ada sekian yang fit sedangkan sisanya tidak fit.

Bagaimana cara menentukan model kita baik?

Nah, begini caranya:

Pertama lihat 2 parameter yang dominan, yakni __Chi Square__ dan __p-value__. Lalu melihat sisa parameter yang lain. Jika model mendapatkan banyak hasil fit, maka model sudah bisa digunakan.

Contoh: dari 20 parameter, model mendapatkan fit dari 13 parameter. Artinya model bisa dikatakan sudah baik.

## Rangkuman Metode Estimasi atau Prediksi

Nah, ini rangkuman yang bisa dijadikan acuan untuk memilih metode mana yang bisa digunakan dalam membuat model estimasi atau prediksi.

Setiap model estimasi atau prediksi kan memiliki setidaknya dua variabel. Variabel dependen dan independen. Seringkali kita menuliskannya sebagai notasi X dan Y. Secara formula, kita menginginkan Y sebagai fungsi dari X, yakni:

Y = f(x)

Berikut panduannya:

1. Regresi linear, dipakai saat X berupa numerik dan Y berupa numerik.
2. Discriminant analysis, dipakai saat X berupa numerik dan Y berupa kategorik. Khusus terkait diskriminan ini. Sepengetahuan saya, jika kita memiliki variabel X lebih dari satu. Semua variabel X disyaratkan harus multivariat normal. Tapi setelah saya tanyakan dan konfirmasi kembali, tidak harus dipenuhi. Saat masing-masing X sudah univariat normal, maka diskriminan bisa dipakai.
3. Regresi loglinear, dipakai saat X berupa kategorik dan Y berupa kategorik.
4. Manova, dipakai saat X berupa kategorik dan Y berupa numerik.
