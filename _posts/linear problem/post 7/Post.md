Optimization Story: Membuat Jadwal Interviewer pada Central Location
Survey
================

Suatu saat, tim riset kami harus melakukan survey secara *central
location* dengan menyewa tempat di `3` lokasi *high traffic* yang
berbeda dalam satu rentang waktu tertentu selama `10` hari. Pada saat
tersebut, ada `12` orang *interviewer* yang akan kami libatkan.

Sebagai informasi, riset dimulai pada hari Senin (hari pertama). Pada
*weekdays*, setidaknya `1-2` orang *interviewer* harus *stand by* di
masing-masing tempat survey. Sedangkan pada saat *weekend*, setidaknya
ada `3-5` orang *interviewer* yang harus *stand by*.

Ada aturan tambahan yang kami buat waktu itu:

> Setiap *interviewer* sebisa mungkin bekerja maksimal 6 hari.

**Lantas, bagaimana cara kami mengatur jadwal mereka?**

-----

# *Problem*

Masalah *optimization* ini mirip-mirip dengan beberapa kasus
*scheduling* yang pernah saya tulis di blog yang lalu. Namun tentunya
agak sedikit lebih sulit. Kenapa?

> Kalau kita sadari, sebenarnya ada `3` dimensi penjadwalan yang ada di
> masalah ini.

Apa saja?

1.  Tanggal / hari
2.  *Interviewer*
3.  Lokasi

<!-- end list -->

    ## Contoh Tabel Jadwal

| interviewer\_ke | tempat\_ke | hari\_1 | hari\_2 | hari\_3 | hari\_10 |
| --------------: | ---------: | :------ | :------ | :------ | :------- |
|               1 |          1 |         |         |         |          |
|               2 |          1 |         |         |         |          |
|               3 |          1 |         |         |         |          |
|               4 |          1 |         |         |         |          |
|               1 |          2 |         |         |         |          |
|               2 |          2 |         |         |         |          |
|               3 |          2 |         |         |         |          |
|               4 |          2 |         |         |         |          |
|               1 |          3 |         |         |         |          |
|               2 |          3 |         |         |         |          |
|               3 |          3 |         |         |         |          |
|               4 |          3 |         |         |         |          |

Saya akan membuat jadwal seperti tabel di atas.

# Formulasi Matematika

## Definisi

Misalkan:

`i = 1,2,..,12` menandakan indeks *interviewer*.

`c = 1,2,3` menandakan indeks lokasi survey.

`h = 1,2,..,10` menandakan indeks hari / tanggal.

  - *Weekend* terjadi pada indeks hari ke `6` dan `7`.
  - *Weekdays* terjadi pada indeks selain `6` dan `7`.

Saya tuliskan
![x\[i,c,h\]](https://latex.codecogs.com/png.latex?x%5Bi%2Cc%2Ch%5D
"x[i,c,h]") berisi bilangan *binary* (`0` atau `1`) menandakan
*assignment interviewer*` i` di tempat `c` pada hari ke-`h`.

  - `0` menandakan *interviewer* tidak di\_assign\_ di tempat `c` pada
    hari ke-`h`.
  - `1` menandakan *interviewer* di\_assign\_ di tempat `c` pada hari
    ke-`h`.

## *Constraint*

### Hari *Weekdays*

Pada *weekdays* ada `1-2` orang yang *stand by* lokasi survey:

  
![ 1 \\leq \\sum\_{i=1}^{12} x\[i,c,h\]
\\leq 2](https://latex.codecogs.com/png.latex?%201%20%5Cleq%20%5Csum_%7Bi%3D1%7D%5E%7B12%7D%20x%5Bi%2Cc%2Ch%5D%20%5Cleq%202
" 1 \\leq \\sum_{i=1}^{12} x[i,c,h] \\leq 2")  

Untuk `h=1,2,3,4,5,8,9,10` dan `c=1,2,3`.

### Hari *Weekend*

Pada hari Sabtu dan Minggu, minimal ada `3` orang yang harus *stand by*.

  
![ 3 \\leq \\sum\_{i=1}^{12} x\[i,c,h\]
\\leq 5](https://latex.codecogs.com/png.latex?%203%20%5Cleq%20%5Csum_%7Bi%3D1%7D%5E%7B12%7D%20x%5Bi%2Cc%2Ch%5D%20%5Cleq%205
" 3 \\leq \\sum_{i=1}^{12} x[i,c,h] \\leq 5")  

Untuk `h=6,7` dan `c=1,2,3`.

### Satu Interviewer di Satu Tempat

Hal yang penting juga adalah memastikan bahwa setiap *interviewr* hanya
boleh ditugaskan tepat di satu lokasi di masing-masing harinya.

  
![ \\sum\_{c=1}^{3} x\[i,c,h\]
\\leq 1](https://latex.codecogs.com/png.latex?%20%5Csum_%7Bc%3D1%7D%5E%7B3%7D%20x%5Bi%2Cc%2Ch%5D%20%5Cleq%201
" \\sum_{c=1}^{3} x[i,c,h] \\leq 1")  

Untuk `i=1,2,..,12` dan `h=1,2,..,10`.

### Maksimal 6 Hari Kerja

Saya juga harus memastikan bahwa setiap interviewer harus mendapatkan
maksimal `6` hari kerja.

  
![ \\sum\_{c=1}^{3} \\sum\_{h=1}^{10} x\[i,c,h\]
\\leq 6](https://latex.codecogs.com/png.latex?%20%5Csum_%7Bc%3D1%7D%5E%7B3%7D%20%5Csum_%7Bh%3D1%7D%5E%7B10%7D%20x%5Bi%2Cc%2Ch%5D%20%5Cleq%206
" \\sum_{c=1}^{3} \\sum_{h=1}^{10} x[i,c,h] \\leq 6")  

Untuk `i=1,2,..,12`.

## *Objective Function*

Oke, sekarang untuk *objective function*-nya saya akan memaksimalkan:

  
![ \\sum\_{i=1}^{12} \\sum\_{c=1}^{3} \\sum\_{h=1}^{10}
x\[i,c,h\]](https://latex.codecogs.com/png.latex?%20%5Csum_%7Bi%3D1%7D%5E%7B12%7D%20%5Csum_%7Bc%3D1%7D%5E%7B3%7D%20%5Csum_%7Bh%3D1%7D%5E%7B10%7D%20x%5Bi%2Cc%2Ch%5D
" \\sum_{i=1}^{12} \\sum_{c=1}^{3} \\sum_{h=1}^{10} x[i,c,h]")  

Jadi alih-alih menghemat *budget* dengan meminimalisir kondisi, kami
justru ingin membuat *constraint* terpenuhi secara maksimal.

-----

# Hasil Optimal

## Beban Kerja per *Interviewer*

Berikut adalah banyaknya hari bekerja per masing-masing *interviewer*:

    ## Beban hari kerja per interviewer

| interviewer\_id | banyak\_hari\_bekerja |
| --------------: | --------------------: |
|               1 |                     6 |
|               2 |                     6 |
|               3 |                     6 |
|               4 |                     6 |
|               5 |                     6 |
|               6 |                     6 |
|               7 |                     6 |
|               8 |                     6 |
|               9 |                     6 |
|              10 |                     6 |
|              11 |                     6 |
|              12 |                     6 |

Kita bisa lihat bahwa semua *interviewer* mendapatkan beban hari kerja
yang sama, yakni pas di `6` hari.

## Jadwal Final

Berikut adalah jadwal finalnya:

    ## Jadwal Final

    ## Angka menunjukkan indeks interviewer yang bertugas di masing-masing
    ## tempat survey dan tanggal

| tempat\_survey | tgl\_1 | tgl\_2 | tgl\_3 | tgl\_4 | tgl\_5 | tgl\_6      | tgl\_7    | tgl\_8 | tgl\_9 | tgl\_10 |
| -------------: | :----- | :----- | :----- | :----- | :----- | :---------- | :-------- | :----- | :----- | :------ |
|              1 | 1,4    | 7,11   | 1,7    | 1,7    | 1,7    | 1,2,3,10,11 | 2,3,4,5,6 | 4,10   | 4,10   | 4,10    |
|              2 | 5,12   | 2,8    | 2,8    | 2,8    | 2,8    | 4,5,6,12    | 1,7,8,9   | 5,11   | 5,11   | 5,11    |
|              3 | 3,6    | 9,10   | 3,9    | 3,9    | 3,9    | 7,8,9       | 10,11,12  | 6,12   | 6,12   | 6,12    |
