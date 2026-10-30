# =============================================================================
# buat_grafik.R
# Membuat semua grafik untuk tulisan "survey tracking kuartalan n=100 dan target marketing".
# Semua data adalah simulasi (brand X fiktif, penetrasi sebenarnya ~7%).
# =============================================================================
suppressPackageStartupMessages({
  library(dplyr); library(tidyr); library(ggplot2); library(patchwork); library(scales)
})

OUT <- "/Users/ikanx101/Documents/ikanx101.github.io/_posts/market_analisis/post24_tracking"

BIRU <- "#2a78d6"; MERAH <- "#d64545"; ABU <- "#a3a3a3"; GELAP <- "#333333"; HIJAU <- "#2e9e6a"
koma <- function(x, d = 1) formatC(x, format = "f", digits = d, decimal.mark = ",")
persen <- function(x, d = 0) paste0(koma(100 * x, d), "%")
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

# ---- fungsi bantu ---------------------------------------------------------------
wald <- function(x, n, z = 1.96) {
  p <- x / n
  cbind(p - z * sqrt(p * (1 - p) / n), p + z * sqrt(p * (1 - p) / n))
}
wilson <- function(x, n, z = 1.96) {
  p <- x / n
  pusat <- (p + z^2 / (2 * n)) / (1 + z^2 / n)
  lebar <- z / (1 + z^2 / n) * sqrt(p * (1 - p) / n + z^2 / (4 * n^2))
  cbind(pusat - lebar, pusat + lebar)
}
P_ASLI <- 0.07
N <- 100

# ---- 1. margin of error tergantung proporsi --------------------------------------
moe <- tibble(p = seq(0.005, 0.995, by = 0.005)) |>
  mutate(moe = 1.96 * sqrt(p * (1 - p) / N))
titik <- tibble(p = c(0.07, 0.5)) |> mutate(moe = 1.96 * sqrt(p * (1 - p) / N),
  label = c("brand X (7%)\nMoE ±5,0 poin", "angka 'keramat' (50%)\nMoE ±9,8 poin"))
g1 <- ggplot(moe, aes(p, moe)) +
  geom_line(colour = BIRU, linewidth = 1) +
  geom_point(data = titik, colour = MERAH, size = 3.5) +
  geom_text(data = titik, aes(label = label), vjust = c(-0.5, 1.6), hjust = c(-0.05, 0.5),
            colour = MERAH, size = 3.8, lineheight = 0.9) +
  scale_x_continuous(labels = percent_format(accuracy = 1), breaks = seq(0, 1, 0.1)) +
  scale_y_continuous(labels = function(x) paste0("±", koma(100 * x, 0), " poin"), limits = c(0, 0.105)) +
  labs(title = "Margin of error survey n = 100 tidak selalu 10%",
       subtitle = "Angka ±10% hanya berlaku kalau proporsinya sekitar 50%. Makin ke pinggir, makin kecil",
       x = "proporsi hasil survey", y = "margin of error (95%)") + tema
simpan(g1, "moe-vs-proporsi.png")

# ---- 2. wald vs wilson ----------------------------------------------------------
kasus <- c(0, 2, 7, 15, 50)
iv <- bind_rows(
  tibble(x = kasus, metode = "Wald (rumus MoE biasa)", lo = wald(kasus, N)[, 1], hi = wald(kasus, N)[, 2]),
  tibble(x = kasus, metode = "Wilson", lo = wilson(kasus, N)[, 1], hi = wilson(kasus, N)[, 2])) |>
  mutate(kasus = factor(paste0(x, " dari 100"), levels = rev(paste0(kasus, " dari 100"))))
g2 <- ggplot(iv, aes(y = kasus, colour = metode)) +
  geom_blank() +
  annotate("rect", xmin = -Inf, xmax = 0, ymin = -Inf, ymax = Inf, fill = "#fbe9e9") +
  annotate("text", x = -0.02, y = 4.5, label = "mustahil\n(< 0%)", colour = MERAH, size = 3.3, lineheight = 0.9) +
  geom_vline(xintercept = 0, colour = GELAP, linewidth = 0.3) +
  geom_linerange(aes(xmin = lo, xmax = hi), linewidth = 2.2,
                 position = position_dodge(width = 0.55)) +
  geom_point(aes(x = x / N), position = position_dodge(width = 0.55), size = 2.2, colour = GELAP) +
  scale_colour_manual(values = c("Wald (rumus MoE biasa)" = ABU, "Wilson" = BIRU)) +
  scale_x_continuous(labels = percent_format(accuracy = 1), breaks = seq(0, 0.6, 0.1)) +
  labs(title = "Interval Wald vs Wilson untuk beberapa hasil survey (n = 100)",
       subtitle = "Titik hitam = hasil survey. Di proporsi kecil, Wald bisa negatif atau malah nol lebarnya",
       x = "rentang perkiraan persentase user di populasi (95%)", y = NULL) + tema
simpan(g2, "wald-vs-wilson.png", h = 5.6)

# ---- 3. coverage -----------------------------------------------------------------
cakupan <- function(p, metode) {
  x <- 0:N; pr <- dbinom(x, N, p)
  ci <- if (metode == "Wilson") wilson(x, N) else wald(x, N)
  sum(pr[ci[, 1] <= p & p <= ci[, 2]])
}
cov <- expand_grid(p = seq(0.01, 0.5, by = 0.0025), metode = c("Wald (rumus MoE biasa)", "Wilson")) |>
  rowwise() |> mutate(cov = cakupan(p, metode)) |> ungroup()
g3 <- ggplot(cov, aes(p, cov, colour = metode)) +
  geom_hline(yintercept = 0.95, linetype = "dashed", colour = GELAP) +
  annotate("text", x = 0.5, y = 0.99, label = "janji: 95% (garis putus-putus)", hjust = 1, size = 3.6) +
  annotate("rect", xmin = 0.06, xmax = 0.08, ymin = -Inf, ymax = Inf, fill = MERAH, alpha = 0.08) +
  annotate("text", x = 0.07, y = 0.71, label = "brand X", colour = MERAH, size = 3.6) +
  geom_line(linewidth = 0.6) +
  scale_colour_manual(values = c("Wald (rumus MoE biasa)" = ABU, "Wilson" = BIRU)) +
  scale_x_continuous(labels = percent_format(accuracy = 1), breaks = seq(0, 0.5, 0.05)) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0.7, 1)) +
  labs(title = "Seberapa sering interval benar-benar memuat nilai sebenarnya? (n = 100)",
       subtitle = "Wald sering 'ingkar janji' di proporsi kecil. Wilson konsisten di sekitar 95%",
       x = "persentase user yang sebenarnya", y = "peluang interval memuat nilai sebenarnya") + tema
simpan(g3, "coverage.png")

# ---- 4. dunia paralel: tracking saat tidak ada yang berubah ------------------------
set.seed(2026)
BULAN <- 16
batas <- qbinom(c(0.025, 0.975), N, P_ASLI) / N
dunia <- expand_grid(dunia = paste("Dunia", 1:4), kuartal = 1:BULAN) |>
  mutate(hasil = rbinom(n(), N, P_ASLI) / N)
g4 <- ggplot(dunia, aes(kuartal, hasil)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = batas[1], ymax = batas[2], fill = BIRU, alpha = 0.08) +
  geom_hline(yintercept = P_ASLI, colour = MERAH, linetype = "dashed") +
  geom_line(colour = ABU) + geom_point(colour = GELAP, size = 1.6) +
  facet_wrap(~dunia, ncol = 2) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 0.18)) +
  scale_x_continuous(breaks = seq(0, 16, 4)) +
  labs(title = "Empat 'dunia paralel': penetrasi brand X tetap 7% selama 16 kuartal (4 tahun)",
       subtitle = "Garis merah = nilai sebenarnya (tidak pernah berubah). Area biru = batas goyang alami survey n = 100",
       x = "kuartal ke-", y = "hasil survey",
       caption = "Setiap titik adalah simulasi survey 100 responden per kuartal. Tidak ada kampanye, tidak ada perubahan pasar.") +
  tema + theme(strip.text = element_text(face = "bold"))
simpan(g4, "dunia-paralel.png", h = 6.2)

# ---- 5. sebaran selisih antarbulan --------------------------------------------------
set.seed(7)
sel <- tibble(d = rbinom(1e5, N, P_ASLI) - rbinom(1e5, N, P_ASLI)) |> count(d) |>
  mutate(pr = n / sum(n), besar = ifelse(abs(d) >= 5, "naik/turun ≥ 5 poin", "di bawah 5 poin"))
p5 <- sum(sel$pr[abs(sel$d) >= 5])
g5 <- ggplot(sel, aes(d, pr, fill = besar)) + geom_col(width = 0.8) +
  scale_fill_manual(values = c("naik/turun ≥ 5 poin" = MERAH, "di bawah 5 poin" = ABU)) +
  scale_x_continuous(breaks = seq(-14, 14, 2), limits = c(-14.5, 14.5)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(title = "Selisih hasil survey kuartal ini vs kuartal lalu, padahal tidak ada yang berubah",
       subtitle = paste0("Kira-kira ", persen(p5), " dari waktu, hasil survey 'melompat' 5 poin atau lebih murni karena kebetulan"),
       x = "selisih (poin persentase)", y = "peluang") + tema
simpan(g5, "selisih-bulanan.png")

# ---- 6. peluang mencapai target 10% ---------------------------------------------------
pt <- expand_grid(p = seq(0.03, 0.16, by = 0.0025), n = c(100, 1000)) |>
  mutate(peluang = 1 - pbinom(ceiling(0.10 * n) - 1, n, p),
         label = paste0("n = ", format(n, big.mark = ".", decimal.mark = ",", trim = TRUE), " per kuartal"))
anot <- tibble(p = c(0.07, 0.10, 0.12)) |>
  mutate(peluang = 1 - pbinom(9, N, p), teks = paste0(persen(peluang)))
g6 <- ggplot(pt, aes(p, peluang, colour = label)) +
  geom_vline(xintercept = 0.10, linetype = "dashed", colour = GELAP) +
  annotate("text", x = 0.101, y = 0.05, label = "target 10%", hjust = 0, size = 3.6) +
  geom_line(linewidth = 1) +
  geom_point(data = anot, inherit.aes = FALSE, aes(p, peluang), colour = MERAH, size = 3) +
  geom_text(data = anot, inherit.aes = FALSE, aes(p, peluang, label = teks),
            colour = MERAH, vjust = -1, hjust = 1.1, size = 3.8, fontface = "bold") +
  scale_colour_manual(values = c(BIRU, HIJAU)) +
  scale_x_continuous(labels = percent_format(accuracy = 1), breaks = seq(0.03, 0.16, 0.01)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(title = "Peluang hasil survey menyentuh target 10%",
       subtitle = "Dengan n = 100: tim yang diam saja tetap bisa lolos, tim yang berhasil tetap bisa gagal",
       x = "persentase user yang SEBENARNYA", y = "peluang hasil survey ≥ 10%") + tema
simpan(g6, "peluang-target.png")

# ---- 7. kampanye yang tidak terlihat ----------------------------------------------------
set.seed(8)
asli <- tibble(bulan = 1:12) |>
  mutate(p = case_when(bulan <= 4 ~ 0.07, bulan <= 6 ~ 0.07 + (bulan - 4) * 0.01, TRUE ~ 0.09))
kamp <- bind_rows(
  asli |> mutate(n = 100, hasil = rbinom(n(), 100, p) / 100),
  asli |> mutate(n = 1400, hasil = rbinom(n(), 1400, p) / 1400)) |>
  mutate(panel = factor(paste0("n = ", format(n, big.mark = ".", decimal.mark = ",", trim = TRUE), " per kuartal"),
                        levels = c("n = 100 per kuartal", "n = 1.400 per kuartal")))
g7 <- ggplot(kamp, aes(bulan, hasil)) +
  annotate("rect", xmin = 4.5, xmax = 6.5, ymin = -Inf, ymax = Inf, fill = HIJAU, alpha = 0.08) +
  annotate("text", x = 5.5, y = 0.165, label = "kampanye\nberjalan", colour = HIJAU, size = 3.6, lineheight = 0.9) +
  geom_line(data = asli, aes(bulan, p), colour = MERAH, linewidth = 1, linetype = "dashed") +
  geom_line(colour = ABU) + geom_point(colour = GELAP, size = 1.8) +
  facet_wrap(~panel) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 0.17)) +
  scale_x_continuous(breaks = 1:12) +
  labs(title = "Kampanye yang benar-benar berhasil: penetrasi naik dari 7% ke 9%",
       subtitle = "Garis merah = nilai sebenarnya. Dengan n = 100, kenaikannya tenggelam di antara naik-turun survey",
       x = "kuartal ke-", y = "hasil survey") + tema + theme(strip.text = element_text(face = "bold"))
simpan(g7, "kampanye-tak-terlihat.png")

# ---- 8. regression to the mean ------------------------------------------------------------
set.seed(3)
pasang <- tibble(bulan_ini = rbinom(2e5, N, P_ASLI), bulan_depan = rbinom(2e5, N, P_ASLI))
buruk <- pasang |> filter(bulan_ini <= 4)
naik <- mean(buruk$bulan_depan > buruk$bulan_ini)
contoh <- buruk |> slice_head(n = 40) |> mutate(id = row_number()) |>
  pivot_longer(c(bulan_ini, bulan_depan), names_to = "kapan", values_to = "x") |>
  mutate(kapan = factor(ifelse(kapan == "bulan_ini", "Kuartal 'buruk'\n(tim ditegur)", "Kuartal berikutnya"),
                        levels = c("Kuartal 'buruk'\n(tim ditegur)", "Kuartal berikutnya")),
         x = x / N + runif(n(), -0.002, 0.002))
g8 <- ggplot(contoh, aes(kapan, x, group = id)) +
  geom_hline(yintercept = P_ASLI, colour = MERAH, linetype = "dashed") +
  geom_line(colour = ABU, alpha = 0.6) + geom_point(aes(colour = kapan), size = 2.2) +
  scale_colour_manual(values = c(MERAH, BIRU), guide = "none") +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(title = "Regression to the mean: teguran yang 'seolah-olah' manjur",
       subtitle = paste0("Setelah kuartal dengan hasil ≤ 4%, ", persen(naik),
                         " kuartal berikutnya naik, walaupun TIDAK ADA yang dilakukan"),
       x = NULL, y = "hasil survey",
       caption = "40 contoh simulasi. Penetrasi sebenarnya tetap 7% (garis merah).") + tema
simpan(g8, "regresi-ke-rataan.png", w = 10, h = 5.6)

# ---- 9. power vs ukuran sampel ---------------------------------------------------------------
pw1 <- function(n, p0 = 0.07, p1 = 0.09) pnorm((p1 - p0 - 1.96 * sqrt(p0 * (1 - p0) / n)) / sqrt(p1 * (1 - p1) / n))
pw2 <- function(n, p0 = 0.07, p1 = 0.09) {
  pb <- (p0 + p1) / 2
  pnorm((p1 - p0 - 1.96 * sqrt(2 * pb * (1 - pb) / n)) / sqrt((p0 * (1 - p0) + p1 * (1 - p1)) / n))
}
pw <- tibble(n = seq(50, 3500, by = 10)) |>
  mutate(`dibandingkan baseline gabungan` = pw1(n), `dibandingkan kuartal lalu` = pw2(n)) |>
  pivot_longer(-n, names_to = "cara", values_to = "power")
g9 <- ggplot(pw, aes(n, power, colour = cara)) +
  geom_hline(yintercept = 0.8, linetype = "dashed", colour = GELAP) +
  annotate("text", x = 300, y = 0.83, label = "standar umum: 80%", hjust = 0, size = 3.6) +
  geom_vline(xintercept = 100, colour = MERAH) +
  annotate("text", x = 130, y = 0.97, label = "survey kita\n(n = 100)", hjust = 0, colour = MERAH, size = 3.6, lineheight = 0.9) +
  geom_line(linewidth = 1) +
  scale_colour_manual(values = c(BIRU, HIJAU)) +
  scale_x_continuous(labels = label_number(big.mark = "."), breaks = seq(0, 3500, 500)) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 1)) +
  labs(title = "Peluang survey 'melihat' kenaikan nyata dari 7% ke 9%",
       subtitle = "Butuh sekitar 1.400 responden (vs baseline) atau 2.900 responden (vs kuartal lalu) per kuartal",
       x = "jumlah responden per kuartal", y = "power") + tema
simpan(g9, "power-vs-n.png")

# ---- 10. control chart: kuartalan vs rata-rata 4 kuartal --------------------------------------
set.seed(16)
cc <- tibble(kuartal = 1:20, p = ifelse(kuartal <= 10, 0.07, 0.10)) |>
  mutate(x = rbinom(n(), N, p), kuartalan = x / N,
         rolling = (x + lag(x) + lag(x, 2) + lag(x, 3)) / (4 * N))
s1 <- sqrt(P_ASLI * (1 - P_ASLI) / N); s4 <- sqrt(P_ASLI * (1 - P_ASLI) / (4 * N))
g10 <- ggplot(cc, aes(kuartal)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = max(0, P_ASLI - 2 * s1), ymax = P_ASLI + 2 * s1, fill = ABU, alpha = 0.15) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = P_ASLI - 2 * s4, ymax = P_ASLI + 2 * s4, fill = BIRU, alpha = 0.15) +
  geom_hline(yintercept = P_ASLI, colour = GELAP, linetype = "dashed") +
  geom_vline(xintercept = 10.5, colour = HIJAU) +
  annotate("text", x = 10.7, y = 0.175, label = "mulai kuartal 11, nilai sebenarnya naik ke 10%",
           hjust = 0, colour = HIJAU, size = 3.6) +
  geom_point(aes(y = kuartalan, colour = "hasil kuartalan (n = 100)"), size = 1.8) +
  geom_line(aes(y = rolling, colour = "rata-rata 4 kuartal (n = 400)"), linewidth = 1, na.rm = TRUE) +
  scale_colour_manual(values = c("hasil kuartalan (n = 100)" = GELAP, "rata-rata 4 kuartal (n = 400)" = BIRU)) +
  scale_x_continuous(breaks = seq(0, 20, 4)) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 0.18)) +
  labs(title = "Control chart: membaca tracking dengan 'batas goyang'",
       subtitle = "Area abu-abu = batas goyang kuartalan (±2σ). Area biru = batas goyang rata-rata 4 kuartal (setahun)",
       x = "kuartal ke-", y = "hasil survey") + tema
simpan(g10, "control-chart.png")

# ---- angka-angka untuk tulisan ---------------------------------------------------------------
cat("batas goyang kuartalan:", batas, "\n")
cat("P(|selisih| >= 5):", p5, "\n")
cat("P(naik | bulan buruk):", naik, " P(bulan buruk):", mean(pasang$bulan_ini <= 4), "\n")
print(cc |> select(kuartal, x, rolling) |> as.data.frame())
cat("batas rolling:", P_ASLI - 2 * s4, P_ASLI + 2 * s4, "\n")
