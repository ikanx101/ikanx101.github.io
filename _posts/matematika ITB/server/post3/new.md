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

  
![\\int\_1^2 x^2 dx = \\frac{x^3}{x}
|\_1^2](https://latex.codecogs.com/png.latex?%5Cint_1%5E2%20x%5E2%20dx%20%3D%20%5Cfrac%7Bx%5E3%7D%7Bx%7D%20%7C_1%5E2
"\\int_1^2 x^2 dx = \\frac{x^3}{x} |_1^2")
