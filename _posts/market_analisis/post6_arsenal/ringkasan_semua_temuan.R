# ============================================================
# Visualisasi Ringkasan: Semua Temuan Juara Premier League
# ============================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)
library(patchwork)
# library(ggtext)  # tidak tersedia, dihapus

# ---- Load data ----
load("premier_league_goals/pl_all_standings.rda")
load("premier_league_goals/pl_faktor_lain.rda")

# ============================================================
# DATA RINGKASAN METRIK
# ============================================================

metrics_df <- data.frame(
  metric   = c(
    "Jumlah Kemenangan (W)",
    "Selisih Gol (GD)",
    "Poin Kandang",
    "Kekalahan Paling Sedikit (L)",
    "Poin Tandang",
    "Gol Dicetak (GF)",
    "Gol Kebobolan Paling Sedikit (GA)",
    "Hasil Seri Paling Sedikit (D)"
  ),
  pct_top1 = c(100, 73, 76, 79, 73, 67, 45, 30),
  pct_top3 = c(100, 100, 100, 97, 97, 100, 85, 55),
  category = c("Kemenangan", "Gol", "Kandang/Tandang", "Kekalahan",
               "Kandang/Tandang", "Gol", "Gol", "Seri"),
  stringsAsFactors = FALSE
) %>%
  arrange(pct_top1) %>%
  mutate(
    metric   = factor(metric, levels = metric),
    gap      = pct_top3 - pct_top1,
    cat_col  = case_when(
      category == "Kemenangan"     ~ "#F1C40F",
      category == "Gol"            ~ "#E74C3C",
      category == "Kandang/Tandang"~ "#3498DB",
      category == "Kekalahan"      ~ "#2ECC71",
      category == "Seri"           ~ "#9B59B6"
    )
  )

# ============================================================
# WARNA & TEMA DASAR
# ============================================================

bg    <- "#0d1117"
panel <- "#161b22"
gold  <- "#FFD700"
grey  <- "#aaaacc"
white <- "white"

base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background  = element_rect(fill = bg,    color = NA),
    panel.background = element_rect(fill = panel, color = NA),
    panel.grid.minor = element_blank(),
    axis.text        = element_text(color = grey,  size = 8.5),
    axis.title       = element_text(color = grey,  size = 9),
    plot.title       = element_text(color = white, face = "bold", size = 11, hjust = 0),
    plot.subtitle    = element_text(color = grey,  size = 8.5, hjust = 0,
                                     margin = margin(b = 8)),
    plot.caption     = element_text(color = "#555577", size = 7.5, hjust = 1),
    plot.margin      = margin(12, 14, 10, 14)
  )

# ============================================================
# PANEL 1 — Dumbbell Chart: % #1 dan % Top 3 per Metrik
# ============================================================

# Titik #1
pts1 <- metrics_df %>%
  select(metric, pct_top1, cat_col, category) %>%
  rename(pct = pct_top1) %>%
  mutate(type = "Ranking #1")

# Titik Top 3
pts3 <- metrics_df %>%
  select(metric, pct_top3, cat_col, category) %>%
  rename(pct = pct_top3) %>%
  mutate(type = "Masuk Top 3")

pts_all <- bind_rows(pts1, pts3)

p1 <- ggplot() +
  # Segmen penghubung (background grey)
  geom_segment(
    data = metrics_df,
    aes(x = pct_top1, xend = pct_top3, y = metric, yend = metric),
    color = "#3a3a5a", linewidth = 2.5, lineend = "round"
  ) +
  # Titik Top 3 (lebih besar, transparan)
  geom_point(
    data = filter(pts_all, type == "Masuk Top 3"),
    aes(x = pct, y = metric),
    shape = 21, size = 5.5, stroke = 1.5,
    fill = "#2a2a4a", color = grey
  ) +
  # Titik #1 (solid, warna kategori)
  geom_point(
    data = filter(pts_all, type == "Ranking #1"),
    aes(x = pct, y = metric, color = category),
    size = 5.5, shape = 16
  ) +
  # Label % #1
  geom_text(
    data = filter(pts_all, type == "Ranking #1"),
    aes(x = pct, y = metric, label = paste0(pct, "%")),
    hjust = 1.55, color = white, size = 2.9, fontface = "bold"
  ) +
  # Label % Top 3
  geom_text(
    data = filter(pts_all, type == "Masuk Top 3"),
    aes(x = pct, y = metric, label = paste0(pct, "%")),
    hjust = -0.55, color = grey, size = 2.7
  ) +
  # Garis vertikal referensi
  geom_vline(xintercept = c(25, 50, 75, 100),
             color = "#2a2a3e", linewidth = 0.4, linetype = "dashed") +
  scale_x_continuous(
    limits = c(0, 115),
    breaks = c(25, 50, 75, 100),
    labels = paste0(c(25, 50, 75, 100), "%")
  ) +
  scale_color_manual(
    values = c(
      "Kemenangan"      = "#F1C40F",
      "Gol"             = "#E74C3C",
      "Kandang/Tandang" = "#3498DB",
      "Kekalahan"       = "#2ECC71",
      "Seri"            = "#9B59B6"
    ),
    name = "Kategori"
  ) +
  labs(
    title    = "Seberapa Sering Juara Menjadi #1 di Setiap Metrik?",
    subtitle = "Titik solid = % musim juara berada di ranking #1 | Titik abu = % musim juara masuk Top 3",
    x = NULL, y = NULL
  ) +
  base_theme +
  theme(
    panel.grid.major.y = element_line(color = "#1e1e2e", linewidth = 0.4),
    panel.grid.major.x = element_blank(),
    legend.position    = "right",
    legend.background  = element_rect(fill = "#1a1a2e", color = NA),
    legend.text        = element_text(color = white, size = 8.5),
    legend.title       = element_text(color = gold,  size = 9, face = "bold"),
    legend.key         = element_rect(fill = NA, color = NA),
    axis.text.y        = element_text(color = white, size = 9, face = "bold"),
    axis.text.x        = element_text(color = grey,  size = 8)
  )

# ============================================================
# PANEL 2 — Win Rate: Juara vs Liga (Kandang & Tandang)
# ============================================================

winrate_df <- data.frame(
  kelompok  = rep(c("Kandang", "Tandang"), each = 2),
  tipe      = rep(c("Juara", "Rata-rata Liga"), 2),
  win_rate  = c(80.5, 45.8, 59.3, 28.7)
) %>%
  mutate(
    kelompok = factor(kelompok, levels = c("Kandang", "Tandang")),
    tipe     = factor(tipe,     levels = c("Rata-rata Liga", "Juara"))
  )

p2 <- ggplot(winrate_df, aes(x = kelompok, y = win_rate, fill = tipe)) +
  geom_col(position = position_dodge(width = 0.65), width = 0.55,
           color = "white", linewidth = 0.25) +
  geom_text(
    aes(label = paste0(win_rate, "%")),
    position = position_dodge(width = 0.65),
    vjust = -0.5, size = 3, color = white, fontface = "bold"
  ) +
  scale_fill_manual(
    values = c("Juara" = "#3498DB", "Rata-rata Liga" = "#2a2a4a"),
    name   = NULL
  ) +
  scale_y_continuous(
    limits = c(0, 95),
    labels = percent_format(scale = 1, accuracy = 1),
    expand = expansion(mult = c(0, 0.05))
  ) +
  labs(
    title    = "Win Rate Kandang & Tandang",
    subtitle = "Juara vs rata-rata semua tim",
    x = NULL, y = "Win Rate"
  ) +
  base_theme +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4),
    legend.position    = "bottom",
    legend.background  = element_rect(fill = "#1a1a2e", color = NA),
    legend.text        = element_text(color = white, size = 8.5),
    axis.text.x        = element_text(color = white, size = 10, face = "bold")
  )

# ============================================================
# PANEL 3 — Distribusi Poin Gap ke Runner-Up
# ============================================================

p3 <- ggplot(pts_gap, aes(x = pts_gap)) +
  geom_histogram(
    binwidth = 2, fill = "#9B59B6", color = bg,
    linewidth = 0.4, boundary = 0
  ) +
  geom_vline(
    xintercept = mean(pts_gap$pts_gap, na.rm = TRUE),
    color = gold, linewidth = 1, linetype = "dashed"
  ) +
  annotate(
    "text",
    x     = mean(pts_gap$pts_gap, na.rm = TRUE) + 0.3,
    y     = 7.5,
    label = paste0("Rata-rata\n", round(mean(pts_gap$pts_gap, na.rm = TRUE), 1), " poin"),
    color = gold, size = 2.8, hjust = 0, fontface = "italic"
  ) +
  scale_x_continuous(breaks = seq(0, 20, 4)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title    = "Distribusi Selisih Poin ke Runner-Up",
    subtitle = "Seberapa jauh juara memimpin?",
    x = "Selisih Poin", y = "Frekuensi (musim)"
  ) +
  base_theme +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4)
  )

# ============================================================
# PANEL 4 — Tabel Skor Ringkasan (Scorecard)
# ============================================================

scorecard_df <- data.frame(
  label = c(
    "Musim Dianalisis",
    "Juara selalu menang terbanyak",
    "Juara selalu Top 3 GD & GF",
    "Juara hampir selalu kalah paling sedikit",
    "Juara hampir selalu Top 3 di kandang",
    "Juara hampir selalu Top 3 di tandang",
    "Median seri juara vs liga",
    "Win rate tandang juara vs liga",
    "Rata-rata unggul poin ke runner-up"
  ),
  nilai = c(
    "33 musim",
    "100% ✓",
    "100% ✓",
    "97% ✓",
    "100% ✓",
    "97% ✓",
    "7 vs 10",
    "59% vs 29%",
    "7 poin"
  ),
  row_color = c(
    "#1a1a2e",
    "#0d2b0d", "#0d2b0d",
    "#1a2e1a",
    "#0d1a2e", "#0d1a2e",
    "#2e1a2e",
    "#1a1a2e",
    "#2e2a0d"
  ),
  y_pos = 9:1,
  stringsAsFactors = FALSE
)

p4 <- ggplot(scorecard_df, aes(y = y_pos)) +
  geom_tile(
    aes(x = 1, fill = row_color),
    width = 2, height = 0.82, color = "#2a2a3e", linewidth = 0.3
  ) +
  geom_text(
    aes(x = 0.18, label = label),
    hjust = 0, color = grey, size = 3, fontface = "plain"
  ) +
  geom_text(
    aes(x = 1.82, label = nilai),
    hjust = 1, color = gold, size = 3.1, fontface = "bold"
  ) +
  scale_fill_identity() +
  scale_x_continuous(limits = c(0, 2), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 9.5), expand = c(0, 0)) +
  labs(
    title    = "Scorecard Ringkasan",
    subtitle = "33 musim Premier League (1992–2025)"
  ) +
  base_theme +
  theme(
    panel.grid  = element_blank(),
    axis.text   = element_blank(),
    axis.title  = element_blank(),
    axis.ticks  = element_blank()
  )

# ============================================================
# GABUNGKAN SEMUA PANEL
# ============================================================

layout <- "
AAAABB
AAAABB
CCCCBB
CCCCDD
"

final_plot <- (p1 + p4 + p2 + p3) +
  plot_layout(design = layout) +
  plot_annotation(
    title    = "Apa yang Selalu Dimiliki Juara Premier League?",
    subtitle = "Analisis 33 musim (1992–2025) · Selain menang dan gol, kekuatan tandang & minimnya kekalahan adalah penentu utama",
    caption  = "Sumber data: Wikipedia (semua musim PL) | Analisis & Visualisasi: R/ggplot2",
    theme    = theme(
      plot.background = element_rect(fill = bg, color = NA),
      plot.title      = element_text(color = white, face = "bold", size = 17,
                                      hjust = 0.5, margin = margin(b = 4)),
      plot.subtitle   = element_text(color = grey, size = 10,
                                      hjust = 0.5, margin = margin(b = 14)),
      plot.caption    = element_text(color = "#555577", size = 8,
                                      hjust = 1,  margin = margin(t = 10)),
      plot.margin     = margin(20, 20, 15, 20)
    )
  )

ggsave(
  filename = "premier_league_goals/ringkasan_semua_temuan.png",
  plot     = final_plot,
  width    = 18, height = 12, dpi = 300, bg = bg
)

message("Selesai! Tersimpan: premier_league_goals/ringkasan_semua_temuan.png")
