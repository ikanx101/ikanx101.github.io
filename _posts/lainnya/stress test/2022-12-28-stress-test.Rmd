---
date: 2022-12-28T14:03:00-04:00
title: "Stress Test Laptop Kantor"
categories:
  - Blog
tags:
  - R
  - Server
  - Linux
  - Virtual Machine
---

Sudah hampir 2 tahun belakangan ini saya menggunakan laptop merek DELL yang diberikan kantor. Speknya bisa dibilang lumayan. Namun karena alasan "sayang" dan tidak tegaan, saya jarang menggunakan laptop tersebut untuk pekerjaan yang berat-berat. Satu komputasi yang sangat berat yang pernah saya lakukan di laptop itu hanya sekali, yakni:

> Melakukan simulasi (ratusan ribu kali) transaksi pembelian ribuan toko jika kelompok harga produk dan diskonnya berubah-ubah. Tujuannya adalah untuk menemukan tingkat diskon terbaik yang memaksimalkan transaksi pembelian.

---

Padahal laptop tersebut memiliki spek mumpuni dan berjalan di Ubuntu Linux OS. Secara teori, laptop ini harusnya sudah sangat oke untuk menjalankan berbagai komputasi yang rumit.

```
SPEK
Memory     : 16 Gb
Proc       : Intel Core i7 8 Core @ 1.8 GHz
Graphic    : Mesa Intel UHD Graphics
```

---

Saya masih lebih suka memacu pekerjaan yang berat ke _Google cloud server_ atau _server_ lainnya di kampus atau kantor.

Namun beberapa minggu ini, semua _server_ yang saya miliki sudah sangat penuh oleh pekerjaan masing-masing, mau tidak mau saya harus memaksa si laptop kantor untuk melakukan beberapa _multitasking_ komputasi menggunakan __R Studio__. 

> "Hitung-hitung melakukan _stress test_ terhadap laptop tersebut", _begitu pikir saya_.

---

## _Stress Test_

Pada beberapa hari lalu, saya membuka 3 _sessions_ __R Studio__ untuk melakukan:

### _Session_ I

Saya membuka _session_ __R Studio__ pertama untuk melakukan _webscraping_ menggunakan __RSelenium__ di `Google Maps`.

### _Session_ II

Saya membuka _session_ __R Studio__ kedua untuk melakukan _geocoding_ seratus ribu alamat menggunakan `Google Geocode API`. Jadi cara kerjanya:

1. Menembak alamat ke `Google Geocode API`.
1. Menerima _feedback_ dari `Google Geocode API`.
1. Merapikan data _feedback_ tersebut ke dalam bentuk _dataframe_.

### _Session_ III

Saya membuka _session_ __R Studio__ ketiga untuk membuat _report_ market riset kantor. Membuat tabulasi dari data yang membuat _markdown_ untuk _report_.

---

Jika membaca semua _session_ di atas, sebenarnya masing-masing _session_ masih bisa dikatakan pekerjaan dengan level _low to medium computation_. Sehingga saat ketiganya dijalankan, secara agregat belum bisa dimasukkan ke level _high computation_.

Jadi sebenarnya, laptop saya tersebut masih bisa digunakan untuk melakukan pekerjaan komputasi lain. Menurut saya, ini adalah keuntungan dari penggunaan Ubuntu Linux OS.