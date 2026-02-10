# ANALISIS CLUSTERING RESTORAN
# =============================
# Skrip ini melakukan analisis clustering untuk data restoran dengan dua teknik:
# 1. DBSCAN untuk clustering spasial berdasarkan longitude dan latitude
# 2. K-Means untuk clustering berdasarkan rating dan jumlah user

# Load libraries
library(tidyverse)
library(dbscan)
library(factoextra)
library(ggrepel)
library(patchwork)
library(cluster)
library(viridis)

# Set seed untuk reproduktibilitas
set.seed(123)

# 1. PREPROCESSING DATA
# =====================

# Cek struktur data
cat("=== STRUKTUR DATA ===\n")
str(df_sel)
cat("\n=== SUMMARY STATISTICS ===\n")
summary(df_sel)

# Cek missing values
cat("\n=== MISSING VALUES ===\n")
colSums(is.na(df_sel))

# Normalisasi data untuk clustering
# Untuk DBSCAN, kita perlu skala data spasial
# Untuk K-Means, kita perlu skala rating dan user_rating

# Skala data untuk K-Means (rating dan user_rating)
df_scaled <- df_sel %>%
  mutate(
    rating_scaled = scale(rating),
    user_rating_scaled = scale(user_rating)
  )

# Skala data spasial untuk DBSCAN (long dan lat)
df_spatial_scaled <- df_sel %>%
  mutate(
    long_scaled = scale(long),
    lat_scaled = scale(lat)
  )

# 2. CLUSTERING SPASIAL DENGAN DBSCAN
# ====================================

cat("\n=== CLUSTERING SPASIAL DENGAN DBSCAN ===\n")

# Tentukan parameter DBSCAN
# eps: radius pencarian tetangga (dalam unit skala)
# minPts: minimum points untuk membentuk cluster

# Optimasi parameter eps menggunakan k-distance plot
k_dist <- kNNdist(df_spatial_scaled[, c("long_scaled", "lat_scaled")], k = 5)
k_dist_sorted <- sort(k_dist)

# Plot k-distance untuk menentukan eps
png("dbscan_kdistance_plot.png", width = 800, height = 600)
plot(k_dist_sorted, type = "l", 
     main = "K-Distance Plot untuk Menentukan Eps",
     xlab = "Points sorted by distance", 
     ylab = "5-NN distance")
abline(h = 0.02, col = "red", lty = 2)  # Saran nilai eps
dev.off()

# Gunakan eps = 0.02 dan minPts = 5 (standar untuk data 2D)
dbscan_result <- dbscan(df_spatial_scaled[, c("long_scaled", "lat_scaled")], 
                        eps = 0.02, minPts = 5)

# Tambahkan hasil clustering ke dataframe
df_sel$dbscan_cluster <- as.factor(dbscan_result$cluster)

# Analisis hasil DBSCAN
cat("\nDistribusi Cluster DBSCAN:\n")
table(df_sel$dbscan_cluster)
cat("\nCluster 0 adalah noise/outlier\n")

# 3. CLUSTERING RATING DENGAN K-MEANS
# ====================================

cat("\n=== CLUSTERING RATING DENGAN K-MEANS ===\n")

# Tentukan jumlah cluster optimal menggunakan elbow method
wss <- sapply(1:10, function(k) {
  kmeans(df_scaled[, c("rating_scaled", "user_rating_scaled")], 
         centers = k, nstart = 25)$tot.withinss
})

# Plot elbow method
png("kmeans_elbow_plot.png", width = 800, height = 600)
plot(1:10, wss, type = "b", 
     main = "Elbow Method untuk Menentukan K Optimal",
     xlab = "Number of Clusters", 
     ylab = "Total Within-Cluster Sum of Squares")
abline(v = 3, col = "red", lty = 2)  # Saran k = 3
dev.off()

# Gunakan k = 3 berdasarkan elbow plot
kmeans_result <- kmeans(df_scaled[, c("rating_scaled", "user_rating_scaled")], 
                        centers = 3, nstart = 25)

# Tambahkan hasil clustering ke dataframe
df_sel$kmeans_cluster <- as.factor(kmeans_result$cluster)

# Analisis hasil K-Means
cat("\nDistribusi Cluster K-Means:\n")
table(df_sel$kmeans_cluster)

# Beri nama cluster berdasarkan karakteristik
cluster_names <- c("Rendah", "Sedang", "Tinggi")
df_sel$kmeans_cluster_label <- factor(df_sel$kmeans_cluster,
                                       levels = 1:3,
                                       labels = cluster_names)

# 4. ANALISIS HASIL CLUSTERING
# =============================

cat("\n=== ANALISIS HASIL CLUSTERING ===\n")

# Analisis DBSCAN clusters
dbscan_summary <- df_sel %>%
  group_by(dbscan_cluster) %>%
  summarise(
    n_restoran = n(),
    avg_rating = mean(rating, na.rm = TRUE),
    avg_user_rating = mean(user_rating, na.rm = TRUE),
    median_rating = median(rating, na.rm = TRUE),
    median_user_rating = median(user_rating, na.rm = TRUE),
    min_long = min(long),
    max_long = max(long),
    min_lat = min(lat),
    max_lat = max(lat)
  ) %>%
  arrange(desc(n_restoran))

cat("\nSummary DBSCAN Clusters:\n")
print(dbscan_summary)

# Analisis K-Means clusters
kmeans_summary <- df_sel %>%
  group_by(kmeans_cluster_label) %>%
  summarise(
    n_restoran = n(),
    avg_rating = mean(rating, na.rm = TRUE),
    avg_user_rating = mean(user_rating, na.rm = TRUE),
    median_rating = median(rating, na.rm = TRUE),
    median_user_rating = median(user_rating, na.rm = TRUE),
    prop_high_rating = sum(rating >= 4.5) / n(),
    prop_popular = sum(user_rating >= 100) / n()
  )

cat("\nSummary K-Means Clusters:\n")
print(kmeans_summary)

# 5. VISUALISASI
# ==============

# Theme untuk visualisasi yang konsisten
my_theme <- theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 10),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.3)
  )

# 5.1 Visualisasi DBSCAN - Clustering Spasial
p1 <- ggplot(df_sel, aes(x = long, y = lat, color = dbscan_cluster)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_viridis_d(name = "DBSCAN Cluster", 
                        labels = c("Noise", paste0("Cluster ", 1:(length(unique(df_sel$dbscan_cluster))-1)))) +
  labs(
    title = "Clustering Spasial Restoran dengan DBSCAN",
    subtitle = "Mengidentifikasi area konsentrasi restoran",
    x = "Longitude",
    y = "Latitude",
    caption = "Cluster 0 = Noise/Outlier"
  ) +
  my_theme +
  theme(legend.position = "right")

# 5.2 Visualisasi DBSCAN dengan ukuran berdasarkan rating
p2 <- ggplot(df_sel, aes(x = long, y = lat, size = rating, color = dbscan_cluster)) +
  geom_point(alpha = 0.6) +
  scale_size_continuous(name = "Rating", range = c(1, 6)) +
  scale_color_viridis_d(name = "DBSCAN Cluster",
                        labels = c("Noise", paste0("Cluster ", 1:(length(unique(df_sel$dbscan_cluster))-1)))) +
  labs(
    title = "Distribusi Spasial dengan Ukuran Berdasarkan Rating",
    subtitle = "Bubble size menunjukkan rating restoran",
    x = "Longitude",
    y = "Latitude"
  ) +
  my_theme

# 5.3 Visualisasi K-Means - Clustering Rating
p3 <- ggplot(df_sel, aes(x = rating, y = log10(user_rating + 1), 
                         color = kmeans_cluster_label)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(name = "K-Means Cluster",
                     values = c("#E41A1C", "#377EB8", "#4DAF4A")) +
  labs(
    title = "Clustering Restoran Berdasarkan Rating dan Popularitas",
    subtitle = "K-Means clustering (log scale untuk user rating)",
    x = "Rating (1-5)",
    y = "log10(User Rating + 1)",
    caption = "Cluster: Rendah = rating rendah/popularitas rendah\nSedang = rating sedang/popularitas sedang\nTinggi = rating tinggi/popularitas tinggi"
  ) +
  my_theme

# 5.4 Visualisasi K-Means dengan density plot
p4 <- ggplot(df_sel, aes(x = rating, fill = kmeans_cluster_label)) +
  geom_density(alpha = 0.6) +
  scale_fill_manual(name = "K-Means Cluster",
                    values = c("#E41A1C", "#377EB8", "#4DAF4A")) +
  labs(
    title = "Distribusi Rating per Cluster",
    subtitle = "Density plot menunjukkan pola rating",
    x = "Rating",
    y = "Density"
  ) +
  my_theme +
  facet_wrap(~ kmeans_cluster_label, ncol = 1)

# 5.5 Visualisasi kombinasi DBSCAN dan K-Means
p5 <- ggplot(df_sel, aes(x = long, y = lat, 
                         color = kmeans_cluster_label,
                         shape = ifelse(dbscan_cluster == 0, "Noise", "Cluster"))) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(name = "Rating Cluster",
                     values = c("#E41A1C", "#377EB8", "#4DAF4A")) +
  scale_shape_manual(name = "Spatial Status",
                     values = c(16, 17)) +
  labs(
    title = "Kombinasi Clustering Spasial dan Rating",
    subtitle = "Warna: K-Means cluster | Shape: DBSCAN status",
    x = "Longitude",
    y = "Latitude"
  ) +
  my_theme

# 5.6 Heatmap density restoran
p6 <- ggplot(df_sel, aes(x = long, y = lat)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = 0.7) +
  geom_point(size = 1, color = "black", alpha = 0.3) +
  scale_fill_viridis_c(name = "Density", option = "plasma") +
  labs(
    title = "Heatmap Kepadatan Restoran",
    subtitle = "Area dengan konsentrasi restoran tertinggi",
    x = "Longitude",
    y = "Latitude"
  ) +
  my_theme

# 5.7 Bar plot perbandingan cluster
p7 <- df_sel %>%
  group_by(dbscan_cluster, kmeans_cluster_label) %>%
  summarise(count = n()) %>%
  ggplot(aes(x = factor(dbscan_cluster), y = count, fill = kmeans_cluster_label)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(name = "Rating Cluster",
                    values = c("#E41A1C", "#377EB8", "#4DAF4A")) +
  labs(
    title = "Distribusi Cluster Rating dalam Cluster Spasial",
    subtitle = "Komposisi rating cluster per area spasial",
    x = "DBSCAN Cluster (0 = Noise)",
    y = "Jumlah Restoran"
  ) +
  my_theme

# 5.8 Scatter plot dengan convex hull untuk cluster spasial
# Hanya untuk cluster non-noise
df_clustered <- df_sel %>% filter(dbscan_cluster != 0)

p8 <- ggplot(df_clustered, aes(x = long, y = lat, color = factor(dbscan_cluster))) +
  geom_point(size = 2.5, alpha = 0.6) +
  geom_encircle(aes(group = factor(dbscan_cluster)), 
                s_shape = 1, expand = 0, alpha = 0.2, size = 1) +
  scale_color_viridis_d(name = "Spatial Cluster") +
  labs(
    title = "Area Cluster Spasial dengan Convex Hull",
    subtitle = "Garis menunjukkan batas area cluster",
    x = "Longitude",
    y = "Latitude"
  ) +
  my_theme

# Simpan semua plot
plots <- list(p1, p2, p3, p4, p5, p6, p7, p8)

# Simpan plot individu
for (i in seq_along(plots)) {
  ggsave(paste0("plot_", i, ".png"), plots[[i]], 
         width = 10, height = 7, dpi = 300)
}

# Buat dashboard plot
dashboard <- (p1 + p2) / (p3 + p5) / (p6 + p8)
ggsave("dashboard_clustering.png", dashboard, width = 16, height = 12, dpi = 300)

# 6. INTERPRETASI HASIL
# =====================

cat("\n=== INTERPRETASI HASIL ===\n")
cat("\n1. ANALISIS CLUSTERING SPASIAL (DBSCAN):\n")
cat("   - Cluster spasial menunjukkan area dengan konsentrasi restoran tinggi\n")
cat("   - Noise points (cluster 0) adalah restoran yang terisolasi\n")
cat("   - Area cluster dapat mengindikasikan:\n")
cat("     * Pusat kota/kawasan komersial\n")
cat("     * Kawasan kuliner terorganisir\n")
cat("     * Area dengan aksesibilitas tinggi\n")

cat("\n2. ANALISIS CLUSTERING RATING (K-MEANS):\n")
cat("   - Cluster rating membantu mengidentifikasi pola:\n")
cat("     * Restoran dengan rating tinggi & popularitas tinggi\n")
cat("     * Restoran dengan rating sedang & popularitas sedang\n")
cat("     * Restoran dengan rating rendah & popularitas rendah\n")

cat("\n3. JAWABAN PERTANYAAN PENELITIAN:\n")
cat("\n   a. Apakah restoran dengan rating tinggi cenderung berkumpul di area elit tertentu?\n")
cat("      - Analisis: Periksa distribusi cluster rating tinggi di cluster spasial\n")
cat("      - Jika cluster rating tinggi terkonsentrasi di cluster spasial tertentu,\n")
cat("        maka ada indikasi area elit\n")
cat("      - Gunakan plot kombinasi (p5) untuk melihat pola ini\n")

cat("\n   b. Apakah ada pusat kuliner baru yang terbentuk secara organik?\n")
cat("      - Analisis: Identifikasi cluster spasial dengan karakteristik khusus:\n")
cat("        * Cluster dengan proporsi restoran baru/rating tinggi\n")
cat("        * Cluster di lokasi yang tidak tradisional\n")
cat("        * Cluster dengan pola rating yang unik\n")
cat("      - DBSCAN dapat mengidentifikasi cluster yang terbentuk organik\n")

cat("\n4. REKOMENDASI:\n")
cat("   - Fokus pada cluster spasial dengan rating tinggi untuk investasi\n")
cat("   - Identifikasi cluster dengan potensi pengembangan (rating sedang-popularitas tinggi)\n")
cat("   - Analisis kompetisi di cluster spasial padat\n")
cat("   - Pertimbangkan restoran noise sebagai peluang niche market\n")

# 7. EKSPOR HASIL
# ===============

# Simpan dataframe dengan hasil clustering
write.csv(df_sel, "restoran_dengan_clustering.csv", row.names = FALSE)

# Simpan summary statistics
sink("clustering_summary.txt")
cat("ANALISIS CLUSTERING RESTORAN\n")
cat("============================\n\n")
cat("Data Summary:\n")
print(summary(df_sel))
cat("\n\nDBSCAN Cluster Summary:\n")
print(dbscan_summary)
cat("\n\nK-Means Cluster Summary:\n")
print(kmeans_summary)
sink()

cat("\n=== ANALISIS SELESAI ===\n")
cat("File yang dihasilkan:\n")
cat("1. restoran_dengan_clustering.csv - Data dengan hasil clustering\n")
cat("2. clustering_summary.txt - Summary statistics\n")
cat("3. plot_1.png sampai plot_8.png - Visualisasi individu\n")
cat("4. dashboard_clustering.png - Dashboard visualisasi\n")
cat("5. dbscan_kdistance_plot.png - Plot optimasi DBSCAN\n")
cat("6. kmeans_elbow_plot.png - Plot elbow method K-Means\n")
