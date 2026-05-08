# =============================================================================
# Visualisasi Market Kopi Bubuk Indonesia
# Untuk artikel blog ikanx101.com
# =============================================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(RColorBrewer)
library(viridis)
library(scales)
library(gridExtra)

# --- Theme setup ---
theme_set(theme_minimal(base_size = 12))

# Warna
warna_kapal <- "#C41E3A"
warna_abc <- "#2E86AB"
warna_tora <- "#F18F01"
warna_luwak <- "#6B4226"
warna_top <- "#1B998B"
warna_excelso <- "#7B2D8B"
warna_goodday <- "#E9B741"
warna_indocafe <- "#2C3E50"
warna_nescafe <- "#D35400"

# =============================================================================
# VIS 1: Timeline TBI Ground Coffee
# =============================================================================

tb_ground <- data.frame(
  Tahun = c(2009, 2010, 2011, 2022, 2023, 2024, 2025, 2026),
  Kapal_Api = c(43.6, 39.4, 35.7, 62.4, 62.8, 52.1, 49.7, 56.5),
  ABC = c(18.9, 22.1, 24.4, NA, NA, 11.1, 17.9, NA),
  Torabika = c(7.5, 6.2, 8.5, NA, NA, NA, NA, NA),
  Nescafe = c(9.9, 8.3, 5.2, NA, NA, NA, NA, NA),
  Indocafe = c(6.4, 9.1, 8.4, NA, NA, NA, NA, NA),
  Luwak_White = c(NA, NA, NA, NA, NA, 20.1, 14.4, NA),
  Excelso = c(NA, NA, NA, NA, NA, 5.4, 5.5, NA),
  Top_Coffee = c(NA, NA, NA, NA, NA, 3.7, 3.1, NA)
)

tb_long <- tb_ground %>%
  pivot_longer(-Tahun, names_to = "Merek", values_to = "TBI") %>%
  mutate(Merek = case_when(
    Merek == "Kapal_Api" ~ "Kapal Api",
    Merek == "Luwak_White" ~ "Luwak White Coffee",
    Merek == "Top_Coffee" ~ "Top Coffee",
    TRUE ~ Merek
  )) %>%
  filter(!is.na(TBI))

tb_utama <- tb_long %>% filter(Merek %in% c("Kapal Api", "ABC", "Torabika", "Luwak White Coffee", "Top Coffee", "Excelso"))

p1 <- ggplot(tb_utama, aes(x = Tahun, y = TBI, color = Merek, group = Merek)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 3) +
  geom_text(aes(label = paste0(round(TBI, 1), "%")), 
            vjust = -1.2, size = 3.2, show.legend = FALSE) +
  scale_color_manual(values = c(
    "Kapal Api" = warna_kapal,
    "ABC" = warna_abc,
    "Torabika" = warna_tora,
    "Luwak White Coffee" = warna_luwak,
    "Top Coffee" = warna_top,
    "Excelso" = warna_excelso
  )) +
  scale_x_continuous(breaks = c(2009, 2010, 2011, 2022, 2023, 2024, 2025, 2026)) +
  scale_y_continuous(limits = c(0, 70), labels = function(x) paste0(x, "%")) +
  labs(
    title = "Perjalanan Top Brand Index Kopi Bubuk Berampas (Ground Coffee)",
    subtitle = "Data: Top Brand Award (2009-2011: Majalah SWA, 2022-2026: Frontier Research)",
    x = "Tahun",
    y = "Top Brand Index (%)",
    color = "Merek",
    caption = "Sumber: Top Brand Award - Frontier Research. Gap data 2012-2021 tidak tersedia secara publik."
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig1_timeline_ground_coffee.png", p1, width = 12, height = 6, dpi = 150)

# =============================================================================
# VIS 2: Bar Chart TBI Kopi Instan/Sachet 2024-2025
# =============================================================================

tb_instan <- data.frame(
  Merek = c("Good Day", "Indocafe", "ABC", "Nescafe", "Torabika", "Kopiko"),
  TBI_2024 = c(48.4, 19.3, NA, 8.3, 4.1, NA),
  TBI_2025 = c(42.8, 19.7, 17.6, 9.1, 6.4, 1.1)
)

tb_instan_long <- tb_instan %>%
  pivot_longer(-Merek, names_to = "Tahun", values_to = "TBI") %>%
  mutate(Tahun = gsub("TBI_", "", Tahun)) %>%
  filter(!is.na(TBI))

p2 <- ggplot(tb_instan_long, aes(x = reorder(Merek, -TBI), y = TBI, fill = Tahun)) +
  geom_col(position = position_dodge(0.8), width = 0.7, alpha = 0.85) +
  geom_text(aes(label = paste0(round(TBI, 1), "%")),
            position = position_dodge(0.8), vjust = -0.4, size = 3.5) +
  scale_fill_manual(values = c("2024" = "#3B7A9E", "2025" = "#6BA3C7")) +
  scale_y_continuous(limits = c(0, 55), labels = function(x) paste0(x, "%")) +
  labs(
    title = "Top Brand Index Kopi Bubuk Instan/Sachet (2024-2025)",
    subtitle = "Torabika masih bertahan di segmen instan, meski jauh dari puncak",
    x = NULL,
    y = "Top Brand Index (%)",
    fill = "Tahun",
    caption = "Sumber: Top Brand Award - Frontier Research"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "bottom",
    panel.grid.major.x = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig2_instan_sachet.png", p2, width = 10, height = 6, dpi = 150)

# =============================================================================
# VIS 3: Belanja Iklan Top Coffee (2012) vs Kompetitor
# =============================================================================

belanja <- data.frame(
  Merek = c("Top Coffee", "Kapal Api", "Indomie", "Ponds White Beauty", "Mie Sedaap", "Torabika"),
  Belanja_Iklan = c(421.7, 150, 339, 510, 504, 85),
  Kategori = c("New Entrant", "Market Leader", "Market Leader", "Market Leader", "Market Leader", "Established")
)

p3 <- ggplot(belanja, aes(x = reorder(Merek, Belanja_Iklan), y = Belanja_Iklan, fill = Kategori)) +
  geom_col(width = 0.65, alpha = 0.85) +
  geom_text(aes(label = paste0("Rp ", round(Belanja_Iklan, 0), " M")),
            hjust = -0.1, size = 3.8) +
  scale_fill_manual(values = c("New Entrant" = warna_top, "Market Leader" = warna_kapal, "Established" = warna_tora)) +
  scale_y_continuous(limits = c(0, 600), labels = function(x) paste0("Rp ", x, " M")) +
  coord_flip() +
  labs(
    title = "Belanja Iklan 2012: Top Coffee vs Kompetitor & Brand Besar",
    subtitle = "Top Coffee — merek baru — belanja iklan Rp 421,7 miliar, #4 se-Indonesia",
    x = NULL,
    y = "Belanja Iklan (Miliar Rupiah)",
    fill = "Status Merek",
    caption = "Sumber: Nielsen Adex via Mix.co.id (2012)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "bottom",
    panel.grid.major.y = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig3_belanja_iklan_top_coffee.png", p3, width = 10, height = 6, dpi = 150)

# =============================================================================
# VIS 4: Pergeseran Torabika — Dualitas Ground vs Instan
# =============================================================================

torabika_df <- data.frame(
  Segmen = c("Ground Coffee\n(2011)", "Kopi Instan\n(2024)", "Kopi Instan\n(2025)"),
  TBI = c(8.5, 4.1, 6.4)
)

p4 <- ggplot(torabika_df, aes(x = Segmen, y = TBI, fill = Segmen)) +
  geom_col(width = 0.5, alpha = 0.85) +
  geom_text(aes(label = paste0(round(TBI, 1), "%")), vjust = -0.8, size = 6, 
            fontface = "bold") +
  scale_fill_manual(values = c(
    "Ground Coffee\n(2011)" = warna_tora,
    "Kopi Instan\n(2024)" = "#D4A843",
    "Kopi Instan\n(2025)" = "#F0C75E"
  )) +
  scale_y_continuous(limits = c(0, 12), labels = function(x) paste0(x, "%")) +
  labs(
    title = "Pergeseran Torabika: Dari Ground Coffee ke Kopi Instan",
    subtitle = "Torabika masih ada — tapi di meja yang berbeda. Segmen ground coffee sudah lama ditinggalkan.",
    x = NULL,
    y = "Top Brand Index (%)",
    caption = "Sumber: Top Brand Award"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "none",
    panel.grid.major.x = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig4_pergeseran_torabika.png", p4, width = 8, height = 6, dpi = 150)

# =============================================================================
# VIS 5: Ringkasan Pangsa Pasar Ground Coffee 2006-2007 vs 2025
# =============================================================================

pangsa_2006 <- data.frame(
  Merek = c("Kapal Api", "ABC", "Nescafe", "Indocafe", "Torabika", "Lainnya"),
  Pangsa = c(44.0, 17.5, 9.9, 6.4, 7.5, 14.7),
  Tahun = "2006-2007"
)

pangsa_2025 <- data.frame(
  Merek = c("Kapal Api", "ABC", "Luwak White Coffee", "Excelso", "Top Coffee", "Lainnya"),
  Pangsa = c(49.7, 17.9, 14.4, 5.5, 3.1, 9.4),
  Tahun = "2025"
)

pangsa_all <- bind_rows(pangsa_2006, pangsa_2025) %>%
  mutate(Merek = factor(Merek, levels = rev(c("Kapal Api", "ABC", "Torabika", "Nescafe", "Indocafe", 
                                              "Luwak White Coffee", "Excelso", "Top Coffee", "Lainnya"))))

p5 <- ggplot(pangsa_all, aes(x = Tahun, y = Pangsa, fill = Merek)) +
  geom_col(width = 0.5, alpha = 0.9) +
  geom_text(aes(label = ifelse(Pangsa > 4, paste0(round(Pangsa, 1), "%"), "")),
            position = position_stack(vjust = 0.5), size = 3.5, color = "white", fontface = "bold") +
  scale_fill_manual(values = c(
    "Kapal Api" = warna_kapal,
    "ABC" = warna_abc,
    "Torabika" = warna_tora,
    "Nescafe" = warna_nescafe,
    "Indocafe" = warna_indocafe,
    "Luwak White Coffee" = warna_luwak,
    "Excelso" = warna_excelso,
    "Top Coffee" = warna_top,
    "Lainnya" = "grey70"
  )) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Perubahan Komposisi Pasar Kopi: 2006-2007 vs 2025",
    subtitle = "Torabika menghilang dari ground coffee, digantikan Luwak White Coffee & Top Coffee",
    x = NULL,
    y = "Pangsa Pasar (%)",
    fill = "Merek",
    caption = "Sumber: 2006-2007 dari MARS Indonesia (via paper marketing Kapal Api), 2025 dari Top Brand Award"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "right",
    panel.grid.major.x = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig5_pangsa_2006_vs_2025.png", p5, width = 10, height = 7, dpi = 150)

# =============================================================================
# VIS 6: Santos Jaya Abadi — Multi-brand Strategy Ecosystem
# =============================================================================

santos <- data.frame(
  Merek = c("Kapal Api\n(Ground Coffee)", "ABC\n(Ground Coffee)", "Good Day\n(Kopi Instan)", 
            "Excelso\n(Premium)", "Merek Ya\n(Ekonomis)", "Fresco\n(Lainnya)"),
  TBI_Tertinggi = c(62.8, 24.4, 48.4, 5.5, 2.2, 1.0),
  Warna = c(warna_kapal, warna_abc, warna_goodday, warna_excelso, "#E67E22", "#95A5A6")
)

p6 <- ggplot(santos, aes(x = reorder(Merek, TBI_Tertinggi), y = TBI_Tertinggi, fill = Merek)) +
  geom_col(width = 0.6, alpha = 0.85) +
  geom_text(aes(label = paste0(round(TBI_Tertinggi, 1), "%")), 
            hjust = -0.2, size = 4, fontface = "bold") +
  scale_fill_manual(values = setNames(santos$Warna, santos$Merek)) +
  coord_flip() +
  scale_y_continuous(limits = c(0, 70), labels = function(x) paste0(x, "%")) +
  labs(
    title = "Kekuatan Kapal Api Group (Santos Jaya Abadi): Multi-brand Strategy",
    subtitle = "Satu induk — lima merek. Good Day (instan) = Santos juga! Kuasai ~60% pasar kopi nasional",
    x = NULL,
    y = "TBI Tertinggi yang Pernah Dicapai (%)",
    caption = "Sumber: Top Brand Award (berbagai tahun)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    legend.position = "none",
    panel.grid.major.y = element_blank()
  )

ggsave("/home/ikanx101/Documents/kerjakan/fig6_santos_multibrand.png", p6, width = 10, height = 6, dpi = 150)

# =============================================================================
# Selesai — semua visualisasi tersimpan
# =============================================================================
cat("\n=== SEMUA VISUALISASI SELESAI ===\n")
cat("File tersimpan di /home/ikanx101/Documents/kerjakan/\n")
