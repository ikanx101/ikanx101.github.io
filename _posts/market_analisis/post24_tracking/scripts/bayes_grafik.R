# =============================================================================
# bayes_grafik.R
# Bagian Bayesian untuk tulisan "survey tracking kuartalan n=100 dan target marketing".
# Metode mengikuti pekerjaan Bayes HiLo 2026: sequential Beta-Binomial
# (prior awal Beta(1,1), posterior -> prior periode berikutnya), forecast
# theta vs prediktif, dan backtest one-step-ahead. Data: simulasi brand X.
# =============================================================================
suppressPackageStartupMessages({
  library(dplyr); library(tidyr); library(purrr); library(ggplot2); library(scales)
})

SEED_SEQ <- 5; SEED_INR <- 224
OUT <- "/Users/ikanx101/Documents/ikanx101.github.io/_posts/market_analisis/post24_tracking"

BIRU <- "#2a78d6"; MERAH <- "#d64545"; ABU <- "#a3a3a3"; GELAP <- "#333333"
HIJAU <- "#2e9e6a"; ORANYE <- "#eb6834"
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

# ---- fungsi inti -----------------------------------------------------------------
# lupa = 1 -> semua kuartal sama bobotnya (seperti Bayes HiLo 2026)
# lupa < 1 -> bukti lama "dilupakan" pelan-pelan (discounting)
sequential_update <- function(x, n, alpha0 = 1, beta0 = 1, lupa = 1) {
  a <- alpha0; b <- beta0
  map_dfr(seq_along(x), function(i) {
    a <<- alpha0 + lupa * (a - alpha0) + x[i]
    b <<- beta0  + lupa * (b - beta0)  + n[i] - x[i]
    tibble(kuartal = i, x = x[i], n = n[i], alpha = a, beta = b,
           rerata = a / (a + b), lo = qbeta(0.025, a, b), hi = qbeta(0.975, a, b))
  })
}
forecast_berikutnya <- function(alpha, beta, n_next, sampel = 50000) {
  theta <- rbeta(sampel, alpha, beta)
  list(theta = theta, prediktif = rbinom(sampel, n_next, theta) / n_next)
}

# ---- 11. sequential update brand X ------------------------------------------------
set.seed(SEED_SEQ)
N <- 100
x <- rbinom(8, N, 0.07)
seq_x <- sequential_update(x, rep(N, 8))
print(seq_x |> mutate(across(c(rerata, lo, hi), \(v) round(100 * v, 1))))
g11 <- ggplot(seq_x, aes(kuartal)) +
  geom_ribbon(aes(ymin = lo, ymax = hi), fill = BIRU, alpha = 0.15) +
  geom_line(aes(y = rerata), colour = BIRU, linewidth = 1) +
  geom_point(aes(y = x / n), colour = GELAP, size = 2.2) +
  geom_hline(yintercept = 0.07, colour = MERAH, linetype = "dashed") +
  scale_x_continuous(breaks = 1:8) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 0.2)) +
  labs(title = "Sequential Bayesian: setiap kuartal, keyakinan kita makin tajam",
       subtitle = "Titik hitam = hasil survey kuartalan (n = 100). Garis + area biru = perkiraan posterior (95%) setelah kuartal itu",
       x = "kuartal ke-", y = "persentase user",
       caption = "Prior awal Beta(1, 1). Posterior kuartal ini menjadi prior kuartal berikutnya. Garis merah = nilai sebenarnya (7%).") + tema
simpan(g11, "bayes-sequential.png")

# ---- 12. theta vs prediktif ---------------------------------------------------------
set.seed(123)
akhir <- tail(seq_x, 1)
fc <- forecast_berikutnya(akhir$alpha, akhir$beta, N)
q_theta <- quantile(fc$theta, c(.1, .9, .025, .975))
q_pred  <- quantile(fc$prediktif, c(.1, .9, .025, .975))
print(round(100 * q_theta, 1)); print(round(100 * q_pred, 1))
pr <- tibble(x = fc$prediktif) |> count(x) |> mutate(p = n / sum(n))
skala <- max(pr$p) / max(density(fc$theta)$y)
g12 <- ggplot() +
  geom_col(data = pr, aes(x, p), fill = ORANYE, alpha = 0.45, width = 0.0085) +
  geom_density(data = tibble(x = fc$theta), aes(x, after_stat(density) * skala),
               colour = BIRU, linewidth = 1) +
  annotate("text", x = 0.105, y = max(pr$p) * 0.85, hjust = 0, colour = BIRU, size = 3.8,
           label = paste0("theta: persentase user di populasi\n80% di antara ",
                          persen(q_theta[1], 1), " – ", persen(q_theta[2], 1))) +
  annotate("text", x = 0.125, y = max(pr$p) * 0.45, hjust = 0, colour = ORANYE, size = 3.8,
           label = paste0("prediktif: hasil SURVEY kuartal depan\n80% di antara ",
                          persen(q_pred[1], 0), " – ", persen(q_pred[2], 0))) +
  scale_x_continuous(labels = percent_format(accuracy = 1), breaks = seq(0, 0.2, 0.02), limits = c(0, 0.2)) +
  labs(title = "Dua jenis forecast untuk kuartal ke-9",
       subtitle = "Kurva biru = keyakinan tentang populasi. Batang oranye = kemungkinan angka yang keluar dari survey 100 orang",
       x = NULL, y = NULL) + tema + theme(axis.text.y = element_blank())
simpan(g12, "bayes-theta-vs-prediktif.png")

# ---- 13. backtest: interval mana yang jujur? ------------------------------------------
set.seed(99)
uji <- map_dfr(1:2000, function(s) {
  xs <- rbinom(9, N, 0.07)
  sq <- sequential_update(xs[1:8], rep(N, 8)) |> tail(1)
  f <- forecast_berikutnya(sq$alpha, sq$beta, N, sampel = 4000)
  obs <- xs[9] / N
  tibble(theta80 = obs >= quantile(f$theta, .1) & obs <= quantile(f$theta, .9),
         pred80  = obs >= quantile(f$prediktif, .1) & obs <= quantile(f$prediktif, .9))
})
cakupan <- tibble(interval = c("Interval 80% theta\n(populasi)", "Interval 80% prediktif\n(hasil survey)"),
                  cakupan = c(mean(uji$theta80), mean(uji$pred80))) |>
  mutate(interval = factor(interval, levels = interval))
print(cakupan)
g13 <- ggplot(cakupan, aes(interval, cakupan, fill = interval)) +
  geom_col(width = 0.55) +
  geom_hline(yintercept = 0.8, linetype = "dashed", colour = GELAP) +
  annotate("text", x = 0.5, y = 0.82, label = "janji: 80%", hjust = 0, vjust = 0, size = 3.8) +
  geom_text(aes(label = persen(cakupan)), vjust = -0.5, size = 5, fontface = "bold") +
  scale_fill_manual(values = c(BIRU, ORANYE), guide = "none") +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 1)) +
  labs(title = "Backtest: seberapa sering hasil survey kuartal depan masuk ke rentang forecast?",
       subtitle = "2.000 simulasi brand X: 8 kuartal dipakai untuk forecast, kuartal ke-9 dipakai untuk menguji",
       x = NULL, y = "hasil survey yang masuk rentang") + tema
simpan(g13, "bayes-backtest.png", w = 9, h = 5.4)

# ---- 14. inersia: saat nilai sebenarnya berubah -------------------------------------------
set.seed(SEED_INR)
p_asli <- c(rep(0.07, 8), rep(0.10, 8))
x2 <- rbinom(16, N, p_asli)
inersia <- bind_rows(
  sequential_update(x2, rep(N, 16)) |> mutate(cara = "ingat semua kuartal (lupa = 1)"),
  sequential_update(x2, rep(N, 16), lupa = 0.6) |> mutate(cara = "bukti lama dilupakan pelan-pelan (lupa = 0,6)"))
print(inersia |> filter(kuartal %in% c(8, 10, 12, 16)) |> select(cara, kuartal, rerata, lo, hi) |>
        mutate(across(c(rerata, lo, hi), \(v) round(100 * v, 1))))
g14 <- ggplot(inersia, aes(kuartal, rerata, colour = cara, fill = cara)) +
  geom_ribbon(aes(ymin = lo, ymax = hi), alpha = 0.12, colour = NA) +
  geom_line(linewidth = 1) +
  geom_step(data = tibble(kuartal = 1:16, p = p_asli), aes(kuartal, p),
            inherit.aes = FALSE, colour = MERAH, linetype = "dashed", direction = "mid") +
  geom_point(data = tibble(kuartal = 1:16, y = x2 / N), aes(kuartal, y), inherit.aes = FALSE,
             colour = GELAP, size = 1.6) +
  annotate("text", x = 8.7, y = 0.165, label = "mulai kuartal 9, nilai sebenarnya naik ke 10%",
           hjust = 0, colour = MERAH, size = 3.6) +
  scale_colour_manual(values = c(HIJAU, BIRU)) + scale_fill_manual(values = c(HIJAU, BIRU)) +
  scale_y_continuous(labels = percent_format(accuracy = 1), limits = c(0, 0.18)) +
  labs(title = "Kelemahan 'ingat semua kuartal': lambat menyadari perubahan",
       subtitle = "Garis merah putus = nilai sebenarnya. Titik hitam = hasil survey kuartalan (n = 100)",
       x = "kuartal ke-", y = "perkiraan persentase user") + tema
simpan(g14, "bayes-inersia.png")

# ---- angka untuk tulisan: target berbasis peluang ----------------------------------------
# peluang theta > 7% bila 3 bulan ke depan masing-masing hasilnya 10%
a0 <- akhir$alpha; b0 <- akhir$beta
cat("posterior kuartal 8: Beta(", a0, ",", b0, ")\n")
cat("P(prediktif >= 10%):", mean(fc$prediktif >= 0.10), "\n")
cat("P(prediktif >= 12%):", mean(fc$prediktif >= 0.12), "\n")
# peluang theta pasca-kampanye > baseline, dengan posterior terpisah untuk periode kampanye
for (k in c(9, 10, 12)) for (m in c(1, 2, 4)) {
  post_kamp <- rbeta(1e5, 1 + k * m, 1 + (N - k) * m)
  base <- rbeta(1e5, a0, b0)
  cat("hasil", k, "% selama", m, "kuartal -> P(theta kampanye > baseline):", round(mean(post_kamp > base), 3), "\n")
}
