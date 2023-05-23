---
date: 2023-05-23T09:26:00-04:00
title: "Optimization Story: Mengatur Pekerjaan untuk Team Members"
categories:
  - Blog
tags:
  - Artificial Intelligence
  - Machine Learning
  - R
  - Modelling
  - Linear Programming
  - Binary Linear Programming
  - Optimization Story
  - Mixed Integer Linear Programming
  - Schedulling
---


Suatu hari, saya dihubungi oleh seorang rekan yang kerjanya nun jauh di
sana. Saya diminta menyelesaikan masalah yang dia hadapi sehari-hari
sebagai *leader* di tempatnya bekerja.

Permasalahan ini adalah tipikal permasalahan rutin yang selalu dihadapi
olehnya secara mingguan. Oleh karena dilakukan secara manual, lama-lama
prosesnya jadi mengganggu pekerjaannya yang lain.

Apa masalahnya? *Cekidot*.

# Masalah

Dalam suatu *workcenter*, terdapat 4 orang pekerja yang bekerja selama 4
hari kerja dalam seminggu. Jam kerja per harinya adalah selama 7 jam
saja. Dalam seminggu, ada banyak *request* pekerjaan yang masuk ke dalam
*workcenter* tersebut.

Contoh *request*-nya sebagai berikut:

| kegiatan    | waktu_kerja |
|:------------|------------:|
| kegiatan 1  |           2 |
| kegiatan 2  |           4 |
| kegiatan 3  |           4 |
| kegiatan 4  |           4 |
| kegiatan 5  |           6 |
| kegiatan 6  |           1 |
| kegiatan 7  |           2 |
| kegiatan 8  |           5 |
| kegiatan 9  |           6 |
| kegiatan 10 |           1 |
| kegiatan 11 |           2 |
| kegiatan 12 |           2 |
| kegiatan 13 |           4 |
| kegiatan 14 |           2 |
| kegiatan 15 |           5 |
| kegiatan 16 |           1 |
| kegiatan 17 |           4 |
| kegiatan 18 |           2 |
| kegiatan 19 |           3 |
| kegiatan 20 |           4 |
| kegiatan 21 |           1 |
| kegiatan 22 |           5 |
| kegiatan 23 |           5 |
| kegiatan 24 |           3 |
| kegiatan 25 |           5 |
| kegiatan 26 |           5 |
| kegiatan 27 |           1 |
| kegiatan 28 |           6 |
| kegiatan 29 |           4 |
| kegiatan 30 |           5 |
| kegiatan 31 |           3 |
| kegiatan 32 |           1 |
| kegiatan 33 |           5 |
| kegiatan 34 |           1 |
| kegiatan 35 |           5 |

Bagaimana caranya menyusun jadwal yang baik untuk masing-masing *team
member*?

Tentunya masalah ini termasuk ke dalam masalah optimisasi karena ada
tujuan untuk membuat jadwal yang terbaik. Artinya ada hal yang hendak
di-minimumkan atau di-maksimumkan.

------------------------------------------------------------------------

Tentunya sebelum kita mencoba membuat model dan menyelesaikan masalah
ini, kita perlu tahu terlebih dahulu apa saja aturan kerja yang ada di
*workcenter* rekan saya tersebut.

Berikut adalah beberapa aturan kerja yang berhasil saya korek:

1.  Setiap *request* yang muncul hanya boleh dikerjakan oleh satu orang
    *team member* saja.
2.  *Team member* diperbolehkan lembur maksimum 2 jam perhari. Namun
    hanya diperbolehkan seminggu sekali saja.
3.  Pekerjaan harus diselesaikan pada hari itu (tidak boleh terputus
    atau ganti hari).
4.  Pekerjaan yang memakan waktu
    ![\geq](https://latex.codecogs.com/png.latex?%5Cgeq "\geq") 4 jam
    sebisa mungkin disebar merata (tidak boleh hanya dikerjakan oleh
    orang yang itu-itu saja).

------------------------------------------------------------------------

Bagaimana membangun modelnya? Mari kita mulai.

*Oh iya*, berhubung rekan saya tidak memerlukan jadwal detail per jam,
maka saya akan buat model yang simpel (*output*-nya tetap bisa
menunjukkan siapa mengerjakan apa di hari ke berapa).

## *Decision Variable*

Saya definisikan indeks sebagai berikut:

- ![i = 1,..,4](https://latex.codecogs.com/png.latex?i%20%3D%201%2C..%2C4 "i = 1,..,4")
  sebagai pekerja.
- ![j = 1,..,4](https://latex.codecogs.com/png.latex?j%20%3D%201%2C..%2C4 "j = 1,..,4")
  sebagai hari.
- ![k = 1,..,30](https://latex.codecogs.com/png.latex?k%20%3D%201%2C..%2C30 "k = 1,..,30")
  sebagai *request*.

Misalkan
![x\_{ijk}](https://latex.codecogs.com/png.latex?x_%7Bijk%7D "x_{ijk}")
*binary*:

- ![x\_{ijk} = 1](https://latex.codecogs.com/png.latex?x_%7Bijk%7D%20%3D%201 "x_{ijk} = 1"),
  jika pekerja ![i](https://latex.codecogs.com/png.latex?i "i") pada
  hari ![j](https://latex.codecogs.com/png.latex?j "j") mengerjakan
  ![k](https://latex.codecogs.com/png.latex?k "k").
- ![x\_{ijk} = 0](https://latex.codecogs.com/png.latex?x_%7Bijk%7D%20%3D%200 "x_{ijk} = 0"),
  lainnya.

## Parameter

Dari informasi yang ada, parameter yang terlibat:

- ![T = 7](https://latex.codecogs.com/png.latex?T%20%3D%207 "T = 7")
  merupakan jam kerja maksimum.
- ![T\_{max} = 9](https://latex.codecogs.com/png.latex?T_%7Bmax%7D%20%3D%209 "T_{max} = 9")
  merupakan jam kerja lembur yang diperbolehkan 1 kali seminggu.
- ![t_k](https://latex.codecogs.com/png.latex?t_k "t_k") merupakan waktu
  kerja kegiatan ![k](https://latex.codecogs.com/png.latex?k "k").

## *Constraints*

Kita akan turunkan formula untuk *constraints* dari aturan kerja yang
ada.

**Pertama** Untuk setiap orang, untuk setiap hari, maksimum jam kerja
harian adalah 7 jam saja. Namun perlu diperhatikan bahwa seseorang
diperbolehkan lembur sekali seminggu.

Untuk mengakalinya:

- Kita akan pilih salah satu hari untuk lembur, misal saya notasikan
  ![\hat{j} \in j](https://latex.codecogs.com/png.latex?%5Chat%7Bj%7D%20%5Cin%20j "\hat{j} \in j").
- Hari “biasa” saya notasikan sebagai
  ![\bar{j} \in j](https://latex.codecogs.com/png.latex?%5Cbar%7Bj%7D%20%5Cin%20j "\bar{j} \in j").

Setelah saya bertanya kembali kepada rekan saya tersebut, ternyata untuk
pemodelan ini, saya bisa dengan mudahnya memilih nilai
![\hat{j}](https://latex.codecogs.com/png.latex?%5Chat%7Bj%7D "\hat{j}")
karena urutan ![j](https://latex.codecogs.com/png.latex?j "j") nya
menjadi **tidak masalah**.

![\forall i, \forall \bar{j} \sum\_{k} x\_{ijk} \times t_k \leq 7](https://latex.codecogs.com/png.latex?%5Cforall%20i%2C%20%5Cforall%20%5Cbar%7Bj%7D%20%5Csum_%7Bk%7D%20x_%7Bijk%7D%20%5Ctimes%20t_k%20%5Cleq%207 "\forall i, \forall \bar{j} \sum_{k} x_{ijk} \times t_k \leq 7")

![\forall i, \forall \hat{j} \sum\_{k} x\_{ijk} \times t_k \leq 9](https://latex.codecogs.com/png.latex?%5Cforall%20i%2C%20%5Cforall%20%5Chat%7Bj%7D%20%5Csum_%7Bk%7D%20x_%7Bijk%7D%20%5Ctimes%20t_k%20%5Cleq%209 "\forall i, \forall \hat{j} \sum_{k} x_{ijk} \times t_k \leq 9")

Namun perlu diperhatikan bahwa lembur diperlukan jika *team member*
tidak bisa menyelesaikan semua pekerjaan yang ada di *slot* hari lain.
Saya akan masukkan ini ke dalam *objective function*.

**Kedua** Untuk setiap pekerjaan hanya boleh dikerjakan oleh satu orang
*team member* saja.

![\forall k \sum\_{ij} x\_{ijk} = 1](https://latex.codecogs.com/png.latex?%5Cforall%20k%20%5Csum_%7Bij%7D%20x_%7Bijk%7D%20%3D%201 "\forall k \sum_{ij} x_{ijk} = 1")

**Ketiga** Pekerjaan yang memakan waktu
![\geq](https://latex.codecogs.com/png.latex?%5Cgeq "\geq") 4 jam sebisa
mungkin disebar merata (tidak boleh hanya dikerjakan oleh orang yang
itu-itu saja).

Dari data pekerjaan, kita bisa notasikan
![\hat{k}](https://latex.codecogs.com/png.latex?%5Chat%7Bk%7D "\hat{k}")
sebagai pekerjaan yang memiliki `waktu_kerja`
![\geq 4](https://latex.codecogs.com/png.latex?%5Cgeq%204 "\geq 4")
sebagai berikut:

![\forall \hat{k} \sum\_{ij} x\_{ijk} \times t_k \geq 0](https://latex.codecogs.com/png.latex?%5Cforall%20%5Chat%7Bk%7D%20%5Csum_%7Bij%7D%20x_%7Bijk%7D%20%5Ctimes%20t_k%20%5Cgeq%200 "\forall \hat{k} \sum_{ij} x_{ijk} \times t_k \geq 0")

## *Objective Function*

Meminimumkan jam kerja *team member*.

![\min \sum{(x\_{ijk} \times t_k) - 7}](https://latex.codecogs.com/png.latex?%5Cmin%20%5Csum%7B%28x_%7Bijk%7D%20%5Ctimes%20t_k%29%20-%207%7D "\min \sum{(x_{ijk} \times t_k) - 7}")

------------------------------------------------------------------------

# Solusi

Sekarang kita lihat solusi yang dihasilkan:

| orang | hari | pekerjaan | waktu_kerja |
|------:|-----:|----------:|------------:|
|     1 |    1 |         3 |           4 |
|     1 |    1 |         4 |           4 |
|     1 |    1 |        27 |           1 |
|     1 |    2 |        11 |           2 |
|     1 |    2 |        26 |           5 |
|     1 |    3 |         7 |           2 |
|     1 |    3 |        35 |           5 |
|     1 |    4 |         1 |           2 |
|     1 |    4 |        23 |           5 |
|     2 |    1 |         9 |           6 |
|     2 |    1 |        12 |           2 |
|     2 |    1 |        21 |           1 |
|     2 |    2 |        14 |           2 |
|     2 |    2 |        33 |           5 |
|     2 |    3 |        17 |           4 |
|     2 |    3 |        31 |           3 |
|     2 |    4 |        18 |           2 |
|     2 |    4 |        25 |           5 |
|     3 |    1 |        13 |           4 |
|     3 |    1 |        22 |           5 |
|     3 |    2 |         5 |           6 |
|     3 |    2 |        16 |           1 |
|     3 |    3 |        24 |           3 |
|     3 |    3 |        29 |           4 |
|     3 |    4 |        28 |           6 |
|     3 |    4 |        34 |           1 |
|     4 |    1 |         2 |           4 |
|     4 |    1 |        15 |           5 |
|     4 |    2 |         6 |           1 |
|     4 |    2 |        10 |           1 |
|     4 |    2 |        30 |           5 |
|     4 |    3 |         8 |           5 |
|     4 |    3 |        32 |           1 |
|     4 |    4 |        19 |           3 |
|     4 |    4 |        20 |           4 |

Kita lihat rekapannya sebagai berikut:

| orang | hari | total_jam |
|------:|-----:|----------:|
|     1 |    1 |         9 |
|     1 |    2 |         7 |
|     1 |    3 |         7 |
|     1 |    4 |         7 |
|     2 |    1 |         9 |
|     2 |    2 |         7 |
|     2 |    3 |         7 |
|     2 |    4 |         7 |
|     3 |    1 |         9 |
|     3 |    2 |         7 |
|     3 |    3 |         7 |
|     3 |    4 |         7 |
|     4 |    1 |         9 |
|     4 |    2 |         7 |
|     4 |    3 |         6 |
|     4 |    4 |         7 |

Terlihat bahwa tidak ada aturan yang dilanggar. Namun kita lihat pada
*team member* `4` di hari `3`, total jam yang dihasilkan berada di bawah
7 jam. Apakah memungkinkan jika kita paksakan agar menjadi `7` jam?

Kira-kira, mana yang bisa kita modifikasi?
