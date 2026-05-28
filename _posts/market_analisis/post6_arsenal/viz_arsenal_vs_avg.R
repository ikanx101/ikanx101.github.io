# ============================================================
# Visualisasi Perbandingan Arsenal 2025-26 vs Rata-rata Juara
# ============================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)
library(patchwork)

load("premier_league_goals/pl_all_standings.rda")

# ============================================================
# DATA
# ============================================================

# Rata-rata historis 33 juara (1992-93 s/d 2024-25)
hist_avg <- all_standings %>%
  filter(Pos == 1) %>%
  summarise(
    avg_pts = mean(Pts, na.rm = TRUE),
    avg_gf  = mean(GF,  na.rm = TRUE),
    avg_ga  = mean(GA,  na.rm = TRUE),
    avg_gd  = mean(GD,  na.rm = TRUE),
    avg_w   = mean(W,   na.rm = TRUE),
    avg_d   = mean(D,   na.rm = TRUE),
    avg_l   = mean(L,   na.rm = TRUE)
  )

# Arsenal 2025-26
arsenal <- list(pts=85, gf=78, ga=34, gd=44, w=26, d=7, l=5)

# Tabel perbandingan
compare_df <- data.frame(
  metric      = c("Poin (Pts)","Gol Dicetak (GF)","Selisih Gol (GD)",
                   "Kemenangan (W)","Hasil Seri (D)",
                   "Gol Kebobolan (GA)","Kekalahan (L)"),
  arsenal_val = c(arsenal$pts, arsenal$gf, arsenal$gd,
                   arsenal$w,   arsenal$d,
                   arsenal$ga,  arsenal$l),
  avg_val     = c(hist_avg$avg_pts, hist_avg$avg_gf, hist_avg$avg_gd,
                   hist_avg$avg_w,   hist_avg$avg_d,
                   hist_avg$avg_ga,  hist_avg$avg_l),
  lower_better = c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE),
  stringsAsFactors = FALSE
) %>%
  mutate(
    # Selisih Arsenal vs rata-rata (positif = Arsenal lebih baik)
    diff      = ifelse(lower_better,
                       avg_val - arsenal_val,   # lower_better: lebih kecil = lebih baik
                       arsenal_val - avg_val),
    diff_pct  = diff / avg_val * 100,
    better    = diff >= 0,
    # Label nilai
    label_ars = round(arsenal_val, 1),
    label_avg = round(avg_val, 1)
  ) %>%
  # Urutkan: Arsenal terbaik di atas
  arrange(desc(diff_pct)) %>%
  mutate(metric = factor(metric, levels = metric))

# ============================================================
# WARNA & TEMA
# ============================================================

bg         <- "#0d1117"
panel_col  <- "#161b22"
gold       <- "#FFD700"
grey       <- "#aaaacc"
white      <- "white"
orange     <- "#E67E22"     # warna Arsenal
grey_dot   <- "#6a6a8a"
green_line <- "#2ECC71"
red_line   <- "#E74C3C"

base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background   = element_rect(fill = bg,        color = NA),
    panel.background  = element_rect(fill = panel_col, color = NA),
    panel.grid.minor  = element_blank(),
    axis.text         = element_text(color = grey,  size = 9),
    axis.title        = element_text(color = grey,  size = 9),
    plot.title        = element_text(color = white, face = "bold", size = 12, hjust = 0),
    plot.subtitle     = element_text(color = grey,  size = 8.5, hjust = 0,
                                      margin = margin(b = 10)),
    plot.caption      = element_text(color = "#555577", size = 7.5, hjust = 1),
    plot.margin       = margin(14, 16, 12, 16)
  )

# ============================================================
# PANEL A — Dumbbell Chart: Arsenal vs Rata-rata Juara
# ============================================================

pA <- ggplot(compare_df) +
  # Garis vertikal nol / referensi
  geom_vline(xintercept = 0, color = "#2a2a3e", linewidth = 0.6) +
  # Segmen konektor (warna hijau/merah berdasarkan Arsenal lebih baik/buruk)
  geom_segment(
    aes(x = avg_val, xend = arsenal_val,
        y = metric,  yend  = metric,
        color = better),
    linewidth = 2, lineend = "round", show.legend = FALSE
  ) +
  # Titik rata-rata juara
  geom_point(
    aes(x = avg_val, y = metric),
    shape = 21, size = 7, fill = "#2a2a4a", color = grey_dot, stroke = 1.5
  ) +
  geom_text(
    aes(x = avg_val, y = metric, label = label_avg),
    color = grey, size = 2.7, fontface = "bold"
  ) +
  # Titik Arsenal
  geom_point(
    aes(x = arsenal_val, y = metric),
    shape = 21, size = 7, fill = orange, color = white, stroke = 1.5
  ) +
  geom_text(
    aes(x = arsenal_val, y = metric, label = label_ars),
    color = white, size = 2.7, fontface = "bold"
  ) +
  # Label selisih persen di sisi kanan
  geom_label(
    aes(x = pmax(arsenal_val, avg_val) + 4,
        y = metric,
        label = paste0(ifelse(diff_pct >= 0, "+", ""), round(diff_pct, 1), "%"),
        fill  = better),
    color = white, size = 2.8, fontface = "bold",
    label.padding = unit(0.22, "lines"), label.r = unit(0.12, "lines"),
    show.legend = FALSE
  ) +
  scale_color_manual(values = c("TRUE" = green_line, "FALSE" = red_line)) +
  scale_fill_manual(values  = c("TRUE" = "#1a3a1a",  "FALSE" = "#3a1a1a")) +
  scale_x_continuous(
    expand = expansion(mult = c(0.02, 0.18)),
    breaks = pretty_breaks(6)
  ) +
  # Legenda manual via annotate
  annotate("point", x = -Inf, y = -Inf, size = 0) +   # dummy
  labs(
    title    = "Arsenal 2025-26 vs Rata-rata Juara Historis (1992–2025)",
    subtitle = paste0(
      "Titik oranye = Arsenal 2025-26  |  Titik abu = rata-rata 33 juara sebelumnya\n",
      "Garis hijau = Arsenal lebih baik  |  Garis merah = Arsenal di bawah rata-rata"
    ),
    x = "Nilai", y = NULL
  ) +
  base_theme +
  theme(
    panel.grid.major.y = element_line(color = "#1e1e2e", linewidth = 0.5),
    panel.grid.major.x = element_line(color = "#2a2a3e", linewidth = 0.3),
    axis.text.y        = element_text(color = white, size = 10, face = "bold"),
    axis.text.x        = element_text(color = grey,  size = 8.5)
  )

# ============================================================
# PANEL B — Bar Poin Arsenal dalam konteks semua juara
# ============================================================

all_champs_pts <- all_standings %>%
  filter(Pos == 1) %>%
  mutate(
    Team_clean   = trimws(gsub("\\s*\\(.*?\\)", "", Team)),
    is_arsenal26 = FALSE,
    club_col     = case_when(
      grepl("Manchester United", Team_clean) ~ "#E74C3C",
      grepl("Manchester City",   Team_clean) ~ "#3498DB",
      grepl("Arsenal",           Team_clean) ~ orange,
      grepl("Chelsea",           Team_clean) ~ "#9B59B6",
      grepl("Liverpool",         Team_clean) ~ gold,
      grepl("Blackburn",         Team_clean) ~ "#2ECC71",
      grepl("Leicester",         Team_clean) ~ "#1ABC9C",
      TRUE ~ grey
    )
  ) %>%
  bind_rows(
    data.frame(season_label="2025-26", Pts=85, Team_clean="Arsenal",
               is_arsenal26=TRUE, club_col=orange, stringsAsFactors=FALSE)
  ) %>%
  mutate(season_label = factor(season_label,
                                levels = unique(season_label)))

pB <- ggplot(all_champs_pts, aes(x = season_label, y = Pts)) +
  geom_col(aes(fill = club_col,
               alpha = ifelse(is_arsenal26, 1, 0.6)),
           width = 0.78, color = NA, show.legend = FALSE) +
  # Highlight Arsenal 2025-26
  geom_col(data = filter(all_champs_pts, is_arsenal26),
           aes(fill = club_col), width = 0.78,
           color = white, linewidth = 0.7, show.legend = FALSE) +
  # Median line
  geom_hline(yintercept = mean(all_champs_pts$Pts, na.rm=TRUE),
             color = grey, linewidth = 0.7, linetype = "dashed") +
  geom_text(data = filter(all_champs_pts, is_arsenal26),
            aes(label = paste0("Arsenal\n", Pts, " poin")),
            vjust = -0.35, size = 2.8, color = orange, fontface = "bold") +
  annotate("text",
           x    = levels(all_champs_pts$season_label)[1],
           y    = mean(all_champs_pts$Pts, na.rm=TRUE) + 1.2,
           label= paste0("Rata-rata: ", round(mean(all_champs_pts$Pts, na.rm=TRUE),1)),
           color = grey, size = 2.5, hjust = 0, fontface = "italic") +
  scale_fill_identity() +
  scale_alpha_identity() +
  scale_y_continuous(limits = c(0, 108),
                     expand = expansion(mult = c(0, 0.04))) +
  scale_x_discrete(guide = guide_axis(angle = 45)) +
  labs(
    title    = "Poin Arsenal 2025-26 dalam Konteks Semua Juara",
    subtitle = paste0("85 poin Arsenal = ",
                      round(mean(all_champs_pts$Pts <= 85, na.rm=TRUE)*100),
                      "% juara pernah meraih poin ≤ ini"),
    x = NULL, y = "Poin"
  ) +
  base_theme +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.35),
    axis.text.x        = element_text(color = grey, size = 7.5)
  )

# ============================================================
# PANEL C — Badge Pencapaian Unik Arsenal 2025-26
# ============================================================

badges <- data.frame(
  icon  = c("🧤", "🚫", "⚽", "📅", "🏆"),
  judul = c("Golden Glove",
             "0 Kartu Merah",
             "19 Gol dari Sudut",
             "Pertama Juara PL\nsejak 2003-04",
             "14 Gelar Liga"),
  detail= c("David Raya: 19 CS\n3× berturut-turut",
             "Pertama dalam sejarah\nPL tanpa red card",
             "Rekor baru PL\n(sebelumnya: 16)",
             "22 tahun penantian\nberakhir",
             "Juara ke-14\nThe Gunners"),
  x     = c(1, 2, 3, 4, 5),
  col   = c("#0d2b3e","#2b0d0d","#2b1a0d","#1a2b0d","#2b0d2b"),
  border= c("#3498DB","#E74C3C",orange,"#2ECC71","#9B59B6"),
  stringsAsFactors = FALSE
)

pC <- ggplot(badges, aes(x = x, y = 1)) +
  geom_tile(aes(fill = col), width = 0.88, height = 1.8,
            color = NA, show.legend = FALSE) +
  geom_tile(aes(color = border), fill = NA, width = 0.88, height = 1.8,
            linewidth = 1.2, show.legend = FALSE) +
  geom_text(aes(label = icon), y = 1.45, size = 7, family = "sans") +
  geom_text(aes(label = judul), y = 0.95,
            color = white, fontface = "bold", size = 3,
            lineheight = 0.9) +
  geom_text(aes(label = detail), y = 0.35,
            color = grey, size = 2.4, lineheight = 0.85) +
  scale_fill_identity() +
  scale_color_identity() +
  scale_x_continuous(limits = c(0.5, 5.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-0.1, 1.9), expand = c(0, 0)) +
  labs(title    = "Pencapaian Bersejarah Arsenal 2025-26",
       subtitle = "Rekor dan pencapaian yang tidak dimiliki juara lain") +
  base_theme +
  theme(
    panel.grid   = element_blank(),
    axis.text    = element_blank(),
    axis.title   = element_blank(),
    axis.ticks   = element_blank(),
    panel.background = element_rect(fill = bg, color = NA)
  )

# ============================================================
# GABUNG SEMUA PANEL
# ============================================================

layout <- "
AAAAACC
AAAAACC
BBBBBCC
"

final <- (pA + pB + pC) +
  plot_layout(design = layout) +
  plot_annotation(
    title    = "Arsenal 2025-26: Di Mana Mereka di Antara Para Juara Premier League?",
    subtitle = paste0(
      "Perbandingan lengkap Arsenal dengan rata-rata 33 juara historis (1992–2025) ",
      "| 85 poin · 26W 7D 5L · GD +44 · 19 clean sheets"
    ),
    caption  = "Sumber: Wikipedia, Arsenal.com, Premier League | Analisis & Visualisasi: R/ggplot2",
    theme    = theme(
      plot.background = element_rect(fill = bg, color = NA),
      plot.title      = element_text(color = white, face = "bold", size = 17,
                                      hjust = 0.5, margin = margin(b = 5)),
      plot.subtitle   = element_text(color = grey, size = 10,
                                      hjust = 0.5, margin = margin(b = 14)),
      plot.caption    = element_text(color = "#555577", size = 8,
                                      hjust = 1, margin = margin(t = 10)),
      plot.margin     = margin(22, 22, 16, 22)
    )
  )

ggsave(
  "premier_league_goals/arsenal_vs_avg_champions.png",
  final, width = 18, height = 13, dpi = 300, bg = bg
)

message("Selesai! Tersimpan: arsenal_vs_avg_champions.png")
