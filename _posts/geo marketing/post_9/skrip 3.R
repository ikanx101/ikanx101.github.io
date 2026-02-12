# Skrip Koreksi Rating Bayesian untuk Data Restoran
# Author: Data Scientist dengan 15 tahun pengalaman

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
  select(nama,long,lat,rating,user_rating) %>% 
  group_by(nama,long,lat) %>% 
  summarise(user_rating = mean(user_rating),
            rating = mean(rating)) %>% 
  ungroup() %>% 
  select(-long,-lat) %>% 
  filter(user_rating > 30)


# Load library yang diperlukan
library(tidyverse)
library(ggplot2)
library(scales)
library(patchwork)

# Fungsi untuk menghitung Bayesian rating
calculate_bayesian_rating <- function(rating, user_count, 
                                     prior_mean = NULL, 
                                     prior_weight = NULL,
                                     min_user_threshold = 30) {
  
  # Menghitung Bayesian rating yang dikoreksi.
  # 
  # Formula: Bayesian Rating = (user_count * rating + prior_weight * prior_mean) / (user_count + prior_weight)
  # 
  # Args:
  #   rating: Rating asli (0-5)
  #   user_count: Jumlah user yang memberikan rating
  #   prior_mean: Rating rata-rata prior (default: mean dari semua rating)
  #   prior_weight: Bobot prior (default: median dari user_count)
  #   min_user_threshold: Threshold minimum user untuk dianggap reliable
  #   
  # Returns:
  #   Dataframe dengan rating asli, rating Bayesian, dan kategori kepercayaan
  
  # Jika prior_mean tidak diberikan, gunakan mean dari semua rating
  if (is.null(prior_mean)) {
    prior_mean <- mean(rating, na.rm = TRUE)
  }
  
  # Jika prior_weight tidak diberikan, gunakan median dari user_count
  if (is.null(prior_weight)) {
    prior_weight <- median(user_count, na.rm = TRUE)
  }
  
  # Hitung Bayesian rating
  bayesian_rating <- (user_count * rating + prior_weight * prior_mean) / (user_count + prior_weight)
  
  # Tentukan kategori kepercayaan berdasarkan jumlah user
  confidence_category <- case_when(
    user_count < 50 ~ "Sangat rendah",
    user_count < 100 ~ "Rendah",
    user_count < 150 ~ "Sedang",
    user_count < 200 ~ "Tinggi",
    TRUE ~ "Sangat tinggi"
  )
  
  # Tentukan apakah rating reliable
  is_reliable <- user_count >= min_user_threshold
  
  return(data.frame(
    original_rating = rating,
    user_count = user_count,
    bayesian_rating = bayesian_rating,
    confidence_category = factor(confidence_category, 
                                 levels = c("Sangat rendah", "Rendah", 
                                            "Sedang", "Tinggi", "Sangat tinggi")),
    is_reliable = is_reliable,
    rating_difference = bayesian_rating - rating
  ))
}

# Analisis data restoran
analyze_restaurant_ratings <- function(df) {
  
  # Melakukan analisis komprehensif pada data rating restoran.
  # 
  # Args:
  #   df: Dataframe dengan kolom 'nama', 'rating', 'user_rating'
  #   
  # Returns:
  #   List berisi hasil analisis dan visualisasi
  # 
  
  # 1. Hitung Bayesian rating untuk semua restoran
  cat("Menghitung Bayesian rating...\n")
  
  # Hitung parameter prior
  prior_mean <- mean(df$rating, na.rm = TRUE)
  prior_weight <- median(df$user_rating, na.rm = TRUE)
  
  cat(sprintf("Prior mean: %.3f\n", prior_mean))
  cat(sprintf("Prior weight (median user count): %.0f\n", prior_weight))
  
  # Terapkan fungsi Bayesian rating
  bayesian_results <- calculate_bayesian_rating(
    df$rating, 
    df$user_rating,
    prior_mean = prior_mean,
    prior_weight = prior_weight
  )
  
  # Gabungkan dengan data asli
  df_analysis <- cbind(df, bayesian_results)
  
  # 2. Analisis statistik
  cat("\n=== ANALISIS STATISTIK ===\n")
  
  # Ringkasan rating asli vs Bayesian
  summary_stats <- df_analysis %>%
    summarise(
      n_restaurants = n(),
      mean_original = mean(original_rating, na.rm = TRUE),
      mean_bayesian = mean(bayesian_rating, na.rm = TRUE),
      sd_original = sd(original_rating, na.rm = TRUE),
      sd_bayesian = sd(bayesian_rating, na.rm = TRUE),
      min_original = min(original_rating, na.rm = TRUE),
      min_bayesian = min(bayesian_rating, na.rm = TRUE),
      max_original = max(original_rating, na.rm = TRUE),
      max_bayesian = max(bayesian_rating, na.rm = TRUE),
      median_user_count = median(user_count, na.rm = TRUE),
      mean_user_count = mean(user_count, na.rm = TRUE)
    )
  
  print(summary_stats)
  
  # Distribusi kategori kepercayaan
  confidence_dist <- df_analysis %>%
    count(confidence_category) %>%
    mutate(percentage = n / sum(n) * 100)
  
  cat("\nDistribusi Kategori Kepercayaan:\n")
  print(confidence_dist)
  
  # Restoran dengan perubahan rating terbesar
  cat("\nTop 10 Restoran dengan Perubahan Rating Terbesar:\n")
  top_changes <- df_analysis %>%
    arrange(desc(abs(rating_difference))) %>%
    head(10) %>%
    select(nama, original_rating, bayesian_rating, rating_difference, user_count, confidence_category)
  
  print(top_changes)
  
  # 3. Visualisasi
  cat("\nMembuat visualisasi...\n")
  
  plots <- list()
  
  # Plot 1: Distribusi rating asli vs Bayesian
  p1 <- ggplot(df_analysis, aes(x = original_rating)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "steelblue", alpha = 0.7) +
    geom_density(color = "darkblue", linewidth = 1) +
    geom_vline(xintercept = prior_mean, color = "red", linetype = "dashed", linewidth = 1) +
    labs(title = "Distribusi Rating Asli",
         subtitle = sprintf("Mean: %.2f | Garis merah: Prior mean (%.2f)", 
                           mean(df$rating), prior_mean),
         x = "Rating Asli", y = "Density") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10))
  
  p2 <- ggplot(df_analysis, aes(x = bayesian_rating)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "darkgreen", alpha = 0.7) +
    geom_density(color = "darkgreen", linewidth = 1) +
    geom_vline(xintercept = prior_mean, color = "red", linetype = "dashed", linewidth = 1) +
    labs(title = "Distribusi Rating Bayesian",
         subtitle = sprintf("Mean: %.2f | Garis merah: Prior mean (%.2f)", 
                           mean(df_analysis$bayesian_rating), prior_mean),
         x = "Rating Bayesian", y = "Density") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10))
  
  # Plot 2: Hubungan antara jumlah user dan perubahan rating
  p3 <- ggplot(df_analysis, aes(x = log10(user_count + 1), y = rating_difference)) +
    geom_point(aes(color = confidence_category, size = abs(rating_difference)), alpha = 0.6) +
    geom_smooth(method = "loess", color = "red", se = FALSE) +
    geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
    scale_color_brewer(palette = "Set1") +
    labs(title = "Hubungan Jumlah User vs Perubahan Rating",
         subtitle = "Rating Bayesian cenderung mendekati prior mean untuk restoran dengan sedikit user",
         x = "Log10(Jumlah User + 1)", 
         y = "Perubahan Rating (Bayesian - Asli)",
         color = "Kategori Kepercayaan",
         size = "Besarnya Perubahan") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10),
          legend.position = "bottom")
  
  # Plot 3: Scatter plot rating asli vs Bayesian dengan warna berdasarkan kepercayaan
  p4 <- ggplot(df_analysis, aes(x = original_rating, y = bayesian_rating)) +
    geom_point(aes(color = confidence_category, size = user_count), alpha = 0.7) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50") +
    geom_smooth(method = "lm", color = "red", se = FALSE) +
    scale_color_brewer(palette = "Set2") +
    labs(title = "Rating Asli vs Rating Bayesian",
         subtitle = "Garis diagonal: Rating tidak berubah | Titik lebih besar = lebih banyak user",
         x = "Rating Asli", 
         y = "Rating Bayesian",
         color = "Kategori Kepercayaan",
         size = "Jumlah User") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10),
          legend.position = "bottom")
  
  # Plot 4: Top 20 restoran dengan perubahan rating terbesar
  top_20_changes <- df_analysis %>%
    arrange(desc(abs(rating_difference))) %>%
    head(20) %>%
    mutate(nama = fct_reorder(nama, rating_difference))
  
  p5 <- ggplot(top_20_changes, aes(x = rating_difference, y = nama)) +
    geom_segment(aes(xend = 0, yend = nama), color = "gray50") +
    geom_point(aes(color = ifelse(rating_difference > 0, "Naik", "Turun"), 
                   size = user_count)) +
    geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
    scale_color_manual(values = c("Naik" = "darkgreen", "Turun" = "darkred")) +
    labs(title = "Top 20 Restoran dengan Perubahan Rating Terbesar",
         subtitle = "Ukuran titik berdasarkan jumlah user",
         x = "Perubahan Rating (Bayesian - Asli)",
         y = "Nama Restoran",
         color = "Arah Perubahan",
         size = "Jumlah User") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10),
          axis.text.y = element_text(size = 8))
  
  # Plot 5: Boxplot rating berdasarkan kategori kepercayaan
  p6 <- ggplot(df_analysis, aes(x = confidence_category, y = bayesian_rating)) +
    geom_boxplot(aes(fill = confidence_category), alpha = 0.7) +
    geom_jitter(width = 0.2, alpha = 0.3, size = 1) +
    stat_summary(fun = mean, geom = "point", shape = 18, size = 4, color = "red") +
    scale_fill_brewer(palette = "Set3") +
    labs(title = "Distribusi Rating Bayesian berdasarkan Kategori Kepercayaan",
         subtitle = "Titik merah: Mean rating",
         x = "Kategori Kepercayaan",
         y = "Rating Bayesian") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14),
          plot.subtitle = element_text(size = 10),
          axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = "none")
  
  # Gabungkan plot
  combined_plot <- (p1 + p2) / (p3 + p4) / (p5 + p6) +
    plot_annotation(
      title = "Analisis Komprehensif Koreksi Rating Bayesian untuk Data Restoran",
      subtitle = sprintf("Total %d restoran | Prior mean: %.2f | Prior weight: %.0f user", 
                        nrow(df), prior_mean, prior_weight),
      theme = theme(plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
                    plot.subtitle = element_text(size = 12, hjust = 0.5))
    )
  
  # 4. Rekomendasi berdasarkan rating Bayesian
  cat("\n=== REKOMENDASI BERDASARKAN RATING BAYESIAN ===\n")
  
  # Top 10 restoran dengan rating Bayesian tertinggi (minimal 50 user)
  top_bayesian <- df_analysis %>%
    filter(user_count >= 50) %>%
    arrange(desc(bayesian_rating)) %>%
    head(10) %>%
    select(nama, original_rating, bayesian_rating, user_count, confidence_category)
  
  cat("\nTop 10 Restoran (minimal 50 user):\n")
  print(top_bayesian)
  
  # Restoran dengan peningkatan peringkat terbesar
  improved_rankings <- df_analysis %>%
    mutate(original_rank = rank(-original_rating, ties.method = "min"),
           bayesian_rank = rank(-bayesian_rating, ties.method = "min"),
           rank_improvement = original_rank - bayesian_rank) %>%
    filter(rank_improvement > 0) %>%
    arrange(desc(rank_improvement)) %>%
    head(10) %>%
    select(nama, original_rating, bayesian_rating, original_rank, bayesian_rank, 
           rank_improvement, user_count)
  
  cat("\nTop 10 Restoran dengan Peningkatan Peringkat Terbesar:\n")
  print(improved_rankings)
  
  return(list(
    df_analysis = df_analysis,
    summary_stats = summary_stats,
    confidence_dist = confidence_dist,
    top_changes = top_changes,
    top_bayesian = top_bayesian,
    improved_rankings = improved_rankings,
    plots = list(
      p1 = p1, p2 = p2, p3 = p3, p4 = p4, p5 = p5, p6 = p6,
      combined_plot = combined_plot
    ),
    parameters = list(
      prior_mean = prior_mean,
      prior_weight = prior_weight,
      min_user_threshold = 10
    )
  ))
}

# Fungsi utama untuk menjalankan analisis
main <- function() {
  cat("=== ANALISIS KOREKSI RATING BAYESIAN UNTUK DATA RESTORAN ===\n")
  cat(sprintf("Dataframe: df_sel (%d restoran)\n", nrow(df_sel)))
  cat("Kolom: nama, rating, user_rating\n\n")
  
  # Jalankan analisis
  results <- analyze_restaurant_ratings(df_sel)
  
  # Simpan hasil analisis
  cat("\n=== MENYIMPAN HASIL ===\n")
  
  # Simpan dataframe dengan rating Bayesian
  write_csv(results$df_analysis, "restaurant_ratings_bayesian_corrected.csv")
  cat("Dataframe dengan rating Bayesian disimpan sebagai: restaurant_ratings_bayesian_corrected.csv\n")
  
  # Simpan plot
  ggsave("bayesian_rating_analysis.png", 
         results$plots$combined_plot, 
         width = 16, height = 20, dpi = 300)
  cat("Plot analisis disimpan sebagai: bayesian_rating_analysis.png\n")
  
  # Simpan summary statistics
  write_csv(results$summary_stats, "rating_summary_statistics.csv")
  cat("Summary statistics disimpan sebagai: rating_summary_statistics.csv\n")
  
  cat("\n=== ANALISIS SELESAI ===\n")
  cat("Hasil analisis telah disimpan dalam berbagai file.\n")
  cat("Gunakan results$df_analysis untuk mengakses dataframe dengan rating Bayesian.\n")
  
  return(results)
}

# Jika skrip dijalankan langsung
if (sys.nframe() == 0) {
  # Pastikan df_sel ada di environment
  if (exists("df_sel")) {
    results <- main()
  } else {
    cat("ERROR: Dataframe 'df_sel' tidak ditemukan di environment.\n")
    cat("Pastikan dataframe dengan kolom 'nama', 'rating', dan 'user_rating' sudah dimuat.\n")
  }
}

# Contoh penggunaan:
# 1. Load data Anda (pastikan df_sel sudah ada)
# 2. Jalankan: source("bayesian_rating_correction.R")
# 3. Atau jalankan fungsi: results <- analyze_restaurant_ratings(df_sel)
