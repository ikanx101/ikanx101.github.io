# =============================================================================
# buat_grafik.R
# Membuat semua grafik untuk tulisan "forecast dengan regresi + kolom Lebaran".
# Data: penjualan.xlsx (distributor fiktif, tanggal Lebaran asli) dari materi
# Financial Analytics URI pekan 7.
# =============================================================================
suppressPackageStartupMessages({
  library(readxl); library(dplyr); library(tidyr); library(ggplot2)
  library(patchwork); library(scales); library(forecast)
})

FILE_SALES <- "/Users/ikanx101/Documents/local-AI-agent-setup/The_Slides/URI/pekan_7/penjualan.xlsx"
OUT <- "/Users/ikanx101/Documents/ikanx101.github.io/_posts/market_analisis/post23_forecast_regresi"

BIRU <- "#2a78d6"; MERAH <- "#d64545"; ABU <- "#a3a3a3"; GELAP <- "#333333"
koma <- function(x, d = 1) formatC(x, format = "f", digits = d, decimal.mark = ",")
tema <- theme_minimal(base_size = 13) +
  theme(panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(),
        plot.title = element_text(face = "bold", size = 15),
        plot.subtitle = element_text(colour = "#555555"),
        plot.caption = element_text(colour = "#555555", hjust = 0),
        axis.text = element_text(colour = "#555555"),
        legend.position = "top", legend.title = element_blank())
simpan <- function(g, nama, w = 10, h = 5.2) {
  ggsave(file.path(OUT, nama), g, width = w, height = h, dpi = 160, bg = "white")
  message("tersimpan: ", nama)
}

LEBARAN <- as.Date(c("2019-06-05", "2020-05-24", "2021-05-13", "2022-05-02",
                     "2023-04-22", "2024-04-10", "2025-03-31", "2026-03-20",
                     "2027-03-10"))

bulanan <- read_excel(FILE_SALES, sheet = "monthly") |>
  mutate(tanggal = as.Date(paste0(month, "-01")))
aktual <- bulanan |> filter(!is.na(sales_billion_idr))
latih  <- bulanan |> filter(set == "training")
uji    <- bulanan |> filter(set == "test")
depan  <- bulanan |> filter(set == "forecast 2027")
mape   <- function(f, a) mean(abs(f - a) / a) * 100
BLN <- c("Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des")

# ---- 1. data bulanan -----------------------------------------------------------
puncak <- aktual |> filter(lebaran_busy_days >= 10)
g1 <- ggplot(aktual, aes(tanggal, sales_billion_idr)) +
  annotate("rect", xmin = as.Date("2020-04-01"), xmax = as.Date("2021-03-31"),
           ymin = -Inf, ymax = Inf, fill = "#eeeeee") +
  annotate("text", x = as.Date("2020-10-01"), y = 88, label = "pandemi",
           colour = "#777777", size = 4) +
  geom_line(colour = ABU, linewidth = 0.8) +
  geom_point(data = puncak, colour = MERAH, size = 3) +
  geom_text(data = puncak, aes(label = paste(BLN[as.integer(format(tanggal, "%m"))], format(tanggal, "%y"))), vjust = -1,
            size = 3.4, colour = MERAH) +
  scale_y_continuous(limits = c(25, 92)) +
  labs(title = "Penjualan bulanan, Januari 2019 - September 2026",
       subtitle = "Titik merah: bulan yang memuat minimal 10 hari belanja menjelang Lebaran",
       x = NULL, y = "miliar rupiah",
       caption = "Data: distributor makanan kemasan fiktif. Tanggal Lebaran asli.") + tema
simpan(g1, "penjualan-bulanan.png")

# ---- 2. dekomposisi ---------------------------------------------------------------
y   <- ts(aktual$sales_billion_idr, start = c(2019, 1), frequency = 12)
dek <- stl(y, s.window = "periodic")
komp <- data.frame(tanggal = aktual$tanggal,
                   Trend = as.numeric(dek$time.series[, "trend"]),
                   Musiman = as.numeric(dek$time.series[, "seasonal"]),
                   Sisa = as.numeric(dek$time.series[, "remainder"]),
                   lebaran = aktual$lebaran_busy_days >= 10)
p_tr <- ggplot(komp, aes(tanggal, Trend)) + geom_line(colour = BIRU, linewidth = 0.9) +
  labs(title = "Trend", subtitle = "naik pelan tapi pasti", x = NULL, y = NULL) + tema
p_se <- ggplot(komp, aes(tanggal, Musiman)) + geom_line(colour = BIRU, linewidth = 0.7) +
  labs(title = "Musiman", subtitle = "bentuk 12 bulan yang sama, diulang", x = NULL, y = NULL) + tema
p_si <- ggplot(komp, aes(tanggal, Sisa)) +
  geom_hline(yintercept = 0, colour = "#cccccc") +
  geom_line(colour = ABU, linewidth = 0.7) +
  geom_point(data = filter(komp, lebaran), colour = MERAH, size = 2.6) +
  labs(title = "Sisa (tak terjelaskan)", subtitle = "titik merah = bulan Lebaran", x = NULL, y = NULL) + tema
g2 <- (p_tr | p_se | p_si) +
  plot_annotation(caption = "Dekomposisi STL dengan pola musiman tetap (s.window = \"periodic\"). Satuan: miliar rupiah.",
                  theme = tema)
simpan(g2, "dekomposisi.png", w = 12, h = 4.4)

# ---- 3. Lebaran bergeser: jendela belanja & libur per tahun ----------------------
jendela <- data.frame(tahun = as.integer(format(LEBARAN, "%Y")), L = LEBARAN)
ke_2000 <- function(d) as.Date(paste0("2000-", format(d, "%m-%d")))  # tahun kabisat acuan
blok <- bind_rows(
  jendela |> transmute(tahun, jenis = "Hari belanja (H-21 s.d. H-2)",
                       mulai = ke_2000(L - 21), akhir = ke_2000(L - 2)),
  jendela |> transmute(tahun, jenis = "Hari libur (H-1 s.d. H+5)",
                       mulai = ke_2000(L - 1), akhir = ke_2000(L + 5))
)
batas_bulan <- as.Date(c("2000-02-01", "2000-03-01", "2000-04-01", "2000-05-01", "2000-06-01", "2000-07-01"))
g3 <- ggplot(blok) +
  geom_vline(xintercept = batas_bulan, colour = "#dddddd") +
  geom_segment(aes(x = mulai, xend = akhir + 1, y = factor(tahun), yend = factor(tahun), colour = jenis),
               linewidth = 6) +
  geom_point(data = jendela, aes(ke_2000(L), factor(tahun)), shape = 21, fill = "white",
             colour = GELAP, size = 2.6) +
  annotate("text", x = batas_bulan[-6] + 14, y = 9.85,
           label = c("Februari", "Maret", "April", "Mei", "Juni"), colour = "#777777", size = 3.8) +
  scale_colour_manual(values = c(BIRU, MERAH)) +
  scale_x_date(limits = as.Date(c("2000-02-01", "2000-07-01")), labels = NULL, breaks = NULL) +
  scale_y_discrete(limits = rev) +
  coord_cartesian(clip = "off") +
  labs(title = "Lebaran maju sekitar 11 hari setiap tahun",
       subtitle = "Lingkaran putih = hari Lebaran. Garis tipis = pergantian bulan.",
       x = NULL, y = NULL,
       caption = "Jendela belanja sering terbelah oleh pergantian bulan, sehingga dampaknya terbagi ke dua bulan.") + tema
simpan(g3, "lebaran-bergeser.png", w = 10, h = 5.6)

# ---- 4. cara lama: time series murni pada 12 bulan uji ---------------------------
y_latih <- ts(latih$sales_billion_idr, start = c(2019, 1), frequency = 12)
fc_ets   <- as.numeric(forecast(ets(y_latih), h = 12)$mean)
fc_arima <- as.numeric(forecast(auto.arima(y_latih), h = 12)$mean)
fc_snaiv <- as.numeric(snaive(y_latih, h = 12)$mean)

# baseline: tahun lalu + pertumbuhan
s <- bulanan$sales_billion_idr; idx <- which(bulanan$set == "test")
g_growth <- sum(s[idx - 12]) / sum(s[idx - 24]) - 1
fc_base  <- s[idx - 12] * (1 + g_growth)

# regresi tiga langkah
bulan_cols <- paste(month.abb[2:12], collapse = " + ")
rumus <- list(
  step1 = ln_sales ~ time_index + pandemic,
  step2 = as.formula(paste("ln_sales ~ time_index + pandemic +", bulan_cols)),
  step3 = as.formula(paste("ln_sales ~ time_index + pandemic +", bulan_cols,
                           "+ lebaran_busy_days + lebaran_holiday_days")))
mod <- lapply(rumus, lm, data = latih)
fc_reg <- sapply(mod, \(m) exp(predict(m, newdata = uji)))

skor <- data.frame(
  metode = c("Tahun lalu + pertumbuhan", "Seasonal naive", "ETS (Holt-Winters)", "Auto ARIMA",
             "Regresi langkah 1: trend", "Regresi langkah 2: + bulan", "Regresi langkah 3: + Lebaran"),
  keluarga = c("Cara lama", "Time series", "Time series", "Time series", "Regresi", "Regresi", "Regresi"),
  mape = c(mape(fc_base, uji$sales_billion_idr), mape(fc_snaiv, uji$sales_billion_idr),
           mape(fc_ets, uji$sales_billion_idr), mape(fc_arima, uji$sales_billion_idr),
           apply(fc_reg, 2, mape, a = uji$sales_billion_idr)))
print(skor)
print(data.frame(bulan = uji$month, aktual = uji$sales_billion_idr, arima = round(fc_arima, 2), ets = round(fc_ets, 2), snaive = round(fc_snaiv, 2)))
cat("Model ETS terpilih:", ets(y_latih)$method, "\n")
cat("Model ARIMA terpilih:"); print(auto.arima(y_latih))
write.csv(skor, file.path(OUT, "scripts", "skor_mape.csv"), row.names = FALSE)

lab_bln <- c("Okt", "Nov", "Des", "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep")
ts_df <- data.frame(no = 1:12, Aktual = uji$sales_billion_idr,
                    `ETS (Holt-Winters)` = fc_ets, `Auto ARIMA` = fc_arima, check.names = FALSE) |>
  pivot_longer(-c(no, Aktual), names_to = "model", values_to = "fc")
g4 <- ggplot(ts_df, aes(no)) +
  annotate("rect", xmin = 4.5, xmax = 7.5, ymin = -Inf, ymax = Inf, fill = "#fdeeee") +
  annotate("text", x = 6, y = 50.5, label = "zona Lebaran 2026", colour = MERAH, size = 3.6) +
  geom_line(aes(y = Aktual), colour = GELAP, linewidth = 1) +
  geom_point(aes(y = Aktual), colour = GELAP, size = 1.8) +
  geom_line(aes(y = fc), colour = BIRU, linewidth = 0.9, linetype = "dashed") +
  facet_wrap(~model) +
  scale_x_continuous(breaks = 1:12, labels = lab_bln) +
  scale_y_continuous(limits = c(50, 92)) +
  labs(title = "Time series murni: lonjakan Lebaran tidak mendarat dengan benar",
       subtitle = "Garis hitam = aktual, putus-putus biru = forecast. Data latih: Jan 2019 - Sep 2025",
       x = NULL, y = "miliar rupiah") + tema
simpan(g4, "time-series-meleset.png", w = 11, h = 4.8)

# ---- 5. baseline vs aktual ---------------------------------------------------------
base_df <- data.frame(no = 1:12, Aktual = uji$sales_billion_idr, fc = fc_base)
g5 <- ggplot(base_df, aes(no)) +
  geom_segment(aes(xend = no, y = Aktual, yend = fc), colour = MERAH, linewidth = 1.6, alpha = .5) +
  geom_line(aes(y = Aktual), colour = GELAP, linewidth = 1) +
  geom_line(aes(y = fc), colour = ABU, linewidth = 0.9, linetype = "dashed") +
  geom_point(aes(y = fc), colour = ABU, size = 2) +
  annotate("text", x = 7.4, y = 84, hjust = 0, size = 3.7, colour = MERAH,
           label = "Mar 2026 ditebak 88,3\n(menyalin Lebaran Mar 2025)\naktualnya 69,4") +
  scale_x_continuous(breaks = 1:12, labels = lab_bln) +
  labs(title = "\"Tahun lalu + pertumbuhan\" vs aktual",
       subtitle = "Garis hitam = aktual, abu-abu putus-putus = forecast, batang merah = error",
       x = NULL, y = "miliar rupiah") + tema
simpan(g5, "baseline-vs-aktual.png", w = 10, h = 4.8)

# ---- 6. tiga langkah regresi ------------------------------------------------------
reg_df <- data.frame(no = 1:12, Aktual = uji$sales_billion_idr, fc_reg) |>
  pivot_longer(starts_with("step"), names_to = "langkah", values_to = "fc") |>
  mutate(langkah = recode(langkah,
    step1 = paste0("Langkah 1: trend saja (MAPE ", koma(mape(fc_reg[, 1], uji$sales_billion_idr)), "%)"),
    step2 = paste0("Langkah 2: + bulan (MAPE ", koma(mape(fc_reg[, 2], uji$sales_billion_idr)), "%)"),
    step3 = paste0("Langkah 3: + Lebaran (MAPE ", koma(mape(fc_reg[, 3], uji$sales_billion_idr)), "%)")))
g6 <- ggplot(reg_df, aes(no)) +
  annotate("rect", xmin = 4.5, xmax = 7.5, ymin = -Inf, ymax = Inf, fill = "#fdeeee") +
  geom_line(aes(y = Aktual), colour = GELAP, linewidth = 1) +
  geom_point(aes(y = Aktual), colour = GELAP, size = 1.6) +
  geom_line(aes(y = fc), colour = BIRU, linewidth = 1, linetype = "dashed") +
  facet_wrap(~langkah, ncol = 3) +
  scale_x_continuous(breaks = c(1, 4, 6, 9, 12), labels = lab_bln[c(1, 4, 6, 9, 12)]) +
  labs(title = "Regresi yang dibangun tiga langkah, diuji di 12 bulan yang sama",
       subtitle = "Garis hitam = aktual, putus-putus biru = forecast. Area merah muda = Feb - Apr 2026",
       x = NULL, y = "miliar rupiah") + tema
simpan(g6, "tiga-langkah.png", w = 12, h = 4.6)

# ---- 7. papan skor ---------------------------------------------------------------
g7 <- skor |>
  mutate(metode = factor(metode, rev(metode))) |>
  ggplot(aes(mape, metode, fill = keluarga)) +
  geom_col(width = 0.65) +
  geom_text(aes(label = paste0(koma(mape), "%")), hjust = -0.15, size = 4) +
  scale_fill_manual(values = c("Cara lama" = ABU, "Time series" = "#9cc3ee", "Regresi" = BIRU)) +
  scale_x_continuous(expand = expansion(mult = c(0, .15))) +
  labs(title = "Papan skor: rata-rata error (MAPE) pada 12 bulan uji",
       subtitle = "Oktober 2025 - September 2026. Makin pendek makin baik.",
       x = "MAPE (%)", y = NULL) + tema +
  theme(panel.grid.major.y = element_blank(), panel.grid.major.x = element_line(colour = "#eeeeee"))
simpan(g7, "papan-skor.png", w = 10, h = 5)

# ---- 8. efek tiap kolom ------------------------------------------------------------
b <- coef(mod$step3)
efek <- data.frame(
  kolom = c("Tiap hari belanja\nmenjelang Lebaran", "Tiap hari libur\nLebaran",
            "Desember\n(dibanding Januari)", "Tiap bulan berlalu\n(pertumbuhan)", "Bulan pandemi"),
  e = (exp(b[c("lebaran_busy_days", "lebaran_holiday_days", "Dec", "time_index", "pandemic")]) - 1) * 100) |>
  mutate(kolom = factor(kolom, rev(kolom)), arah = e > 0)
g8 <- ggplot(efek, aes(e, kolom, fill = arah)) +
  geom_col(width = 0.6) +
  geom_vline(xintercept = 0, colour = GELAP) +
  geom_text(aes(label = paste0(ifelse(e > 0, "+", ""), koma(e), "%"),
                hjust = ifelse(e > 0, -0.15, 1.15)), size = 4.2) +
  scale_fill_manual(values = c(`TRUE` = BIRU, `FALSE` = MERAH), guide = "none") +
  scale_x_continuous(limits = c(-17, 19)) +
  labs(title = "Apa yang dipelajari regresi (langkah 3)",
       subtitle = "Efek = e^b - 1. Efeknya saling mengalikan, bukan menjumlah.",
       x = "efek terhadap penjualan bulan itu (%)", y = NULL) + tema +
  theme(panel.grid.major.y = element_blank())
simpan(g8, "efek-kolom.png", w = 10, h = 4.8)

# ---- 9. forecast 2027 --------------------------------------------------------------
semua <- aktual
m2_all <- lm(rumus$step2, data = semua)
m3_all <- lm(rumus$step3, data = semua)
ramal <- function(m, d) {
  p <- predict(m, newdata = d, interval = "prediction", level = 0.80)
  s2 <- summary(m)$sigma^2
  data.frame(tanggal = d$tanggal, low = exp(p[, "lwr"]), fc = exp(p[, "fit"] + s2 / 2), high = exp(p[, "upr"]))
}
fc3 <- ramal(m3_all, depan); fc2 <- ramal(m2_all, depan)
print(fc3)
hist <- semua |> filter(tanggal >= as.Date("2025-01-01"))
g9 <- ggplot() +
  geom_ribbon(data = fc3, aes(tanggal, ymin = low, ymax = high), fill = "#d6e6f8") +
  geom_line(data = hist, aes(tanggal, sales_billion_idr), colour = GELAP, linewidth = 1) +
  geom_line(data = fc3, aes(tanggal, fc), colour = BIRU, linewidth = 1, linetype = "dashed") +
  geom_point(data = filter(fc3, tanggal == as.Date("2027-02-01")), aes(tanggal, fc), colour = BIRU, size = 3) +
  annotate("text", x = as.Date("2027-02-01"), y = 86, size = 3.8, colour = BIRU,
           label = "Feb 2027: 78,0\n(73,7 - 82,5)") +
  annotate("text", x = as.Date("2025-03-01"), y = 87.5, size = 3.6, colour = GELAP,
           label = "Lebaran 2025") +
  labs(title = "Forecast Oktober 2026 - September 2027 dengan rentang 80%",
       subtitle = "Model langkah 3 di-fit ulang dengan seluruh 93 bulan data",
       x = NULL, y = "miliar rupiah") + tema
simpan(g9, "forecast-2027.png", w = 10, h = 4.8)

# ---- 10. dengan vs tanpa kolom Lebaran, Feb-Mar 2027 ------------------------------
bd <- data.frame(
  model = rep(c("Langkah 2 (tanpa kolom Lebaran)", "Langkah 3 (dengan kolom Lebaran)"), each = 2),
  bulan = rep(c("Februari 2027", "Maret 2027"), 2),
  nilai = c(fc2$fc[format(fc2$tanggal, "%m") %in% c("02", "03")],
            fc3$fc[format(fc3$tanggal, "%m") %in% c("02", "03")]))
print(bd)
g10 <- ggplot(bd, aes(bulan, nilai, fill = model)) +
  geom_col(position = position_dodge(0.7), width = 0.65) +
  geom_text(aes(label = koma(nilai)), position = position_dodge(0.7), vjust = -0.5, size = 4.4) +
  scale_fill_manual(values = c(ABU, BIRU)) +
  scale_y_continuous(limits = c(0, 90)) +
  labs(title = "Tanpa kolom Lebaran, Rp14 miliar mendarat di bulan yang salah",
       subtitle = "Lebaran 2027 sekitar 10 Maret, jadi hari belanjanya jatuh di Februari",
       x = NULL, y = "miliar rupiah") + tema +
  theme(panel.grid.major.y = element_line(colour = "#eeeeee"))
simpan(g10, "dengan-tanpa-lebaran.png", w = 9, h = 5)
