---
date: 2026-08-18T09:44:00-01:00
title: "Simulasi Triase IGD dengan library(simmer) di R"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Medis
  - Tenaga kesehatan
  - Teori Antrian
  - Simulasi
  - Rumah Sakit
  - Triase
---


Beberapa waktu lalu saya menulis tentang bagaimana [antrean di klinik bisa menjelaskan kenapa nakes jutek dan pasien marah](https://ikanx101.com/blog/nakes-simmer/), semuanya cuma gara-gara sistem antrean yang dipaksa jalan di atas kapasitasnya. 

Ada satu komentar dari pembaca yang terus mengganjal di kepala saya: 

> "Terus kalau di IGD bagaimana kondisinya? _Kan_ _nggak_ mungkin __FIFO__ (_first in, first out), siapa duluan sampai dilayani duluan?"

__Betul sekali__.

Di klinik, puskesmas, atau faskes sejenisnya, praktek __FIFO__ (_First In, First Out_) itu wajar dan cenderung adil: siapa yang datang duluan, dia yang dilayani duluan. Tapi coba bayangkan aturan itu diterapkan mentah-mentah di ruang gawat darurat. Ada pasien yang datang jalan sendiri karena kaki keseleo main futsal, mengantre normal di loket. Lalu lima menit kemudian datang pasien dengan nyeri dada hebat yang dicurigai serangan jantung. Kalau __FIFO__ diberlakukan apa adanya, si pasien jantung harus antre di belakang si kaki keseleo.

> Itu bukan lagi soal antrean yang tidak efisien, itu soal nyawa yang dipertaruhkan demi "keadilan" yang keliru.

Makanya IGD di seluruh dunia menerapkan **sistem triase**: pasien dipilah berdasarkan tingkat kegawatan (biasanya kode warna Merah, Kuning, Hijau), bukan berdasarkan siapa yang datang duluan. Secara matematis, ini artinya kita butuh model antrean dengan **prioritas**, bukan lagi antrean biasa. `library(simmer)` di R yang sudah saya gunakan pada artikel sebelumnya sanggup memodelkan ini dengan cukup rapi.

### Skenario Simulasi: IGD dengan 3 Dokter Jaga

Parameternya saya buat mirip dengan tulisan sebelumnya biar bisa dibandingkan, tapi dengan tambahan lapisan triase:

1. **Durasi Operasional:** 1 _shift_ jaga, 4 jam (240 menit).
2. **Kapasitas Dokter (_c_):** 3 dokter jaga IGD.
3. **Tingkat Kedatangan Pasien (λ):** Rata-rata 1 pasien datang setiap 3.5 menit, jauh lebih padat dibanding klinik / puskesmas karena IGD menampung kasus dari mana-mana.
4. **Komposisi Triase:** Dari seluruh pasien yang datang, 10% masuk kategori **Merah** (kritis), 30% **Kuning** (urgent), dan 60% **Hijau** (_non-urgent_). Proporsi ini saya ambil berdasarkan perkiraan dari pola umum kasus IGD di lapangan, bukan angka baku. Jika saya keliru, silakan dikoreksi.
5. **Waktu Pelayanan (μ) per Kelas:** Pasien Merah butuh penanganan paling lama karena kompleks (rata-rata 30 menit stabilisasi), Kuning rata-rata 15 menit, Hijau rata-rata 8 menit saja.
6. **Aturan Prioritas:** Pasien Merah bisa "menyerobot" dokter yang sedang menangani pasien Kuning atau Hijau. Pasien Kuning bisa menyerobot dokter yang sedang menangani Hijau. Pasien Hijau tidak bisa menyerobot siapa-siapa.

Poin nomor 6 inilah yang membedakan simulasi ini secara fundamental dari simulasi klinik sebelumnya. Di sana semua pasien setara di mata sistem. Di sini, sistem secara sengaja dan sadar memilih untuk tidak adil.

### Membuat _Script_ Simulasi dengan `library(simmer)` di **R**

```r
library(simmer)
library(dplyr)
library(ggplot2)

set.seed(2026)

# 1. Inisialisasi Environment Simulasi
env <- simmer("IGD")

# 2. Membuat Trajectory dengan cabang berdasarkan hasil triase
# Begitu pasien tiba, perawat triase langsung memutuskan kelasnya:
# 10% Merah, 30% Kuning, 60% Hijau
jalur_pasien <- trajectory("Jalur IGD") %>%
  branch(
    option = function() sample(1:3, 1, prob = c(0.1, 0.3, 0.6)),
    continue = c(TRUE, TRUE, TRUE),

    # --- Kelas Merah: kritis, prioritas tertinggi, boleh menyerobot ---
    trajectory("Merah") %>%
      set_attribute("kelas", 3) %>%
      set_prioritization(c(3, 3, FALSE)) %>%  # c(priority, preemptible, restart)
      seize("dokter", 1) %>%
      timeout(function() rexp(1, 1/30)) %>%
      release("dokter", 1),

    # --- Kelas Kuning: urgent, prioritas menengah ---
    trajectory("Kuning") %>%
      set_attribute("kelas", 2) %>%
      set_prioritization(c(2, 2, FALSE)) %>%
      seize("dokter", 1) %>%
      timeout(function() rexp(1, 1/15)) %>%
      release("dokter", 1),

    # --- Kelas Hijau: non-urgent, prioritas terendah ---
    trajectory("Hijau") %>%
      set_attribute("kelas", 1) %>%
      set_prioritization(c(1, 1, FALSE)) %>%
      seize("dokter", 1) %>%
      timeout(function() rexp(1, 1/8)) %>%
      release("dokter", 1)
  )

# 3. Setup Resource dan Generator
# preemptive = TRUE wajib diset, kalau tidak, prioritas hanya menentukan
# urutan antre, bukan hak untuk menyerobot dokter yang sedang bekerja
arrival_dist <- function() {
  if (now(env) > 240) return(Inf)
  rexp(1, 1/3.5)
}

env %>%
  add_resource("dokter", capacity = 3, preemptive = TRUE) %>%
  add_generator("pasien", jalur_pasien, arrival_dist, mon = 2)

# 4. Jalankan Simulasi
env %>% run(until = 1000)
```

### Bentuk Alur Triase Kalau Divisualisasikan

Sebelum masuk ke hasil simulasinya, ada satu kelebihan `simmer` yang sayang kalau dilewatkan: kita bisa memvisualisasikan _trajectory_ itu sendiri lewat _package_ pendampingnya: `simmer.plot`.

```r
library(simmer.plot)

plot(jalur_pasien)
```

Masalahnya, keluaran mentah `plot()` ini melabeli tiap _node_ dengan nama internal di `simmer` — `SetAttribute`, `SetPrior`, `Seize`, `Timeout`, dan `Release` yang sebenarnya cuma jargon nama _method_, bukan bahasa yang menjelaskan konteks _flow_ di IGD-nya. Jadi saya harus _relabel_ manual _nodes_-nya (strukturnya tetap persis mengikuti _trajectory_ yang sama, cuma teksnya saya ganti) supaya diagramnya benar-benar terbaca sebagai alur kerja triase, bukan sekadar diagram kode.

![Diagram alur triase pasien IGD berdasarkan kelas kegawatan](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post17_nakes/plot-trajectory-igd.png)

Begitu pasien tiba, perawat triase menentukan kelasnya sesuai poin 6: 10% Merah, 30% Kuning, 60% Hijau. Ketiga jalur itu strukturnya identik, yakni: tentukan prioritas, "rebut" dokter, ditangani, dokter lalu "dilepas". 

Pembedanya cuma tiga hal: 

- Angka prioritasnya (3, 2, 1), 
- Aturan boleh-tidaknya menyerobot, dan 
- Rata-rata lama penanganannya (30, 15, 8 menit). 

Tiga perbedaan kecil itulah yang nanti menentukan siapa boleh menyerobot siapa begitu simulasi berjalan.

### Beban Kerja Dokter: Sama Sibuknya, Beda Ceritanya

Mari kita lihat dulu utilisasi dokter, sebagai pembanding dengan kasus klinik.

```r
data_dokter <- get_mon_resources(env) %>% filter(time <= 240)

ggplot(data_dokter, aes(x = time, y = server / capacity)) +
  geom_step(color = "#D9534F", linewidth = 1.2) +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1.1)) +
  labs(
    title = "Beban Kerja Dokter IGD (Utilisasi Kapasitas)",
    subtitle = "Dokter tetap sibuk penuh sepanjang shift, seperti kasus Puskesmas",
    x = "Waktu Berjalan (Menit)",
    y = "Tingkat Utilisasi",
    caption = "Simulasi simmer by ikanx101.com"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )
```

![Grafik utilisasi dokter IGD](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post17_nakes/plot-utilisasi-dokter.png)

Sejak menit ke-47, utilisasi dokter terkunci di 100% dan tidak pernah turun lagi sampai akhir _shift_. Total 179,4 menit dari 240 menit _shift_ (sekitar **75%** dari waktu _shift_) ketiga dokter bekerja tanpa jeda sedetik pun. **Sekilas, grafik ini terlihat mirip dengan kasus klinik: dokter yang sama-sama kelelahan, sama-sama bekerja seperti mesin.** Tapi di sinilah triase menunjukkan kelebihannya: utilisasi yang sama tinggi ini menyembunyikan cerita yang jauh lebih rumit tentang **siapa** yang harus menunggu.

### Waktu Tunggu per Kelas: Di Sinilah Triase Membuktikan Dirinya

```r
data_atribut <- get_mon_attributes(env) %>%
  filter(key == "kelas") %>%
  select(name, kelas = value)

data_pasien <- get_mon_arrivals(env) %>%
  mutate(waiting_time = end_time - start_time - activity_time) %>%
  left_join(data_atribut, by = "name") %>%
  mutate(kelas = factor(kelas, levels = c(1, 2, 3),
                         labels = c("Hijau", "Kuning", "Merah"))) %>%
  filter(start_time <= 240)

ggplot(data_pasien, aes(x = start_time, y = waiting_time, color = kelas)) +
  geom_point(alpha = 0.6, size = 2.5) +
  geom_smooth(method = "loess", se = FALSE, linewidth = 1.2) +
  scale_color_manual(values = c("Hijau" = "#5CB85C", "Kuning" = "#F0AD4E", "Merah" = "#D9534F")) +
  labs(
    title = "Triase Bekerja: Pasien Merah Tetap Cepat Dilayani",
    subtitle = "Tapi pasien Hijau menanggung beban antrean yang terus menumpuk",
    x = "Waktu Kedatangan Pasien (Menit ke-)",
    y = "Waktu Tunggu (Menit)",
    color = "Kelas Triase",
    caption = "Simulasi simmer by ikanx101.com"
  ) +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold"))
```

![Grafik waktu tunggu pasien per kelas triase](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post17_nakes/plot-waktu-tunggu-triase.png)

Grafik ini adalah inti dari seluruh tulisan ini. Dari 240 menit simulasi, ada 37 pasien Hijau, 15 pasien Kuning, dan 5 pasien Merah yang datang. Dan lihat bedanya:

- **Pasien Merah**: rata-rata waktu tunggu **0 menit**. Bukan dibulatkan, betul-betul nol. Setiap kali ada pasien kritis datang, dia langsung mendapat dokter, kalau perlu dengan cara menyerobot pasien Kuning atau Hijau yang sedang diperiksa. Persis seperti yang diharapkan dari sebuah IGD yang berfungsi dengan baik.
- **Pasien Kuning**: rata-rata menunggu **9,5 menit**, dengan median cuma **0.5 menit**. Artinya lebih dari separuh pasien Kuning nyaris tidak menunggu sama sekali. Tapi ada momen-momen "sial" di mana mereka harus menunggu sampai **39.8 menit**, biasanya ketika kebetulan ada pasien Merah yang datang tepat saat itu.
- **Pasien Hijau**: di sinilah semua beban akhirnya jatuh. Rata-rata waktu tunggu mereka **48.5 menit**, dengan titik terparah mencapai **108 menit** (nyaris dua jam). Lalu pola yang muncul sangat jelas: pasien Hijau yang datang di 60 menit pertama _shift_ hanya menunggu rata-rata **3.8 menit**, tapi begitu memasuki 60 menit terakhir _shift_, rata-rata waktu tunggu mereka melonjak jadi **84.4 menit**.

Bandingkan ini dengan grafik waktu tunggu di tulisan klinik sebelumnya. Di sana, semua pasien, apapun kondisinya, ikut terseret naik garis waktu tunggu yang sama karena semua diperlakukan setara oleh sistem FIFO. Di sini, triase secara sengaja memecah garis itu menjadi tiga nasib yang sangat berbeda. Pasien yang paling butuh pertolongan mendapat pertolongan tercepat. Pasien yang paling bisa menunggu, dipaksa menunggu paling lama.

Apakah ini adil? Secara waktu tunggu, jelas tidak. Tapi secara medis, ini justru **tujuan yang benar**. Triase tidak dirancang untuk membuat semua orang menunggu sama lama. Sistem ini dirancang untuk memastikan sumber daya yang terbatas mengalir dulu ke tempat yang paling membutuhkan. Ketidakadilan waktu tunggu di sini bukan _bugs_, melainkan fitur yang disengaja.

Meski begitu, angka 108 menit untuk pasien Hijau bukan berarti aman diabaikan. Dalam simulasi ini saya belum memodelkan kemungkinan pasien Hijau yang menyerah menunggu dan pergi begitu saja (istilahnya _balking_ atau _reneging_ dalam teori antrean) atau kemungkinan kondisinya memburuk selama menunggu sehingga naik kelas triase. Itu bahan simulasi lanjutan yang menarik untuk lain kali.

### Epilog: Ketidakadilan yang Disengaja, Bukan Ketidakadilan yang Gagal

Tulisan sebelumnya tentang klinik menyimpulkan bahwa sistem yang kelebihan beban akan membuat gesekan antar manusia jadi keniscayaan, karena semua pihak sama-sama jadi korban dari sistem yang gagal dirancang. Simulasi IGD ini menambahkan satu nuansa penting: **tidak semua antrean yang tidak setara itu buruk**.

Kalau tujuannya menyelamatkan nyawa dengan sumber daya terbatas, ketimpangan waktu tunggu antara pasien kritis dan pasien ringan bukan kegagalan sistem. Justru itulah buktinya sistem bekerja sesuai rancangan. Yang justru berbahaya adalah kalau sebuah sistem menerapkan aturan "adil" versi FIFO di tempat yang seharusnya butuh prioritas (seperti ilustrasi pasien jantung yang saya sebut di awal), atau sebaliknya, menerapkan prioritas di tempat yang seharusnya cukup FIFO saja (misalnya loket pendaftaran biasa yang dibuat berjenjang tanpa alasan medis, cuma karena "kenalan pejabat").

Pelajaran praktisnya untuk para pengelola faskes: sebelum menambah dokter atau nakes, pastikan dulu **desain prioritas antreannya sudah benar**. Sistem yang sama persis dari sisi kapasitas dan beban kerja bisa menghasilkan pengalaman pasien yang jauh berbeda, semata karena bedanya siapa yang diprioritaskan duluan.

Matematika tidak pernah berbohong, dan kali ini matematika juga mengajarkan kita bahwa adil itu bukan selalu berarti sama rata. Terkadang, adil berarti tahu betul siapa yang harus didahulukan.

Semoga tulisan ini bisa jadi pelengkap dari tulisan sebelumnya. 

---

`if you find this article helpful, support this blog by clicking the ads.`

