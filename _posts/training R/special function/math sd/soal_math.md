Membuat Program Generator Soal Matematika untuk Anak SD
================

Saya masih ingat betul di bulan Maret 2020 saya mulai 100% WFH dan si
sulung 100% SFH. Seketika saya dan istri mau tak mau harus mengambil
alih peran gurunya di sekolah untuk mengajarkan semua materi mata
pelajaran yang ada di buku.

Salah satu materi di mata pelajaran matematika adalah **berhitung**,
yakni: penjumlahan, pengurangan, perkalian, dan pembagian. Seiring
dengan penambahan waktu, materi si sulung berkembang menjadi pengurutan
bilangan, operasi di pecahan, dan faktorisasi bilangan prima.

Bagi saya, mengajar dan memberikan evaluasi adalah dua hal yang berbeda.
Mengajar adalah proses *transfer knowledge* sehingga agak sulit untuk
dibuat menjadi otomatis. Berbeda dengan proses **memberikan evaluasi**.
Kita bisa membuatnya menjadi otomatis.

Atas dasar itu, saya mencoba membuat suatu program sederhana di **R**
yang berguna untuk membuat soal berhitung secara otomatis. Beberapa
bulan yang lalu, saya sempat menuliskan bagaimana membuat soal di **R**
di tulisan [berikut](https://ikanx101.com/blog/soal-berhitung/).
Sekarang saya tinggal mengembangkannya menjadi suatu program di mana
*user* mendapatkan soal, menjawabnya, dan menerima *feedback* atas
jawaban tersebut.

Proses membuat programnya tidak serumit yang dibayangkan *kok*. Justru
relatif simpel dan mudah.

Jika rekan-rekan sempat membaca tulisan saya terkait [*computational
thinking*](https://ikanx101.com/blog/comp-think/), saya sempat *mention*
bagaimana proses dekomposisi dan *modular* akan sangat berguna saat kita
hendak membuat suatu model komputasi (dalam hal ini berupa program).

-----
