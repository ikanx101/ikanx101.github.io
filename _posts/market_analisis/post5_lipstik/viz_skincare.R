library(ggplot2)
library(dplyr)
library(patchwork)

# ── Palette konsisten ─────────────────────────────────────────────────────────
red_hi  <- "#C0392B"
red_mid <- "#E74C3C"
navy    <- "#2C3E50"
blue    <- "#2980B9"
grey_l  <- "#BDC3C7"
bg      <- "#FAFAFA"

# ══════════════════════════════════════════════════════════════════════════════
# PANEL A — Pertumbuhan per kategori produk (lollipop chart)
# ══════════════════════════════════════════════════════════════════════════════
growth <- data.frame(
  kategori = c(
    "Baby Lotion/Cream", "Sunscreen", "Serum & Essence",
    "Parfum", "Pelembap Wajah", "Skincare (Lebaran vs 2023)",
    "Perawatan (overall)", "Body Lotion"
  ),
  pct = c(84, 60, 38.97, 26, 25, 23, 22, 17),
  stringsAsFactors = FALSE
) %>%
  arrange(pct) %>%
  mutate(
    kategori = factor(kategori, levels = kategori),
    warna    = case_when(
      pct >= 50 ~ red_hi,
      pct >= 30 ~ red_mid,
      TRUE      ~ blue
    ),
    label = paste0("+", pct, "%")
  )

pa <- ggplot(growth, aes(x = pct, y = kategori)) +
  # batang solid
  geom_col(aes(fill = warna), width = 0.55) +
  # angka di ujung kanan bar (putih, di dalam)
  geom_text(aes(label = label),
            hjust = 1.15, size = 3.5, fontface = "bold", color = "white") +
  scale_fill_identity() +
  scale_x_continuous(limits = c(0, 90), expand = expansion(mult = c(0, 0.02))) +
  labs(
    title    = "Pertumbuhan Penjualan Skincare Indonesia 2024",
    subtitle = "Semua kategori tumbuh dua digit meski daya beli melemah",
    x = "Pertumbuhan (%)", y = NULL
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title      = element_text(size = 12, face = "bold",   color = navy,   hjust = 0),
    plot.subtitle   = element_text(size = 9,  color = "grey45", hjust = 0,
                                   margin = margin(b = 8)),
    axis.text.y     = element_text(size = 9, color = "grey25"),
    axis.text.x     = element_text(size = 8, color = "grey55"),
    axis.title.x    = element_text(size = 8, color = "grey55"),
    panel.grid.major.y = element_blank(),
    panel.grid.major.x = element_line(color = "grey92"),
    panel.grid.minor   = element_blank(),
    plot.background    = element_rect(fill = bg, color = NA),
    plot.margin        = margin(10, 20, 10, 10)
  )

# ══════════════════════════════════════════════════════════════════════════════
# PANEL B — Pertumbuhan jumlah pemain industri kosmetik
# ══════════════════════════════════════════════════════════════════════════════
pemain <- data.frame(
  tahun  = c(2020, 2021, 2022, 2023, 2024),
  jumlah = c(726, 820, 950, 1100, 1292)
)

pb <- ggplot(pemain, aes(x = tahun, y = jumlah)) +
  geom_area(fill = red_hi, alpha = 0.15) +
  geom_line(color = red_hi, linewidth = 1.4) +
  geom_point(color = red_hi, size = 3.5, fill = bg, shape = 21, stroke = 2) +
  geom_text(aes(label = format(jumlah, big.mark = ".")),
            nudge_y = 55, size = 3, color = navy, fontface = "bold") +
  annotate("text", x = 2022, y = 400,
           label = "+77% dalam\n4 tahun",
           size = 4.5, fontface = "bold", color = red_hi, lineheight = 1.2) +
  scale_x_continuous(breaks = 2020:2024) +
  scale_y_continuous(limits = c(0, 1500),
                     labels = scales::comma_format(big.mark = ".")) +
  labs(
    title    = "Jumlah Pelaku Industri Kosmetik",
    subtitle = "Sumber: Kemenperin",
    x = NULL, y = "Jumlah industri"
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title    = element_text(size = 12, face = "bold", color = navy),
    plot.subtitle = element_text(size = 8, color = "grey50",
                                 margin = margin(b = 8)),
    axis.text     = element_text(size = 8, color = "grey55"),
    axis.title.y  = element_text(size = 8, color = "grey55"),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.background    = element_rect(fill = bg, color = NA),
    plot.margin        = margin(10, 10, 10, 10)
  )

# ══════════════════════════════════════════════════════════════════════════════
# PANEL C — Dominasi brand lokal vs global (bar horizontal)
# ══════════════════════════════════════════════════════════════════════════════
brand_df <- data.frame(
  tahun = rep(c("2022", "2024"), each = 2),
  tipe  = rep(c("Brand Lokal", "Brand Global"), 2),
  pct   = c(45, 55, 68, 32)
)
brand_df$tahun <- factor(brand_df$tahun, levels = c("2022", "2024"))
brand_df$tipe  <- factor(brand_df$tipe,  levels = c("Brand Global", "Brand Lokal"))

pc <- ggplot(brand_df, aes(x = tahun, y = pct, fill = tipe)) +
  geom_col(width = 0.55, color = "white", linewidth = 0.8) +
  geom_text(aes(label = paste0(pct, "%")),
            position = position_stack(vjust = 0.5),
            size = 4.5, fontface = "bold", color = "white") +
  scale_fill_manual(values = c("Brand Lokal" = red_hi,
                               "Brand Global" = "#7F8C8D"),
                    name = NULL) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title    = "Dominasi Brand di\nE-Commerce Skincare",
    subtitle = "Skintific, Wardah, Ms Glow\ngeser L'Oréal & Maybelline",
    x = NULL, y = NULL
  ) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title      = element_text(size = 11, face = "bold", color = navy,
                                   lineheight = 1.2),
    plot.subtitle   = element_text(size = 8, color = "grey45",
                                   lineheight = 1.3, margin = margin(b = 8)),
    axis.text.x     = element_text(size = 10, face = "bold", color = navy),
    axis.text.y     = element_blank(),
    panel.grid      = element_blank(),
    legend.position = "bottom",
    legend.text     = element_text(size = 8),
    plot.background = element_rect(fill = bg, color = NA),
    plot.margin     = margin(10, 10, 10, 5)
  )

# ══════════════════════════════════════════════════════════════════════════════
# GABUNG SEMUA PANEL
# ══════════════════════════════════════════════════════════════════════════════
layout <- "
AA
BC
"

final <- (pa + pb + pc) +
  plot_layout(design = layout, widths = c(1, 1), heights = c(1.2, 1)) +
  plot_annotation(
    title   = "Pasar Skincare Indonesia 2024: Tumbuh di Tengah Tekanan Ekonomi",
    subtitle = "Pertumbuhan dua digit di hampir semua kategori — namun brand lokal mulai mendominasi, mengindikasikan trade-down",
    caption  = "Sumber: NielsenIQ, Compas.co.id, CNBC Indonesia, Kemenperin, GoodStats (2024–2025)\nDibuat oleh ikanx101.com",
    theme = theme(
      plot.title      = element_text(size = 14, face = "bold", color = navy,
                                     hjust = 0.5, margin = margin(b = 4)),
      plot.subtitle   = element_text(size = 9.5, color = "grey40",
                                     hjust = 0.5, lineheight = 1.4,
                                     margin = margin(b = 6)),
      plot.caption    = element_text(size = 7.5, color = "grey55",
                                     hjust = 0.5, margin = margin(t = 10)),
      plot.background = element_rect(fill = bg, color = NA),
      plot.margin     = margin(15, 20, 15, 20)
    )
  )

ggsave(
  "/home/ikanx101/Documents/penelitian/viz_skincare_indonesia.png",
  final, width = 14, height = 10, dpi = 200, bg = bg
)
message("Chart 1 selesai: viz_skincare_indonesia.png")
