# ============================================================
# GDP Growth Q1 2026: Growth Rate vs Absolute Delta
# Matematika Sederhana: Rasio tanpa Konteks adalah Hampa
# ============================================================
# Author: AIkanx for Yang Mulia King Ikang
# ============================================================

library(ggplot2)
library(dplyr)
library(scales)
library(gridExtra)
library(grid)

# Data --------------------------------------------------------
gdp_data <- data.frame(
  negara = c("Vietnam", "Indonesia", "Malaysia", "China", "Thailand", "Amerika Serikat"),
  growth = c(7.83, 5.61, 5.40, 5.00, 2.80, 2.70),
  gdp_nominal_trillion = c(0.470, 1.500, 0.445, 18.300, 0.530, 29.200), # in $T
  stringsAsFactors = FALSE
) %>%
  mutate(
    delta_gdp_billion = gdp_nominal_trillion * 1000 * growth / 100,  # $Miliar
    # Urutkan berdasarkan growth menurun untuk konsistensi visual
    negara = factor(negara, levels = rev(negara[order(growth)])),
    label_growth = sprintf("%.2f%%", growth),
    label_delta = sprintf("$%.0f M", delta_gdp_billion)
  )

# Color palette yang elegan -----------------------------------
warna <- c(
  "Vietnam"          = "#2E86AB",
  "Indonesia"        = "#CE4257",
  "Malaysia"         = "#F6AE2D",
  "China"            = "#D81159",
  "Thailand"         = "#8F2D56",
  "Amerika Serikat"  = "#1B998B"
)

# Theme konsisten ---------------------------------------------
theme_ikanx <- theme_minimal(base_family = "sans") +
  theme(
    plot.title       = element_text(size = 16, face = "bold", hjust = 0.5, margin = margin(b = 4)),
    plot.subtitle    = element_text(size = 9, color = "grey40", hjust = 0.5, margin = margin(b = 16)),
    plot.caption     = element_text(size = 7, color = "grey60", hjust = 0.5, margin = margin(t = 10)),
    axis.title       = element_text(size = 10, face = "bold"),
    axis.text        = element_text(size = 9),
    axis.text.x      = element_text(angle = 0, hjust = 0.5),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    legend.position  = "none",
    plot.margin      = margin(12, 16, 8, 12)
  )

# Panel 1: Growth Rate (%) ------------------------------------
p_growth <- ggplot(gdp_data, aes(x = negara, y = growth, fill = negara)) +
  geom_bar(stat = "identity", width = 0.65, alpha = 0.90) +
  geom_text(aes(label = label_growth),
            hjust = -0.15, size = 3.8, fontface = "bold", color = "grey30") +
  scale_fill_manual(values = warna) +
  scale_y_continuous(limits = c(0, 10.5), expand = c(0, 0)) +
  coord_flip() +
  labs(
    title    = "Growth Rate Q1 2026 (y-on-y)",
    subtitle = "Semakin tinggi persentase, semakin besar\npertumbuhan relatif terhadap basis sendiri",
    x = NULL, y = "Pertumbuhan (%)"
  ) +
  theme_ikanx +
  theme(
    plot.subtitle = element_text(size = 8, color = "grey45", hjust = 0.5, lineheight = 1.1)
  )

# Panel 2: Absolute Delta GDP ($ Miliar) ---------------------
p_delta <- ggplot(gdp_data, aes(x = negara, y = delta_gdp_billion, fill = negara)) +
  geom_bar(stat = "identity", width = 0.65, alpha = 0.90) +
  geom_text(aes(label = label_delta),
            hjust = -0.1, size = 3.8, fontface = "bold", color = "grey30") +
  scale_fill_manual(values = warna) +
  scale_y_continuous(limits = c(0, 1150), expand = c(0, 0),
                     labels = dollar_format(suffix = " M", prefix = "")) +
  coord_flip() +
  labs(
    title    = "Tambahan Nilai Ekonomi Q1 2026 ($Miliar)",
    subtitle = "Nilai absolut: China dan AS tetap jauh lebih besar\nmeski growth rate-nya lebih rendah",
    x = NULL, y = "Tambahan GDP (USD Miliar)"
  ) +
  theme_ikanx +
  theme(
    plot.subtitle = element_text(size = 8, color = "grey45", hjust = 0.5, lineheight = 1.1)
  )

# Gabungkan dalam satu layout ---------------------------------
judul <- textGrob(
  label = "Growth Rate vs Nilai Absolut: Kenapa Rasio Saja Tidak Cukup",
  gp = gpar(fontsize = 18, fontface = "bold", col = "#2C3E50"),
  vjust = 1
)

subjudul <- textGrob(
  label = expression(
    "Growth rate adalah rasio: " * frac(Delta ~ GDP, GDP[sebelum]) *
    ". Membandingkan rasio tanpa melihat penyebutnya adalah sesat logika."
  ),
  gp = gpar(fontsize = 9, col = "#5D6D7E", fontfamily = "sans"),
  vjust = 0
)
  
footer <- textGrob(
  label = "Sumber: BPS, DOSM, GSO, NESDC, NBS, BEA | Visual: AIkanx",
  gp = gpar(fontsize = 7, col = "#95A5A6"),
  vjust = 0
)

# Note kecil di bawah
catatan <- textGrob(
  label = "China (growth 5,0%) menambah ~$915 M — 11× lipat dari Indonesia (growth 5,61%) yang menambah ~$84 M.",
  gp = gpar(fontsize = 8, col = "#C0392B", fontface = "italic"),
  vjust = 0
)

layout_matrix <- rbind(
  c(1, 1),
  c(2, 2),
  c(3, 4),
  c(5, 5),
  c(6, 6)
)

png_plot <- grid.arrange(
  judul, subjudul,
  p_growth, p_delta,
  catatan, footer,
  layout_matrix = layout_matrix,
  heights = c(0.12, 0.06, 0.62, 0.08, 0.06)
)

# Simpan ke PNG -----------------------------------------------
ggsave(
  filename = "/home/ikanx101/Documents/draft_blog/gdp_growth_vs_absolute.png",
  plot = png_plot,
  width = 14,
  height = 8,
  dpi = 200,
  type = "cairo",
  bg = "white"
)

cat("Visual selesai disimpan.\n")
