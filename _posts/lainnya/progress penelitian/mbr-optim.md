Penelitian Thesis di Magister Sains Komputasi
================

Tidak terasa, saya sudah melalui satu tahun perkuliahan di magister
sains komputasi ITB. Pada tahun final ini, saya harus dengan segera
menyelesaikan topik penelitian agar bisa di-*submit* di jurnal ilmiah
bereputasi internasyenel.

Kali ini saya mau bercerita mengenai topik penelitian yang saya lakukan
dalam setahun terakhir ini.

------------------------------------------------------------------------

## Optimisasi pada *Supply Chain Management*

Hal yang menarik adalah, walaupun saya *market researcher* tapi saya
malah mengerjakan penelitian yang berhubungan dengan *supply chain
management* di pabrik. Tidak semua lini SCM yang saya kerjakan tapi
hanya pada *production planning* yakni proses *supplier selection*, *raw
material purchase*, dan *matching* antara *raw material* dan *finished
goods*.

Saya coba ceritakan ya…

### Masalah

Setiap perusahaan bisa menggunakan dua strategi terkait pemenuhan bahan
baku, yakni:

1.  *Single sourcing*; yakni hanya memiliki satu pemasok bahan baku
    saja. Proses produksi bisa terganggu jika pasokan dari *supplier*
    terganggu.
2.  *Multiple sourcing*; yakni memiliki lebih dari satu pemasok bahan
    baku. Hal yang krusial adalah memastikan kualitas bahan baku dari
    berbagai *suppliers* masih sesuai dengan standar yang dibutuhkan.

Jadi untuk memproduksi produknya, perusahaan saya menggunakan strategi
*multiple sourcing* untuk beberapa bahan baku utama. Masing-masing
*supplier* memiliki harga, *delivery time*, dan perjanjian kerja sama
yang berbeda-beda.

Jadi masalahnya adalah bagaimana menentukan jumlah *raw material* yang
harus dibeli dari masing-masing *supplier* lalu memasangkannya kepada
*finished goods* sesuai dengan kebutuhannya di setiap periode tertentu.

### Sains Komputasi

Lantas di mana letak **sains komputasi**-nya?

Untuk menyelesaikan masalah optimisasi tersebut, maka diperlukan model
komputasi (algoritma atau *computer codes*) agar masalah tersebut bisa
diselesaikan dengan cepat dan tepat.

------------------------------------------------------------------------

Terdengar simpel *yah*, tapi saya bisa pastikan masalah ini cukup
kompleks untuk dimodelkan dalam persamaan matematis - optimisasi.
