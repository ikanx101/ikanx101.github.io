#' Membuat Visualisasi Selling In vs Selling Out
#'
#' Fungsi ini membuat dua grafik untuk menganalisis hubungan antara selling in dan selling out:
#' 1. Grafik timeline historikal selling in vs selling out
#' 2. Grafik scatterplot hubungan antara selling in vs selling out
#'
#' @param df Dataframe yang berisi kolom: month, period, selling_in, selling_out, notes
#' @param save_plot Logical, apakah menyimpan plot ke file? Default: FALSE
#' @param output_dir Direktori output jika save_plot = TRUE. Default: "plots"
#' @param file_prefix Prefix nama file jika save_plot = TRUE. Default: "selling_analysis"
#'
#' @return List berisi dua objek ggplot
#' @export
#'
#' @examples
#' \dontrun{
#'   plots <- create_selling_plots(df)
#'   # Tampilkan plot pertama
#'   print(plots$timeline_plot)
#'   # Tampilkan plot kedua
#'   print(plots$scatter_plot)
#' }
create_selling_plots <- function(df, save_plot = FALSE, output_dir = "plots", file_prefix = "selling_analysis") {
  
  # Pastikan paket ggplot2 tersedia
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Paket ggplot2 diperlukan. Silakan install dengan: install.packages('ggplot2')")
  }
  
  library(ggplot2)
  
  # Validasi input dataframe
  required_cols <- c("month", "period", "selling_in", "selling_out", "notes")
  missing_cols <- setdiff(required_cols, names(df))
  
  if (length(missing_cols) > 0) {
    stop(paste("Kolom berikut tidak ditemukan dalam dataframe:", 
               paste(missing_cols, collapse = ", ")))
  }
  
  # Konversi period ke format tanggal untuk sorting yang benar
  # Ekstrak bulan dan tahun dari period
  df$period_clean <- as.character(df$period)
  
  # Buat kolom tanggal untuk sorting
  df$date <- as.Date(paste0("01-", df$period_clean), format = "%d-%b-%Y")
  
  # Urutkan data berdasarkan tanggal
  df <- df[order(df$date), ]
  
  # 1. GRAFIK TIMELINE - Selling In vs Selling Out
  timeline_plot <- ggplot(df, aes(x = date)) +
    # Garis untuk selling in
    geom_line(aes(y = selling_in, color = "Selling In"), size = 1.2, alpha = 0.8) +
    # Garis untuk selling out
    geom_line(aes(y = selling_out, color = "Selling Out"), size = 1.2, alpha = 0.8) +
    # Titik untuk selling in
    geom_point(aes(y = selling_in, color = "Selling In"), size = 2) +
    # Titik untuk selling out
    geom_point(aes(y = selling_out, color = "Selling Out"), size = 2) +
    # Area fill untuk visualisasi yang lebih baik
    geom_area(aes(y = selling_in, fill = "Selling In"), alpha = 0.1, position = "identity") +
    geom_area(aes(y = selling_out, fill = "Selling Out"), alpha = 0.1, position = "identity") +
    # Skala warna dan fill
    scale_color_manual(
      name = "Metric",
      values = c("Selling In" = "#1f77b4", "Selling Out" = "#ff7f0e")
    ) +
    scale_fill_manual(
      name = "Metric",
      values = c("Selling In" = "#1f77b4", "Selling Out" = "#ff7f0e")
    ) +
    # Format tanggal pada sumbu x
    scale_x_date(
      date_breaks = "3 months",
      date_labels = "%b %Y",
      expand = expansion(mult = c(0.02, 0.02))
    ) +
    # Judul dan label
    labs(
      title = "Timeline Historikal Selling In vs Selling Out",
      subtitle = "Perbandingan tren penjualan dari waktu ke waktu",
      x = "Periode",
      y = "Nilai Penjualan",
      caption = paste("Data periode:", min(df$period_clean), "-", max(df$period_clean))
    ) +
    # Tema
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40"),
      axis.title = element_text(face = "bold"),
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.position = "bottom",
      legend.title = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      plot.caption = element_text(color = "gray50", size = 9),
      plot.margin = unit(c(1, 1, 1, 1), "cm")
    )
  
  # 2. GRAFIK SCATTERPLOT - Hubungan Selling In vs Selling Out
  scatter_plot <- ggplot(df, aes(x = selling_in, y = selling_out)) +
    # Titik scatter dengan warna berdasarkan notes
    geom_point(aes(color = notes), size = 3, alpha = 0.7) +
    # Garis regresi untuk melihat tren
    geom_smooth(method = "lm", se = TRUE, color = "darkred", 
                fill = "lightpink", alpha = 0.2, size = 1) +
    # Garis diagonal (y = x) sebagai referensi
    geom_abline(intercept = 0, slope = 1, linetype = "dashed", 
                color = "gray50", alpha = 0.5) +
    # Skala warna untuk notes
    scale_color_brewer(palette = "Set2", name = "Keterangan") +
    # Judul dan label
    labs(
      title = "Hubungan antara Selling In dan Selling Out",
      subtitle = "Scatter plot dengan garis regresi",
      x = "Selling In",
      y = "Selling Out",
      caption = paste("Korelasi:", round(cor(df$selling_in, df$selling_out), 3))
    ) +
    # Anotasi untuk interpretasi
    annotate("text", 
             x = max(df$selling_in) * 0.8, 
             y = min(df$selling_out) * 1.1,
             label = "Garis putus-putus: y = x\n(ideal: selling out = selling in)",
             size = 3, color = "gray40", hjust = 0) +
    # Tema
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40"),
      axis.title = element_text(face = "bold"),
      legend.position = "bottom",
      legend.title = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      plot.caption = element_text(color = "gray50", size = 9),
      plot.margin = unit(c(1, 1, 1, 1), "cm")
    )
  
  # Jika save_plot = TRUE, simpan plot ke file
  if (save_plot) {
    # Buat direktori output jika belum ada
    if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
      message(paste("Direktori", output_dir, "telah dibuat"))
    }
    
    # Simpan timeline plot
    timeline_file <- file.path(output_dir, paste0(file_prefix, "_timeline.png"))
    ggsave(timeline_file, timeline_plot, width = 12, height = 8, dpi = 300)
    message(paste("Timeline plot disimpan ke:", timeline_file))
    
    # Simpan scatter plot
    scatter_file <- file.path(output_dir, paste0(file_prefix, "_scatter.png"))
    ggsave(scatter_file, scatter_plot, width = 10, height = 8, dpi = 300)
    message(paste("Scatter plot disimpan ke:", scatter_file))
  }
  
  # Return list berisi kedua plot
  return(list(
    timeline_plot = timeline_plot,
    scatter_plot = scatter_plot
  ))
}

#' Fungsi wrapper untuk membuat plot dari dataframe df
#'
#' Fungsi ini adalah wrapper sederhana untuk create_selling_plots() 
#' yang secara khusus bekerja dengan dataframe df
#'
#' @param ... Parameter tambahan untuk create_selling_plots()
#'
#' @return List berisi dua objek ggplot
#' @export
#'
#' @examples
#' \dontrun{
#'   plot_selling_data()
#' }
plot_selling_data <- function(...) {
  # Pastikan df ada di environment
  if (!exists("df")) {
    stop("Dataframe 'df' tidak ditemukan di environment")
  }
  
  # Panggil fungsi utama
  create_selling_plots(df, ...)
}

# Contoh penggunaan
if (FALSE) {
  # Contoh 1: Tampilkan plot saja
  plots <- plot_selling_data()
  print(plots$timeline_plot)
  print(plots$scatter_plot)
  
  # Contoh 2: Simpan plot ke file
  plots <- plot_selling_data(save_plot = TRUE, output_dir = "analysis_plots")
  
  # Contoh 3: Dengan prefix custom
  plots <- plot_selling_data(save_plot = TRUE, 
                             output_dir = "reports", 
                             file_prefix = "monthly_sales_analysis")
}
