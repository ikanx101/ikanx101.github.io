#' Tampilkan Statistika Deskriptif untuk Vektor ROI Historis
#'
#' Fungsi ini menghasilkan tabel statistika deskriptif yang estetis untuk vektor `roi_historis`
#' yang akan dirender dengan baik dalam format markdown.
#'
#' @param vector Vektor numerik yang akan dianalisis (default: `roi_historis` dari environment)
#' @param digits Jumlah digit desimal untuk pembulatan (default: 2)
#' @param include_plot Logical, apakah menyertakan plot distribusi sederhana (default: FALSE)
#'
#' @return Tabel statistika deskriptif dalam format yang siap untuk markdown
#' @export
#'
#' @examples
#' \dontrun{
#' tampilkan_statistik_roi()
#' tampilkan_statistik_roi(vector = c(1, 2, 3, 4, 5), digits = 3)
#' }
tampilkan_statistik_roi <- function(vector = NULL, digits = 2, include_plot = FALSE) {
  
  # Jika vector tidak diberikan, gunakan roi_historis dari environment
  if (is.null(vector)) {
    if (exists("roi_historis", envir = .GlobalEnv)) {
      vector <- get("roi_historis", envir = .GlobalEnv)
    } else {
      stop("Vektor 'roi_historis' tidak ditemukan di environment. Silakan berikan vektor secara eksplisit.")
    }
  }
  
  # Validasi input
  if (!is.numeric(vector)) {
    stop("Input harus berupa vektor numerik.")
  }
  
  if (length(vector) < 2) {
    stop("Vektor harus memiliki setidaknya 2 elemen untuk analisis statistika.")
  }
  
  # Hitung statistika deskriptif
  stats_list <- list(
    "Jumlah Data" = length(vector),
    "Rata-rata" = mean(vector, na.rm = TRUE),
    "Median" = median(vector, na.rm = TRUE),
    "Standar Deviasi" = sd(vector, na.rm = TRUE),
    "Varians" = var(vector, na.rm = TRUE),
    "Minimum" = min(vector, na.rm = TRUE),
    "Maksimum" = max(vector, na.rm = TRUE),
    "Range" = max(vector, na.rm = TRUE) - min(vector, na.rm = TRUE),
    "Kuartil 1 (Q1)" = quantile(vector, 0.25, na.rm = TRUE),
    "Kuartil 3 (Q3)" = quantile(vector, 0.75, na.rm = TRUE),
    "IQR" = IQR(vector, na.rm = TRUE),
    "Skewness" = if (requireNamespace("e1071", quietly = TRUE)) {
      e1071::skewness(vector, na.rm = TRUE)
    } else {
      # Formula sederhana untuk skewness
      n <- length(vector)
      mean_val <- mean(vector, na.rm = TRUE)
      sd_val <- sd(vector, na.rm = TRUE)
      (sum((vector - mean_val)^3) / n) / (sd_val^3)
    },
    "Kurtosis" = if (requireNamespace("e1071", quietly = TRUE)) {
      e1071::kurtosis(vector, na.rm = TRUE)
    } else {
      # Formula sederhana untuk kurtosis
      n <- length(vector)
      mean_val <- mean(vector, na.rm = TRUE)
      sd_val <- sd(vector, na.rm = TRUE)
      (sum((vector - mean_val)^4) / n) / (sd_val^4) - 3
    }
  )
  
  # Buat data frame untuk tabel
  stats_df <- data.frame(
    Statistik = names(stats_list),
    Nilai = sapply(stats_list, function(x) {
      if (is.numeric(x)) {
        round(x, digits)
      } else {
        x
      }
    }),
    stringsAsFactors = FALSE
  )
  
  # Tambahkan informasi tambahan
  cat("## 📊 Statistika Deskriptif ROI Historis\n\n")
  cat(paste0("**Jumlah observasi:** ", length(vector), "\n"))
  cat(paste0("**Rentang nilai:** ", round(min(vector), digits), " - ", 
             round(max(vector), digits), "\n"))
  cat(paste0("**Rata-rata:** ", round(mean(vector), digits), "\n\n"))
  
  # Tampilkan tabel utama
  cat("### 📈 Ringkasan Statistika\n\n")
  
  # Format tabel untuk markdown
  cat("| Statistik | Nilai |\n")
  cat("|-----------|-------|\n")
  
  for (i in 1:nrow(stats_df)) {
    cat(paste0("| ", stats_df$Statistik[i], " | ", stats_df$Nilai[i], " |\n"))
  }
  
  cat("\n")
  
  # Tampilkan ringkasan 5-number summary
  cat("### 📋 Ringkasan 5-Angka\n\n")
  five_num <- fivenum(vector)
  names(five_num) <- c("Minimum", "Q1", "Median", "Q3", "Maksimum")
  
  cat("| Statistik | Nilai |\n")
  cat("|-----------|-------|\n")
  for (name in names(five_num)) {
    cat(paste0("| ", name, " | ", round(five_num[name], digits), " |\n"))
  }
  
  cat("\n")
  
  # Interpretasi skewness dan kurtosis
  skew_val <- stats_list[["Skewness"]]
  kurt_val <- stats_list[["Kurtosis"]]
  
  cat("### 🔍 Interpretasi\n\n")
  
  # Interpretasi skewness
  if (abs(skew_val) < 0.5) {
    skew_interpret <- "distribusi hampir simetris"
  } else if (skew_val > 0.5) {
    skew_interpret <- "distribusi miring ke kanan (positif)"
  } else {
    skew_interpret <- "distribusi miring ke kiri (negatif)"
  }
  
  # Interpretasi kurtosis
  if (abs(kurt_val) < 0.5) {
    kurt_interpret <- "distribusi mesokurtik (normal)"
  } else if (kurt_val > 0.5) {
    kurt_interpret <- "distribusi leptokurtik (puncak tinggi)"
  } else {
    kurt_interpret <- "distribusi platykurtik (puncak rendah)"
  }
  
  cat(paste0("- **Skewness:** ", round(skew_val, digits), " - ", skew_interpret, "\n"))
  cat(paste0("- **Kurtosis:** ", round(kurt_val, digits), " - ", kurt_interpret, "\n\n"))
  
  # Jika diminta, tampilkan plot sederhana
  if (include_plot && interactive()) {
    cat("### 📊 Visualisasi Distribusi\n\n")
    cat("```r\n")
    cat("# Kode untuk plot distribusi:\n")
    cat("par(mfrow = c(1, 2))\n")
    cat("hist(vector, main = 'Histogram ROI Historis', \n")
    cat("     xlab = 'ROI', col = 'lightblue', border = 'white')\n")
    cat("boxplot(vector, main = 'Boxplot ROI Historis', \n")
    cat("        ylab = 'ROI', col = 'lightgreen')\n")
    cat("abline(h = mean(vector), col = 'red', lty = 2, lwd = 2)\n")
    cat("legend('topright', legend = 'Rata-rata', \n")
    cat("       col = 'red', lty = 2, lwd = 2)\n")
    cat("```\n\n")
    
    # Eksekusi plot jika dalam environment interaktif
    try({
      par(mfrow = c(1, 2))
      hist(vector, main = "Histogram ROI Historis", 
           xlab = "ROI", col = "lightblue", border = "white")
      boxplot(vector, main = "Boxplot ROI Historis", 
              ylab = "ROI", col = "lightgreen")
      abline(h = mean(vector), col = "red", lty = 2, lwd = 2)
      legend("topright", legend = "Rata-rata", 
             col = "red", lty = 2, lwd = 2)
      par(mfrow = c(1, 1))
    }, silent = TRUE)
  }
  
  # Return invisible object untuk penggunaan lebih lanjut
  invisible(list(
    statistics = stats_df,
    vector = vector,
    summary = summary(vector),
    five_number = five_num
  ))
}

#' Fungsi Alias untuk Tampilkan Statistika
#' 
#' @rdname tampilkan_statistik_roi
#' @export
show_roi_stats <- tampilkan_statistik_roi

#' Fungsi untuk Generate Tabel Markdown Saja
#'
#' @param vector Vektor numerik
#' @param digits Jumlah digit desimal
#'
#' @return String tabel markdown
#' @export
#'
#' @examples
#' \dontrun{
#' tabel_markdown <- buat_tabel_statistik(roi_historis)
#' cat(tabel_markdown)
#' }
buat_tabel_statistik <- function(vector = NULL, digits = 2) {
  if (is.null(vector)) {
    if (exists("roi_historis", envir = .GlobalEnv)) {
      vector <- get("roi_historis", envir = .GlobalEnv)
    } else {
      stop("Vektor 'roi_historis' tidak ditemukan.")
    }
  }
  
  stats <- list(
    "Jumlah Data" = length(vector),
    "Rata-rata" = mean(vector, na.rm = TRUE),
    "Median" = median(vector, na.rm = TRUE),
    "Standar Deviasi" = sd(vector, na.rm = TRUE),
    "Minimum" = min(vector, na.rm = TRUE),
    "Maksimum" = max(vector, na.rm = TRUE)
  )
  
  # Buat tabel markdown
  output <- "## 📊 Tabel Statistika Deskriptif\n\n"
  output <- paste0(output, "| Statistik | Nilai |\n")
  output <- paste0(output, "|-----------|-------|\n")
  
  for (name in names(stats)) {
    value <- if (is.numeric(stats[[name]])) {
      round(stats[[name]], digits)
    } else {
      stats[[name]]
    }
    output <- paste0(output, "| ", name, " | ", value, " |\n")
  }
  
  return(output)
}
