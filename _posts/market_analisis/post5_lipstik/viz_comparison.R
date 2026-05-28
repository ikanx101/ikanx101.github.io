library(ggplot2)
library(dplyr)
library(patchwork)

# ── Palette ───────────────────────────────────────────────────────────────────
red_hi  <- "#C0392B"
navy    <- "#2C3E50"
blue    <- "#2980B9"
green   <- "#27AE60"
orange  <- "#E67E22"
grey_l  <- "#ECF0F1"
bg      <- "#FAFAFA"

# ══════════════════════════════════════════════════════════════════════════════
# PANEL A — Scorecard perbandingan (tile matrix)
# ══════════════════════════════════════════════════════════════════════════════
scorecard <- data.frame(
  kriteria = rep(c(
    "Data omzet/penjualan\ntersedia secara publik",
    "Pertumbuhan terukur\nsaat ekonomi melemah",
    "Domain asli\nteori lipstick effect",
    "Ada indikasi\ntrade-down",
    "Faktor struktural\npengganggu kuat",
    "Kesimpulan lipstick\neffect"
  ), times = 2),
  sektor  = rep(c("Coffee Shop", "Skincare"), each = 6),
  skor    = c(
    # Coffee Shop
    1,  # Data tidak ada
    1,  # Pertumbuhan tidak terbukti
    2,  # Bukan domain asli
    2,  # Ada (warkop, sachet)
    1,  # Faktor struktural mendominasi
    1   # Lemah
    ,
    # Skincare
    3,  # Data tersedia (NielsenIQ, Compas)
    3,  # +23% hingga +84%
    3,  # Domain asli
    2,  # Ada (brand lokal vs global)
    2,  # Ada (K-beauty, SPF awareness)
    3   # Moderat–kuat
  ),
  nilai = c(
    "Tidak tersedia", "+?% (tidak terukur)", "Bukan domain asli",
    "Ya (warkop/sachet)", "Sangat kuat", "Lemah",
    "Ya (NielsenIQ)", "+23% s/d +84%", "Domain asli",
    "Ya (brand global→lokal)", "Cukup kuat", "Moderat–Kuat"
  ),
  stringsAsFactors = FALSE
)

# urutan kriteria
ord_kriteria <- c(
  "Data omzet/penjualan\ntersedia secara publik",
  "Pertumbuhan terukur\nsaat ekonomi melemah",
  "Domain asli\nteori lipstick effect",
  "Ada indikasi\ntrade-down",
  "Faktor struktural\npengganggu kuat",
  "Kesimpulan lipstick\neffect"
)
scorecard$kriteria <- factor(scorecard$kriteria, levels = rev(ord_kriteria))
scorecard$sektor   <- factor(scorecard$sektor, levels = c("Coffee Shop", "Skincare"))

pal_score <- c("1" = "#E74C3C", "2" = "#F39C12", "3" = "#27AE60")

pa <- ggplot(scorecard,
             aes(x = sektor, y = kriteria, fill = factor(skor))) +
  geom_tile(color = "white", linewidth = 1.2, width = 0.88, height = 0.85) +
  geom_text(aes(label = nilai),
            size = 3, color = "white", fontface = "bold", lineheight = 1.2) +
  scale_fill_manual(
    values = pal_score,
    labels = c("Lemah / Tidak", "Sedang / Parsial", "Kuat / Ya"),
    name   = ""
  ) +
  scale_x_discrete(position = "top") +
  labs(
    title    = "Scorecard: Kekuatan Bukti Lipstick Effect",
    subtitle = "Merah = lemah/tidak  •  Kuning = parsial  •  Hijau = kuat/ya"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title       = element_text(size = 12, face = "bold", color = navy,
                                    hjust = 0.5, margin = margin(b = 3)),
    plot.subtitle    = element_text(size = 8.5, color = "grey45",
                                    hjust = 0.5, margin = margin(b = 10)),
    axis.text.x.top  = element_text(size = 11, face = "bold", color = navy),
    axis.text.y      = element_text(size = 8.5, color = "grey25",
                                    lineheight = 1.2),
    axis.title       = element_blank(),
    panel.grid       = element_blank(),
    legend.position  = "none",
    plot.background  = element_rect(fill = bg, color = NA),
    plot.margin      = margin(10, 20, 10, 20)
  )

# ══════════════════════════════════════════════════════════════════════════════
# PANEL B — Bar chart: pertumbuhan pasar (angka yang tersedia)
# ══════════════════════════════════════════════════════════════════════════════
growth_comp <- data.frame(
  sektor  = c("Coffee Shop\n(pasar total, CAGR)", "Skincare\n(Lebaran 2024 vs 2023)",
              "Skincare\n(Sunscreen)", "Skincare\n(Serum & Essence)",
              "Skincare\n(Baby Lotion)"),
  pct     = c(10, 23, 60, 38.97, 84),
  warna   = c(blue, red_hi, red_hi, red_hi, red_hi),
  catatan = c("Proyeksi CAGR\n(bukan data aktual)", "Data NielsenIQ",
              "Data Compas/CNBC", "Data Compas Q3 2024", "Data Compas/CNBC")
)

growth_comp$sektor <- factor(growth_comp$sektor, levels = rev(growth_comp$sektor))

pb <- ggplot(growth_comp, aes(x = pct, y = sektor, fill = warna)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0("+", pct, "%")),
            nudge_x = 1.8, size = 3.5, fontface = "bold",
            color = ifelse(growth_comp$warna == blue, blue, red_hi)) +
  # anotasi catatan
  geom_text(aes(x = 1, label = catatan),
            hjust = 0, size = 2.4, color = "white",
            fontface = "italic", lineheight = 1.1) +
  # garis pemisah coffee shop vs skincare
  geom_hline(yintercept = 4.5, linetype = "dashed",
             color = "grey70", linewidth = 0.5) +
  annotate("text", x = 87, y = 2.5,
           label = "Skincare", size = 3.5, fontface = "bold",
           color = red_hi, hjust = 1) +
  annotate("text", x = 87, y = 4.8,
           label = "Coffee Shop", size = 3.5, fontface = "bold",
           color = blue, hjust = 1) +
  scale_fill_identity() +
  scale_x_continuous(limits = c(0, 95),
                     labels = function(x) paste0(x, "%")) +
  labs(
    title    = "Perbandingan Pertumbuhan yang Terukur",
    subtitle = "Skincare punya data aktual; coffee shop hanya proyeksi CAGR",
    x = "Pertumbuhan (%)", y = NULL
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title    = element_text(size = 12, face = "bold", color = navy,
                                 hjust = 0, margin = margin(b = 3)),
    plot.subtitle = element_text(size = 8.5, color = "grey45",
                                 hjust = 0, margin = margin(b = 10)),
    axis.text.y   = element_text(size = 9, color = "grey25"),
    axis.text.x   = element_text(size = 8, color = "grey55"),
    axis.title.x  = element_text(size = 8, color = "grey55"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor   = element_blank(),
    plot.background    = element_rect(fill = bg, color = NA),
    plot.margin        = margin(10, 20, 10, 10)
  )

# ══════════════════════════════════════════════════════════════════════════════
# GABUNG
# ══════════════════════════════════════════════════════════════════════════════
final <- (pa | pb) +
  plot_layout(widths = c(1.1, 1)) +
  plot_annotation(
    title   = "Coffee Shop vs Skincare: Mana yang Lebih Kuat Menunjukkan Lipstick Effect?",
    subtitle = "Skincare memiliki bukti yang lebih solid — data tersedia, pertumbuhan terukur, dan sesuai domain asli teori",
    caption  = "Sumber: NielsenIQ, Compas.co.id, LPEM FEB UI IEO Q3-2025, CNBC Indonesia, Kemenperin\nDibuat oleh ikanx101.com",
    theme = theme(
      plot.title      = element_text(size = 14, face = "bold", color = navy,
                                     hjust = 0.5, margin = margin(b = 4)),
      plot.subtitle   = element_text(size = 9.5, color = "grey40",
                                     hjust = 0.5, lineheight = 1.4,
                                     margin = margin(b = 8)),
      plot.caption    = element_text(size = 7.5, color = "grey55",
                                     hjust = 0.5, margin = margin(t = 10)),
      plot.background = element_rect(fill = bg, color = NA),
      plot.margin     = margin(15, 20, 15, 20)
    )
  )

ggsave(
  "/home/ikanx101/Documents/penelitian/viz_comparison_coffeeshop_skincare.png",
  final, width = 15, height = 8, dpi = 200, bg = bg
)
message("Chart 2 selesai: viz_comparison_coffeeshop_skincare.png")
