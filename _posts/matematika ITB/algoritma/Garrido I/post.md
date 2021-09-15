Computational Thinking, Computational Science, dan Computational Model
================

Pada minggu-minggu awal perkuliahan pemrograman dalam sains, kami
diminta untuk merangkum satu buku yang akan dijadikan rujukan dalam
kuliah ini, yakni: ***INTRODUCTION TO COMPUTATIONAL MODELS WITH
PHYTON*** karya **Jose M. Garrido**.

<img src="MicrosoftTeams-image.png" width="25%" style="display: block; margin: auto;" />

Walaupun buku ini ditulis untuk bahasa *Python*, tapi pada **chapter I**
ini berlaku sangat *general* karena ditekankan pada *computational
thinking*.

Saya rasa sangat sayang jika rangkuman ini hanya ada di *drive* laptop
saja. Jadi saya akan coba *share* rangkumannya ditambah dengan beberapa
materi yang sudah saya pernah dapatkan dari sumber lainnya. Selamat
membaca.

------------------------------------------------------------------------

# *Problem Solving* dan *Computing*

## *Introduction*

Dalam hidupnya, manusia pasti akan berhadapan dengan masalah. Tidak
sedikit permasalahan yang membutuhkan penyelesaian secara komputasi
sedangkan otak manusia memiliki keterbatasan dalam melakukan komputasi
yang rumit. Oleh karena itu, mereka menciptakan suatu *tools* yang dapat
membantu mereka menyelesaikan masalah tersebut, salah satunya adalah
*computer solution* seperti *computer program*.

*Computer program* berisi data dan sekumpulan perintah berupa algoritma
untuk melakukan *well-defined tasks*.

*Computer program* pada dasarnya menjalankan *computational model*,
yakni implementasi dari model matematika yang diformulasikan untuk
mencari solusi permasalahan. Biasanya *computational model* membutuhkan
*resource* komputasi yang tinggi.

## *Computer Problem Solving*

*Problem solving* adalah proses membuat solusi komputer dari masalah
nyata. Hal yang paling menantang dari proses ini adalah memilih metode
yang tepat untuk menyelesaikan permasalahan tersebut.

Sebagai mana yang kita tahu ada istilah *no free lunch*, artinya metode
penyelesaian setiap permasalahan adalah *unique*[1].

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-2-1.png" alt="Proses Problem Solving"  />
<p class="caption">
Proses Problem Solving
</p>

</div>

Algoritma adalah sekumpulan baris perintah untuk melakukan suatu proses
komputasi dari suatu *data* input sehingga menghasilkan data *output*.
Algoritma bisa dituliskan dalam bentuk *pseudo-code* atau *flowcharts*.

Program komputer ditulis berdasarkan algoritma yang telah dibuat
sebelumnya dengan bahasa pemrograman tertentu.

## *Elementary Concepts*

Model adalah representasi dari sistem atau masalah. Bisa jadi model
hanya berisi bagian tertentu saja dari sistem atau masalah. Suatu model
bisa juga lebih sederhana dari masalah sebenarnya asalkan masih relevan
dalam beberapa aspek.

> Bagaimana cara kita membuat model tersebut?

Sebenarnya dalam membuat suatu model dari permasalahan yang ada,
prosesnya mirip dengan melakukan penelitian pada umumnya[2]. Setidaknya
ada beberapa tahapan sebagai berikut:

<div class="figure" style="text-align: center">

<img src="proses riset.png" alt="Flow Melakukan Research" width="100%" />
<p class="caption">
Flow Melakukan Research
</p>

</div>

Salah satu tahap kritis yang paling penting adalah tahapan pertama,
yakni **formulasi masalah**.

> *Salah dalam memformulasikan masalah akan menimbulkan masalah bagi
> keseluruhan penelitian.*

Di dalam *computational modelling*, formulasi masalah biasa disebut
dengan *abstraction*. *Abstraction* yang baik harus bisa mendapatkan
elemen esensial dari permasalahan atau sistem.

Setelah kita berhasil melakukan *abstraction*, kita harus mulai berpikir
bagaimana memformulasikan masalah tersebut dan mulai mencari solusi
komputasinya. Proses ini disebut dengan *computational thinking*.

Ada **empat pilar utama** dalam *computational thinking*:

1.  Dekomposisi.
    -   Memecah masalah besar ke masalah-masalah yang lebih kecil
        sehingga lebih bisa di-*manage*.
2.  *Pattern recognition*.
    -   Menganalisa dan melihat apakah ada pola atau pengulangan.
3.  *Algorithm design*
    -   Menuliskan langkah-langkah dalam bentuk formal.
4.  *Abstraction*
    -   Memisahkan mana yang *important*, mana yang *less important*.

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-4-1.png" alt="Elemen Computational Thinking"  />
<p class="caption">
Elemen Computational Thinking
</p>

</div>

Setelah kita memformulasikan masalah dan membuat modelnya, untuk
mendapatkan solusi kita bisa menempuh cara matematis. Sebagai contoh
kita bisa mencari solusi dari model *predator-prey*[3] dengan menurunkan
sendiri persamaan diferensial yang ada. Namun ada kalanya kita tidak
bisa melakukan hal tersebut sehingga perlu ada penyelesaian dengan
pendekatan numerik. Contoh sederhana adalah penggunaan Metode Newton
yang memanfaatkan *Taylor’s Series* dan iterasi untuk mendapatkan akar
suatu persamaan[4].

Dari sinilah muncul istilah *computational science* (sains komputasi).

> Sains komputasi menggabungkan komsep dan prinsip dari matematika dan
> *computer science* untuk diaplikasikan di bidang sains lain atau
> *engineering*.

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-5-1.png" alt="Integrasi Sains Komputasi"  />
<p class="caption">
Integrasi Sains Komputasi
</p>

</div>

## *Developing Computational Models*

<div class="figure" style="text-align: center">

<img src="Screenshot from 2021-09-01 09-39-52.png" alt="Development of Computational Models" width="50%" />
<p class="caption">
Development of Computational Models
</p>

</div>

*Computational model* dibangun secara iteratif. Maksudnya pada saat kita
membuat modelnya, perlu ada proses *fine tuning* (penyempurnaan)
berkelanjutan agar model tersebut bisa merepresentasikan masalah atau
sistem dengan baik.

<div class="figure" style="text-align: center">

<img src="Screenshot from 2021-09-01 09-50-50.png" alt="Model development and Abstract Levels" width="50%" />
<p class="caption">
Model development and Abstract Levels
</p>

</div>

## Contoh Kasus

Pada bagian ini saya sarikan contoh kasus yang ada pada buku, yakni:

1.  *Converter* Celcius ke Farenheit.
2.  Perhitungan luas dan keliling lingkaran.

Untuk memudahkan proses *summary*, saya akan gunakan *framework* sebagai
berikut:

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-8-1.png" alt="Framework Problem - Output" width="100%" />
<p class="caption">
Framework Problem - Output
</p>

</div>

### *Converter* Celcius ke Farenheit

#### *Initial Problem Statement*

Turis Eropa yang datang ke Amerika perlu mengetahui temperatur di
kotanya berkunjung. Mereka butuh informasi temperatur dalam Farenheit
sementara informasi temperatur yang ada dalam Celcius.

Dari *statement* di atas, kita masukkan ke dalam *framework* sebagai
berikut:

-   **Masalah**
    -   Turis Eropa biasa menggunakan unit Farenheit sedangkan di
        Amerika menggunakan unit Celcius. Mereka perlu mengetahui berapa
        suhu udara di kotanya berkunjung (dalam Farenheit) menggunakan
        informasi temperatur dalam Celcius.
-   **Tujuan**
    -   Melakukan konversi temperatur Farenheit ke Celcius.
-   ***Input***
    -   Informasi yang dimiliki saat ini adalah temperatur udara dalam
        Celcius, misal dinotasikan sebagai
        ![C](https://latex.codecogs.com/png.latex?C "C").
-   **Proses**
    -   Untuk melakukan konversi, saya akan membuat fungsi berikut ini:
        ![F = \\frac{9}{5}C + 32](https://latex.codecogs.com/png.latex?F%20%3D%20%5Cfrac%7B9%7D%7B5%7DC%20%2B%2032 "F = \frac{9}{5}C + 32").
-   **Output**
    -   Hasil akhir yang diharapkan adalah temperatur udara dalam unit
        Farenheit, yakni
        ![F](https://latex.codecogs.com/png.latex?F "F").

Secara *simple*, algoritmanya adalah sebagai berikut:

    INPUT C
    COMPUTE F = (9/5)*C + 32
    OUTPUT F

#### *Key Take Points*

Kasus ini adalah salah satu contoh kasus yang sangat *clear* dalam hal
komputasi (proses perhitungan) sehingga kita sudah tidak perlu lagi
melakukan *fine tuning* terhadap algoritma yang ada.

Untuk melakukan proses perhitungan, saya menggunakan fungsi matematis
hubungan antara ![F](https://latex.codecogs.com/png.latex?F "F") dan
![C](https://latex.codecogs.com/png.latex?C "C"). Fungsi matematis
inilah yang sudah kita pelajari di kalkulus.

### Perhitungan Luas dan Keliling Lingkaran

#### *Initial Problem Statement*

Hitung luas dan keliling lingkaran dari suatu lingkaran berjari-jari
![r](https://latex.codecogs.com/png.latex?r "r").

Dari *statement* di atas, kita masukkan ke dalam *framework* sebagai
berikut:

-   **Masalah**
    -   Menggunakan informasi berupa jari-jari
        ![r](https://latex.codecogs.com/png.latex?r "r"), kita harus
        menghitung luas dan keliling lingkaran.
-   **Tujuan**
    -   Menghitung luas lingkaran.
    -   Menghitung keliling lingkaran.
-   ***Input***
    -   Informasi yang dimiliki saat ini adalah jari-jari
        ![r](https://latex.codecogs.com/png.latex?r "r").
-   **Proses**
    -   Untuk menghitung luas, kita gunakan fungsi
        ![L = \\pi r^2](https://latex.codecogs.com/png.latex?L%20%3D%20%5Cpi%20r%5E2 "L = \pi r^2").
    -   Untuk menghitung keliling, kita gunakan fungsi
        ![K = 2 \\pi r](https://latex.codecogs.com/png.latex?K%20%3D%202%20%5Cpi%20r "K = 2 \pi r").
-   **Output**
    -   Hasil akhir yang diharapkan adalah luas
        ![L](https://latex.codecogs.com/png.latex?L "L") dan keliling
        ![K](https://latex.codecogs.com/png.latex?K "K").

Secara *simple*, algoritmanya adalah sebagai berikut:

    INPUT r
    COMPUTE L = pi * r^2
            K = 2 * pi * r
    OUTPUT L
           K

## Kategori *Computational Models*

Seperti halnya model matematika, ada dua pendekatan yang bisa digunakan
dalam membuat suatu fungsi, yakni:

1.  *Continuous model*
    -   Salah satu contoh dari model ini adalah model yang menggunakan
        persamaan diferensial.
2.  *Discrete model*
    -   Salah satu contoh dari model ini adalah pendekatan distribusi
        *Poisson*[5] untuk data gol tercipta dalam sebuah pertandingan
        sepakbola.

## *Software Life Cycle*

Dalam *software development*, kita bisa menggunakan *waterfall model*.
Maksudnya adalah fase berikutnya tidak boleh jalan sebelum fase
sebelumnya selesai.

<div class="figure" style="text-align: center">

<img src="Screenshot from 2021-09-01 11-54-45.png" alt="Waterfall Model" width="50%" />
<p class="caption">
Waterfall Model
</p>

</div>

Selain fase yang ada di *waterfall model*, ada fase lainnya yakni:

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-10-1.png" alt="Fase Lain dalam Sorftware Life Cycle" width="100%" />
<p class="caption">
Fase Lain dalam Sorftware Life Cycle
</p>

</div>

## *Design Modular*

Dalam membuat menghadapi suatu permasalahan yang kompleks, kita bisa
menggunakan analogi *chocolate bar*[6].

> *If you have to solve a complex problem, you will want to cut it in
> the smallest pieces as possible, until reaching the most elementary
> ones, and then expand them little by little to understand the overall
> problem.*

Di dalam buku ini istilah yang digunakan adalah *divide and conquer*.
Sejatinya permasalahan yang kompleks bisa dipecah menjadi
submasalah-submasalah kecil yang *manage-able*. Proses ini bisa kita
sebut sebagai *decomposition*.

Oleh karena itu, *abstraction* dan *decomposition* memegang peranan
penting dalam menyelesaikan masalah.

<div class="figure" style="text-align: center">

<img src="Screenshot from 2021-09-02 07-08-45.png" alt="Konsep Decomposition" width="100%" />
<p class="caption">
Konsep Decomposition
</p>

</div>

## Bahasa Pemrograman

Ada banyak bahasa pemrograman di dunia ini. Kita bisa memilih bahasa
mana yang sesuai dengan kebutuhan, tujuan, kemampuan, dan permasalahan
yang dihadapi. Sebagai contoh:

1.  Saat seseorang membutuhkan *output* berupa aplikasi mandiri
    (*executable file*), tentu dia tidak akan mempertimbangkan bahasa
    pemrograman MATLAB.
2.  Saat seseorang membutuhkan *output* hanya berupa *advance
    statistical analysis* dari data yang ada, tentu dia tidak akan
    mempertimbangkan bahasa pemrograman Java atau C.

Salah satu istilah dalam bahasa pemrograman yang sering kita dengar
adalah *high level programming language*. Apa artinya?

> *High level programming language* adalah bahasa pemrograman yang
> bersifat *problem oriented* dan bisa dijalankan tanpa ada keterbatasan
> di *hardware*.

Salah satu ciri lainnya adalah penggunaan skrip yang lebih mirip *human
language* dibandingkan *machine language*[7].

**R** dan *Python* merupakan salah satu contoh *high level programming
language* yang memiliki **IDE** beragam.

## Presisi, Akurasi, dan Galat

Seperti yang telah kita ketahui bersama, solusi yang dihasilkan dalam
*computational model* bisa berasal dari metode penyelesaian numerik.
Salah satu sifat dasar dari metode numerik adalah **aproksimasi**
(pendekatan). Oleh karena itu, kita harus mempertimbangkan galat
(*error*) yang ada yakni: akurasi dan presisi.

<div class="figure" style="text-align: center">

<img src="post_files/figure-gfm/unnamed-chunk-12-1.png" alt="Presisi, Akurasi, dan Galat" width="100%" />
<p class="caption">
Presisi, Akurasi, dan Galat
</p>

</div>

Kita bisa menggunakan beberapa definisi galat atau *error* tergantung
dengan kebutuhan. Setidaknya ada dua *error* yang biasanya digunakan:

-   *Error*: selisih antara *true value* dengan *approximate value*.

Secara matematis kita tuliskan:

![err = value\_{true} - value\_{approx}](https://latex.codecogs.com/png.latex?err%20%3D%20value_%7Btrue%7D%20-%20value_%7Bapprox%7D "err = value_{true} - value_{approx}")

-   *Relative error*: *ratio* dari *error* terhadap *true value*.

Secara matematis kita tuliskan:

![relative\_{err} = \\frac{err}{value\_{true}} = \\frac{value\_{true} - value\_{approx}}{value\_{true}}](https://latex.codecogs.com/png.latex?relative_%7Berr%7D%20%3D%20%5Cfrac%7Berr%7D%7Bvalue_%7Btrue%7D%7D%20%3D%20%5Cfrac%7Bvalue_%7Btrue%7D%20-%20value_%7Bapprox%7D%7D%7Bvalue_%7Btrue%7D%7D "relative_{err} = \frac{err}{value_{true}} = \frac{value_{true} - value_{approx}}{value_{true}}")

Salah satu kegunaannya adalah sebagai kriteria penghentian iterasi pada
saat kita menggunakan metode numerik tertentu.

#### Misalkan

Kita hendak mencari suatu akar persamaan menggunakan metode Newton. Kita
akan *set* terlebih dahulu berapa level akurasi yang masih bisa kita
terima sehingga proses iterasi bisa berhenti saat aproksimasi yang
dihasilkan sudah **sangat dekat** dengan solusi sebenarnya[8].

### Jenis-Jenis Galat

Berikut adalah beberapa jenis galat yang bisa terjadi saat kita
melakukan perhitungan numerik:

1.  *Iteration error*.
2.  *Approximation error*.
3.  *Roundoff error*.
    -   Yakni *error* yang tercipta akibat adanya pembulatan[9].
    -   Contoh:
        -   Nilai *exact* dari suatu variabel
            ![x = 1.0104074](https://latex.codecogs.com/png.latex?x%20%3D%201.0104074 "x = 1.0104074")
        -   Nilai hampiran atau pendekatannya adalah
            ![\\hat{x} = 1.0104](https://latex.codecogs.com/png.latex?%5Chat%7Bx%7D%20%3D%201.0104 "\hat{x} = 1.0104")
        -   Sehingga *error* yang tercipta adalah
            ![\\Delta = 1.0104074 - 1.0104](https://latex.codecogs.com/png.latex?%5CDelta%20%3D%201.0104074%20-%201.0104 "\Delta = 1.0104074 - 1.0104")

[1] *No free lunch*: <https://ikanx101.com/blog/no_free-lunch/>

[2] *Flow* melakuan penelitian: <https://ikanx101.com/blog/tujuan/>

[3] Contoh model persamaan diferensial yang terkenal:
<https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations>

[4] Metode Newton: <https://ikanx101.com/blog/newton_method/>

[5] <https://en.wikipedia.org/wiki/Poisson_distribution>

[6] <https://towardsdatascience.com/how-to-solve-complex-problems-efficiently-629c71adcd8d>

[7] <https://www.bbc.co.uk/bitesize/guides/z4cck2p/revision/1>

[8] <https://ikanx101.com/blog/newton_method/>

[9] <https://hithaldia.in/faculty/sas_faculty/Mrs_Sumana_Mandal/Lecture%20Note%20(M(CS)301%20&%20M(CS)401>).pdf
