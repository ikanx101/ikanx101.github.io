---
date: 2026-09-05T10:19:00-01:00
title: "Agent-BAsed Modelling: Bagaimana Demonstrasi Berubah Menjadi Suatu Kerusuhan?"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - ABM
  - Agent Based Modelling
  - Simulasi
  - Komputasi
  - Kerusuhan
  - Demonstrasi
---

Beberapa hari lalu, kita melihat bahwa di sejumlah daerah di Indonesia terjadi demonstrasi bahkan ada yang berujung menjadi keributan di malam harinya.

> Awalnya demonstrasi berjalan seperti biasa saja. Sekelompok orang berkumpul, membawa spanduk, berorasi. Lalu sore berganti malam, tiba-tiba ketegangan naik, dan tidak butuh waktu lama sebelum video-video amatir membanjiri linimasa: asap, aksi pelemparan, dan orang-orang berlarian.

Ada satu hal yang menarik bagi saya, ___demonstrasi dengan tuntutan yang hampir sama bisa berjalan damai di satu kota, tapi bisa jadi "meledak" di kota lain___. Bedanya di mana? Apakah murni soal "ada provokator" atau "massa tidak tertib"? Atau ada pola yang lebih dalam yang bisa dijelaskan secara permodelan matematika?

> Sebagai orang yang berkecimpung di dunia data, saya selalu percaya: sebelum menyalahkan individu, mari kita lihat apakah __struktur sistemnya__ yang memungkinkan "ledakan" itu terjadi.

Untuk itu, saya mencoba membangun simulasi berbasis agen (*Agent-Based Model*, ABM). Model yang saya pakai adalah replikasi dari model terkenal **Joshua Epstein** tentang *civil violence* yang terbit di PNAS tahun 2002, lalu saya tambahkan satu variabel yang menurut saya tidak bisa diabaikan di tahun 2026, yaitu **media sosial**.

Buat yang sudah pernah baca tulisan saya soal [wabah campak](https://ikanx101.com/blog/wabah-campak/) atau [model perekonomian sederhana](https://ikanx101.com/blog/simple-economy/), ABM mungkin sudah tidak asing. Konsepnya sederhana: kita ciptakan "dunia mainan" berisi agen-agen otonom dengan aturan sederhana, lalu lihat pola apa yang muncul dari interaksi mereka. Pola itu sering kali tidak terduga dan di situlah letak pelajarannya.

> Oh iya, _disclaimer_ dulu. Saya bukan sosiolog, bukan politisi, juga bukan ahli hankam. Simulasi ini adalah **penyederhanaan yang sangat kasar** dari realitas yang saya bisa amati, dibuat untuk tujuan pemahaman konsep, bukan untuk memprediksi kejadian nyata. 

Tapi justru karena sederhana, model ini bisa menunjukkan mekanisme yang sering luput dari perdebatan di media sosial.

## Penjelasan Singkat Model Joshua Epstein

Perlu saya jelaskan bahwa Epstein yang saya bahas pada tulisan ini bukan Epstein yang sempat viral karena konspirasinya _yah_. _Beda orang_.

Model Epstein memandang kerusuhan sebagai __fenomena yang muncul dari keputusan individual__. Di dalam "dunia mainan" buatan saya (dunia simulasi seperti film __The Matrix__) ada tiga jenis entitas:

1. **Warga** (*citizens*): orang biasa yang bisa memilih ikut demo atau tidak.
2. **Polisi** (*cops*): aparat yang menangkap warga yang berdemo.
3. **Penjara**: status yang membuat warga "keluar dari permainan" sementara waktu.

Setiap warga membawa tiga atribut psikologis:

- **Grievance (G)**: tingkat ketidakpuasan/keluhan terhadap keadaan. Semakin tinggi, semakin ingin warga itu "turun ke jalan".
- **Risk aversion (R)**: seberapa takut warga terhadap risiko ditangkap oleh aparat.
- **Legitimacy (L)**: seberapa percaya warga pada rezim/pemerintah. Ini **satu nilai global** yang dirasakan semua warga.

pada setiap iterasi model (langkah waktu pada model), warga menghitung dua hal: 

- Seberapa berat "penderitaan" yang dirasakan, dan 
- Seberapa besar risiko yang dihadapi.

**Hardship (J) = G × (1 − L)**

> Semakin tinggi _grievance_ dan semakin rendah legitimasi, semakin berat beban yang dirasakan warga.

**Perceived risk (P) = 1 − exp(−k × jumlah polisi di sekitar / jumlah pendemo di sekitar)**

> Warga menilai risiko ditangkap dari perbandingan polisi vs pendemo di lingkungannya. Jika berdemo sendiri atau hanya sedikit massa-nya sedangkan polisinya banyak, maka orang-orang akan berpikir demo ini berisiko besar. Sedangkan jika demo dilakukan beramai-ramai maka risiko mengecil. Inilah yang disebut dengan efek "keselamatan dalam jumlah".

Aturan keputusannya cuma satu baris, dan ini bagian paling elegan dari model Epstein:

```
warga ikut demo jika:  G(1 − L) − R × P > T
```

Bahasa manusianya adalah: 

> Warga turun ke jalan jika **beban yang dirasakan** lebih besar daripada **ketakutan yang tertimbang risiko**. Kalau legitimasi pemerintah tinggi, (1 − L) kecil, beban terasa ringan, dan orang memilih tetap di rumah. Kalau legitimasi jeblok, beban terasa berat, dan hanya ketakutan yang menahan mereka untuk turun demo. TAPI ketakutan itu bisa luruh saat massa sudah ramai.

_Parameter default_ simulasi saya:

- _Grid_: 40 × 40 = 1.600 sel (sebuah "kota mainan").
- Kepadatan warga: 70% (≈ 1.120 orang), polisi: 4% (≈ 64 orang).
- Ambang aktivasi: T = 0,1.
- Masa hukuman: 30 langkah waktu (iterasi).

## Algoritma Simulasi

Bagian inti algoritmanya adalah sebagai berikut:

```
# setiap langkah waktu, untuk setiap warga:
hardship  = grievance * (1 - legitimacy)          # beban yang dirasakan
p_arrest  = 1 - np.exp(-k * cops_lokal / (rebels_lokal + 1))   # risiko tertangkap
net_risk  = risk_aversion * p_arrest              # ketakutan tertimbang

# satu baris keputusan:
ikut_demo = (hardship - net_risk) > threshold
```

Lalu untuk __ekstensi media sosial__, saya tambahkan mekanisme umpan balik:

```
# setiap kali ada penangkapan, ada peluang video "viral":
if penangkapan terjadi and random() < medsos_strength:
    grievance semua warga += spike          # informasi menyebar, amarah naik

# tapi grievance perlahan meluruh kembali:
grievance += (grievance_baseline - grievance) * decay
```

Logikanya adalah penangkapan bukan sekadar peristiwa hukum. Maksudnya, di era sekarang peristiwa tersebut adalah **konten**. Setiap kali polisi menangkap pendemo, ada kemungkinan video penyekapan/penangkapan tersebar luas, menaikkan kemarahan warga yang tadinya tidak ikut demo. Dan seperti semua emosi, kemarahan itu meluruh seiring waktu kecuali terus dipicu lagi.

Sekarang mari kita lihat apa yang keluar dari dunia mainan ini.

## Eksperimen 1: Legitimasi Tinggi vs Rendah

Skenario paling dasar: saya jalankan dua kota mainan yang identik, satu dengan legitimasi pemerintah 0.82 dan satu dengan 0.20.

![Perbandingan jumlah demonstran](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp1_timeseries.png)

Hasilnya kontras sekali:

- **L = 0.82**: kota tenang. Tidak ada satu pun warga yang turun ke jalan selama 600 langkah simulasi.
- **L = 0.20**: kerusuhan hampir permanen. Rata-rata sekitar **310 dari 1.120 warga** aktif berdemo setiap saat, dalam gelombang yang naik-turun.

Yang menarik, kerusuhan di L = 0.20 tidak pernah benar-benar berhenti. Ia berosilasi: massa ramai → polisi menangkap banyak → massa sedikit mereda → warga baru (yang tadi ragu-ragu) ikut turun karena melihat risiko mengecil → massa ramai lagi. Siklus ini muncul **tanpa ada "provokator" di dalam model**, murni dari interaksi warga, polisi, dan penjara.

![Snapshot akhir simulasi](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp1_snapshot.png)

![Animasi simulasi](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp1_animasi.gif)

Kalau dilihat animasinya, terlihat titik-titik merah (pendemo) "menyala" di sana-sini lalu menyebar — seperti api yang merambat ke rumput kering. Polisi biru berusaha memadamkan, tapi sumber apinya tidak pernah hilang.

Pelajaran pertama: **dalam model ini, legitimasi adalah rem utama.** Kalau remnya bagus, tidak ada yang perlu dipadamkan.

## Eksperimen 2: Phase Diagram — Mencari Titik Kritis

Pertanyaan berikutnya: di titik mana sebuah kota "berubah fase" dari tenang menjadi rusuh? Saya jalankan simulasi untuk 19 nilai legitimasi dari 0.05 sampai 0.95, dan ukur total "hari-demonstran" selama 600 langkah.

![Phase diagram legitimasi](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp2_phase_diagram.png)

Hasilnya adalah kurva yang sangat informatif:

- Di bawah L ≈ 0.45, kota berada dalam "fase rusuh": total aktivitas tinggi.
- Di atas L ≈ 0.75, kota "fase tenang": tidak ada aktivitas sama sekali.
- Di antara keduanya (**zona abu-abu**) kota tidak meledak, tapi juga tidak benar-benar damai. Di zona inilah guncangan kecil bisa berakibat besar.

Perhatikan angka-angkanya: menaikkan legitimasi dari 0.45 ke 0.50 memotong total aktivitas hampir 75% (dari ~52 ribu ke ~13 ribu hari-demonstran). Kenaikan sebesar 0.05 saja tapi memberikan efek yang dramatis. Ini bukan kurva linear tapi kurva dengan **efek ambang** (*threshold effect*).

> Dalam fisika, ini seperti es yang mencair: suhu naik sedikit di bawah 0°C tidak mengubah apa pun, tapi melewati 0°C semuanya berubah. Sistem sosial bisa punya titik kritis seperti itu dan itu kabar baik sekaligus buruk. 

- Buruk karena perbaikan kecil di bawah ambang terasa "tidak mempan". 
- Baik karena begitu melewati ambang, perubahan bisa datang cepat.

## Eksperimen 3: Apakah Menambah Polisi Menyelesaikan Masalah?

Sekarang saya pegang legitimasi tetap rendah (L = 0.45 yang menandakan kondisi yang masih sering rusuh) dan saya **lipatgandakan polisi**: dari 1% populasi sampai 20%.

![Efek menambah polisi](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp3_polisi.png)

Hasilnya? Menambah polisi memang **menekan** aktivitas pendemo. Dimulai dari ~67 ribu hari demo saat polisi 1% menjadi hanya sekitar ~13 ribu saat polisi 20%. 

> Lima kali lipat personel, aktivitas turun 80%. Terdengar bagus.

Tapi lihat garis hijau putus-putus: **menaikkan legitimasi dari 0,45 ke 0,55 — tanpa menambah satu polisi pun bisa menekan aktivitas sampai ~8,5 ribu**, lebih rendah dari hasil menambah polisi lima kali lipat.

> Inilah temuan kontra-intuitif yang terkenal dari model Epstein: **polisi menekan gejala, legitimasi menyembuhkan sumber.** Menambah polisi di tengah legitimasi rendah hanya membuat kota menjadi "penjara besar yang ramai": aktivitasnya kecil, tapi ketegangannya tetap ada dan yang paling berbahaya adalah kota tersebut siap meledak begitu ada pemicu.

Ada temuan berikutnya yang bisa memberikan kita _insights_ yang menarik. Perhatikan bahwa kurva polisi melandai: dari 12% ke 20% polisi, aktivitas hanya turun sedikit. Ini **diminishing returns**. Polisi pertama yang ditambah paling efektif kemudian polisi kesekian hanya memberi sedikit manfaat. Sementara itu, biaya politik dan fiskalnya terus naik (ini yang tidak digambarkan dalam model tapi terjadi secara nyata di lapangan).

## Eksperimen 4: Ekstensi Media Sosial sebagau Amplifier Kemarahan

Sampai di sini, model saya masih model Epstein "asli": _grievance_ warga statis. Tapi kita semua tahu realitas pada 2026 tidak begitu. Kemarahan bisa **dipicu** oleh informasi, terutama informasi yang viral.

Maka saya tambahkan ekstensi: setiap penangkapan punya peluang 50% untuk "viral" (menaikkan _grievance_ semua warga sebesar 0.02), dan _grievance_ meluruh 2% per langkah menuju _baseline_. Saya jalankan di zona abu-abu (L = 0.45) di mana kondisi kota sebenarnya masih terkendali tanpa medsos.

![Efek media sosial](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp4_medsos.png)

Hasilnya mengejutkan:

- **Tanpa media sosial**: rata-rata ~52 ribu hari-demonstran, dengan fluktuasi yang terkendali.
- **Dengan media sosial**: melonjak ke **~431 ribu hari-demonstran — sekitar 8 kali lipat**. Kerusuhan menjadi jauh lebih masif dan persisten.

![Perbandingan total](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post18_demo/images/exp4_bar.png)

Mekanismenya persis seperti yang saya duga: penangkapan → video viral → kemarahan naik → lebih banyak orang turun → lebih banyak penangkapan → lebih banyak konten. **Umpan balik positif.** Dalam istilah teknis, media sosial menaikkan _"gain"_ sistem. yaitu guncangan kecil yang tadinya mereda sendiri, sekarang diperkuat menjadi gelombang.

Ada satu temuan tambahan yang menarik: varians antar _run_ simulasi juga membesar drastis (lihat batang _error_ pada grafik). Artinya, dengan media sosial, hasil akhir sangat sensitif terhadap **keberuntungan**. Apakah video pertama viral atau tidak, apakah polisi bertindak tepat di depan kamera atau tidak. Kota yang sama bisa berakhir damai atau rusuh hanya karena perbedaan satu momen. Ini yang dalam ilmu kompleksitas disebut **sensitive dependence on initial conditions**.

## Apa yang Bisa Kita Pelajari?

Saya sadar ini cuma dunia simulasi. Tapi model sederhana seperti ini justru bagus untuk *memperjelas intuisi*. Menurut keyakinan saya, intuisi tersebut punya implikasi kebijakan yang konkret:

### Legitimasi adalah variabel kebijakan yang paling ampuh

Di semua eksperimen, perbaikan legitimasi mengalahkan penambahan represi. Legitimasi di sini bukan sekadar "popularitas pemimpin" tapi ia mencakup kepercayaan pada proses, penegakan hukum yang adil, dan rasa bahwa keluhan didengar. Kebijakan yang menaikkan legitimasi (transparansi, dialog, penanganan akar keluhan) adalah investasi pengamanan yang paling murah dalam jangka panjang.

### Waspadai zona abu-abu

Kota yang "biasa saja" (tidak terlalu rusuh, tidak terlalu tenang) adalah kota yang paling rentan terhadap guncangan. Di zona ini, peristiwa kecil (satu penangkapan yang dianggap tidak adil, satu kebijakan yang menyakitkan) bisa menjadi pemicu transisi fase. Pemerintah yang hanya melihat "angka demo masih kecil" bisa kecolongan: di sistem dengan efek ambang, ledakan tidak memberi peringatan linear.

### Polisi itu perlu, tapi ia bukan pengganti legitimasi

Menambah personel menekan angka, tapi dengan biaya yang meningkat dan hasil yang melandai. Lebih dari itu, represi yang berlebihan bisa menjadi *konten* yang memicu umpan balik negatif. Terutama jika penanganannya dianggap tidak proporsional dan profesional.

### Media sosial adalah _amplifier_, bukan penyebab tunggal

Di model saya, media sosial tidak menciptakan _grievance_ dari nol tapi memperbesar yang sudah ada. Kota dengan legitimasi tinggi (L = 0.82) tetap damai meski media sosial aktif; media sosial baru "berbahaya" ketika _grievance_ sudah tinggi dan legitimasi sudah rendah. Ini sejalan dengan pepatah lama: api hanya menyala kalau ada bahan bakarnya. Kebijakan yang fokus membatasi _platform_ tanpa menyentuh bahan bakar (_grievance_) hanya menunda, tidak menyelesaikan.

### Kecepatan informasi = kecepatan eskalasi

Dalam model, eskalasi terjadi karena informasi penangkapan menyebar lebih cepat daripada kemampuan sistem untuk meredamnya. Implikasinya: di era media sosial, **responden pertama krisis** (polisi, pemerintah daerah) harus berasumsi bahwa setiap tindakan akan dilihat semua orang dalam hitungan menit. Prosedur operasi yang mengabaikan tangkapan "lensa kamera _smartphone_" akan membayar mahal.

## Keterbatasan Model yang Perlu Diingat

Sebagai penutup bagian teknis, saya perlu menjelaskan limitasi dan asumsi dari model ini kepada rekan-rekan semua:

1. Semua warga dianggap sama (tidak ada tokoh, ormas, partai, atau kepentingan ekonomi).
2. Tidak ada geografi, tidak ada malam vs siang, tidak ada cuaca.
3. Media sosial dimodelkan sangat sederhana. Realitanya jauh lebih kompleks: ada algoritma, polarisasi, disinformasi, dan struktur jaringan.
4. Legitimasi di sini statis padahal di dunia nyata ia justru berubah justru karena peristiwa seperti demonstrasi.
5. Model ini **tidak bisa memprediksi** kapan dan di mana kerusuhan terjadi. Ia hanya membantu kita memahami mekanisme.

## Epilog

Kembali ke berita yang saya lihat beberapa hari lalu. Setelah membaca _output_ simulasi ini, cara saya membaca berita itu berubah sedikit. Saya jadi tidak terlalu fokus pada pertanyaan "siapa biang keroknya?" tapi berpindah ke sisi lain pertanyaan yang lebih struktural: 

> Seberapa rendah legitimasi yang dirasakan massa? Seberapa dekat ia dengan ambang? Dan seberapa cepat setiap insiden kecil berubah menjadi konten?

Karena kalau model Epstein (dan perpanjangannya) benar, maka kerusuhan bukanlah sebuah kebetulan, juga bukan semata ulah segelintir orang. Ia adalah **sifat dari sistem** yang berada di dekat titik kritisnya dan sistem seperti itu bisa menyala oleh percikan apa pun.

TAPI kabar baiknya adalah sistem bisa diubah (jika mau tentunya). Titik kritis bisa digeser. __Rem utama ada di legitimasi__. Dan hal ini bukan barang yang bisa dibeli dengan anggaran.

`if you find this article helpful, support this blog by clicking the ads.`





