# ============================================================
# Analisis: Apa yang Membedakan Juara Premier League?
# Scraping data standings Wikipedia 1992-93 s/d 2024-25
# ============================================================

library(rvest)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(forcats)
library(purrr)

# ---- 1. Fungsi scrape satu musim dari Wikipedia ----

scrape_pl_season <- function(season_start, season_end) {
  # Coba beberapa format URL Wikipedia
  dash   <- "–"  # en-dash
  season <- paste0(season_start, dash, substr(season_end, 3, 4))

  urls <- c(
    paste0("https://en.wikipedia.org/wiki/", season, "_Premier_League"),
    paste0("https://en.wikipedia.org/wiki/", season, "_FA_Premier_League")
  )

  page <- NULL
  used_url <- ""
  for (url in urls) {
    page <- tryCatch(read_html(url), error = function(e) NULL)
    if (!is.null(page)) { used_url <- url; break }
  }
  if (is.null(page)) {
    message("  GAGAL: ", season)
    return(NULL)
  }

  tabs <- html_elements(page, "table.wikitable")
  df   <- NULL
  for (i in seq_along(tabs)) {
    t <- tryCatch(html_table(tabs[[i]], fill = TRUE), error = function(e) NULL)
    if (!is.null(t) && all(c("W", "D", "L", "GF", "GA", "Pts") %in% names(t))) {
      df <- t; break
    }
  }
  if (is.null(df)) {
    message("  Tabel tidak ditemukan: ", season)
    return(NULL)
  }

  # Bersihkan data
  df <- df %>%
    select(any_of(c("Pos", "Team", "Pld", "W", "D", "L", "GF", "GA", "GD", "Pts"))) %>%
    filter(!is.na(Pos), is.numeric(Pos) | grepl("^[0-9]+$", Pos)) %>%
    mutate(
      season_label = paste0(season_start, "-", substr(season_end, 3, 4)),
      season_end   = as.integer(season_end),
      Team         = gsub("\\s*\\(.*?\\)", "", Team),   # hapus ket. (C), (R), dll.
      Team         = trimws(Team),
      across(c(Pos, Pld, W, D, L, GF, GA, Pts), as.integer),
      GD = GF - GA
    )

  message("  OK: ", season, " (", nrow(df), " tim)")
  Sys.sleep(1.5)
  df
}

# ---- 2. Scrape semua musim 1992-93 s/d 2024-25 ----

seasons <- list(
  c("1992", "1993"), c("1993", "1994"), c("1994", "1995"),
  c("1995", "1996"), c("1996", "1997"), c("1997", "1998"),
  c("1998", "1999"), c("1999", "2000"), c("2000", "2001"),
  c("2001", "2002"), c("2002", "2003"), c("2003", "2004"),
  c("2004", "2005"), c("2005", "2006"), c("2006", "2007"),
  c("2007", "2008"), c("2008", "2009"), c("2009", "2010"),
  c("2010", "2011"), c("2011", "2012"), c("2012", "2013"),
  c("2013", "2014"), c("2014", "2015"), c("2015", "2016"),
  c("2016", "2017"), c("2017", "2018"), c("2018", "2019"),
  c("2019", "2020"), c("2020", "2021"), c("2021", "2022"),
  c("2022", "2023"), c("2023", "2024"), c("2024", "2025")
)

message("Mulai scraping data ", length(seasons), " musim...")
all_standings <- map_dfr(seasons, function(s) {
  scrape_pl_season(s[1], s[2])
})

message("\nTotal baris: ", nrow(all_standings))

# ---- 3. Simpan data mentah ----

save(all_standings, file = "premier_league_goals/pl_all_standings.rda")
message("Data mentah tersimpan: pl_all_standings.rda")

# ---- 4. Hitung ranking tiap tim per musim per metrik ----

ranked <- all_standings %>%
  group_by(season_label) %>%
  mutate(
    rank_gf  = rank(-GF,  ties.method = "min"),  # lebih banyak = lebih baik
    rank_ga  = rank( GA,  ties.method = "min"),  # lebih sedikit = lebih baik
    rank_gd  = rank(-GD,  ties.method = "min"),
    rank_pts = rank(-Pts, ties.method = "min"),
    rank_w   = rank(-W,   ties.method = "min"),
    rank_d   = rank(-D,   ties.method = "min"),
    n_teams  = n()
  ) %>%
  ungroup()

# Ambil hanya data juara (Pos == 1)
champions <- ranked %>% filter(Pos == 1)

message("\nJumlah musim dengan data juara: ", nrow(champions))

# ---- 5. Ringkasan analisis: seberapa sering juara #1 di tiap metrik? ----

summary_stats <- champions %>%
  summarise(
    # Gol dicetak
    top1_gf     = mean(rank_gf == 1,  na.rm = TRUE),
    top3_gf     = mean(rank_gf <= 3,  na.rm = TRUE),
    median_gf   = median(rank_gf, na.rm = TRUE),
    # Gol kebobolan
    top1_ga     = mean(rank_ga == 1,  na.rm = TRUE),
    top3_ga     = mean(rank_ga <= 3,  na.rm = TRUE),
    median_ga   = median(rank_ga, na.rm = TRUE),
    # Selisih gol
    top1_gd     = mean(rank_gd == 1,  na.rm = TRUE),
    top3_gd     = mean(rank_gd <= 3,  na.rm = TRUE),
    median_gd   = median(rank_gd, na.rm = TRUE),
    # Kemenangan
    top1_w      = mean(rank_w == 1,   na.rm = TRUE),
    top3_w      = mean(rank_w <= 3,   na.rm = TRUE),
    median_w    = median(rank_w, na.rm = TRUE)
  )

message("\n=== RINGKASAN ANALISIS ===")
message("% juara dengan GF terbanyak (#1)  : ", round(summary_stats$top1_gf * 100), "%")
message("% juara dengan GF top-3            : ", round(summary_stats$top3_gf * 100), "%")
message("% juara dengan GA paling sedikit   : ", round(summary_stats$top1_ga * 100), "%")
message("% juara dengan GA top-3            : ", round(summary_stats$top3_ga * 100), "%")
message("% juara dengan GD terbesar (#1)    : ", round(summary_stats$top1_gd * 100), "%")
message("% juara dengan GD top-3            : ", round(summary_stats$top3_gd * 100), "%")
message("% juara dengan Wins terbanyak (#1) : ", round(summary_stats$top1_w * 100), "%")
message("% juara dengan Wins top-3          : ", round(summary_stats$top3_w * 100), "%")

# ---- 6. Data untuk visualisasi ranking distribution ----

champ_ranks <- champions %>%
  select(season_label, Team, rank_gf, rank_ga, rank_gd, rank_w) %>%
  pivot_longer(
    cols      = starts_with("rank_"),
    names_to  = "metric",
    values_to = "rank"
  ) %>%
  mutate(
    metric_label = case_when(
      metric == "rank_gf" ~ "Gol Dicetak (GF)",
      metric == "rank_ga" ~ "Gol Kebobolan (GA)\n[sedikit = baik]",
      metric == "rank_gd" ~ "Selisih Gol (GD)",
      metric == "rank_w"  ~ "Jumlah Kemenangan (W)"
    ),
    is_top1 = rank == 1,
    is_top3 = rank <= 3
  )

# Hitung proporsi untuk label
prop_df <- champ_ranks %>%
  group_by(metric_label) %>%
  summarise(
    pct_top1 = mean(rank == 1, na.rm = TRUE),
    pct_top3 = mean(rank <= 3, na.rm = TRUE),
    med_rank = median(rank, na.rm = TRUE),
    .groups  = "drop"
  ) %>%
  mutate(
    label_top1 = paste0(round(pct_top1 * 100), "% juara\njadi #1"),
    label_pct3 = paste0(round(pct_top3 * 100), "% masuk\nTop 3")
  )

# Simpan data analisis
save(champions, champ_ranks, prop_df, summary_stats,
     file = "premier_league_goals/pl_champion_analysis.rda")

# ---- 7. Visualisasi utama: Distribusi ranking juara per metrik ----

# Urutan metrik berdasarkan median rank (terkecil = paling konsisten #1)
metric_order <- prop_df %>%
  arrange(med_rank) %>%
  pull(metric_label)

champ_ranks$metric_label <- factor(champ_ranks$metric_label, levels = metric_order)
prop_df$metric_label     <- factor(prop_df$metric_label,     levels = metric_order)

bg     <- "#0d1117"
panel  <- "#161b22"
gold   <- "#FFD700"
green  <- "#2ECC71"
blue   <- "#3498DB"
grey   <- "#aaaacc"

p1 <- ggplot(champ_ranks, aes(x = factor(rank))) +
  # Histogram batang per rank
  geom_bar(aes(fill = is_top1), width = 0.75) +
  scale_fill_manual(
    values = c("TRUE" = gold, "FALSE" = "#4a4a6a"),
    guide  = "none"
  ) +
  # Label persen #1 dan top-3
  geom_label(
    data        = prop_df,
    aes(x = 1, y = Inf,
        label = paste0(round(pct_top1 * 100), "% juara = #1\n",
                       round(pct_top3 * 100), "% juara ≤ Top 3")),
    inherit.aes = FALSE,
    hjust       = 0, vjust = 1.1,
    fill        = "#1a1a2e", color = gold,
    size        = 3, fontface = "bold",
    label.padding = unit(0.35, "lines"),
    label.r       = unit(0.12, "lines")
  ) +
  facet_wrap(~metric_label, scales = "free_x", ncol = 2) +
  scale_x_discrete(name = "Ranking di antara semua tim (1 = terbaik)") +
  scale_y_continuous(name = "Frekuensi (jumlah musim)", expand = expansion(mult = c(0, 0.25))) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.background    = element_rect(fill = bg,    color = NA),
    panel.background   = element_rect(fill = panel, color = NA),
    panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    strip.background   = element_rect(fill = "#1a1a2e", color = NA),
    strip.text         = element_text(color = gold, face = "bold", size = 10),
    axis.text          = element_text(color = grey, size = 8),
    axis.title         = element_text(color = grey, size = 9),
    plot.title         = element_text(color = "white", face = "bold", size = 15, hjust = 0.5,
                                       margin = margin(b = 6)),
    plot.subtitle      = element_text(color = grey, size = 10, hjust = 0.5,
                                       margin = margin(b = 14)),
    plot.caption       = element_text(color = "#555577", size = 8, hjust = 1,
                                       margin = margin(t = 8)),
    plot.margin        = margin(20, 20, 15, 20)
  ) +
  labs(
    title    = "Di Metrik Apa Juara Premier League Selalu Teratas?",
    subtitle = paste0("Distribusi ranking juara di antara semua tim, ",
                      min(champions$season_end) - 1, "–", max(champions$season_end),
                      " (→ batang emas = ranking #1)"),
    caption  = "Sumber: Wikipedia | Analisis & Visualisasi: R/ggplot2"
  )

ggsave(
  filename = "premier_league_goals/analisis_juara_ranking.png",
  plot     = p1,
  width    = 14, height = 9, dpi = 300, bg = bg
)

# ---- 8. Visualisasi timeline: ranking juara per musim ----

p2 <- ggplot(champ_ranks, aes(x = season_label, y = rank, color = metric_label, group = metric_label)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = gold, linewidth = 0.6, alpha = 0.6) +
  geom_line(linewidth = 0.9, alpha = 0.8) +
  geom_point(size = 2.2, alpha = 0.9) +
  scale_color_manual(
    values = c(
      "Gol Dicetak (GF)"              = "#E74C3C",
      "Gol Kebobolan (GA)\n[sedikit = baik]" = "#3498DB",
      "Selisih Gol (GD)"              = "#2ECC71",
      "Jumlah Kemenangan (W)"         = "#F1C40F"
    ),
    name = "Metrik"
  ) +
  scale_y_reverse(
    breaks = c(1, 3, 5, 10, 15, 20),
    labels = c("1 (terbaik)", "3", "5", "10", "15", "20 (terburuk)")
  ) +
  scale_x_discrete(guide = guide_axis(angle = 45)) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.background    = element_rect(fill = bg,    color = NA),
    panel.background   = element_rect(fill = panel, color = NA),
    panel.grid.major   = element_line(color = "#2a2a3e", linewidth = 0.4),
    panel.grid.minor   = element_blank(),
    axis.text.x        = element_text(color = grey, size = 7.5, angle = 45, hjust = 1),
    axis.text.y        = element_text(color = grey, size = 8),
    axis.title         = element_text(color = grey, size = 9),
    legend.background  = element_rect(fill = "#1a1a2e", color = NA),
    legend.text        = element_text(color = "white", size = 9),
    legend.title       = element_text(color = gold, size = 10, face = "bold"),
    legend.key         = element_rect(fill = NA, color = NA),
    plot.title         = element_text(color = "white", face = "bold", size = 14, hjust = 0.5,
                                       margin = margin(b = 6)),
    plot.subtitle      = element_text(color = grey, size = 9.5, hjust = 0.5,
                                       margin = margin(b = 14)),
    plot.caption       = element_text(color = "#555577", size = 8, hjust = 1,
                                       margin = margin(t = 8)),
    plot.margin        = margin(20, 20, 15, 20)
  ) +
  labs(
    title    = "Ranking Juara Premier League per Metrik, Setiap Musim",
    subtitle = "Sumbu Y dibalik: semakin atas = ranking semakin baik (mendekati #1)",
    x        = "Musim",
    y        = "Ranking",
    caption  = "Sumber: Wikipedia | Analisis & Visualisasi: R/ggplot2"
  )

ggsave(
  filename = "premier_league_goals/analisis_juara_timeline.png",
  plot     = p2,
  width    = 16, height = 8, dpi = 300, bg = bg
)

# ---- 9. Visualisasi ringkasan: heatmap proporsi ----

heatmap_df <- champ_ranks %>%
  group_by(metric_label) %>%
  mutate(total_seasons = n()) %>%
  group_by(metric_label, rank) %>%
  summarise(
    count = n(),
    pct   = n() / first(total_seasons),
    .groups = "drop"
  )

p3 <- ggplot(heatmap_df, aes(x = factor(rank), y = metric_label, fill = pct)) +
  geom_tile(color = bg, linewidth = 0.5) +
  geom_text(aes(label = ifelse(pct >= 0.04, paste0(round(pct * 100), "%"), "")),
            color = "white", size = 3, fontface = "bold") +
  scale_fill_gradientn(
    colors = c("#1a1a2e", "#16213e", "#0f3460", "#533483", gold),
    values = c(0, 0.15, 0.35, 0.6, 1),
    name   = "Proporsi\nMusim",
    labels = percent_format(accuracy = 1)
  ) +
  scale_x_discrete(name = "Ranking di antara semua tim (1 = terbaik)") +
  theme_minimal(base_family = "sans") +
  theme(
    plot.background  = element_rect(fill = bg, color = NA),
    panel.background = element_rect(fill = bg, color = NA),
    panel.grid       = element_blank(),
    axis.text.x      = element_text(color = grey, size = 8),
    axis.text.y      = element_text(color = "white", size = 9.5, face = "bold"),
    axis.title       = element_text(color = grey, size = 9),
    legend.background = element_rect(fill = "#1a1a2e", color = NA),
    legend.text       = element_text(color = "white", size = 8),
    legend.title      = element_text(color = gold, size = 9, face = "bold"),
    plot.title        = element_text(color = "white", face = "bold", size = 14, hjust = 0.5,
                                      margin = margin(b = 6)),
    plot.subtitle     = element_text(color = grey, size = 9.5, hjust = 0.5,
                                      margin = margin(b = 14)),
    plot.caption      = element_text(color = "#555577", size = 8, hjust = 1,
                                      margin = margin(t = 8)),
    plot.margin       = margin(20, 20, 15, 20)
  ) +
  labs(
    title    = "Heatmap: Sebaran Ranking Juara Premier League",
    subtitle = "Setiap sel = proporsi musim di mana juara berada di ranking tersebut",
    x        = "Ranking",
    y        = NULL,
    caption  = "Sumber: Wikipedia | Analisis & Visualisasi: R/ggplot2"
  )

ggsave(
  filename = "premier_league_goals/analisis_juara_heatmap.png",
  plot     = p3,
  width    = 14, height = 6, dpi = 300, bg = bg
)

message("\nSemua file berhasil disimpan di folder premier_league_goals/")
message("  - pl_all_standings.rda       (data mentah semua tim semua musim)")
message("  - pl_champion_analysis.rda   (data analisis juara)")
message("  - analisis_juara_ranking.png (distribusi ranking per metrik)")
message("  - analisis_juara_timeline.png (timeline ranking per musim)")
message("  - analisis_juara_heatmap.png  (heatmap proporsi ranking)")
