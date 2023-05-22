Optimization Story: Menyeimbangkan Workload untuk Team Members
================

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
| kegiatan 1  |           3 |
| kegiatan 2  |           1 |
| kegiatan 3  |           2 |
| kegiatan 4  |           1 |
| kegiatan 5  |           2 |
| kegiatan 6  |           3 |
| kegiatan 7  |           2 |
| kegiatan 8  |           6 |
| kegiatan 9  |           4 |
| kegiatan 10 |           1 |
| kegiatan 11 |           1 |
| kegiatan 12 |           6 |
| kegiatan 13 |           6 |
| kegiatan 14 |           5 |
| kegiatan 15 |           4 |
| kegiatan 16 |           5 |
| kegiatan 17 |           3 |
| kegiatan 18 |           4 |
| kegiatan 19 |           3 |
| kegiatan 20 |           4 |
| kegiatan 21 |           1 |
| kegiatan 22 |           5 |
| kegiatan 23 |           3 |
| kegiatan 24 |           3 |
| kegiatan 25 |           2 |
| kegiatan 26 |           2 |
| kegiatan 27 |           6 |
| kegiatan 28 |           1 |
| kegiatan 29 |           3 |
| kegiatan 30 |           6 |

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
    hanya diperbolehkan seminggu maksimum 2 kali lembur.
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
  merupakan jam kerja lembur yang diperbolehkan 2 kali seminggu.
- ![t_k](https://latex.codecogs.com/png.latex?t_k "t_k") merupakan waktu
  kerja kegiatan ![k](https://latex.codecogs.com/png.latex?k "k").

## *Constraints*

Kita akan turunkan formula untuk *constraints* dari aturan kerja yang
ada.

**Pertama** Setiap *request* yang muncul hanya boleh dikerjakan oleh
satu orang *team member* saja.

![\forall k \sum\_{ij} x\_{ijk} = 1](https://latex.codecogs.com/png.latex?%5Cforall%20k%20%5Csum_%7Bij%7D%20x_%7Bijk%7D%20%3D%201 "\forall k \sum_{ij} x_{ijk} = 1")

1.  *Team member* diperbolehkan lembur maksimum 2 jam perhari. Namun
    hanya diperbolehkan seminggu maksimum 2 kali lembur.
2.  Pekerjaan harus diselesaikan pada hari itu (tidak boleh terputus
    atau ganti hari).
3.  Pekerjaan yang memakan waktu
    ![\geq](https://latex.codecogs.com/png.latex?%5Cgeq "\geq") 4 jam
    sebisa mungkin disebar merata (tidak boleh hanya dikerjakan oleh
    orang yang itu-itu saja).

## *Objective Function*

Meminimumkan jam kerja *team member*.

![\min \sum{x\_{ijk} \times t_k}](https://latex.codecogs.com/png.latex?%5Cmin%20%5Csum%7Bx_%7Bijk%7D%20%5Ctimes%20t_k%7D "\min \sum{x_{ijk} \times t_k}")
