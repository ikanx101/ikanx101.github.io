Membandingkan Runtime Integral Numerik Antara Prosesor Huawei dan Google
Virtual Machine
================

Pada *posting* [sebelumnya](https://ikanx101.com/blog/vm-cloud/), saya
telah menginformasikan cara menyewa *virtual machine* di *Google Cloud*
untuk berbagai keperluan. Untuk kasus saya, saya menggunakannya sebagai
*server* untuk melakukan komputasi atau mengerjakan kerjaan kantor
dengan bantuan **R**.

Setelah pemakaian selama hampir dua minggu, saya sangat puas dengan
performanya. Pada awalnya, saya mencoba untuk menyewa *server* **e2**
dengan **2 core** dan **2GB RAM** saja. Namun karena *free trial credit*
masih banyak, saya jadi tergoda untuk *upgrade* ke *server* yang lebih
tinggi. *FYI*, ternyata untuk *high performance compute nodes* tidak
tersedia di region Asia Tenggara. Jadi kalau kita hendak menyewa
*server* tersebut, kita hanya perlu mengganti *region* ke Eropa atau
Amerika atau Jepang (region Asia terdekat). Setelah mencoba berbagai
macam spek *server*, terakhir ini saya sedang memakai *server* dengan
spek **4 core** dan **16GB RAM**.

Sebagai gambaran, saya sudah mencoba *virtual machine* ini untuk:

1.  Melakukan *web scraping*. Percaya atau tidak, proses *web scraping*
    dengan **VM** jauh lebih cepat dibandingkan jika kita melakukannya
    di *local machine*. Saya menduga hal ini terjadi karena
    **transaksi** yang terjadi dilakukan antara *cloud to cloud*.
2.  Mengerjakan kerjaan kantor, yakni melakukan *data carpentry* dan
    membuat *report* dengan **R Markdown**. Walaupun saya menggunakan
    **R** versi **CLI** tapi semuanya *alhamdulillah* aman terkendali.
3.  Komputasi numerik. Saya melakukan uji coba untuk mengerjakan
    beberapa soal kuliah dengan beberapa algoritma numerik. *Runtime*
    yang dihasilkan cukup cepat. Seberapa cepat? Tentunya tidak bisa
    dibandingkan dengan laptop kantor saya. Kenapa? Karena laptop kantor
    saya punya spek yang lumayan tinggi (Intel i7 18 Ghz, 8 core dan 15
    GB RAM). Nah, *postingan* kali ini saya akan membahas terkait ini.

-----

## Komputasi Numerik

Apa sih komputasi numerik?

Secara simpel saya bisa definisikan komputasi numerik adalah proses
perhitungan iteratif yang digunakan untuk mencari solusi dari suatu
permasalah matematis dengan cara hampiran (aproksimasi). Jadi alih-alih
menurunkan rumus di atas kertas, kita gunakan bantuan komputer untuk
menghitungnya. Saya sudah pernah menuliskan beberapa contohnya di
*postings* sebelumnya.

Sekarang saya akan memberikan contoh sederhana perhitungan komputasi
numerik untuk menyelesaikan permasalahan integral sekaligus
membandingkan *runtime* algoritma tersebut saat dijalankan di *server
Google* dan tablet Huawei. Kenapa tablet Huawei? Sebagai mana yang saya
sempat ceritakan di *posting*-an yang lalu, saya sekarang sedang rajin
menggunakan tablet **Huawei T10s** sebagai *daily driver* untuk
menyelesaikan studi S2.

### Masalah Matematika

Oke, permasalahan matematika yang akan saya selesaikan adalah sebagai
berikut:

  
![\\int\_1^2 x^2
dx](https://latex.codecogs.com/png.latex?%5Cint_1%5E2%20x%5E2%20dx
"\\int_1^2 x^2 dx")  

Berapa nilainya?

Secara matematis, kita bisa menghitungnya dengan cara sebagai berikut:

  
![\\int\_1^2 x^2 dx = \\frac{x^3}{3} |\_1^2 = \\frac{2^3}{3} -
\\frac{1^3}{3}
\\simeq 2.3333](https://latex.codecogs.com/png.latex?%5Cint_1%5E2%20x%5E2%20dx%20%3D%20%5Cfrac%7Bx%5E3%7D%7B3%7D%20%7C_1%5E2%20%3D%20%5Cfrac%7B2%5E3%7D%7B3%7D%20-%20%5Cfrac%7B1%5E3%7D%7B3%7D%20%5Csimeq%202.3333
"\\int_1^2 x^2 dx = \\frac{x^3}{3} |_1^2 = \\frac{2^3}{3} - \\frac{1^3}{3} \\simeq 2.3333")  

### Algoritma Numerik

Ada berbagai macam algoritma numerik yang bisa digunakan untuk
menyelesaikan masalah di atas, salah satunya adalah algoritma berikut:

    mulai = Sys.time()
    
    n = 10^6
    a = 1
    b = 2
    h = (b-a)/n
    x = seq(a,b,h)
    
    f = function(x)x^2
    
    y = sapply(x,f)
    int = mean(y)
    
    print(paste0("Integral f(x) dx adalah: ",int))
    print(Sys.time()-mulai)

Algoritma di atas adalah algoritma integral numerik dengan metode
persegi. Saya menggunakan pendekatan *multi processing* di **R**. Hal
ini terlihat dari:

1.  Penggunaan `sapply()`,
2.  Operasi *array*,
3.  Tidak ada *looping* yang digunakan.

Kelak saya akan membandingkan *runtime* antara dua mesin yang saya
gunakan.

### *Runtime* Huawei

Berikut adalah spek Huawei T10s yang saya gunakan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post3/huawei.jpg)

Jika saya *run* saya dapatkan hasil sebagai berikut:

    "Integral f(x) dx adalah: 2.3333335"
    Time difference of 10.74728 secs

### *Runtime Google Virtual Machine*

Berikut adalah spek *Google virtual machine* yang saya gunakan:

![](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/matematika%20ITB/server/post3/google.jpg)

Jika saya *run* saya dapatkan hasil sebagai berikut:

    "Integral f(x) dx adalah: 2.3333335"
    Time difference of 1.37858 secs

## Kesimpulan

Ternyata terlihat dengan jelas bahwa *Google virtual machine* memiliki
*runtime* hampir **10%** dari *runtime* Huawei T10s.

Jika kalian membutuhkan *mobile server* yang bisa diandalkan, saya
merekomendasikan *Google virtual machine*.

-----

`if you find this article helpful, support this blog by clicking the
ads.`
