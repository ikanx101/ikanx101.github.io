library(ggplot2)
library(dplyr)

# Data ranking coffee shop dunia
data <- data.frame(
  negara = c("Indonesia", "China", "Amerika Serikat", "Korea Selatan",
             "Vietnam", "Thailand", "Jepang", "Filipina", "Lainnya"),
  jumlah = c(461991, 190000, 145600, 95000, 80000, 70000, 65000, 55000, 200000),
  stringsAsFactors = FALSE
)

# Hitung persentase
data <- data %>%
  arrange(desc(jumlah)) %>%
  mutate(
    persen     = jumlah / sum(jumlah) * 100,
    label_pct  = paste0(round(persen, 1), "%"),
    label_full = paste0(negara, "\n", format(jumlah, big.mark = ".", decimal.mark = ","), " kedai")
  )

# Posisi label di tengah tiap segmen
data <- data %>%
  mutate(
    ymax   = cumsum(persen),
    ymin   = lag(ymax, default = 0),
    ymid   = (ymax + ymin) / 2
  )

# Palet warna — Indonesia diberi aksen merah-putih
n      <- nrow(data)
colors <- c(
  "#C0392B",   # Indonesia — merah kuat
  "#2C3E50",   # China
  "#2980B9",   # Amerika Serikat
  "#8E44AD",   # Korea Selatan
  "#16A085",   # Vietnam
  "#D35400",   # Thailand
  "#7F8C8D",   # Jepang
  "#27AE60",   # Filipina
  "#BDC3C7"    # Lainnya
)

# ── Plot ──────────────────────────────────────────────────────────────────────
p <- ggplot(data, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 2.5, fill = negara)) +
  geom_rect(color = "white", linewidth = 0.6) +
  # Label gabungan: negara + persen (hanya segmen ≥ 5%)
  geom_text(
    aes(x = 4.7, y = ymid,
        label = ifelse(persen >= 5,
                       paste0(negara, "  ", label_pct), "")),
    size = 3.1, fontface = "bold", color = "grey20", hjust = 0
  ) +
  # Teks tengah donut
  annotate("text", x = 0, y = 0, label = "Coffee\nShop Dunia",
           size = 5, fontface = "bold", color = "#2C3E50", lineheight = 1.25) +
  annotate("text", x = 0, y = -25, label = "~1,36 juta kedai",
           size = 2.8, color = "grey55") +
  coord_polar(theta = "y", start = 0) +
  scale_fill_manual(values = setNames(colors, data$negara)) +
  xlim(c(-2, 7.5)) +
  labs(
    title    = "Negara dengan Jumlah Coffee Shop Terbanyak di Dunia",
    subtitle = "Indonesia menempati peringkat pertama dengan 461.991 kedai kopi",
    caption  = "Sumber: OpenStreetMap Point of Interest (POI) — November 2025, via SCAI (@aksi_scai)\nDibuat oleh ikanx101.com"
  ) +
  theme_void(base_family = "sans") +
  theme(
    plot.title      = element_text(size = 14, face = "bold",   color = "#2C3E50",
                                   hjust = 0.5, margin = margin(b = 4)),
    plot.subtitle   = element_text(size = 10, color = "#C0392B",
                                   hjust = 0.5, margin = margin(b = 10)),
    plot.caption    = element_text(size = 7.5, color = "grey50", hjust = 0.5,
                                   margin = margin(t = 10)),
    legend.position = "none",
    plot.background = element_rect(fill = "#FAFAFA", color = NA),
    plot.margin     = margin(15, 60, 15, 15)
  )

# Simpan
ggsave(
  filename = "/home/ikanx101/Documents/penelitian/ranking_coffee_shop_dunia.png",
  plot     = p,
  width    = 10,
  height   = 7,
  dpi      = 200,
  bg       = "#FAFAFA"
)

message("Selesai! File disimpan: ranking_coffee_shop_dunia.png")
