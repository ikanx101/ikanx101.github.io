# ============================================================
# Data & Visualisasi Gol Juara Premier League (1992-2025)
# ============================================================

library(ggplot2)
library(dplyr)

# ---- Data ----
pl_champions <- data.frame(
  season = c(
    "1992-93", "1993-94", "1994-95", "1995-96", "1996-97",
    "1997-98", "1998-99", "1999-00", "2000-01", "2001-02",
    "2002-03", "2003-04", "2004-05", "2005-06", "2006-07",
    "2007-08", "2008-09", "2009-10", "2010-11", "2011-12",
    "2012-13", "2013-14", "2014-15", "2015-16", "2016-17",
    "2017-18", "2018-19", "2019-20", "2020-21", "2021-22",
    "2022-23", "2023-24", "2024-25"
  ),
  club = c(
    "Manchester United", "Manchester United", "Blackburn Rovers", "Manchester United", "Manchester United",
    "Arsenal",          "Manchester United", "Manchester United", "Manchester United", "Arsenal",
    "Manchester United", "Arsenal",          "Chelsea",           "Chelsea",           "Manchester United",
    "Manchester United", "Manchester United", "Chelsea",           "Manchester United", "Manchester City",
    "Manchester United", "Manchester City",   "Chelsea",           "Leicester City",    "Chelsea",
    "Manchester City",   "Manchester City",   "Liverpool",         "Manchester City",   "Manchester City",
    "Manchester City",   "Manchester City",   "Liverpool"
  ),
  goals = c(
    67, 80, 80, 73, 76,
    68, 80, 97, 79, 79,
    74, 73, 72, 72, 83,
    80, 68, 103, 78, 93,
    86, 102, 73, 68, 85,
    106, 95, 85, 83, 99,
    94, 96, 86
  ),
  stringsAsFactors = FALSE
)

# Label khusus untuk highlight
pl_champions <- pl_champions %>%
  mutate(
    label_note = case_when(
      season == "2003-04" ~ "Invincibles\n(73 gol)",
      season == "2017-18" ~ "Rekor!\n(106 gol)",
      season == "2009-10" ~ "Pertama\n100+ gol",
      TRUE ~ NA_character_
    ),
    color_group = case_when(
      club == "Manchester United" ~ "Manchester United",
      club == "Manchester City"   ~ "Manchester City",
      club == "Arsenal"           ~ "Arsenal",
      club == "Chelsea"           ~ "Chelsea",
      club == "Liverpool"         ~ "Liverpool",
      club == "Blackburn Rovers"  ~ "Blackburn Rovers",
      club == "Leicester City"    ~ "Leicester City"
    )
  )

# Simpan data
save(pl_champions, file = "premier_league_goals/pl_champions.rda")

# ---- Warna klub (distinct, estetis) ----
club_colors <- c(
  "Manchester United" = "#E74C3C",   # merah cerah
  "Manchester City"   = "#3498DB",   # biru langit
  "Arsenal"           = "#E67E22",   # oranye
  "Chelsea"           = "#9B59B6",   # ungu
  "Liverpool"         = "#F1C40F",   # kuning emas
  "Blackburn Rovers"  = "#2ECC71",   # hijau
  "Leicester City"    = "#1ABC9C"    # toska
)

# ---- Visualisasi ----
p <- ggplot(pl_champions, aes(x = season, y = goals, fill = color_group)) +
  # Garis referensi 100 gol
  geom_hline(yintercept = 100, linetype = "dashed", color = "#FFD700", linewidth = 0.8, alpha = 0.9) +
  annotate("text", x = "1992-93", y = 101.5, label = "Ambang 100 Gol",
           color = "#FFD700", size = 3, hjust = 0, fontface = "italic") +
  # Bar chart
  geom_col(width = 0.75, color = "white", linewidth = 0.3) +
  # Nilai gol di atas bar
  geom_text(aes(label = goals), vjust = -0.5, size = 2.8, color = "white", fontface = "bold") +
  # Label khusus
  geom_label(
    data = filter(pl_champions, !is.na(label_note)),
    aes(label = label_note, y = goals + 6),
    fill = "#1a1a2e", color = "white", size = 2.5, label.padding = unit(0.25, "lines"),
    label.r = unit(0.15, "lines"), fontface = "bold"
  ) +
  # Skala warna
  scale_fill_manual(values = club_colors, name = "Klub") +
  # Skala Y
  scale_y_continuous(
    limits = c(0, 120),
    breaks = seq(0, 120, 20),
    expand = c(0, 0)
  ) +
  # Tema
  theme_minimal(base_family = "sans") +
  theme(
    plot.background    = element_rect(fill = "#0d1117", color = NA),
    panel.background   = element_rect(fill = "#0d1117", color = NA),
    panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    axis.text.x        = element_text(angle = 45, hjust = 1, color = "#aaaacc", size = 8),
    axis.text.y        = element_text(color = "#aaaacc", size = 9),
    axis.title.x       = element_text(color = "#ccccee", size = 10, margin = margin(t = 10)),
    axis.title.y       = element_text(color = "#ccccee", size = 10, margin = margin(r = 10)),
    legend.background  = element_rect(fill = "#1a1a2e", color = NA),
    legend.text        = element_text(color = "white", size = 9),
    legend.title       = element_text(color = "#FFD700", size = 10, face = "bold"),
    legend.key         = element_rect(fill = NA, color = NA),
    plot.title         = element_text(color = "white", size = 16, face = "bold", hjust = 0.5,
                                       margin = margin(b = 6)),
    plot.subtitle      = element_text(color = "#aaaacc", size = 10, hjust = 0.5,
                                       margin = margin(b = 16)),
    plot.caption       = element_text(color = "#666688", size = 8, hjust = 1,
                                       margin = margin(t = 10)),
    plot.margin        = margin(20, 20, 15, 20)
  ) +
  labs(
    title    = "Gol Juara Premier League Setiap Musim (1992–2025)",
    subtitle = "Seberapa banyak gol yang dicetak oleh setiap tim juara?",
    x        = "Musim",
    y        = "Jumlah Gol",
    caption  = "Sumber: Premier League / Wikipedia  |  Visualisasi: ggplot2"
  )

# Simpan PNG
ggsave(
  filename = "premier_league_goals/pl_champions_goals.png",
  plot     = p,
  width    = 16,
  height   = 8,
  dpi      = 300,
  bg       = "#0d1117"
)

message("Selesai! File tersimpan di folder premier_league_goals/")
