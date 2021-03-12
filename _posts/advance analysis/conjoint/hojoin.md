Mengenal Conjoint Analysis untuk Development Produk atau Jasa
================

Ketika pertama kali saya bekerja di *market research agency* 2008 lalu,
*big boss* pernah bertanya kepada saya:

> ***Kang, kamu tahu Conjoint Analysis? Ada calon klien yang mau
> eksplorasi analisa ini.***

Istilah *conjoint analysis* masih sangat awam bagi saya waktu itu.

Singkat cerita, pada 2011 saat saya sudah bekerja di *multinational
market research agency*, salah satu provider telekomunikasi terbesar di
**Malaysia** hendak melakukan *conjoint analysis* untuk *developing*
beberapa produk baru mereka yang hendak ditargetkan kepada para TKI yang
bekerja di sana.

Itulah saat **pertama** dan **terakhir** kali saya menggunakan *conjoint
analysis* selama saya bekerja di *market research*.

-----

Mengutip dari halaman
[Wikipedia](https://en.wikipedia.org/wiki/Conjoint_analysis), *conjoint
analysis* adalah:

> ***Survey-based statistical technique used in market research that
> helps determine how people value different attributes (feature,
> function, benefits) that make up an individual product or service.***

Ada *keywords* yang hendak saya *highlight* dari definisi di atas:

1.  *How people value different attibutes?*
2.  *Product or service*.

Jadi analisa ini biasa dipakai saat suatu perusahaan sedang *developing
new product or service*.

Salah satu ciri analisa ini yang saya sukai adalah:

> ***Mampu melakukan analisa atribut yang terpenting secara implisit
> (tidak menanyakan langsung) atribut kepada responden.***

Bagaimana maksudnya? Saya berikan contoh sederhana melakukan *Conjoint
Analysis* dengan **R** berikut ini.

-----

## Contoh Kasus

Suatu perusahaan *smartphone* berencana untuk meluncurkan *smartphone*
varian terbarunya di akhir tahun ini. Namun mereka masih bingung
kira-kira fitur apa saja yang harus disematkan di *smartphone* tersebut.

Mereka sudah *list* beberapa alternatif pilihan fitur sebagai berikut:

1.  Fitur kamera utama, pilihannya:
      - `10 MP`
      - `15 MP`
      - `20 MP`
2.  Fitur *security*, pilihannya:
      - *Fingerprint*
      - *Face recognition*
      - *Fingerprint* dan *face recognition*
3.  Fitur *charging*, pilihannya:
      - *Fast charging*
      - *Wireless charging*

Fitur `kamera utama`, `security` dan `charging` selanjutnya akan disebut
***attributes***. Sedangkan pilihan-pilihan yang ada (misal `10 MP`, `15
MP`, …, *wireless charging*) akan disebut ***level***.

-----

Jika kita melakukan **survey biasa**, hal yang paling sering terjadi
adalah memberikan pertanyaan langsung (*direct question*) kepada
responden terkait seberapa penting masing-masing *attributes* dan
*level* mana yang mereka pilih.

Contohnya sebagai berikut:

1.  Dalam memilih suatu smartphone, dari ketiga aspek berikut ini:
    kamera, *security*, dan *charging*. Urutkan dari aspek yang **paling
    penting** ke aspek yang paling **tidak penting**\!
      - Urutan 1:
      - Urutan 2:
      - Urutan 3:
2.  Berapa spek ketajaman kamera yang Anda inginkan ada di *smartphone*
    pilihan Anda? (pilih salah satu)
      - `10 MP`
      - `15 MP`
      - `20 MP`
3.  Apa jenis fitur *security* yang Anda inginkan ada di *smartphone*
    pilihan Anda? (pilih salah satu)
      - *Fingerprint*
      - *Face recognition*
      - *Fingerprint* dan *face recognition*
4.  Apa jenis fitur *charging* yang Anda inginkan ada di *smartphone*
    pilihan Anda? (pilih salah satu)
      - *Fast charging*
      - *Wireless charging*

-----

Jika kita menggunakan *Conjoint Analysis*, kita tidak akan bertanya
*direct* kepada responden seperti pada cara sebelumnya. Lantas bagaimana
caranya?

> ***Kita akan memberikan beberapa alternatif pilihan produk untuk
> kemudian dipilih oleh responden.***

Responden bisa diminta untuk:

1.  Memberikan *ranking* (mengurutkan) alternatif produk mana yang
    **paling disukai** sampai yang **tidak disukai**.
2.  Memberikan *rating* (nilai) setiap alternatif produk yang
    ditanyakan.
3.  Memilih **satu saja alternatif produk** yang paling disukai.

Pertanyaannya adalah:

> ***Bagaimana caranya kita generate alternatif pilihan produk yang
> hendak ditanyakan?***

### Orthogonal

Perhatikan bahwa kita memiliki 3 *level* di *attribute* `kamera`, 3
*level* di *atribute* `security`, dan 2 *level* di *atribute*
`charging`.

Oleh karena itu, ada ![3 \* 3 \* 2
= 18](https://latex.codecogs.com/png.latex?3%20%2A%203%20%2A%202%20%3D%2018
"3 * 3 * 2 = 18") alternatif pilihan produk yang bisa ditawarkan sebagai
berikut:

| Alternatif | Kamera | Security                   | Charging |
| ---------: | :----- | :------------------------- | :------- |
|          1 | 10 MP  | fingerprint                | fast     |
|          2 | 15 MP  | fingerprint                | fast     |
|          3 | 20 MP  | fingerprint                | fast     |
|          4 | 10 MP  | face recog                 | fast     |
|          5 | 15 MP  | face recog                 | fast     |
|          6 | 20 MP  | face recog                 | fast     |
|          7 | 10 MP  | fingerprint and face recog | fast     |
|          8 | 15 MP  | fingerprint and face recog | fast     |
|          9 | 20 MP  | fingerprint and face recog | fast     |
|         10 | 10 MP  | fingerprint                | normal   |
|         11 | 15 MP  | fingerprint                | normal   |
|         12 | 20 MP  | fingerprint                | normal   |
|         13 | 10 MP  | face recog                 | normal   |
|         14 | 15 MP  | face recog                 | normal   |
|         15 | 20 MP  | face recog                 | normal   |
|         16 | 10 MP  | fingerprint and face recog | normal   |
|         17 | 15 MP  | fingerprint and face recog | normal   |
|         18 | 20 MP  | fingerprint and face recog | normal   |

Masalahnya adalah jika kita memberikan `18` alternatif produk ini kepada
responden untuk diberikan *ranking* atau *rating*, tentunya responden
akan pusing. Terlalu banyak pilihannya.

Lantas bagaimana memilih alternatif pilihan yang paling sedikit namun
tetap baik dari segi analisa statistik?

Di [aljabar](https://ikanx101.com/blog/kuliah-mat/#aljabar), ada satu
istilah bernama *orthogonal*.

> \_**Misalkan suatu vektor x dan y disebut orthogonal saat x dan y
> tegak lurus. Salah satu kegunaan kumpulan vektor orthogonal adalah
> dalam membuat basis suatu bidang atau ruang.**

Nah, dalam kasus *Conjoint Analysis*, pemilihan alternatif produk harus
dibuat sesedikit mungkin tapi harus *orthogonal* sehingga bisa dijadikan
basis per *attributes* untuk membangun produknya kelak.

Masih bingung *yah*? Boleh sambil *Googling kok*.

Berikut adalah `9` alternatif pilihan yang orthogonal:

|    | Kamera | Security                   | Charging |
| :- | :----- | :------------------------- | :------- |
| 2  | 15 MP  | fingerprint                | fast     |
| 4  | 10 MP  | face recog                 | fast     |
| 9  | 20 MP  | fingerprint and face recog | fast     |
| 10 | 10 MP  | fingerprint                | normal   |
| 12 | 20 MP  | fingerprint                | normal   |
| 14 | 15 MP  | face recog                 | normal   |
| 15 | 20 MP  | face recog                 | normal   |
| 16 | 10 MP  | fingerprint and face recog | normal   |
| 17 | 15 MP  | fingerprint and face recog | normal   |

## Install Packages

``` r
#print(round(cov(prof),5))
#print(round(cor(prof),5))
```

``` r
jawab = function(){
  sample(10,9,replace = T)
}

for(i in 1:10){
  nam = paste0("op",i)
  tes = jawab()
  assign(nam,tes)
}

responses = data.frame(op1,op2,op3,op4,op5,op6,op7,op8,op9,op10)
responses
```

    ##   op1 op2 op3 op4 op5 op6 op7 op8 op9 op10
    ## 1   3   9  10   7   1   4   2   9  10    9
    ## 2   4   4   3   7   2   4   5   2   5    8
    ## 3   4   8   2   5   2   9   6   5   4    1
    ## 4   9   4   5   8   3   9   3   6   4    7
    ## 5   5   1   9   1   3  10   7   9   2    1
    ## 6   4   6   1   9   8   3   4  10   9    9
    ## 7   2   9   7   2   3   3   8   5  10    6
    ## 8   4   5   4   2   8   8   8  10   1    7
    ## 9   2   6   7   3   8   4   5  10   9   10

``` r
#Conjoint(y=responses, x=prof, z=case_level)
```

``` r
#caSegmentation(y=responses, x=prof, c=3)
```
