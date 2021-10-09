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

## Ide Dasar

Ide dasar dari program ini adalah:

1.  Men-*generate* dua angka secara acak untuk kemudian dijadikan soal
    penjumlahan, pengurangan, pembagian, dan perkalian.
2.  Untuk soal pengurutan, di-*generate* 4-5 bilangan secara acak di
    suatu *range* bilangan tertentu.
3.  Untuk faktorisasi bilangan prima, kita bisa menggunakan algoritma
    yang pernah saya tulis di [tulisan
    ini](https://ikanx101.com/blog/algo-faktor/).

Masing-masing saya buat *functions* kecil-kecil. Setelah itu, semua
*functions* tersebut akan digabung ke dalam suatu *function* yang
berguna sebagai *user interface*.

Tingkat kesulitan soal juga bisa disesuaikan sesuai dengan kelas anak.
Kita bisa mengatur seberapa “besar” bilangan yang *randomly generated*.

-----

## Contoh *Function*

Untuk membuat keseluruhan program, kita akan mulai dari beberapa
*functions* kecil seperti *function* yang berfungsi untuk *generator*
soal. Sebagai contoh saya akan menjelaskan bagaimana cara kerja
*function* penjumlahan.

### Penjumlahan

Intinya adalah generate soal, cek jawaban *user*, dan catat waktu yang
dibutuhkan *user* untuk menjawab soal tersebut.

Berikut adalah *function* yang saya buat:

    penjumlahan = function(){
      bilangan = sample(50:5000,2,replace = F)
      kunci = sum(bilangan)
      
      soal = paste(bilangan,collapse = " + ")
      soal = paste0(soal," = ")
      
      start = Sys.time()
      jawab = readline(prompt = soal)
      jawab = as.numeric(jawab)
      end = Sys.time()
      waktu = end-start
      
      cek = jawab == kunci
      if(cek == T){cat("Kamu Benar!\n\n")}
      else {cat("Kamu Salah... Jawaban yang benar adalah: ",kunci,"\n\n")}
      
      output = list(waktu,cek)
      return(output)
    }
