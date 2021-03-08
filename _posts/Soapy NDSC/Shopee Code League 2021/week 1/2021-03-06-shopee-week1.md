---
date: 2021-03-06T22:00:00-04:00
title: "Shopee Code League 2021 Week I: Data Analytics Competition"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Shopee
  - Matching
  - Automation
---


Kompetisi yang ditunggu-tunggu akhirnya sudah dimulai. **Shopee Code
League 2021** mempertandingkan `3` kategori lomba:

1.  *Data Analytics*,
2.  *Data Science*, dan
3.  *Programming*.

Ketiga kategori tersebut akan dilombakan pada pekan yang berbeda-beda.
Pada giliran pertama di pekan ini (**6 Maret 2021**), Shopee memberikan
masalah *data analytics*.

> Bagaimana masalahnya?

# Masalah

*Customer service* menjadi prioritas utama dan proses kritis bagi
Shopee. Penting bagi Shopee untuk menyelesaikan setiap masalah
*customer* dalam waktu singkat dan tidak membuat *customer*
**bolak-balik** menghubungi Shopee.

Shopee menginginkan agar *customer do less effort* hingga masalahnya
selesai. Oleh karena itu mereka menghitung suatu **KPI** yang disebut
*Repeat Contact Rate* (**RCR**).

*Customer* bisa menghubungi Shopee melalui berbagai layanan seperti
*livechat*, email, telepon, dan lainnya. Setiap layanan tersebut akan
secara otomatis membuat `ticket_id`. Masalah muncul saat *customer*
menggunakan berbagai layanan tersebut dengan informasi data diri
berbeda-beda (email dan nomor telepon) untuk menyelesaikan masalah yang
sama. Akibatnya muncul berbagai `ticket_id` padahal berasal dari
*customer* dan masalah yang sama.

Jadi, bagaimana caranya agar kita bisa mengidentifikasi dari `500.000`
ribu baris `ticket_id`, mana saja `ticket_id` yang sama?

# Contoh Soal

Misalkan saya memiliki data *contact* sebagai berikut:

| ticket\_id |    id | email            |  phone | order\_id | contacts |
| :--------- | ----: | :--------------- | -----: | --------: | -------: |
| A          |     0 | <Jhon@gmail.com> |     NA |      1234 |        5 |
| B          |     1 | NA               | 682211 |      1234 |        2 |
| C          | 34567 | <wick@gmail.com> | 682211 |        NA |        4 |
| D          | 78999 | <wick@gmail.com> |     NA |        NA |        3 |

Jika kita perhatikan secara seksama, sebenarnya semua *ticket* ini
berasal dari satu *customer* yang sama.

  - *Ticket* **A** dan **B** dihubungkan oleh `order id` yang sama.
  - *Ticket* **B** dan **C** dihubungkan oleh `phone` yang sama.
  - *Ticket* **C** dan **D** dihubungkan oleh `email` yang sama.

Oleh karena itu jika kita jumlahkan berapa banyak `contacts` yang
terjadi di seluruh *tikets*, didapatkan untuk satu *customer* ini
melakukan total `14` *contacts*.

Format jawaban yang diinginkan oleh Shopee untuk setiap baris customer
adalah berbentuk `ticket trace` per `id`. Sebagai contoh, untuk baris
pertama (`id` = 0), jawabannya adalah: `0-1-34567-78999,14`.

# *Dataset* yang Digunakan

Jadi persoalan pada pekan ini relatif simpel menurut saya. Hanya membuat
algoritma *matching*, bukan membuat model *machine learning*. Lantas
bagaimana *dataset* yang digunakan?

Shopee memberikan satu *file* berformat `.json` berisi `500.000`
`ticket_id`. Berikut adalah isi *file*-nya jika saya baca dengan
`library(jsonlite)`.

    ## [[1]]
    ## [[1]]$Id
    ## [1] 0
    ## 
    ## [[1]]$Email
    ## [1] "gkzAbIy@qq.com"
    ## 
    ## [[1]]$Phone
    ## [1] ""
    ## 
    ## [[1]]$Contacts
    ## [1] 1
    ## 
    ## [[1]]$OrderId
    ## [1] ""
    ## 
    ## 
    ## [[2]]
    ## [[2]]$Id
    ## [1] 1
    ## 
    ## [[2]]$Email
    ## [1] ""
    ## 
    ## [[2]]$Phone
    ## [1] "329442681752"
    ## 
    ## [[2]]$Contacts
    ## [1] 4
    ## 
    ## [[2]]$OrderId
    ## [1] "vDDJJcxfLtSfkooPhbYnJdxov"
    ## 
    ## 
    ## [[3]]
    ## [[3]]$Id
    ## [1] 2
    ## 
    ## [[3]]$Email
    ## [1] ""
    ## 
    ## [[3]]$Phone
    ## [1] "9125983679"
    ## 
    ## [[3]]$Contacts
    ## [1] 0
    ## 
    ## [[3]]$OrderId
    ## [1] ""
    ## 
    ## 
    ## [[4]]
    ## [[4]]$Id
    ## [1] 3
    ## 
    ## [[4]]$Email
    ## [1] "mdllpYmE@gmail.com"
    ## 
    ## [[4]]$Phone
    ## [1] ""
    ## 
    ## [[4]]$Contacts
    ## [1] 0
    ## 
    ## [[4]]$OrderId
    ## [1] "bHquEnCbbsGLqllwryxPsNOxa"

Format `.json` menghasilkan struktur data berupa
[*list*](https://ikanx101.com/blog/train-r-4/#struktur-data-di-r) di
**R**.

Bagi saya, akan mudah mengerjakannya jika diubah dulu strukturnya
menjadi *dataframe*. Hasilnya seperti ini:

| id | email                | phone        | contact | order\_id                 |
| -: | :------------------- | :----------- | ------: | :------------------------ |
|  0 | <gkzAbIy@qq.com>     |              |       1 |                           |
|  1 |                      | 329442681752 |       4 | vDDJJcxfLtSfkooPhbYnJdxov |
|  2 |                      | 9125983679   |       0 |                           |
|  3 | <mdllpYmE@gmail.com> |              |       0 | bHquEnCbbsGLqllwryxPsNOxa |

Lantas bagaimana cara mengerjakannya?

# Cara Mengerjakan

Sebenarnya untuk mengerjakannya saya hanya perlu melakukan data
*carpentry* dengan prinsip `tidyverse` untuk melakukan *hierarchical
filtering based on*: `email`, `phone` dan `order_id`.

Berbekal `dplyr` dan `stringr` saya membuat *function* sebagai berikut:

``` r
library(dplyr)
library(stringr)
cek = function(i){
  email_find = data_new$email[i]
  n_email_find = str_length(email_find)
  if(n_email_find > 0){
    d_1 = data_new %>% filter(email == email_find)
  } else(d_1 = data.frame())
  
  phone_find = data_new$phone[i]
  n_phone_find = str_length(phone_find)
  if(n_phone_find > 0){
    d_2 = data_new %>% filter(phone == phone_find)
  } else(d_2 = data.frame())
  
  order_id_find = data_new$order_id[i]
  n_order_id_find = str_length(order_id_find)
  if(n_order_id_find > 0){
    d_3 = data_new %>% filter(order_id == order_id_find)
  } else(d_3 = data.frame())
  
  final = rbind(d_1,d_2)
  final = rbind(final,d_3)
  final$ticket_id = i-1
  
  final = 
    final %>% 
    distinct %>%
    arrange(id) %>% 
    group_by(ticket_id) %>% 
    summarise(p1 = paste(id,collapse = "-"),
              p2 = sum(contact)) %>% 
    ungroup() %>% 
    mutate(`ticket_trace/contact` = paste(p1,p2,sep = ",")) %>% 
    select(-p1,-p2)
  
  return(final)
}
```

`data_new` merupakan hasil transformasi bentuk *list* ke *dataframe*
dari data soal yang diberikan.

# Hasil Perhitungan Saya

*Oh iya*, cara di atas hanya salah satu cara untuk menyelesaikan masalah
ini. *Feel free* jika teman-teman memiliki cara lain yang memiliki
performa yang lebih baik (*runtime* yang lebih cepat).

Berikut adalah *sample* dari jawaban saya:

| ticket\_id | ticket\_trace/contact  |
| ---------: | :--------------------- |
|          0 | 0,1                    |
|          1 | 1-2458-476346,5        |
|          2 | 2-348955,0             |
|          3 | 3,0                    |
|          4 | 4,2                    |
|          5 | 5-50,4                 |
|          6 | 6-38-32871-142067,10   |
|          7 | 7,1                    |
|          8 | 8-183160,5             |
|          9 | 9-13-343161,1          |
|     499989 | 388551-448689-499989,4 |
|     499990 | 204097-499990,2        |
|     499991 | 499991,0               |
|     499992 | 499992,2               |
|     499993 | 499993,4               |
|     499994 | 184208-499994,4        |
|     499995 | 499995,2               |
|     499996 | 499996,4               |
|     499997 | 499997,2               |
|     499998 | 121111-499998,5        |
|     499999 | 499999,0               |

# *Notes*

Buat teman-teman yang berminat kerja di *marketplace*, percayalah bahwa
masalah yang diberikan ini bisa melatih kemampuan berpikir dan *problem
solving* Anda.

Saya dan tim tidak mengikuti kompetisi *data analytics* karena hanya
komit untuk ikut kompetisi pada pekan depan (*data science*). Apalagi di
Sabtu siang yang syahdu kemarin, **Netflix** begitu menggoda.

---

`if you find this article helpful, support this blog by clicking the ads shown.`