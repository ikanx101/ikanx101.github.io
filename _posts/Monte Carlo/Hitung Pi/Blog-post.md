SIMULASI MONTECARLO: Menghitung Nilai Pi
================

Suatu ketika di salah satu sekolah dasar di kota Bekasi. Jam menunjukkan
pukul 11.50, sekitar 10 menit menuju jam pulang siswa. Sang guru
memberikan kuis matematika kepada murid-muridnya.

> Jika ada yang bisa menyelesaikan soal ini, boleh pulang duluan\!

Begitu ujarnya.

Lantas beliau menggambar sebuah lingkaran yang diberi keterangan
memiliki radius 7 cm di papan tulis. Soalnya: Hitung luas lingkaran
tersebut\!

Semua murid sudah hapal bahwa rumus luas lingkaran adalah:

  
![L = \\pi \*
r^2](https://latex.codecogs.com/png.latex?L%20%3D%20%5Cpi%20%2A%20r%5E2
"L = \\pi * r^2")  

Sebagian murid menggunakan ![\\pi =
\\frac{22}{7}](https://latex.codecogs.com/png.latex?%5Cpi%20%3D%20%5Cfrac%7B22%7D%7B7%7D
"\\pi = \\frac{22}{7}") sedangkan sebagian yang lain menggunakan ![\\pi
= 3.14](https://latex.codecogs.com/png.latex?%5Cpi%20%3D%203.14
"\\pi = 3.14").

Jadi timbullah dua jawaban:

1.  154 cm
2.  153.86 cm

Kedua nilai tersebut dibenarkan oleh sang guru. Murid-murid yang
menjawab salah satu dari kedua jawaban tersebut diperbolehkan pulang.

-----

# Pertanyaan Mendasar: Sebenarnya berapa nilai ![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi")?

Ada satu pertanyaan yang menggelayuti pikiran saya selama ini.

> Berapa sih nilai ![\\pi](https://latex.codecogs.com/png.latex?%5Cpi
> "\\pi") yang sebenarnya?

Sebagai orang yang pernah kuliah di jurusan matematika, saya mengetahui
fakta menarik bahwa ![\\pi](https://latex.codecogs.com/png.latex?%5Cpi
"\\pi") sejatinya bukanlah
![\\frac{22}{7}](https://latex.codecogs.com/png.latex?%5Cfrac%7B22%7D%7B7%7D
"\\frac{22}{7}").

Baik angka
![\\frac{22}{7}](https://latex.codecogs.com/png.latex?%5Cfrac%7B22%7D%7B7%7D
"\\frac{22}{7}") dan ![3.14](https://latex.codecogs.com/png.latex?3.14
"3.14") hanyalah aproksimasi dari nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi") yang
sebenarnya. *Gak* percaya? Dengan menggunakan nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi") yang ada di
*base* **R**, saya akan hitung selisihnya ke dua nilai aproksimasi
tersebut:

1.  ![\\pi - \\frac{22}{7}
    =](https://latex.codecogs.com/png.latex?%5Cpi%20-%20%5Cfrac%7B22%7D%7B7%7D%20%3D
    "\\pi - \\frac{22}{7} =") -0.0012645
2.  ![\\pi - 3.14
    =](https://latex.codecogs.com/png.latex?%5Cpi%20-%203.14%20%3D
    "\\pi - 3.14 =") 0.0015927

Setelah kita tahu bahwa sejatinya nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi") yang
sebenarnya berbeda dengan apa yang kita ketahui selama ini, lalu berapa
nilai sesungguhnya?

Apa ada cara menghitung nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi")?

## Cara Menghitung ![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi")

Bagi matematikawan, ada banyak cara menghitung nilai pi. Ada yang cara
deterministik dan ada cara probabilistik.

Kali ini saya akan mencoba menghitung nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi") dengan cara
kedua yakni dengan pendekatan simulasi MonteCarlo. Bagaimana cara
kerjanya? *Yuk* perhatikan dengan seksama.

### Lingkaran dengan ![r = 1](https://latex.codecogs.com/png.latex?r%20%3D%201 "r = 1")

Saya mulai dari lingkaran dengan ![r
= 1](https://latex.codecogs.com/png.latex?r%20%3D%201 "r = 1") berikut
ini:

<img src="Blog-post_files/figure-gfm/unnamed-chunk-1-1.png" width="672" />

Dari gambar di atas, luas area pada
![x](https://latex.codecogs.com/png.latex?x "x") di range
![\[0,1\]](https://latex.codecogs.com/png.latex?%5B0%2C1%5D "[0,1]")
saya tuliskan sebagai berikut:

  
![L1 = \\frac{1}{4} \* L\_{lingkaran} = \\frac{1}{4} \* \\pi \*
r^2](https://latex.codecogs.com/png.latex?L1%20%3D%20%5Cfrac%7B1%7D%7B4%7D%20%2A%20L_%7Blingkaran%7D%20%3D%20%5Cfrac%7B1%7D%7B4%7D%20%2A%20%5Cpi%20%2A%20r%5E2
"L1 = \\frac{1}{4} * L_{lingkaran} = \\frac{1}{4} * \\pi * r^2")  

  
![L1 = \\frac{1}{4} \* \\pi \* (1^2) = \\frac{1}{4} \*
\\pi](https://latex.codecogs.com/png.latex?L1%20%3D%20%5Cfrac%7B1%7D%7B4%7D%20%2A%20%5Cpi%20%2A%20%281%5E2%29%20%3D%20%5Cfrac%7B1%7D%7B4%7D%20%2A%20%5Cpi
"L1 = \\frac{1}{4} * \\pi * (1^2) = \\frac{1}{4} * \\pi")  

### Mencari Nilai ![L1](https://latex.codecogs.com/png.latex?L1 "L1")

Kunci untuk mencari nilai
![\\pi](https://latex.codecogs.com/png.latex?%5Cpi "\\pi") adalah dengan
menghitung ![L1](https://latex.codecogs.com/png.latex?L1 "L1").

> Bagaimana menghitung ![L1](https://latex.codecogs.com/png.latex?L1
> "L1")?

Untuk menghitungnya saya akan gunakan metode yang tidak biasa, yakni
dengan melakukan *generating random dots* di area ![x \\in
\[0,1\]](https://latex.codecogs.com/png.latex?x%20%5Cin%20%5B0%2C1%5D
"x \\in [0,1]") dan ![y \\in
\[0,1\]](https://latex.codecogs.com/png.latex?y%20%5Cin%20%5B0%2C1%5D
"y \\in [0,1]"). Setiap titik yang memenuhi persyaratan ![x^2 + y^2
\\leq 1](https://latex.codecogs.com/png.latex?x%5E2%20%2B%20y%5E2%20%5Cleq%201
"x^2 + y^2 \\leq 1") akan saya tandai sebagai `inner` dan diluar itu
akan saya tandai sebagai `outer`.

Perhatikan grafik di bawah ini:

<img src="Blog-post_files/figure-gfm/unnamed-chunk-2-1.png" width="960" />

Jika dilihat dari grafik di atas, semakin banyak *dots* yang saya buat,
semakin banyak area ![L1](https://latex.codecogs.com/png.latex?L1 "L1")
yang ter-*cover*. Luas ![L1](https://latex.codecogs.com/png.latex?L1
"L1") dapat saya tuliskan sebagai:

  
![L1 =
\\frac{count(dots\_{inner})}{count(all.dots)}](https://latex.codecogs.com/png.latex?L1%20%3D%20%5Cfrac%7Bcount%28dots_%7Binner%7D%29%7D%7Bcount%28all.dots%29%7D
"L1 = \\frac{count(dots_{inner})}{count(all.dots)}")  

Lalu: ![\\pi = 4 \*
L1](https://latex.codecogs.com/png.latex?%5Cpi%20%3D%204%20%2A%20L1
"\\pi = 4 * L1")

Berikut algoritma dan hasil perhitungan saya:

``` r
hitung_pi = function(n){
  x = runif(n)
  y = runif(n)
  data = data.frame(x,y)
  data =
    data %>%
    mutate(jatuh = x^2 + y^2,
           ket = ifelse(jatuh <= 1, 1,0))
  return(4 * sum(data$ket)/n)
}
```

<img src="Blog-post_files/figure-gfm/unnamed-chunk-4-1.png" width="672" />

Ternyata hasil perhitungan saya lebih akurat dibandingkan pendekatan
![\\frac{22}{7}](https://latex.codecogs.com/png.latex?%5Cfrac%7B22%7D%7B7%7D
"\\frac{22}{7}").
