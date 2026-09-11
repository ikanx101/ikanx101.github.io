# =============================================================================
# 01_generate_data.R
# Simulasi 3 dataset untuk studi kasus Denton temporal disaggregation:
#   1. Brand awareness TAHUNAN (2021-2025)      -> benchmark (low-frequency)
#   2. Ad awareness survey KUARTALAN (Q1 2021-Q4 2025) -> indicator (high-frequency)
#   3. Sales KUARTALAN (Q1 2021-Q4 2025)        -> series pembanding, sengaja
#      dibuat berkorelasi positif KUAT dengan ad awareness tapi DENGAN LAG
#      1 KUARTAL (sales kuartal ini mengikuti awareness kuartal sebelumnya),
#      supaya korelasi serentak (lag-0) lemah tapi korelasi lag-1 kuat.
# Semua output disimpan sebagai .rda ke folder output/
# =============================================================================

set.seed(2025)

# -----------------------------------------------------------------------------
# 1. Brand awareness TAHUNAN (2021-2025), Normal(mean = 70, sd = 10)
# -----------------------------------------------------------------------------
years <- 2021:2025
brand_awareness_annual <- rnorm(n = length(years), mean = 70, sd = 10)
brand_awareness_annual <- pmin(pmax(brand_awareness_annual, 0), 100)  # clip ke 0-100%

annual_awareness_df <- data.frame(
  year = years,
  brand_awareness = round(brand_awareness_annual, 2)
)

annual_awareness_ts <- ts(annual_awareness_df$brand_awareness,
                           start = 2021, frequency = 1)

# -----------------------------------------------------------------------------
# 2. Ad awareness survey KUARTALAN (Q1 2021 - Q4 2025) -> indicator series
#    Dibangun dengan tren ringan + pola musiman kuartalan + noise AR(1),
#    berputar di sekitar level yang mirip brand awareness tahunan supaya
#    disagregasi menghasilkan hasil yang masuk akal.
#    Digenerate mulai dari Q4 2020 (1 kuartal ekstra "bayangan/seed", TIDAK
#    dipakai sebagai indicator resmi) supaya sales Q1 2021 tetap punya nilai
#    awareness kuartal-sebelumnya untuk membentuk hubungan lag 1 kuartal.
# -----------------------------------------------------------------------------
n_q_full <- 20  # 5 tahun x 4 kuartal (Q1 2021 - Q4 2025), indicator resmi
n_q_ext  <- n_q_full + 1  # + 1 kuartal seed (Q4 2020)

quarters_full <- seq(as.Date("2021-01-01"), by = "quarter", length.out = n_q_full)
quarters_ext  <- seq(as.Date("2020-10-01"), by = "quarter", length.out = n_q_ext)

trend_full <- seq(-1.5, 1.5, length.out = n_q_full)  # tren dijaga ringan supaya tidak mendominasi lag-1
trend_ext  <- c(trend_full[1] - diff(trend_full)[1], trend_full)  # ekstrapolasi 1 titik ke belakang

quarter_num_ext   <- as.numeric(substr(quarters(quarters_ext), 2, 2))
seasonal_lookup   <- c(`1` = 2, `2` = -1, `3` = -3, `4` = 2)
seasonal_ext      <- unname(seasonal_lookup[as.character(quarter_num_ext)])

# koefisien AR sengaja dijaga kecil (0.3) supaya awareness(t) tidak terlalu
# mirip dengan awareness(t-1) -- ini yang membuat korelasi lag-0 tetap lemah
# sementara hubungan lag-1 yang dibangun secara eksplisit ke sales tetap kuat.
ar_noise_ext <- numeric(n_q_ext)
ar_noise_ext[1] <- rnorm(1, 0, 3)
for (i in 2:n_q_ext) {
  ar_noise_ext[i] <- 0.3 * ar_noise_ext[i - 1] + rnorm(1, 0, 3)
}

ad_awareness_ext <- 65 + trend_ext + seasonal_ext + ar_noise_ext
ad_awareness_ext <- pmin(pmax(ad_awareness_ext, 0), 100)  # clip ke 0-100%, index 1 = Q4 2020 (seed)

ad_awareness_quarterly <- ad_awareness_ext[-1]  # buang seed -> Q1 2021...Q4 2025 (20 titik resmi)

ad_awareness_df <- data.frame(
  year    = as.numeric(format(quarters_full, "%Y")),
  quarter = as.numeric(substr(quarters(quarters_full), 2, 2)),
  period  = paste0(format(quarters_full, "%Y"), "-Q", substr(quarters(quarters_full), 2, 2)),
  ad_awareness = round(ad_awareness_quarterly, 2)
)

ad_awareness_ts <- ts(ad_awareness_df$ad_awareness,
                      start = c(2021, 1), frequency = 4)

# -----------------------------------------------------------------------------
# 3. Sales KUARTALAN (Q1 2021 - Q4 2025) -> series pembanding.
#    Sengaja dibuat berkorelasi positif KUAT dengan ad_awareness, TAPI dengan
#    LAG 1 KUARTAL: sales(t) mengikuti ad_awareness(t-1), bukan ad_awareness(t).
#    Sales sendiri tidak punya benchmark tahunan sendiri sehingga tidak bisa
#    langsung didisagregasi dengan Denton.
# -----------------------------------------------------------------------------
n_q_sales <- n_q_full  # 5 tahun x 4 kuartal, sama seperti ad_awareness
quarters_sales <- quarters_full

awareness_lag1 <- ad_awareness_ext[1:n_q_sales]  # = ad_awareness kuartal SEBELUM tiap titik sales

# pola musiman sales dibuat ADITIF (bukan mengalikan efek awareness) supaya
# tidak mendistorsi hubungan monotonik lag-1 antara awareness dan sales
sales_seasonal_add <- rep(c(15, -10, -20, 25), length.out = n_q_sales)  # Q4 lebih tinggi (musiman)
sales_noise         <- rnorm(n_q_sales, mean = 0, sd = 8)

sales_quarterly <- 500 + 14 * (awareness_lag1 - mean(awareness_lag1)) + sales_seasonal_add + sales_noise
sales_quarterly <- pmax(sales_quarterly, 0)

sales_df <- data.frame(
  year    = as.numeric(format(quarters_sales, "%Y")),
  quarter = as.numeric(substr(quarters(quarters_sales), 2, 2)),
  period  = paste0(format(quarters_sales, "%Y"), "-Q", substr(quarters(quarters_sales), 2, 2)),
  sales   = round(sales_quarterly, 1)
)

sales_ts <- ts(sales_df$sales, start = c(2021, 1), frequency = 4)

# -----------------------------------------------------------------------------
# Simpan semua objek ke output/01_simulated_data.rda
# -----------------------------------------------------------------------------
save(
  annual_awareness_df, annual_awareness_ts,
  ad_awareness_df, ad_awareness_ts,
  sales_df, sales_ts,
  file = file.path("output", "01_simulated_data.rda")
)

cat("Data berhasil digenerate dan disimpan ke output/01_simulated_data.rda\n")
print(annual_awareness_df)
print(ad_awareness_df)
print(sales_df)
