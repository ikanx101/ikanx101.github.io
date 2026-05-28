library(ggplot2)
library(dplyr)
library(patchwork)

# ── Data ──────────────────────────────────────────────────────────────────────
# Sumber: LPEM FEB UI, IEO Q3-2025 (via Kompas, Agustus 2025)
raw <- data.frame(
  kategori = c("Elektronik &\nPeralatan", "Pakaian &\nAlas Kaki", "Kosmetik &\nPerawatan"),
  pct_2019 = c(2.89, 2.84, 1.14),
  pct_2024 = c(1.95, 2.25, 1.27)
)

rescale <- function(x) x / sum(x) * 100

long <- bind_rows(
  raw %>% mutate(tahun = "2019", persen = rescale(pct_2019)) %>%
    select(tahun, kategori, persen),
  raw %>% mutate(tahun = "2024", persen = rescale(pct_2024)) %>%
    select(tahun, kategori, persen)
) %>%
  group_by(tahun) %>%
  arrange(tahun, desc(persen)) %>%
  mutate(
    ymax  = cumsum(persen),
    ymin  = lag(ymax, default = 0),
    ymid  = (ymax + ymin) / 2,
    label = paste0(round(persen, 1), "%")
  ) %>%
  ungroup()

# ── Palette ───────────────────────────────────────────────────────────────────
pal <- c(
  "Elektronik &\nPeralatan" = "#2980B9",
  "Pakaian &\nAlas Kaki"    = "#95A5A6",
  "Kosmetik &\nPerawatan"   = "#C0392B"
)

# ── Fungsi donut (label hanya persen, di dalam segmen) ───────────────────────
make_donut <- function(df_year, year_label, sub_label) {
  ggplot(df_year,
         aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 2.3, fill = kategori)) +
    geom_rect(color = "white", linewidth = 1) +
    # persen di dalam segmen
    geom_text(aes(x = 3.15, y = ymid, label = label),
              size = 4, fontface = "bold", color = "white") +
    # tahun di tengah
    annotate("text", x = 0, y = 0, label = year_label,
             size = 9, fontface = "bold", color = "#2C3E50") +
    annotate("text", x = 0, y = -22, label = sub_label,
             size = 2.6, color = "grey55", fontface = "italic") +
    coord_polar(theta = "y", start = 0) +
    scale_fill_manual(values = pal) +
    xlim(c(-2, 5.5)) +
    theme_void(base_family = "sans") +
    theme(legend.position = "none",
          plot.margin     = margin(5, 5, 5, 5))
}

p2019 <- make_donut(
  long %>% filter(tahun == "2019"), "2019", "Sebelum tekanan ekonomi"
)
p2024 <- make_donut(
  long %>% filter(tahun == "2024"), "2024", "Di tengah perlambatan daya beli"
)

# ── Panel bawah: legenda + angka perubahan ────────────────────────────────────
change_df <- data.frame(
  x     = c(1, 2, 3),
  nama  = c("Elektronik & Peralatan", "Pakaian & Alas Kaki", "Kosmetik & Perawatan"),
  sebelum = c("2,89%", "2,84%", "1,14%"),
  sesudah = c("1,95%", "2,25%", "1,27%"),
  delta = c("▼  -32,5%", "▼  -20,8%", "▲  +11,4%"),
  warna = c("#2980B9", "#95A5A6", "#C0392B"),
  stringsAsFactors = FALSE
)

info_plot <- ggplot() +
  # kotak warna (legend swatch)
  geom_tile(data = change_df,
            aes(x = x, y = 0.92, fill = nama),
            width = 0.18, height = 0.12) +
  scale_fill_manual(values = setNames(change_df$warna, change_df$nama)) +
  # nama kategori
  geom_text(data = change_df,
            aes(x = x, y = 0.75, label = nama, color = nama),
            size = 3.2, fontface = "bold", lineheight = 1.1) +
  scale_color_manual(values = setNames(change_df$warna, change_df$nama)) +
  # angka sebelum → sesudah
  geom_text(data = change_df,
            aes(x = x, y = 0.52,
                label = paste0("(", sebelum, " → ", sesudah, ")")),
            size = 2.8, color = "grey45") +
  # delta
  geom_text(data = change_df,
            aes(x = x, y = 0.32, label = delta, color = nama),
            size = 4.2, fontface = "bold") +
  # garis pemisah
  geom_hline(yintercept = 0.12, color = "grey85", linewidth = 0.4) +
  # catatan inflasi
  annotate("text", x = 2, y = 0.02,
           label = "Inflasi jasa perawatan pribadi: 3,56% (Q1 2024)  →  8,71% (Q1 2025)",
           size = 2.8, color = "grey45", fontface = "italic") +
  xlim(c(0.4, 3.6)) + ylim(c(-0.08, 1.05)) +
  guides(fill = "none", color = "none") +
  theme_void(base_family = "sans") +
  theme(plot.margin = margin(0, 20, 0, 20))

# ── Gabung layout ─────────────────────────────────────────────────────────────
layout <- "
AABB
CCCC
"

final <- (p2019 + p2024 + info_plot) +
  plot_layout(design = layout, heights = c(3, 1)) +
  plot_annotation(
    title    = "Lipstick Effect di Indonesia: Pergeseran Pengeluaran Diskresioner",
    subtitle = "Saat daya beli melemah, belanja barang besar turun — namun kosmetik & perawatan justru naik\n(Porsi dihitung relatif terhadap 3 kategori diskresioner)",
    caption  = "Sumber: LPEM FEB UI — Indonesia Economic Outlook Q3-2025, via Kompas (Agustus 2025)\nDibuat oleh ikanx101.com",
    theme = theme(
      plot.title      = element_text(size = 15, face = "bold", color = "#2C3E50",
                                     hjust = 0.5, margin = margin(b = 5)),
      plot.subtitle   = element_text(size = 9.5, color = "grey40",
                                     hjust = 0.5, margin = margin(b = 4),
                                     lineheight = 1.5),
      plot.caption    = element_text(size = 8, color = "grey55",
                                     hjust = 0.5, margin = margin(t = 10)),
      plot.background = element_rect(fill = "#FAFAFA", color = NA),
      plot.margin     = margin(15, 20, 15, 20)
    )
  )

# ── Simpan ─────────────────────────────────────────────────────────────────────
ggsave(
  filename = "/home/ikanx101/Documents/penelitian/lipstick_effect_indonesia.png",
  plot     = final,
  width    = 13,
  height   = 9,
  dpi      = 200,
  bg       = "#FAFAFA"
)

message("Selesai! File disimpan: lipstick_effect_indonesia.png")
