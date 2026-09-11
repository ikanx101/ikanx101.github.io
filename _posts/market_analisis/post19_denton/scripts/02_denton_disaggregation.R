# =============================================================================
# 02_denton_disaggregation.R
# Menerapkan metode Denton (proportional Denton-Cholette) untuk
# mendisagregasi brand awareness TAHUNAN (benchmark) menjadi KUARTALAN,
# menggunakan ad awareness survey kuartalan sebagai indicator series.
#
# Sebagai pembanding, dihitung juga hasil pro-rata naif (tanpa smoothing)
# untuk menunjukkan "step problem" di batas tahun yang diperbaiki oleh Denton.
# =============================================================================

library(tempdisagg)

load(file.path("output", "01_simulated_data.rda"))

# -----------------------------------------------------------------------------
# 1. Denton-Cholette (proportional) disaggregation
#    conversion = "average" karena brand awareness adalah indeks/persentase
#    (stock-like), bukan flow -> rata-rata kuartalan harus sama dengan
#    nilai tahunan, bukan dijumlahkan.
# -----------------------------------------------------------------------------
denton_model <- td(
  annual_awareness_ts ~ 0 + ad_awareness_ts,
  conversion = "average",
  method     = "denton-cholette",
  criterion  = "proportional"
)

denton_result_ts <- predict(denton_model)

# -----------------------------------------------------------------------------
# 2. Pro-rata naif sebagai pembanding: setiap tahun, quarterly share indicator
#    dikalikan langsung ke nilai tahunan (rata-rata dipertahankan per tahun,
#    tapi TANPA constraint kemulusan lintas-tahun) -> akan terlihat "step".
# -----------------------------------------------------------------------------
naive_prorate <- numeric(length(ad_awareness_ts))
for (yr in unique(ad_awareness_df$year)) {
  idx <- which(ad_awareness_df$year == yr)
  annual_val <- annual_awareness_df$brand_awareness[annual_awareness_df$year == yr]
  indicator_vals <- ad_awareness_df$ad_awareness[idx]
  # skala indicator supaya rata-ratanya persis sama dengan annual_val
  naive_prorate[idx] <- indicator_vals * (annual_val / mean(indicator_vals))
}
naive_prorate_ts <- ts(naive_prorate, start = c(2021, 1), frequency = 4)

# -----------------------------------------------------------------------------
# 3. Cek konsistensi: rata-rata kuartalan per tahun harus sama dengan benchmark
# -----------------------------------------------------------------------------
check_df <- data.frame(
  year             = years <- annual_awareness_df$year,
  benchmark_annual = annual_awareness_df$brand_awareness,
  denton_avg       = tapply(denton_result_ts, floor(time(denton_result_ts)), mean),
  naive_avg        = tapply(naive_prorate_ts, floor(time(naive_prorate_ts)), mean)
)
check_df$denton_diff <- round(check_df$denton_avg - check_df$benchmark_annual, 6)
check_df$naive_diff  <- round(check_df$naive_avg - check_df$benchmark_annual, 6)

cat("=== Cek konsistensi benchmark (harus ~0) ===\n")
print(check_df)

# -----------------------------------------------------------------------------
# 4. Susun data.frame hasil akhir untuk plotting & interpretasi
# -----------------------------------------------------------------------------
denton_result_df <- data.frame(
  year         = ad_awareness_df$year,
  quarter      = ad_awareness_df$quarter,
  period       = ad_awareness_df$period,
  ad_awareness = ad_awareness_df$ad_awareness,
  denton_quarterly_awareness = round(as.numeric(denton_result_ts), 2),
  naive_quarterly_awareness  = round(as.numeric(naive_prorate_ts), 2)
)

# -----------------------------------------------------------------------------
# 5. Analisis hubungan brand awareness (hasil Denton) vs sales, Q1 2021-Q4 2025
#    -- BUKAN bagian dari Denton itu sendiri, tapi analisis lanjutan yang
#    relevan untuk market research (sales tidak punya benchmark tahunan
#    sendiri sehingga tidak bisa langsung didisagregasi dengan Denton).
#    Diuji lag 0, 1, 2, dan 3 kuartal:
#      lag-k : sales(t) vs denton_awareness(t-k)
# -----------------------------------------------------------------------------
overlap_df <- merge(
  denton_result_df,
  sales_df[, c("period", "sales")],
  by = "period"
)
overlap_df <- overlap_df[order(overlap_df$year, overlap_df$quarter), ]
n_overlap <- nrow(overlap_df)

max_lag <- 3
lag_cortests <- vector("list", max_lag + 1)
names(lag_cortests) <- paste0("lag", 0:max_lag)

for (k in 0:max_lag) {
  awareness_k <- overlap_df$denton_quarterly_awareness[1:(n_overlap - k)]
  sales_k     <- overlap_df$sales[(k + 1):n_overlap]
  lag_cortests[[paste0("lag", k)]] <- cor.test(awareness_k, sales_k, method = "spearman")
}

lag_results_df <- data.frame(
  lag     = 0:max_lag,
  n_pairs = n_overlap - (0:max_lag),
  rho     = sapply(lag_cortests, function(x) unname(x$estimate)),
  p_value = sapply(lag_cortests, function(x) x$p.value)
)
lag_results_df$signif <- ifelse(lag_results_df$p_value < 0.05, "signifikan (p<0.05)", "tidak signifikan")

cat("\n=== Korelasi Spearman: Denton quarterly awareness vs sales, lag 0-3 kuartal ===\n")
print(lag_results_df, row.names = FALSE)

# variabel individual (dipertahankan untuk kompatibilitas skrip visualisasi)
cortest_lag0 <- lag_cortests$lag0
cortest_lag1 <- lag_cortests$lag1
cortest_lag2 <- lag_cortests$lag2
cortest_lag3 <- lag_cortests$lag3

# -----------------------------------------------------------------------------
# Simpan semua hasil
# -----------------------------------------------------------------------------
save(
  denton_model, denton_result_ts, naive_prorate_ts,
  denton_result_df, check_df, overlap_df,
  lag_cortests, lag_results_df,
  cortest_lag0, cortest_lag1, cortest_lag2, cortest_lag3,
  file = file.path("output", "02_denton_results.rda")
)

cat("\nHasil disimpan ke output/02_denton_results.rda\n")
