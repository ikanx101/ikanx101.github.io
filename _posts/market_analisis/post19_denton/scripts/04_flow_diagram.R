# =============================================================================
# 04_flow_diagram.R
# Membuat diagram alur sederhana: cara pengerjaan analisis Denton di project
# ini, dari data mentah sampai insight. Disimpan sebagai PNG ke folder plots/
# =============================================================================

library(ggplot2)
library(grid)

# -----------------------------------------------------------------------------
# Definisi kotak (box) alur
# -----------------------------------------------------------------------------
boxes <- data.frame(
  xmin  = c(0.4, 3.6, 6.8,  2.5, 2.5, 2.5),
  xmax  = c(3.2, 6.4, 9.6,  7.5, 7.5, 7.5),
  ymin  = c(12,  12,  12,   8.5, 5.5, 2.5),
  ymax  = c(13.2,13.2,13.2, 10,  7,   4),
  label = c(
    "Brand Awareness TAHUNAN\n(benchmark, 2021-2025)",
    "Ad Awareness Survey KUARTALAN\n(indicator, 2021-2025)",
    "Sales KUARTALAN\n(2021-2025)",
    "DENTON-CHOLETTE\nDisagregasi tahunan -> kuartalan\n(cek: rata-rata kuartalan = benchmark tahunan)",
    "UJI KORELASI SPEARMAN\nBrand Awareness (hasil Denton) vs Sales\nlag 0, 1, 2, 3 kuartal",
    "INSIGHT\nLag paling kuat & signifikan -> visualisasi (PNG)"
  ),
  fill  = c("#F7DADA", "#DCEAF2", "#EAEAEA", "#2E86AB", "#C1272D", "#2C3E50"),
  color = c("#C1272D", "#2E86AB", "#888888", "#2E86AB", "#C1272D", "#2C3E50"),
  textcol = c("#C1272D", "#2E86AB", "#555555", "white", "white", "white"),
  size  = c(3.4, 3.4, 3.4, 3.6, 3.6, 3.6),
  stringsAsFactors = FALSE
)

# -----------------------------------------------------------------------------
# Definisi panah penghubung antar kotak
# -----------------------------------------------------------------------------
arrows <- data.frame(
  x    = c(1.8, 5.0, 8.2, 5.0, 5.0),
  y    = c(12,  12,  12,  8.5, 5.5),
  xend = c(4.0, 6.2, 7.55,5.0, 5.0),
  yend = c(10,  10,  7.05,7.0, 4.0)
)

# -----------------------------------------------------------------------------
# Plot
# -----------------------------------------------------------------------------
p <- ggplot() +
  geom_rect(data = boxes,
            aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                fill = fill, color = color),
            linewidth = 1) +
  geom_text(data = boxes,
            aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2,
                label = label, color = textcol, size = size),
            fontface = "bold", lineheight = 0.95) +
  geom_segment(data = arrows,
               aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.28, "cm"), type = "closed"),
               linewidth = 0.9, color = "#555555") +
  scale_fill_identity() +
  scale_color_identity() +
  scale_size_identity() +
  coord_cartesian(xlim = c(0, 10), ylim = c(2, 13.5), clip = "off") +
  labs(title = "Alur Analisis Denton: dari Data ke Insight") +
  theme_void(base_size = 14) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5, size = 17,
                                   margin = margin(b = 10)),
        plot.margin = margin(10, 10, 10, 10))

ggsave(file.path("plots", "07_diagram_alur_denton.png"), p, width = 10, height = 8, dpi = 150)

cat("Diagram alur berhasil disimpan ke plots/07_diagram_alur_denton.png\n")
