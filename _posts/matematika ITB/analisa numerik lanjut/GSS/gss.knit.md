---
title: "Metode Numerik: Mencari Akar Fungsi dengan Menggunakan Golden Ratio"
output: 
  github_document:
    pandoc_args: --webtex
---



Pada dua _posts_ sebelumnya, saya pernah menulis bagaimana metode [_bisection_](https://ikanx101.com/blog/metode-bisection/) dan metode [_Newton_](https://ikanx101.com/blog/newton_method/) untuk mencari akar dari suatu fungsi.

Salah satu kelemahan dari metode _bisection_ adalah _running time_. Salah satu kelemahan dari metode _Newton_ adalah harus mencari turunan dari fungsi yang dikerjakan $\frac{d}{dx}f(x)$.

> _Apakah ada metode yang cepat dan tidak memerlukan turunan?_

---

# _Golden Ratio_

Kalian semua pasti pernah mendengar tentang istilah [_golden ratio_](https://en.wikipedia.org/wiki/Golden_ratio). Konon katanya kesempurnaan dan keseimbangan di dunia itu mengikuti aturan _golden ratio_.

> Lantas apa hubungannya _golden ratio_ dengan pendekatan numerik untuk mencari akar persamaan?

Ada satu metode numerik bernama _Golden Section Search_ yang bisa dipakai untuk mencari __nilai minimum global__. Prinsipnya adalah sebagai berikut:

> Misalkan $f(x)$ disebut [_unimodal_](https://id.wikipedia.org/wiki/Modus_(statistika)) pada selang $I = [a,b]$, jika terdapat sebuah titik $p \in I$ sehingga $f(x)$ monoton turun murni pada $[a,p]$ dan monoton naik murni pada $[p,b]$.

Dari definisi diatas dimungkinkan suatu cara untuk mengidentifikasi bahwa fungsi $f(x)$ memiliki __minimum global tunggal__ di titik $p$, dengan tidak secara ___eksplisit___ melibatkan turunan fungsi. Jika diperhatikan dengan baik, diharapkan titik $p$ menjadi __titik terendah dari grafik fungsinya__ sehingga masalah ini menjadi __masalah minimisasi__.

Jadi proses optimisasi bisa dimodifikasi untuk menghitung akar persamaan.

Sekarang permasalahannya adalah menentukan di mana letak titik $p$. Nah, si _golden ratio_ masuk di tahap ini untuk menentukan dimana letak si titik $p$.

---

# Cara Kerja _Golden Section Search_

Dari selang $[a,b]$ yang ada, akan dicari dua titik baru $(c,d)$ yang berada di dalam selang dengan menggunakan rumus:

$$c = b - (b - a) / r$$

$$d = a + (b - a) / r$$

dengan $r$ adalah _golden ratio_.

$$r = \frac{1 + \sqrt5}{2} \simeq 0.618$$

Perhatikan bahwa $a < d < c < b$. Kita perlu cek nilai $f(a), f(c), f(d), f(b)$.

Perhatikan bahwa karena $f$ _unimodal_ maka $f(c)$ dan $f(d)$ masing-masing bernilai lebih kecil dari $max \{ f(a) , f(b) \}$. Perhatikan dua kondisi berikut ini:

1. Jika $f(c) \leq f(d)$ maka dari sifat _unimodal_, $f$ monoton naik di selang $[d,b]$ dan dengan demikian maka $p \in [a,d]$.
1. Jika $f(c) > f(d)$ maka dari sifat _unimodal_, $f$ monoton turun di selang $[a,c]$ dan dengan demikian maka $p \in [c,b]$.

Situasi di atas memungkinkan kita untuk __melakukan reduksi lebar selang pencarian__ untuk mencari titik $p$.

Algoritma iterasinya adalah sebagai berikut:

```
if f(c) <= f(d)
  b = d
  fb = fd
else
  a = c
  fa = fc
end
  c = a + r * (b-a) 
  fc = f(c) 
  d = a + (1-r)*(b-a) 
  fd = f(d)
```

Iterasi akan berhenti saat kita mendefinisikan _toleransi error max_ yang diperbolehkan. 

---

## Dari Optimisasi ke Mencari Akar

Terdapat hubungan antara masalah optimisasi ini dengan akar persamaan. Persamaan $f(x) = 0$ memiliki solusi $x$ jika fungsi objektif $F$ dari masalah optimisasi yang didefinisikan sebagai berikut:

- $F(x) = (f(x))^2$ memiliki nilai minimum global sebesar $0$.
- $F(x) = |f(x)|$ memiliki nilai minimum global sebesar $0$.
- $F(x) = - \frac{1}{a+ |f(x)|}$ memiliki nilai minimum global sebesar $-1$.


### Contoh {-}

Untuk fungsi $f(x) = x^3 - 10x^2 + 29x -20$ di $0 \leq x \leq 6$, tentukan semua akarnya dengan metode _Golden Section Search_ !

#### Jawab {-}

Mari kita buat dulu grafik fungsinya di selang tersebut:

<img src="gss_files/figure-gfm/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Kalau kita perhatikan, akar persamaan tersebut ada di selang $[0,2],[3.5,4.5].[4.5,6]$.

> Perlu saya ingatkan kembali, tujuan dari __GSS__ adalah mencari titik minimum global di selang tertentu.

Oleh karena itu, jika kita ingin mencari akar, maka kita harus ubah terlebih dahulu fungsinya mejadi $f'(x) = |f(x)|$. Berikut adalah grafiknya:

<img src="gss_files/figure-gfm/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Sekarang kita bisa mencari akarnya di selang $[0,2]$, yakni:


```r
rm(list=ls())

# definisikan r sebagai golden ratio
r = (1 + sqrt(5))/2
tol_max = 10^(-10)

# fungsi dari soal
f_awal = function(x){x^3 - 10*x^2 + 29*x -20}
f = function(x){abs(x^3 - 10*x^2 + 29*x -20)}

# initial
a = 0
b = 2

while(abs(b - a) > tol_max){
  c = b - (b - a) / r
  d = a + (b - a) / r
  
  if(f(c) < f(d)){
    b = d
    } else{
    a = c
    }
  
}

hasil = (a+b)/2
```

Akar pada selang tersebut adalah di $x =$ 1.

Sekarang saya akan bikin _function_-nya di __R__ untuk bisa mencari akar $x$ di selang lainnya.



Kita akan coba pada selang $[3.5,4.5]$ sebagai berikut:


```r
golden_ss(3.5,4.5,f)
```

```
## [1] 4
```

Selanjutnya pada selang $[4.5,6]$ sebagai berikut:


```r
golden_ss(4.5,6,f)
```

```
## [1] 5
```

Secara iterasi, _GSS_ memiliki _processing time_ yang lebih cepat.
