# TUTORIAL ANALISIS KONJOIN (CONJOINT ANALYSIS) DENGAN R
# ========================================================

rm(list=ls())

# 1. PERSIAPAN DAN LOADING PACKAGE
# --------------------------------

# Install package jika belum terinstall
# install.packages("conjoint")
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("tidyr")

# Load library yang diperlukan
library(conjoint)
library(ggplot2)
library(dplyr)
library(tidyr)

# 2. DEFINISI ATRIBUT DAN LEVEL
# -----------------------------

# Data atribut dan level sesuai permintaan
atribut <- list(
  Rasa    = c('Manis', 'Sedikit_Manis', 'Tidak_Manis'),
  Ukuran  = c('250ml', '500ml', '1000ml'),
  Klaim   = c('Alami_100pct', 'Tanpa_Pengawet', 'Reguler'),
  Kemasan = c('Botol_Plastik', 'Botol_Kaca', 'Kotak_Karton'),
  Harga   = c('Rp4000', 'Rp7000', 'Rp12000', 'Rp18000')
)

# Tampilkan struktur atribut
cat("STRUKTUR ATRIBUT DAN LEVEL:\n")
cat("============================\n")
for (i in seq_along(atribut)) {
  cat(names(atribut)[i], ":", paste(atribut[[i]], collapse = ", "), "\n")
}
cat("\n")

# 3. DESAIN EKSPERIMEN
# --------------------

# Hitung jumlah kombinasi total (full factorial)
n_kombinasi <- prod(sapply(atribut, length))
cat("Jumlah kombinasi total (full factorial):", n_kombinasi, "\n")
cat("Ini terlalu banyak untuk dievaluasi responden!\n\n")

# Gunakan fractional factorial design
# Buat semua kombinasi level untuk setiap atribut
level_codes <- lapply(atribut, function(x) 1:length(x))
names(level_codes) <- names(atribut)

# Buat desain eksperimen menggunakan AlgDesign
cat("Membuat desain eksperimen fractional factorial...\n")
set.seed(123)  # Untuk reproduktibilitas

# Buat dataframe dengan semua level
level_df <- expand.grid(atribut)
cat("Dimensi full factorial design:", dim(level_df), "\n")

# Pilih subset untuk evaluasi (biasanya 8-16 profil)
n_profil <- 12  # Jumlah profil yang akan dievaluasi
cat("Jumlah profil yang akan dievaluasi:", n_profil, "\n\n")

# 4. SIMULASI DATA RESPONDEN
# --------------------------

# Simulasi data preferensi dari 50 responden
n_responden <- 50
cat("Simulasi data dari", n_responden, "responden...\n")

# Buat matriks desain untuk analisis
# Pertama, buat semua kombinasi yang mungkin
all_profiles <- expand.grid(atribut)

# Pilih subset acak untuk evaluasi
selected_indices <- sample(1:nrow(all_profiles), n_profil)
profiles <- all_profiles[selected_indices, ]

cat("PROFIL PRODUK YANG AKAN DIEVALUASI:\n")
cat("===================================\n")
print(profiles)
cat("\n")

# 5. SIMULASI RATING PREFERENSI
# -----------------------------

# Fungsi untuk menghasilkan rating acak dengan pola tertentu
generate_ratings <- function(profiles, n_responden) {
  ratings <- matrix(NA, nrow = n_responden, ncol = nrow(profiles))
  
  # Parameter utilitas untuk setiap level (dibuat acak tapi konsisten)
  utility_params <- list(
    Rasa = c(Manis = 8, Sedikit_Manis = 5, Tidak_Manis = 2),
    Ukuran = c(`250ml` = 4, `500ml` = 7, `1000ml` = 6),
    Klaim = c(Alami_100pct = 9, Tanpa_Pengawet = 7, Reguler = 3),
    Kemasan = c(Botol_Plastik = 5, Botol_Kaca = 8, Kotak_Karton = 6),
    Harga = c(Rp4000 = 9, Rp7000 = 7, Rp12000 = 4, Rp18000 = 2)
  )
  
  for (r in 1:n_responden) {
    # Tambahkan variasi individual
    individual_variation <- runif(length(utility_params), -2, 2)
    names(individual_variation) <- names(utility_params)
    
    for (p in 1:nrow(profiles)) {
      total_utility <- 0
      
      # Hitung utilitas untuk setiap atribut
      for (attr in names(atribut)) {
        level_value <- as.character(profiles[p, attr])
        base_utility <- utility_params[[attr]][level_value]
        adjusted_utility <- base_utility + individual_variation[attr]
        total_utility <- total_utility + adjusted_utility
      }
      
      # Tambahkan noise dan konversi ke skala 1-10
      noise <- rnorm(1, 0, 1)
      rating <- total_utility/5 + noise  # Normalisasi
      rating <- pmax(1, pmin(10, rating))  # Batasi antara 1-10
      
      ratings[r, p] <- round(rating)
    }
  }
  
  return(ratings)
}

# Generate ratings
ratings <- generate_ratings(profiles, n_responden)
colnames(ratings) <- paste0("Profil_", 1:n_profil)

cat("Contoh data rating (5 responden pertama):\n")
print(ratings[1:5, ])
cat("\n")

# 6. ANALISIS KONJOIN
# -------------------

cat("MELAKUKAN ANALISIS KONJOIN...\n")
cat("==============================\n")

# Persiapan data untuk package conjoint
# Ubah profil menjadi format yang sesuai
profile_codes <- matrix(NA, nrow = nrow(profiles), ncol = length(atribut))
colnames(profile_codes) <- names(atribut)

for (i in 1:length(atribut)) {
  attr_name <- names(atribut)[i]
  profile_codes[, i] <- as.numeric(factor(profiles[[attr_name]], 
                                          levels = atribut[[attr_name]]))
}

# Analisis konjoin
conjoint_result <- Conjoint(ratings, profile_codes, atribut)

# 7. VISUALISASI HASIL
# --------------------

cat("\nVISUALISASI HASIL ANALISIS KONJOIN\n")
cat("===================================\n")

# 7.1. IMPORTANCE PERCENTAGE (TINGKAT PENTINGNYA ATRIBUT)
importance_df <- data.frame(
  Atribut = names(conjoint_result$importance),
  Importance = conjoint_result$importance
)

# Urutkan berdasarkan importance
importance_df <- importance_df[order(-importance_df$Importance), ]

cat("\nTINGKAT PENTINGNYA ATRIBUT (IMPORTANCE PERCENTAGE):\n")
print(importance_df)

# Visualisasi Importance Percentage
p1 <- ggplot(importance_df, aes(x = reorder(Atribut, Importance), y = Importance)) +
  geom_bar(stat = "identity", fill = "steelblue", alpha = 0.8) +
  geom_text(aes(label = paste0(round(Importance, 1), "%")), 
            hjust = -0.2, size = 3.5) +
  coord_flip() +
  labs(title = "Tingkat Pentingnya Atribut (Importance Percentage)",
       x = "Atribut",
       y = "Importance (%)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text = element_text(size = 10))

print(p1)

# 7.2. PART-WORTH UTILITIES (UTILITAS SETIAP LEVEL)
# Ekstrak part-worth utilities
utilities <- conjoint_result$partworth

# Buat dataframe untuk visualisasi
utility_list <- list()
for (attr in names(utilities)) {
  temp_df <- data.frame(
    Atribut = attr,
    Level = names(utilities[[attr]]),
    Utility = utilities[[attr]]
  )
  utility_list[[attr]] <- temp_df
}

utility_df <- do.call(rbind, utility_list)
rownames(utility_df) <- NULL

cat("\nPART-WORTH UTILITIES (UTILITAS SETIAP LEVEL):\n")
print(utility_df)

# Visualisasi Part-Worth Utilities
p2 <- ggplot(utility_df, aes(x = Level, y = Utility, fill = Atribut)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  facet_wrap(~ Atribut, scales = "free_x", ncol = 2) +
  labs(title = "Part-Worth Utilities (Utilitas setiap Level)",
       x = "Level",
       y = "Utility") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none",
        strip.text = element_text(face = "bold"))

print(p2)

# 7.3. SEGMENTASI RESPONDEN BERDASARKAN PREFERENSI
# Hitung utilitas per responden
individual_utilities <- caUtilities(ratings, profile_codes, atribut)

# Analisis cluster untuk segmentasi
set.seed(123)
kmeans_result <- kmeans(individual_utilities, centers = 3)

# Buat dataframe untuk visualisasi segmentasi
segment_df <- data.frame(
  Responden = 1:n_responden,
  Segment = as.factor(kmeans_result$cluster),
  PC1 = cmdscale(dist(individual_utilities))[, 1],
  PC2 = cmdscale(dist(individual_utilities))[, 2]
)

cat("\nSEGMENTASI RESPONDEN:\n")
cat("Jumlah responden per segment:\n")
print(table(segment_df$Segment))

# Visualisasi Segmentasi
p3 <- ggplot(segment_df, aes(x = PC1, y = PC2, color = Segment)) +
  geom_point(size = 3, alpha = 0.7) +
  stat_ellipse(level = 0.8, linetype = 2) +
  labs(title = "Segmentasi Responden Berdasarkan Preferensi",
       x = "Principal Component 1",
       y = "Principal Component 2",
       color = "Segment") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "right")

print(p3)

# 7.4. SIMULASI PRODUK BARU DAN MARKET SHARE
cat("\nSIMULASI PRODUK BARU DAN PERKIRAAN MARKET SHARE\n")
cat("================================================\n")

# Definisikan beberapa produk alternatif
produk_alternatif <- list(
  Produk_A = c(Rasa = "Manis", Ukuran = "500ml", Klaim = "Alami_100pct", 
               Kemasan = "Botol_Kaca", Harga = "Rp12000"),
  Produk_B = c(Rasa = "Sedikit_Manis", Ukuran = "1000ml", Klaim = "Tanpa_Pengawet", 
               Kemasan = "Botol_Plastik", Harga = "Rp7000"),
  Produk_C = c(Rasa = "Tidak_Manis", Ukuran = "250ml", Klaim = "Reguler", 
               Kemasan = "Kotak_Karton", Harga = "Rp4000")
)

# Hitung utilitas untuk setiap produk
calculate_product_utility <- function(product, utility_df) {
  total_utility <- 0
  for (attr in names(product)) {
    level <- product[attr]
    utility <- utility_df$Utility[utility_df$Atribut == attr & utility_df$Level == level]
    total_utility <- total_utility + utility
  }
  return(total_utility)
}

# Hitung utilitas untuk setiap produk alternatif
product_utilities <- sapply(produk_alternatif, calculate_product_utility, utility_df = utility_df)

# Hitung market share menggunakan model logit
market_share <- exp(product_utilities) / sum(exp(product_utilities)) * 100

# Buat dataframe untuk visualisasi
market_df <- data.frame(
  Produk = names(produk_alternatif),
  Deskripsi = sapply(produk_alternatif, function(x) paste(x, collapse = ", ")),
  Utility = product_utilities,
  Market_Share = market_share
)

cat("\nPERKIRAAN MARKET SHARE:\n")
print(market_df)

# Visualisasi Market Share
p4 <- ggplot(market_df, aes(x = reorder(Produk, Market_Share), y = Market_Share)) +
  geom_bar(stat = "identity", fill = c("darkgreen", "darkblue", "darkred"), alpha = 0.8) +
  geom_text(aes(label = paste0(round(Market_Share, 1), "%")), 
            vjust = -0.5, size = 4, fontface = "bold") +
  labs(title = "Perkiraan Market Share Produk Alternatif",
       x = "Produk",
       y = "Market Share (%)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.text = element_text(size = 11))

print(p4)

# 8. KESIMPULAN DAN REKOMENDASI
# -----------------------------

cat("\nKESIMPULAN DAN REKOMENDASI\n")
cat("===========================\n")

# Identifikasi atribut paling penting
most_important <- importance_df[1, ]
cat("1. ATRIBUT PALING PENTING:", most_important$Atribut, 
    "(", round(most_important$Importance, 1), "%)\n")

# Identifikasi level dengan utilitas tertinggi untuk setiap atribut
cat("\n2. LEVEL OPTIMAL UNTUK SETIAP ATRIBUT:\n")
for (attr in names(atribut)) {
  attr_data <- utility_df[utility_df$Atribut == attr, ]
  best_level <- attr_data[which.max(attr_data$Utility), "Level"]
  cat("   -", attr, ": ", best_level, 
      "(Utility = ", round(max(attr_data$Utility), 2), ")\n")
}

# Rekomendasi produk optimal
optimal_product <- list()
for (attr in names(atribut)) {
  attr_data <- utility_df[utility_df$Atribut == attr, ]
  optimal_product[attr] <- attr_data[which.max(attr_data$Utility), "Level"]
}

cat("\n3. REKOMENDASI PRODUK OPTIMAL:\n")
for (attr in names(optimal_product)) {
  cat("   -", attr, ": ", optimal_product[[attr]], "\n")
}

# 9. SIMPAN HASIL ANALISIS
# ------------------------

cat("\nMENYIMPAN HASIL ANALISIS...\n")

# Simpan dataframe penting
write.csv(importance_df, "importance_atribut.csv", row.names = FALSE)
write.csv(utility_df, "partworth_utilities.csv", row.names = FALSE)
write.csv(market_df, "market_share_simulasi.csv", row.names = FALSE)
write.csv(segment_df, "segmentasi_responden.csv", row.names = FALSE)

cat("File hasil analisis telah disimpan:\n")
cat("1. importance_atribut.csv\n")
cat("2. partworth_utilities.csv\n")
cat("3. market_share_simulasi.csv\n")
cat("4. segmentasi_responden.csv\n")

# Simpan plot
ggsave("importance_plot.png", p1, width = 10, height = 6, dpi = 300)
ggsave("utilities_plot.png", p2, width = 12, height = 8, dpi = 300)
ggsave("segmentasi_plot.png", p3, width = 10, height = 6, dpi = 300)
ggsave("marketshare_plot.png", p4, width = 10, height = 6, dpi = 300)

cat("\nPlot visualisasi telah disimpan:\n")
cat("1. importance_plot.png\n")
cat("2. utilities_plot.png\n")
cat("3. segmentasi_plot.png\n")
cat("4. marketshare_plot.png\n")

cat("\n===========================================\n")
cat("TUTORIAL ANALISIS KONJOIN SELESAI!\n")
cat("===========================================\n")
cat("\nRingkasan:\n")
cat("1. Analisis menunjukkan atribut yang paling penting bagi konsumen\n")
cat("2. Ditemukan utilitas setiap level dari setiap atribut\n")
cat("3. Responden dapat disegmentasi berdasarkan preferensi\n")
cat("4. Dapat dilakukan simulasi market share untuk produk baru\n")
cat("5. Hasil dapat digunakan untuk pengembangan produk dan strategi pemasaran\n")
