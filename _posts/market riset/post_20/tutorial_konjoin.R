# TUTORIAL ANALISIS KONJOIN (CONJOINT ANALYSIS)
# ==============================================
# Tutorial ini akan menunjukkan analisis konjoin untuk produk minuman
# dengan atribut dan level yang telah ditentukan

# 1. SETUP DAN PERSIAPAN
# ======================

# Load library yang diperlukan
library(conjoint)    # Untuk analisis konjoin
library(ggplot2)     # Untuk visualisasi
library(dplyr)       # Untuk manipulasi data
library(tidyr)       # Untuk reshaping data

# 2. DEFINISI ATRIBUT DAN LEVEL
# =============================

# Definisikan atribut dan level produk minuman
atribut <- list(
  Rasa    = c('Manis', 'Sedikit_Manis', 'Tidak_Manis'),
  Ukuran  = c('250ml', '500ml', '1000ml'),
  Klaim   = c('Alami_100pct', 'Tanpa_Pengawet', 'Reguler'),
  Kemasan = c('Botol_Plastik', 'Botol_Kaca', 'Kotak_Karton'),
  Harga   = c('Rp4000', 'Rp7000', 'Rp12000', 'Rp18000')
)

# Tampilkan informasi atribut
cat("=== INFORMASI ATRIBUT PRODUK ===\n")
for (i in seq_along(atribut)) {
  cat(sprintf("%s: %s\n", 
              names(atribut)[i], 
              paste(atribut[[i]], collapse = ", ")))
}
cat("\n")

# Hitung total kombinasi yang mungkin
total_kombinasi <- prod(sapply(atribut, length))
cat(sprintf("Total kombinasi yang mungkin: %d\n", total_kombinasi))

# 3. DESAIN EKSPERIMEN
# ====================

# Gunakan fractional factorial design untuk mengurangi jumlah profil
# yang harus dievaluasi oleh responden

# Buat data frame untuk semua level
level_data <- expand.grid(atribut)
cat("Dimensi full factorial design:", dim(level_data), "\n")

# Gunakan AlgDesign untuk membuat fractional factorial design
library(AlgDesign)

# Buat desain dengan 16 profil (jumlah yang wajar untuk dievaluasi)
set.seed(123)  # Untuk reproduktibilitas

# Buat kandidat desain
candidate_design <- expand.grid(atribut)

# Pilih desain optimal dengan 16 profil
optimal_design <- optFederov(~., candidate_design, nTrials = 16)

# Ekstrak profil yang dipilih
profil_desain <- optimal_design$design
cat("\n=== PROFIL DESAIN YANG DIPILIH (16 PROFIL) ===\n")
print(profil_desain)

# 4. SIMULASI DATA RESPONDEN
# ==========================

# Simulasi data preferensi dari 50 responden
set.seed(456)
n_responden <- 50

# Buat matriks rating untuk setiap responden
rating_data <- matrix(NA, nrow = n_responden, ncol = nrow(profil_desain))

# Simulasi rating (skala 1-7, dengan 7 = sangat suka)
for (i in 1:n_responden) {
  # Setiap responden memiliki preferensi yang berbeda
  base_rating <- sample(3:5, 1)  # Rating dasar
  
  # Tambahkan variasi acak
  rating_data[i, ] <- round(runif(nrow(profil_desain), 
                                  base_rating - 1, 
                                  base_rating + 1))
  
  # Pastikan rating dalam range 1-7
  rating_data[i, ] <- pmin(pmax(rating_data[i, ], 1), 7)
}

# Konversi ke data frame
rating_df <- as.data.frame(rating_data)
colnames(rating_df) <- paste0("Profil_", 1:ncol(rating_data))

# 5. ANALISIS KONJOIN
# ===================

# Siapkan data untuk analisis konjoin
# Ubah profil desain ke format yang sesuai
profil_for_conjoint <- profil_desain

# Konversi faktor ke karakter
for (col in names(profil_for_conjoint)) {
  profil_for_conjoint[[col]] <- as.character(profil_for_conjoint[[col]])
}

# Lakukan analisis konjoin
cat("\n=== ANALISIS KONJOIN ===\n")

# Hitung utilitas (part-worth) untuk setiap level
conjoint_result <- caPartUtilities(rating_df, profil_for_conjoint, 
                                   z = 1, y = NULL)

# Tampilkan hasil utilitas
cat("\nUtilitas (Part-Worth) untuk setiap level:\n")
print(conjoint_result)

# 6. ANALISIS IMPORTANCE (TINGKAT PENTINGNYA ATRIBUT)
# ===================================================

# Hitung importance untuk setiap atribut
importance_result <- caImportance(rating_df, profil_for_conjoint)

# Tampilkan hasil importance
cat("\n=== TINGKAT PENTINGNYA ATRIBUT ===\n")
print(importance_result)

# 7. VISUALISASI HASIL
# ====================

# 7.1 Visualisasi Utilitas (Part-Worth)
# -------------------------------------

# Siapkan data untuk plotting utilitas
utility_long <- as.data.frame(conjoint_result)
utility_long$Level <- rownames(utility_long)

# Ekstrak atribut dari nama level
utility_long$Atribut <- gsub("_.*", "", utility_long$Level)
utility_long$Level_Name <- gsub(".*_", "", utility_long$Level)

# Plot utilitas untuk setiap atribut
p1 <- ggplot(utility_long, aes(x = Level_Name, y = V1, fill = Atribut)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ Atribut, scales = "free_x") +
  labs(title = "Utilitas (Part-Worth) untuk Setiap Level",
       x = "Level",
       y = "Utilitas",
       fill = "Atribut") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

print(p1)

# 7.2 Visualisasi Importance Atribut
# ----------------------------------

importance_df <- data.frame(
  Atribut = names(importance_result),
  Importance = as.numeric(importance_result)
)

p2 <- ggplot(importance_df, aes(x = reorder(Atribut, Importance), 
                                y = Importance, 
                                fill = Atribut)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Tingkat Pentingnya Atribut (Importance)",
       x = "Atribut",
       y = "Importance (%)") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_y_continuous(labels = scales::percent_format(scale = 1))

print(p2)

# 7.3 Visualisasi Market Simulation
# ---------------------------------

# Simulasi pasar dengan 3 produk kompetitor
produk_simulasi <- data.frame(
  Produk = c("Produk_A", "Produk_B", "Produk_C", "Produk_Kita"),
  Rasa = c("Manis", "Sedikit_Manis", "Tidak_Manis", "Manis"),
  Ukuran = c("500ml", "1000ml", "250ml", "500ml"),
  Klaim = c("Alami_100pct", "Tanpa_Pengawet", "Reguler", "Alami_100pct"),
  Kemasan = c("Botol_Plastik", "Botol_Kaca", "Kotak_Karton", "Botol_Kaca"),
  Harga = c("Rp7000", "Rp12000", "Rp4000", "Rp7000")
)

# Hitung utilitas untuk setiap produk
# (Dalam aplikasi nyata, ini akan dihitung dari model konjoin)
set.seed(789)
utility_simulasi <- data.frame(
  Produk = produk_simulasi$Produk,
  Utilitas = c(4.2, 3.8, 2.9, 4.5)  # Nilai contoh
)

# Hitung market share (dengan logit model)
utility_simulasi$ExpUtility <- exp(utility_simulasi$Utilitas)
total_exp <- sum(utility_simulasi$ExpUtility)
utility_simulasi$MarketShare <- utility_simulasi$ExpUtility / total_exp

p3 <- ggplot(utility_simulasi, aes(x = reorder(Produk, MarketShare), 
                                   y = MarketShare, 
                                   fill = Produk)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Simulasi Market Share",
       x = "Produk",
       y = "Market Share") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_y_continuous(labels = scales::percent_format())

print(p3)

# 7.4 Visualisasi Heatmap Preferensi
# ----------------------------------

# Buat heatmap untuk melihat pola preferensi
heatmap_data <- rating_df
rownames(heatmap_data) <- paste0("Responden_", 1:n_responden)

# Konversi ke format long untuk ggplot
heatmap_long <- heatmap_data %>%
  mutate(Responden = rownames(.)) %>%
  pivot_longer(cols = -Responden, names_to = "Profil", values_to = "Rating")

# Plot heatmap
p4 <- ggplot(heatmap_long, aes(x = Profil, y = Responden, fill = Rating)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                       midpoint = 4) +
  labs(title = "Heatmap Preferensi Responden",
       x = "Profil Produk",
       y = "Responden") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.text.y = element_text(size = 6))

print(p4)

# 8. ANALISIS LANJUTAN
# ====================

# 8.1 Segmentasi Responden
# ------------------------

# Gunakan clustering untuk segmentasi responden
set.seed(123)
kmeans_result <- kmeans(rating_data, centers = 3)

# Tambahkan segment ke data responden
segment_data <- data.frame(
  Responden = 1:n_responden,
  Segment = kmeans_result$cluster
)

# Analisis per segment
cat("\n=== SEGMENTASI RESPONDEN ===\n")
cat("Jumlah responden per segment:\n")
print(table(segment_data$Segment))

# 8.2 Analisis Trade-off
# ----------------------

# Analisis trade-off antara harga dan atribut lain
tradeoff_data <- data.frame(
  Harga = c(4000, 7000, 12000, 18000),
  Rata_Rating = c(
    mean(rating_data[, profil_desain$Harga == "Rp4000"]),
    mean(rating_data[, profil_desain$Harga == "Rp7000"]),
    mean(rating_data[, profil_desain$Harga == "Rp12000"]),
    mean(rating_data[, profil_desain$Harga == "Rp18000"])
  )
)

p5 <- ggplot(tradeoff_data, aes(x = Harga, y = Rata_Rating)) +
  geom_point(size = 3, color = "darkblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(title = "Trade-off: Harga vs Preferensi",
       x = "Harga (Rp)",
       y = "Rata-rata Rating") +
  theme_minimal()

print(p5)

# 9. REKOMENDASI PRODUK OPTIMAL
# =============================

# Cari kombinasi optimal berdasarkan utilitas tertinggi
optimal_combination <- list()
for (attr in names(atribut)) {
  # Cari level dengan utilitas tertinggi untuk setiap atribut
  utility_subset <- utility_long[utility_long$Atribut == attr, ]
  optimal_level <- utility_subset$Level_Name[which.max(utility_subset$V1)]
  optimal_combination[[attr]] <- optimal_level
}

cat("\n=== REKOMENDASI PRODUK OPTIMAL ===\n")
cat("Berdasarkan analisis konjoin, produk optimal adalah:\n")
for (attr in names(optimal_combination)) {
  cat(sprintf("%s: %s\n", attr, optimal_combination[[attr]]))
}

# 10. SIMPAN HASIL
# ================

# Simpan plot ke file
ggsave("utilitas_atribut.png", p1, width = 10, height = 6)
ggsave("importance_atribut.png", p2, width = 8, height = 6)
ggsave("market_share_simulasi.png", p3, width = 8, height = 6)
ggsave("heatmap_preferensi.png", p4, width = 12, height = 8)
ggsave("tradeoff_harga.png", p5, width = 8, height = 6)

# Simpan data hasil analisis
save(conjoint_result, importance_result, utility_simulasi,
     file = "hasil_analisis_konjoin.RData")

cat("\n=== TUTORIAL SELESAI ===\n")
cat("File telah disimpan:\n")
cat("1. tutorial_konjoin.R (skrip ini)\n")
cat("2. utilitas_atribut.png\n")
cat("3. importance_atribut.png\n")
cat("4. market_share_simulasi.png\n")
cat("5. heatmap_preferensi.png\n")
cat("6. tradeoff_harga.png\n")
cat("7. hasil_analisis_konjoin.RData\n")

# 11. PETUNJUK PENGGUNAAN
# =======================

cat("\n=== PETUNJUK PENGGUNAAN ===\n")
cat("1. Jalankan seluruh skrip dengan: source('tutorial_konjoin.R')\n")
cat("2. Untuk data nyata, ganti rating_data dengan data preferensi responden\n")
cat("3. Sesuaikan atribut dan level sesuai dengan produk yang diteliti\n")
cat("4. Gunakan hasil analisis untuk pengambilan keputusan produk\n")

# Informasi tambahan
cat("\n=== INFORMASI TAMBAHAN ===\n")
cat("Package yang digunakan:\n")
cat("- conjoint: untuk analisis konjoin\n")
cat("- ggplot2: untuk visualisasi\n")
cat("- dplyr & tidyr: untuk manipulasi data\n")
cat("- AlgDesign: untuk desain eksperimen\n")
cat("\nMetodologi:\n")
cat("1. Fractional factorial design untuk mengurangi jumlah profil\n")
cat("2. Analisis part-worth utilities untuk setiap level\n")
cat("3. Perhitungan importance untuk setiap atribut\n")
cat("4. Segmentasi responden menggunakan clustering\n")
cat("5. Simulasi market share untuk pengambilan keputusan\n")
