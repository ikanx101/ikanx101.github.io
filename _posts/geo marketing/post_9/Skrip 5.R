rm(list=ls())
gc()

library(dplyr)
library(tidyr)

setwd("~/ikanx101.github.io/_posts/geo marketing/post_9")

load("all_data.rda")

colnames(df_final)

df_sel = 
  df_final %>% 
  filter(kota == "Surabaya") %>% 
  filter(kecamatan %in% c("Gubeng","Genteng")) %>% 
  filter(!is.na(rating)) %>% 
  filter(user_rating > 0) %>% 
  select(nama,rating,long,lat) |> 
  distinct()


# ============================================
# ANALISIS HUBUNGAN JARAK DAN KUALITAS RESTORAN
# ============================================
# Skrip ini mencari restoran yang "melawan arus" di wilayahnya
# ============================================

# Load libraries
library(tidyverse)
library(ggplot2)
library(scales)
library(ggrepel)
library(cluster)  # Untuk perhitungan jarak
library(ggspatial) # Untuk peta jika diperlukan

# ============================================
# 1. FUNGSI UTILITAS
# ============================================

# Fungsi untuk menghitung jarak Euclidean antara dua titik(dalam derajat)
# Catatan: Ini adalah aproksimasi sederhana, untuk akurasilebih tinggi
# gunakan formula Haversine atau paket geosphere
calculate_distance <- function(lat1, lon1, lat2, lon2) {
  # Konversi derajat ke radian
  lat1_rad <- lat1 * pi / 180
  lon1_rad <- lon1 * pi / 180
  lat2_rad <- lat2 * pi / 180
  lon2_rad <- lon2 * pi / 180
  
  # Perbedaan koordinat
  dlat <- lat2_rad - lat1_rad
  dlon <- lon2_rad - lon1_rad
  
  # Formula Haversine (aproksimasi untuk jarak kecil)
  a <- sin(dlat/2)^2 + cos(lat1_rad) * cos(lat2_rad) * 
    sin(dlon/2)^2
  c <- 2 * atan2(sqrt(a), sqrt(1-a))
  
  # Radius bumi dalam km (aproksimasi)
  R <- 6371
  
  # Jarak dalam km
  distance_km <- R * c
  
  return(distance_km)
}

# ============================================
# 2. ANALISIS RESTORAN "MELAWAN ARUS"
# ============================================

# Parameter analisis
RADIUS_KM <- 0.4  # Radius pencarian tetangga (dalam km)
MIN_NEIGHBORS <- 5  # Minimal jumlah tetangga untuk analisis
RATING_THRESHOLD <- 0.8  # Threshold perbedaan rating darirata-rata wilayah

# Salin data untuk analisis
df_analysis <- df_sel

# Hitung rata-rata rating untuk setiap restoran berdasarkan tetangga dalam radius
df_analysis$avg_neighbor_rating <- NA
df_analysis$neighbor_count <- NA
df_analysis$rating_difference <- NA

for (i in 1:nrow(df_analysis)) {
  current_lat <- df_analysis$lat[i]
  current_long <- df_analysis$long[i]
  current_rating <- df_analysis$rating[i]
  
  # Hitung jarak ke semua restoran lain
  distances <- sapply(1:nrow(df_analysis), function(j) {
    if (i == j) return(Inf)  # Exclude diri sendiri
    calculate_distance(current_lat, current_long, 
                       df_analysis$lat[j], 
                       df_analysis$long[j])
  })
  
  # Temukan tetangga dalam radius
  neighbor_indices <- which(distances <= RADIUS_KM)
  
  if (length(neighbor_indices) >= MIN_NEIGHBORS) {
    neighbor_ratings <- 
      df_analysis$rating[neighbor_indices]
    avg_neighbor <- mean(neighbor_ratings, na.rm = TRUE)
    
    df_analysis$avg_neighbor_rating[i] <- avg_neighbor
    df_analysis$neighbor_count[i] <- 
      length(neighbor_indices)
    df_analysis$rating_difference[i] <- current_rating - 
      avg_neighbor
  }
}

# Identifikasi restoran yang "melawan arus"
df_outliers <- df_analysis %>%
  filter(!is.na(rating_difference)) %>%
  mutate(
    is_outlier = rating_difference >= RATING_THRESHOLD,
    outlier_strength = rating_difference / 
      sd(rating_difference, na.rm = TRUE)
  ) %>%
  arrange(desc(rating_difference))

# ============================================
# 3. VISUALISASI
# ============================================

# 3.1. Scatter Plot: Rating vs Rata-rata Rating Tetangga
p1 <- ggplot(df_outliers, aes(x = avg_neighbor_rating, y =
                                rating, 
                              color = is_outlier, size = 
                                neighbor_count)) +
  geom_point(alpha = 0.7) +
  geom_abline(slope = 1, intercept = 0, linetype = 
                "dashed", color = "gray50") +
  geom_text_repel(
    data = df_outliers %>% filter(is_outlier) %>% 
      head(10),
    aes(label = nama),
    size = 3,
    box.padding = 0.5,
    max.overlaps = 20
  ) +
  scale_color_manual(
    values = c("FALSE" = "gray70", "TRUE" = "#E41A1C"),
    labels = c("Normal", "Melawan Arus")
  ) +
  labs(
    title = "Restoran yang Melawan Arus di Wilayahnya",
    subtitle = paste("Restoran dengan rating jauh di atas 
rata-rata tetangga (radius", RADIUS_KM, "km)"),
    x = "Rata-rata Rating Tetangga",
    y = "Rating Restoran",
    color = "Status",
    size = "Jumlah Tetangga"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = 
                                   "gray50"),
    legend.position = "bottom"
  )

print(p1)

# 3.2. Top 10 Restoran dengan Perbedaan Rating Tertinggi
top_outliers <- df_outliers %>%
  filter(is_outlier) %>%
  arrange(desc(rating_difference)) %>%
  head(10)

p2 <- ggplot(top_outliers, 
             aes(x = reorder(nama, rating_difference), y =
                   rating_difference)) +
  geom_col(fill = "#377EB8", alpha = 0.8) +
  geom_text(aes(label = sprintf("%.2f", 
                                rating_difference)), 
            hjust = -0.2, size = 3.5) +
  coord_flip() +
  labs(
    title = "Tujuh Tempat makan dengan
    Perbedaan Rating Tertinggi",
    subtitle = "Dibandingkan dengan rata-rata 
    tetangga terdekat",
    x = "Nama Restoran",
    y = "Perbedaan Rating (Restoran - Rata-rata Tetangga)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = 
                                   "gray50"),
    axis.text.y = element_text(size = 9)
  )

print(p2)

# 3.3. Distribusi Perbedaan Rating
p3 <- ggplot(df_outliers, aes(x = rating_difference, fill 
                              = is_outlier)) +
  geom_histogram(bins = 30, alpha = 0.7, position = 
                   "identity") +
  geom_vline(xintercept = RATING_THRESHOLD, 
             linetype = "dashed", color = "red", size = 1) +
  geom_vline(xintercept = 0, 
             linetype = "dashed", color = "gray50", size =
               0.5) +
  annotate("text", x = -0.5, y = Inf, 
           label = paste("Threshold:", RATING_THRESHOLD), 
           hjust = 0, vjust = 2, color = "red") +
  scale_fill_manual(
    values = c("FALSE" = "gray70", "TRUE" = "#4DAF4A"),
    labels = c("Normal", "Melawan Arus")
  ) +
  labs(
    title = "Distribusi Perbedaan Rating Restoran",
    subtitle = "Dibandingkan dengan rata-rata wilayah 
sekitar",
    x = "Perbedaan Rating (Restoran - Rata-rata 
Tetangga)",
    y = "Frekuensi",
    fill = "Status"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = 
                                   "gray50")
  )

print(p3)

# 3.4. Peta Heatmap Kualitas (jika data spasial cukup padat)
# Buat grid untuk heatmap
create_heatmap_data <- function(df, grid_size = 0.01) {
  # Buat grid berdasarkan koordinat
  lat_range <- range(df$lat, na.rm = TRUE)
  long_range <- range(df$long, na.rm = TRUE)
  
  lat_seq <- seq(lat_range[1], lat_range[2], by = 
                   grid_size)
  long_seq <- seq(long_range[1], long_range[2], by = 
                    grid_size)
  
  grid_data <- expand.grid(lat = lat_seq, long = long_seq)
  
  # Hitung rata-rata rating untuk setiap grid cell
  grid_data$avg_rating <- NA
  
  for (i in 1:nrow(grid_data)) {
    distances <- calculate_distance(grid_data$lat[i], 
                                    grid_data$long[i],
                                    df$lat, df$long)
    
    # Ambil restoran dalam radius tertentu
    nearby_indices <- which(distances <= RADIUS_KM)
    
    if (length(nearby_indices) > 0) {
      grid_data$avg_rating[i] <- 
        mean(df$rating[nearby_indices], na.rm = TRUE)
    }
  }
  
  return(grid_data)
}

# Hanya buat heatmap jika data tidak terlalu besar
if (nrow(df_analysis) < 1000) {
  heatmap_data <- create_heatmap_data(df_analysis, 
                                      grid_size = 0.005)
  
  p4 <- ggplot() +
    geom_tile(data = heatmap_data, 
              aes(x = long, y = lat, fill = avg_rating),
              alpha = 0.7) +
    geom_point(data = df_outliers %>% filter(is_outlier),
               aes(x = long, y = lat, size = 
                     rating_difference),
               color = "red", shape = 1, stroke = 1.5) +
    geom_text_repel(
      data = df_outliers %>% filter(is_outlier) %>% 
        head(5),
      aes(x = long, y = lat, label = nama),
      size = 3,
      box.padding = 0.5,
      color = "darkred"
    ) +
    scale_fill_gradient2(
      low = "#D73027", mid = "#FFFFBF", high = "#1A9850",
      midpoint = mean(df_analysis$rating, na.rm = TRUE),
      name = "Rata-rata Rating\nWilayah"
    ) +
    scale_size_continuous(
      name = "Kekuatan\nMelawan Arus",
      range = c(2, 6)
    ) +
    labs(
      title = "Peta Heatmap Kualitas Restoran",
      subtitle = "Area merah: rating rendah, Area hijau: 
rating tinggi\nTitik merah: restoran yang melawan arus",
      x = "Longitude",
      y = "Latitude"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold", size = 16),
      plot.subtitle = element_text(size = 12, color = 
                                     "gray50"),
      legend.position = "right"
    )
  
  print(p4)
}

# ============================================
# 4. ANALISIS STATISTIK DAN INSIGHT
# ============================================

# Ringkasan statistik
cat("\n=== RINGKASAN ANALISIS ===\n")
cat("Total restoran:", nrow(df_analysis), "\n")
cat("Restoran dengan cukup tetangga:", 
    sum(!is.na(df_analysis$rating_difference)), "\n")
cat("Restoran yang 'melawan arus':", 
    sum(df_outliers$is_outlier, na.rm = TRUE), "\n")
cat("\n")

# Statistik perbedaan rating
rating_diff_stats <- df_outliers %>%
  summarise(
    mean_diff = mean(rating_difference, na.rm = TRUE),
    median_diff = median(rating_difference, na.rm = TRUE),
    sd_diff = sd(rating_difference, na.rm = TRUE),
    min_diff = min(rating_difference, na.rm = TRUE),
    max_diff = max(rating_difference, na.rm = TRUE)
  )

cat("Statistik Perbedaan Rating:\n")
print(rating_diff_stats)
cat("\n")

# Top 5 restoran yang paling melawan arus
cat("TOP 5 RESTORAN YANG PALING MELAWAN ARUS:\n")
top5 <- df_outliers %>%
  filter(is_outlier) %>%
  select(nama, rating, avg_neighbor_rating, 
         rating_difference, neighbor_count) %>%
  arrange(desc(rating_difference)) %>%
  head(5)

print(top5)
cat("\n")

# Analisis karakteristik restoran yang melawan arus
cat("KARAKTERISTIK RESTORAN YANG MELAWAN ARUS:\n")

# 1. Apakah mereka memiliki rating absolut yang tinggi?
outlier_stats <- df_outliers %>%
  group_by(is_outlier) %>%
  summarise(
    count = n(),
    avg_rating = mean(rating, na.rm = TRUE),
    avg_neighbors = mean(neighbor_count, na.rm = TRUE),
    avg_neighbor_rating = mean(avg_neighbor_rating, na.rm 
                               = TRUE)
  )

print(outlier_stats)
cat("\n")

# 2. Korelasi antara jumlah tetangga dan kemampuan melawanarus
cor_test <- cor.test(df_outliers$neighbor_count, 
                     df_outliers$rating_difference, 
                     use = "complete.obs")

cat("Korelasi jumlah tetangga vs perbedaan rating:\n")
cat("  Korelasi:", round(cor_test$estimate, 3), "\n")
cat("  p-value:", format.pval(cor_test$p.value, digits = 
                                3), "\n")
cat("\n")

# ============================================
# 5. REKOMENDASI DAN INSIGHT BISNIS
# ============================================

cat("=== INSIGHT BISNIS DAN REKOMENDASI ===\n\n")

cat("1. RESTORAN YANG SANGAT UNGGUL DIBANDING 
KOMPETITOR:\n")
cat("   Restoran berikut memiliki rating jauh di atas 
rata-rata wilayahnya:\n")
for (i in 1:min(3, nrow(top5))) {
  cat(sprintf("   - %s: Rating %.1f vs rata-rata wilayah 
%.1f (selisih +%.1f)\n",
              top5$nama[i], top5$rating[i], 
              top5$avg_neighbor_rating[i], 
              top5$rating_difference[i]))
}
cat("\n")

cat("2. MENGAPA MEREKA BISA UNGGUL?\n")
cat("   Beberapa kemungkinan alasan:\n")
cat("   a. Kualitas produk/service yang benar-benar 
exceptional\n")
cat("   b. Unique selling proposition (USP) yang kuat\n")
cat("   c. Lokasi strategis meski di area kompetitif\n")
cat("   d. Marketing dan branding yang efektif\n")
cat("   e. Customer experience yang memorable\n")
cat("\n")

cat("3. REKOMENDASI UNTUK BISNIS LAIN:\n")
cat("   a. Studi kasus: Pelajari best practices dari 
restoran unggul ini\n")
cat("   b. Benchmarking: Bandingkan dengan kompetitor 
langsung\n")
cat("   c. Differentiation: Cari celah pasar yang belum 
terisi\n")
cat("   d. Customer feedback: Analisis review pelanggan 
mereka\n")
cat("   e. Location strategy: Pertimbangkan cluster 
kompetisi\n")

# ============================================
# 6. EKSPOR HASIL ANALISIS
# ============================================

# Simpan hasil analisis ke CSV
save(p1,p2,p3,p4,cor_test,file = "analisa_5.rda")