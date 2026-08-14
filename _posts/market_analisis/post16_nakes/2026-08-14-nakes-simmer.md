---
date: 2026-08-14T07:39:00-01:00
title: "Nakes yang Jutek dan Pasien yang Marah: Membedah Sistem Antrean Faskes dengan Discrete-Event Simulation di R"
categories:
  - Blog
tags:
  - R
  - Machine Learning
  - Artificial Intelligence
  - Medis
  - Tenaga kesehatan
  - dr. Gia
  - Deddy Corbuzier
  - Close the Door
  - Teori Antrian
  - Simulasi
  - BPJS
  - Rumah Sakit
---

Beberapa malam yang lalu, saya menonton _podcast_ Deddy Corbuzier dengan dokter Gia yang membahas tentang kasus yang sedang viral yang melibatkan kematian salah seorang pasien saat sedang menunggu tersedianya kamar perawatan di salah satu rumah sakit. 

> Hal yang membuat kasus ini menjadi viral dan berpolemik adalah saat ada beberapa tenaga kesehatan (dokter dan perawat) yang melontarkan komentar-komentar nirempati kepada pasien tersebut.

Dari sekian banyak topik yang dibicarakan, ada satu topik yang menurut saya menarik untuk ditelaah dan disimulasikan lebih lanjut. Topik tersebut tentang _burnout_ para tenaga kesehatan. Sedikit banyak topik ini juga sering seliweran di *timeline* media sosial saya.

Di satu sisi, ada rentetan keluhan dari pasien BPJS yang merasa diperlakukan kurang manusiawi, dilayani dengan wajah jutek, dan minim empati. Di sisi lain, para tenaga kesehatan (nakes) harus menghadapi puluhan hingga ratusan pasien per hari.

> Ketika ada dua pihak yang sama-sama merasa menjadi korban, biasanya masalah utamanya bukan pada karakter individu-individunya (nakes yang jahat atau pasien yang banyak menuntut), melainkan pada **sistem yang gagal**.

Secara spesifik, ini adalah masalah klasik dalam *Operations Research* yang disebut dengan **Queueing Theory** (Teori Antrean).

Daripada sekadar beropini, mari kita buktikan secara matematis. Kali ini, saya akan membuat simulasi fiktif menggunakan *Discrete-Event Simulation* (DES) di __R__. 

Kenapa DES? 

> Karena dengan metode ini, kita bisa melihat pergerakan antrean layaknya kejadian nyata dari menit ke menit, bukan sekadar melihat angka rata-rata yang statis.

Sebagai catatan, simulasi yang saya lakukan ini tidak _apple to apple_ dengan kasus yang sedang viral tersebut. Tapi simulasi ini sedikit banyak akan memberikan gambaran bagaimana sistem pelayanan dan antrian yang tidak mumpuni akan berdampak ke mana-mana.

## Skenario Simulasi: Klinik Fiktif yang Menuju Kehancuran

Misalkan ada sebuah klinik fiktif bernama __Klinik Sehat Selalu__. Berikut adalah beberapa parameter yang akan saya gunakan saat melakukan simulasi. Saya coba membuat beberapa parameter berdasarkan asumsi tertentu dan akan saya _set_ nilainya serealistis mungkin seolah-olah pada saat itu adalah hari yang sibuk di klinik:

1. **Durasi Operasional:** 1 *shift* kerja, anggaplah 4 jam nonstop (240 menit).
2. **Kapasitas Nakes ($c$):** Hanya ada 2 dokter yang bertugas melayani klinik tersebut.
3. **Tingkat Kedatangan Pasien ($\lambda$):** Rata-rata ada 1 pasien datang setiap 4 menit.
4. **Waktu Pelayanan ($\mu$):** Dokter butuh waktu rata-rata 10 menit per pasien untuk melakukan anamnesis, diagnosa, hingga meresepkan obat dengan layak. Perlu saya ingatkan kembali bahwa ini adalah waktu rata-rata. Waktu nyatanya bisa memiliki simpangan tertentu.

Secara matematis sederhana, 2 dokter x (60 menit / 10 menit) = __kapasitas maksimal hanya 12 pasien per jam__. Sedangkan pasien datang 15 orang per jam. 

Dari perhitungan sederhana ini, kita bisa menduga bahwa sistem ini *pasti* akan kolaps. Tapi seberapa parah kolapsnya? Mari kita simulasikan!

### Membuat *Script* Simulasi dengan `simmer` di __R__

Untuk simulasi ini, saya menggunakan `library(simmer)` yang sangat tangguh untuk memodelkan *event-based*, dipadukan dengan `ggplot2` untuk membuat visualisasinya.

```r
# Load library yang dibutuhkan
library(simmer)
library(dplyr)
library(ggplot2)

# 1. Inisialisasi Environment Simulasi
env <- simmer("Klinik_Pagi")

# 2. Membuat Trajectory (Perjalanan Pasien)
# Pasien datang -> antre nakes -> diperiksa (rata-rata 10 menit) -> selesai
jalur_pasien <- trajectory("Jalur Pemeriksaan") %>%
  seize("nakes", 1) %>%
  # Menggunakan distribusi eksponensial untuk waktu pelayanan (rata-rata 10 menit)
  timeout(function() rexp(1, 1/10)) %>%
  release("nakes", 1)

# 3. Setup Resource dan Generator
# Mengalokasikan 2 nakes, dan pasien datang dengan distribusi eksponensial (rata-rata 4 menit).
# Pendaftaran pasien baru ditutup begitu shift lewat 240 menit -- persis seperti klinik
# yang tutup pintu jam segini, tapi tetap menuntaskan pasien yang sudah kadung antre.
arrival_dist <- function() {
  if (now(env) > 240) return(Inf)
  rexp(1, 1/4)
}

env %>%
  add_resource("nakes", capacity = 2) %>%
  add_generator("pasien", jalur_pasien, arrival_dist)

# 4. Jalankan Simulasi
# Kita jalankan lebih lama dari 240 menit agar pasien yang sudah antre di detik-detik akhir
# tetap tuntas dilayani dan waktu tunggu mereka tidak "terpotong" begitu saja
set.seed(2026) # Seed diset agar hasilnya reproducible jika kalian mau coba sendiri
env %>% run(until = 1000)
```

Simulasi sudah selesai berjalan, mari kita ekstrak datanya dan buat grafiknya. Ada dua metrik yang ingin saya lihat, yakni: **Utilisasi Nakes** dan **Waktu Tunggu Pasien**.

Ada satu catatan kecil saat melakukan simulasi ini:

> Fungsi bawaan `simmer` untuk menghitung waktu tunggu ternyata cuma mencatat pasien yang *sudah selesai* diperiksa sampai simulasinya berhenti. Jadi kalau saya hentikan persis di menit ke-240, pasien yang telat datang dan masih mengantre di detik-detik akhir malah hilang dari data. Padahal justru merekalah yang paling lama menunggu!

Ibaratnya, ini seperti survei kepuasan pelanggan yang cuma menanyai orang yang sempat dilayani, lalu menyimpulkan "semua puas". Padahal yang paling kesal justru yang belum sempat dilayani sama sekali.

Makanya saya akali simulasinya menjadi: pendaftaran pasien baru saya tutup persis di menit ke-240 (persis seperti klinik yang menutup pintu), tapi dokternya tetap saya suruh "lembur" menuntaskan pasien yang sudah kadung antre. Dengan begitu, waktu tunggu semua pasien yang datang dalam satu _shift_ terhitung utuh, tidak ada yang terpotong.

### Mengapa Nakes Bisa Kehilangan Empati? (Analisis Utilisasi)

Pertama, mari kita lihat beban kerja dokter dari menit ke-0 hingga menit ke-240.

```r
# Ekstrak data resource, batasi hanya untuk jendela waktu 1 shift (0-240 menit)
data_nakes <- get_mon_resources(env) %>% filter(time <= 240)

# Plot Utilisasi Nakes
ggplot(data_nakes, aes(x = time, y = server / capacity)) +
  geom_step(color = "#D9534F", linewidth = 1.2) +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1.1)) +
  labs(
    title = "Beban Kerja Nakes (Utilisasi Kapasitas)",
    subtitle = "Sejak menit ke-20, dokter sibuk penuh ~84% dari sisa waktu shift",
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

![Grafik utilisasi nakes](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post16_nakes/plot-utilisasi-nakes.png)

Grafik di atas menunjukkan utilisasi kedua dokter naik ke 100% sejak menit ke-20, lalu sempat naik-turun tajam beberapa kali (dokter sempat kebagian jeda singkat setiap ada pasien yang selesai lebih cepat dari perkiraan). Tapi sejak menit ke-156, utilisasi terkunci di 100% dan **tidak pernah turun lagi sampai shift berakhir**. Artinya hampir 85 menit klinik penuh dengan pasien tanpa jeda sedetik pun. Secara keseluruhan, dokter bekerja pada utilisasi penuh selama kurang lebih 84% dari waktu sejak menit ke-20. Artinya apa? 

> Sepanjang sebagian besar _shift_, kedua dokter tersebut bekerja seperti mesin pabrik. Begitu satu pasien keluar dari ruangan, detik itu juga pasien berikutnya masuk. Tidak banyak waktu untuk rehat.

Dalam ilmu saraf dan ergonomi kognitif, empati membutuhkan cadangan energi mental yang besar. Otak manusia yang dipaksa mengambil keputusan klinis (yang menyangkut nyawa orang) secara beruntun dengan utilisasi mendekati 100% akan mengalami *cognitive fatigue*. Saat otak kelelahan, fungsi regulasi emosi di *prefrontal cortex* menurun. Nakes tidak menjadi "jutek" karena mereka jahat; mereka jutek karena secara biologis, baterai sosial dan empati mereka sudah habis.

### Mengapa Pasien Marah? (Analisis Waktu Tunggu)

Sekarang, mari kita lihat dari kacamata pasien.

```r
# Ekstrak data kedatangan pasien, batasi hanya untuk yang datang dalam 1 shift (0-240 menit)
data_pasien <- get_mon_arrivals(env) %>%
  mutate(waiting_time = end_time - start_time - activity_time) %>%
  filter(start_time <= 240)

# Plot Waktu Tunggu Pasien
ggplot(data_pasien, aes(x = start_time, y = waiting_time)) +
  geom_point(alpha = 0.5, color = "#5BC0DE", size = 3) +
  geom_smooth(method = "loess", color = "#2C3E50", linewidth = 1.5, se = FALSE) +
  labs(
    title = "Waktu Tunggu Pasien Meningkat Tajam",
    subtitle = "Pasien yang datang belakangan menunggu jauh lebih lama",
    x = "Waktu Kedatangan Pasien (Menit ke-)",
    y = "Waktu Tunggu (Menit)",
    caption = "Simulasi simmer by ikanx101.com"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )
```

![Grafik waktu tunggu pasien](https://raw.githubusercontent.com/ikanx101/ikanx101.github.io/master/_posts/market_analisis/post16_nakes/plot-waktu-tunggu-pasien.png)

Grafik kedua ini sangat menyedihkan. Pasien yang datang di 30 menit pertama menunggu rata-rata sekitar **10 menit** saja. Sistem sempat "bernapas" di pertengahan _shift_ (sekitar menit ke-100 hingga ke-150) ketika beberapa pasien kebetulan selesai diperiksa lebih cepat. Tapi begitu menit ke-150 terlewati, antrean menumpuk permanen: pasien yang datang di atas menit ke-200 harus menunggu rata-rata **35 menit**, dengan titik terparah mencapai hampir **47 menit** -- lebih dari 4 kali lipat waktu pemeriksaan itu sendiri.

> Ketika orang sedang sakit, duduk menunggu puluhan menit hingga hampir satu jam adalah sebuah siksaan. Wajar jika emosi mereka tersulut. Dan sayangnya, kepada siapa mereka akan melampiaskan amarah tersebut? Ya, kepada nakes yang kebetulan berhadapan langsung dengan mereka, nakes yang utilisasinya sudah mendekati 100% tadi.

Ada satu hal menarik dari grafik ini yang jujur perlu saya akui: keadaannya tidak melorot mulus dari awal sampai akhir. Di pertengahan _shift_, sempat ada jeda di mana antrean terlihat "membaik". Namanya juga kejadian acak, kadang keberuntungan berpihak sebentar. Tapi jangan salah sangka: selama pasien yang datang tetap lebih banyak daripada yang sanggup ditangani dokter, jeda itu cuma sementara. Cepat atau lambat antrean bakal menumpuk lagi. Ini juga jadi pengingat buat kita semua: jangan buru-buru menyimpulkan _"klinik ini kelihatannya nggak terlalu penuh kok"_ hanya dari mengamati sesaat. Kita perlu melihatnya dalam rentang waktu yang cukup panjang untuk menangkap pola aslinya.

### Epilog

Dari simulasi sederhana ini, kita bisa belajar bahwa perdebatan antara nakes vs pasien seringkali salah sasaran. Menyuruh nakes mengikuti _"Pelatihan Senyum dan Empati"_ tidak akan mengubah keadaan jika desain operasional rumah sakit / puskesmas / kliniknya memang sudah keliru dari awal.

Solusi berbasis *operations research* selalu berkutat pada perbaikan rasio antara $\lambda$ (kedatangan) dan $\mu$ (pelayanan):

1. **Mengontrol Kedatangan ($\lambda$):** Untuk beberapa kondisi yang memungkinkan (misal bukan di UGD), faskes bisa menerapkan sistem antrean *online* dengan kuota yang ketat per jam, bukan membiarkan semua pasien menumpuk di jam 7 pagi.
2. **Menambah Kapasitas ($c$):** Jelas, butuh lebih banyak tenaga medis pada jam-jam sibuk (*peak hours*).
3. **Mengefisienkan Layanan ($\mu$):** Jika waktu dokter banyak habis untuk mengetik rekam medis ke komputer, perbaiki sistemnya sehingga dokter bisa fokus 100% berinteraksi dengan pasien.

Matematika dan simulasi ini tidak pernah berbohong. Selama sistem dipaksa berjalan melampaui kapasitasnya, pergesekan antar manusia di dalamnya hanyalah sebuah keniscayaan yang tinggal menunggu waktu.


---

`if you find this article helpful, support this blog by clicking the ads.`