# =============================================================================
# 03_visualization.R
# Membuat visualisasi hasil analisis Denton, disimpan sebagai .png ke folder plots/
# =============================================================================

library(ggplot2)

load(file.path("output", "01_simulated_data.rda"))
load(file.path("output", "02_denton_results.rda"))

quarter_dates <- seq(as.Date("2021-01-01"), by = "quarter",
                      length.out = nrow(denton_result_df))
denton_result_df$date <- quarter_dates

annual_awareness_df$date <- as.Date(paste0(annual_awareness_df$year, "-01-01"))

# -----------------------------------------------------------------------------
# Plot 1: Benchmark tahunan vs indicator kuartalan (data mentah)
# -----------------------------------------------------------------------------
p1 <- ggplot() +
  geom_line(data = denton_result_df, aes(x = date, y = ad_awareness, color = "Ad Awareness (indicator, kuartalan)"), linewidth = 0.9) +
  geom_point(data = denton_result_df, aes(x = date, y = ad_awareness, color = "Ad Awareness (indicator, kuartalan)"), size = 1.8) +
  geom_step(data = annual_awareness_df, aes(x = date, y = brand_awareness, color = "Brand Awareness (benchmark, tahunan)"), linewidth = 1, linetype = "dashed") +
  geom_point(data = annual_awareness_df, aes(x = date, y = brand_awareness, color = "Brand Awareness (benchmark, tahunan)"), size = 3) +
  scale_color_manual(values = c("Ad Awareness (indicator, kuartalan)" = "#2E86AB",
                                 "Brand Awareness (benchmark, tahunan)" = "#C1272D")) +
  labs(title = "Data Mentah: Benchmark Tahunan vs Indicator Kuartalan",
       subtitle = "Brand awareness (tahunan) dan ad awareness survey (kuartalan), 2021-2025",
       x = NULL, y = "Awareness (%)", color = NULL) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

ggsave(file.path("plots", "01_raw_benchmark_vs_indicator.png"), p1, width = 9, height = 5.5, dpi = 150)

# -----------------------------------------------------------------------------
# Plot 2: Perbandingan Denton vs Naive pro-rata vs indicator asli
#         (memperlihatkan "step problem" pada naive pro-rata)
# -----------------------------------------------------------------------------
plot2_df <- data.frame(
  date = rep(quarter_dates, 3),
  value = c(denton_result_df$ad_awareness,
            denton_result_df$naive_quarterly_awareness,
            denton_result_df$denton_quarterly_awareness),
  method = rep(c("Indicator asli (ad awareness survey)",
                 "Pro-rata naif (step problem)",
                 "Denton-Cholette (proportional)"),
               each = nrow(denton_result_df))
)
plot2_df$method <- factor(plot2_df$method, levels = c(
  "Indicator asli (ad awareness survey)",
  "Pro-rata naif (step problem)",
  "Denton-Cholette (proportional)"
))

p2 <- ggplot(plot2_df, aes(x = date, y = value, color = method, linetype = method)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  geom_vline(xintercept = as.Date(paste0(2022:2025, "-01-01")), color = "grey70", linetype = "dotted") +
  scale_color_manual(values = c("Indicator asli (ad awareness survey)" = "#999999",
                                 "Pro-rata naif (step problem)" = "#E69F00",
                                 "Denton-Cholette (proportional)" = "#2E86AB")) +
  scale_linetype_manual(values = c("solid", "dashed", "solid")) +
  labs(title = "Denton-Cholette vs Pro-rata Naif",
       subtitle = "Garis putus-putus abu-abu menandai batas pergantian tahun (di sinilah 'step problem' pro-rata naif terlihat)",
       x = NULL, y = "Brand Awareness (%)", color = NULL, linetype = NULL) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

ggsave(file.path("plots", "02_denton_vs_naive_prorate.png"), p2, width = 10, height = 6, dpi = 150)

# -----------------------------------------------------------------------------
# Plot 3: Hasil akhir Denton dengan benchmark tahunan overlay
# -----------------------------------------------------------------------------
annual_step_df <- data.frame(
  date = as.Date(paste0(rep(annual_awareness_df$year, each = 4), "-",
                        sprintf("%02d", rep(c(1,4,7,10), times = nrow(annual_awareness_df))), "-01")),
  value = rep(annual_awareness_df$brand_awareness, each = 4)
)

p3 <- ggplot() +
  geom_line(data = annual_step_df, aes(x = date, y = value, color = "Rata-rata benchmark tahunan"),
            linewidth = 0.8, linetype = "dotted") +
  geom_line(data = denton_result_df, aes(x = date, y = denton_quarterly_awareness, color = "Hasil disagregasi Denton (kuartalan)"),
            linewidth = 1.1) +
  geom_point(data = denton_result_df, aes(x = date, y = denton_quarterly_awareness, color = "Hasil disagregasi Denton (kuartalan)"),
             size = 2) +
  scale_color_manual(values = c("Rata-rata benchmark tahunan" = "#C1272D",
                                 "Hasil disagregasi Denton (kuartalan)" = "#2E86AB")) +
  labs(title = "Hasil Akhir: Brand Awareness Kuartalan (Denton-Cholette)",
       subtitle = "Rata-rata tiap 4 titik kuartalan sama persis dengan benchmark tahunan",
       x = NULL, y = "Brand Awareness (%)", color = NULL) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

ggsave(file.path("plots", "03_denton_final_result.png"), p3, width = 9, height = 5.5, dpi = 150)

# -----------------------------------------------------------------------------
# Plot 4: Hubungan Denton quarterly awareness vs sales, Q1 2021-Q4 2025
#         Facet: Lag-0, Lag-1, Lag-2, Lag-3 kuartal
# -----------------------------------------------------------------------------
n_overlap <- nrow(overlap_df)
lag_labels <- c(
  "0" = "Lag-0 (serentak)",
  "1" = "Lag-1 (awareness -1 kuartal)",
  "2" = "Lag-2 (awareness -2 kuartal)",
  "3" = "Lag-3 (awareness -3 kuartal)"
)

lag_df <- do.call(rbind, lapply(lag_results_df$lag, function(k) {
  data.frame(
    period    = overlap_df$period[(k + 1):n_overlap],
    awareness = overlap_df$denton_quarterly_awareness[1:(n_overlap - k)],
    sales     = overlap_df$sales[(k + 1):n_overlap],
    scenario  = lag_labels[as.character(k)]
  )
}))
lag_df$scenario <- factor(lag_df$scenario, levels = lag_labels)

annot_df <- data.frame(
  scenario = lag_labels[as.character(lag_results_df$lag)],
  label = sprintf("rho = %.2f\np-value = %s", lag_results_df$rho, signif(lag_results_df$p_value, 3))
)
annot_df$scenario <- factor(annot_df$scenario, levels = lag_labels)

p4 <- ggplot(lag_df, aes(x = awareness, y = sales)) +
  geom_point(size = 2.5, color = "#2E86AB") +
  geom_smooth(method = "lm", se = TRUE, color = "#C1272D", fill = "#C1272D", alpha = 0.15) +
  geom_text(data = annot_df, aes(x = -Inf, y = Inf, label = label),
            hjust = -0.1, vjust = 1.3, size = 3.2, fontface = "bold", inherit.aes = FALSE) +
  facet_wrap(~scenario, nrow = 2) +
  labs(title = "Brand Awareness (Denton) vs Sales, Q1 2021-Q4 2025",
       subtitle = paste0("Korelasi Spearman untuk lag 0-3 kuartal\n",
                          "Bukan bagian dari Denton, analisis lanjutan"),
       x = "Brand Awareness Kuartalan (hasil Denton, %)", y = "Sales (kuartalan)") +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(size = 10),
        strip.text = element_text(face = "bold"))

ggsave(file.path("plots", "04_awareness_vs_sales.png"), p4, width = 10, height = 9, dpi = 150)

# -----------------------------------------------------------------------------
# Plot 5: Time series overlay -- awareness vs sales, memperlihatkan pola lag
#         secara visual (kedua series distandardisasi/z-score agar sebanding)
# -----------------------------------------------------------------------------
z <- function(x) (x - mean(x)) / sd(x)

overlap_df$date <- quarter_dates[match(overlap_df$period, denton_result_df$period)]

ts_overlay_df <- data.frame(
  date = overlap_df$date,
  awareness_z = z(overlap_df$denton_quarterly_awareness),
  sales_z     = z(overlap_df$sales)
)
ts_overlay_long <- data.frame(
  date  = rep(ts_overlay_df$date, 2),
  value = c(ts_overlay_df$awareness_z, ts_overlay_df$sales_z),
  series = rep(c("Brand Awareness (Denton, z-score)", "Sales (z-score)"),
               each = nrow(ts_overlay_df))
)

p5 <- ggplot(ts_overlay_long, aes(x = date, y = value, color = series)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.8) +
  scale_color_manual(values = c("Brand Awareness (Denton, z-score)" = "#2E86AB",
                                 "Sales (z-score)" = "#C1272D")) +
  labs(title = "Pola Lag Awareness -> Sales (1 Kuartal)",
       subtitle = paste0("Kedua series distandardisasi (z-score); puncak/lembah sales cenderung\n",
                          "menyusul puncak/lembah awareness satu kuartal kemudian"),
       x = NULL, y = "Nilai terstandardisasi (z-score)", color = NULL) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(size = 10))

ggsave(file.path("plots", "05_awareness_sales_timeseries_lag.png"), p5, width = 10, height = 6, dpi = 150)

# -----------------------------------------------------------------------------
# Plot 6: Cross-correlation Spearman rho vs lag (0-3 kuartal)
# -----------------------------------------------------------------------------
lag_results_df$scenario <- factor(lag_labels[as.character(lag_results_df$lag)], levels = lag_labels)

p6 <- ggplot(lag_results_df, aes(x = factor(lag), y = rho, fill = signif)) +
  geom_col(width = 0.6) +
  geom_hline(yintercept = 0, color = "grey40") +
  geom_text(aes(label = sprintf("rho=%.2f\np=%s", rho, signif(p_value, 3))),
            vjust = ifelse(lag_results_df$rho >= 0, -0.3, 1.2), size = 3.4, fontface = "bold") +
  scale_fill_manual(values = c("signifikan (p<0.05)" = "#2E86AB",
                                "tidak signifikan" = "#B0B0B0")) +
  scale_y_continuous(limits = c(min(0, min(lag_results_df$rho) - 0.15), max(lag_results_df$rho) + 0.2)) +
  labs(title = "Cross-correlation: Korelasi Spearman Awareness-Sales per Lag",
       subtitle = "Lag optimal terlihat pada kuartal dengan |rho| tertinggi dan signifikan",
       x = "Lag (kuartal, awareness mendahului sales)", y = "Spearman rho", fill = NULL) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(size = 10))

ggsave(file.path("plots", "06_cross_correlation_by_lag.png"), p6, width = 8, height = 5.5, dpi = 150)

cat("6 file PNG berhasil disimpan ke folder plots/\n")
