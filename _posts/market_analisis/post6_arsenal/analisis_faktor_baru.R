# ============================================================
# Analisis Faktor Baru: Clean Sheet, Top Scorer, Poin Total
# Perbandingan dengan Arsenal 2025-26
# ============================================================

library(rvest)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(purrr)
library(stringr)
library(patchwork)

load("premier_league_goals/pl_all_standings.rda")

# ============================================================
# 1. SCRAPE TOP SCORER & CLEAN SHEET DARI WIKIPEDIA
# ============================================================

scrape_awards <- function(season_start, season_end) {
  dash   <- "–"
  season <- paste0(season_start, dash, substr(season_end, 3, 4))
  urls   <- c(
    paste0("https://en.wikipedia.org/wiki/", season, "_Premier_League"),
    paste0("https://en.wikipedia.org/wiki/", season, "_FA_Premier_League")
  )

  page <- NULL
  for (url in urls) {
    page <- tryCatch(read_html(url), error = function(e) NULL)
    if (!is.null(page)) break
  }
  if (is.null(page)) return(NULL)

  tabs <- html_elements(page, "table.wikitable")

  top_scorer_club <- NA_character_
  top_cs_club     <- NA_character_
  top_scorer_name <- NA_character_
  top_scorer_goals <- NA_integer_
  top_cs_name     <- NA_character_
  top_cs_n        <- NA_integer_

  for (i in seq_along(tabs)) {
    t <- tryCatch(html_table(tabs[[i]], fill = TRUE), error = function(e) NULL)
    if (is.null(t) || nrow(t) < 2) next
    cols <- tolower(names(t))

    # Top scorer: tabel dengan kolom "goals" dan "club"/"team"
    if (is.na(top_scorer_club) &&
        any(grepl("goals?$", cols)) &&
        any(grepl("^(club|team)$", cols)) &&
        any(grepl("player|name", cols))) {
      goals_col  <- names(t)[grepl("goals?$",       tolower(names(t)))][1]
      club_col   <- names(t)[grepl("^(club|team)$",  tolower(names(t)))][1]
      player_col <- names(t)[grepl("player|name",    tolower(names(t)))][1]
      row1 <- t[1, ]
      val  <- suppressWarnings(as.integer(gsub("[^0-9]","", as.character(row1[[goals_col]]))))
      if (!is.na(val) && val > 0 && val < 50) {
        top_scorer_goals <- val
        top_scorer_club  <- trimws(as.character(row1[[club_col]]))
        top_scorer_name  <- trimws(as.character(row1[[player_col]]))
      }
    }

    # Clean sheets: tabel dengan kolom "cleansheets" atau "clean sheets"
    if (is.na(top_cs_club) &&
        any(grepl("clean", cols)) &&
        any(grepl("^(club|team)$", cols)) &&
        any(grepl("player|name", cols))) {
      cs_col     <- names(t)[grepl("clean", tolower(names(t)))][1]
      club_col   <- names(t)[grepl("^(club|team)$", tolower(names(t)))][1]
      player_col <- names(t)[grepl("player|name",   tolower(names(t)))][1]
      row1 <- t[1, ]
      val  <- suppressWarnings(as.integer(gsub("[^0-9]","", as.character(row1[[cs_col]]))))
      if (!is.na(val) && val > 0 && val < 40) {
        top_cs_n    <- val
        top_cs_club <- trimws(as.character(row1[[club_col]]))
        top_cs_name <- trimws(as.character(row1[[player_col]]))
      }
    }
  }

  data.frame(
    season_label     = paste0(season_start, "-", substr(season_end, 3, 4)),
    season_end       = as.integer(season_end),
    top_scorer_name  = top_scorer_name,
    top_scorer_club  = top_scorer_club,
    top_scorer_goals = top_scorer_goals,
    top_cs_name      = top_cs_name,
    top_cs_club      = top_cs_club,
    top_cs_n         = top_cs_n,
    stringsAsFactors = FALSE
  )
}

seasons <- list(
  c("1992","1993"), c("1993","1994"), c("1994","1995"),
  c("1995","1996"), c("1996","1997"), c("1997","1998"),
  c("1998","1999"), c("1999","2000"), c("2000","2001"),
  c("2001","2002"), c("2002","2003"), c("2003","2004"),
  c("2004","2005"), c("2005","2006"), c("2006","2007"),
  c("2007","2008"), c("2008","2009"), c("2009","2010"),
  c("2010","2011"), c("2011","2012"), c("2012","2013"),
  c("2013","2014"), c("2014","2015"), c("2015","2016"),
  c("2016","2017"), c("2017","2018"), c("2018","2019"),
  c("2019","2020"), c("2020","2021"), c("2021","2022"),
  c("2022","2023"), c("2023","2024"), c("2024","2025")
)

message("Scraping top scorer & clean sheet data...")
awards_df <- map_dfr(seasons, function(s) {
  res <- scrape_awards(s[1], s[2])
  if (!is.null(res))
    message("  OK: ", s[1], "-", substr(s[2],3,4),
            " | Scorer: ", res$top_scorer_name, " (", res$top_scorer_club, ")",
            " | CS: ", res$top_cs_name, " (", res$top_cs_club, ")")
  Sys.sleep(1.5)
  res
})

# ============================================================
# 2. IDENTIFIKASI JUARA TIAP MUSIM & GABUNG
# ============================================================

champions_basic <- all_standings %>%
  filter(Pos == 1) %>%
  mutate(Team_clean = trimws(gsub("\\s*\\(.*?\\)","", Team))) %>%
  select(season_label, season_end, Team_clean, W, D, L, GF, GA, GD, Pts)

# Tambahkan data Arsenal 2025-26 secara manual
arsenal_2526 <- data.frame(
  season_label = "2025-26", season_end = 2026,
  Team_clean = "Arsenal",
  W = 26, D = 7, L = 5,
  GF = 78, GA = 34, GD = 44, Pts = 85,
  stringsAsFactors = FALSE
)
champions_all <- bind_rows(champions_basic, arsenal_2526)

# Tambahkan data awards Arsenal 2025-26 manual
awards_2526 <- data.frame(
  season_label = "2025-26", season_end = 2026,
  top_scorer_name  = "Erling Haaland",
  top_scorer_club  = "Manchester City",
  top_scorer_goals = 27L,
  top_cs_name      = "David Raya",
  top_cs_club      = "Arsenal",
  top_cs_n         = 19L,
  stringsAsFactors = FALSE
)
awards_all <- bind_rows(awards_df, awards_2526)

# Gabung
combined <- champions_all %>%
  left_join(awards_all, by = c("season_label","season_end")) %>%
  mutate(
    # Fuzzy match: apakah top scorer dari klub juara?
    scorer_at_champ = mapply(function(sc, ch) {
      if (is.na(sc) || is.na(ch)) return(NA)
      grepl(word(sc,1), ch, ignore.case=TRUE) |
        grepl(word(ch,1), sc, ignore.case=TRUE) |
        tolower(sc) == tolower(ch)
    }, top_scorer_club, Team_clean),
    # Apakah top keeper dari klub juara?
    cs_at_champ = mapply(function(cc, ch) {
      if (is.na(cc) || is.na(ch)) return(NA)
      grepl(word(cc,1), ch, ignore.case=TRUE) |
        grepl(word(ch,1), cc, ignore.case=TRUE) |
        tolower(cc) == tolower(ch)
    }, top_cs_club, Team_clean),
    is_arsenal_2526 = season_label == "2025-26"
  )

message("\n=== RINGKASAN ===")
message("% juara punya top scorer liga (#1)  : ",
        round(mean(combined$scorer_at_champ, na.rm=TRUE)*100), "%")
message("% juara punya keeper clean sheet #1 : ",
        round(mean(combined$cs_at_champ, na.rm=TRUE)*100), "%")
message("\nMin poin juara : ", min(combined$Pts))
message("Median poin juara: ", median(combined$Pts))
message("Max poin juara : ", max(combined$Pts))

# ============================================================
# 3. RANKING CLEAN SHEETS PER MUSIM (dari existing standings)
# ============================================================

cs_rank <- all_standings %>%
  group_by(season_label) %>%
  mutate(
    rank_cs_proxy = rank(GA, ties.method = "min")  # GA paling sedikit ≈ proxy clean sheet
  ) %>%
  filter(Pos == 1) %>%
  select(season_label, Team, GA, rank_cs_proxy)

# Arsenal 2025-26 rank GA
arsenal_ga_rank <- all_standings %>%
  filter(season_label == "2024-25") %>%          # season terbaru yang ada di data
  summarise(n_teams = n()) %>%
  pull()
# Arsenal 2025-26: GA=34, kita hitung manual berdasarkan konteks: #1

# ============================================================
# 4. SIMPAN DATA
# ============================================================

save(combined, awards_all, champions_all,
     file = "premier_league_goals/pl_faktor_baru.rda")

# ============================================================
# 5. VISUALISASI
# ============================================================

bg    <- "#0d1117"; panel <- "#161b22"
gold  <- "#FFD700"; grey  <- "#aaaacc"; white <- "white"
orange <- "#E67E22"; blue <- "#3498DB"; green <- "#2ECC71"
red   <- "#E74C3C"; purple <- "#9B59B6"
arsenal_col <- "#E67E22"

base_theme <- theme_minimal(base_family = "sans") +
  theme(
    plot.background  = element_rect(fill = bg,    color = NA),
    panel.background = element_rect(fill = panel, color = NA),
    panel.grid.minor = element_blank(),
    axis.text        = element_text(color = grey, size = 8.5),
    axis.title       = element_text(color = grey, size = 9),
    plot.title       = element_text(color = white, face = "bold", size = 11, hjust = 0),
    plot.subtitle    = element_text(color = grey, size = 8.5, hjust = 0, margin = margin(b=8)),
    plot.caption     = element_text(color = "#555577", size = 7.5, hjust = 1),
    plot.margin      = margin(12, 14, 10, 14)
  )

# --- Panel A: Poin Total Juara (timeline + Arsenal highlight) ---

club_colors <- c(
  "Manchester United" = red, "Manchester City" = blue,
  "Arsenal" = orange, "Chelsea" = purple,
  "Liverpool" = gold, "Blackburn Rovers" = green,
  "Leicester City" = "#1ABC9C"
)

pA <- ggplot(combined, aes(x = season_label, y = Pts, fill = Team_clean)) +
  geom_col(aes(alpha = ifelse(is_arsenal_2526, 1, 0.85)),
           width = 0.75, color = "white", linewidth = 0.2, show.legend = FALSE) +
  geom_hline(yintercept = median(combined$Pts, na.rm=TRUE),
             linetype = "dashed", color = grey, linewidth = 0.6) +
  geom_hline(yintercept = min(combined$Pts, na.rm=TRUE),
             linetype = "dotted", color = red, linewidth = 0.6) +
  annotate("text", x = "1992-93", y = median(combined$Pts, na.rm=TRUE)+1.2,
           label = paste0("Median: ", median(combined$Pts, na.rm=TRUE), " poin"),
           color = grey, size = 2.5, hjust = 0, fontface = "italic") +
  annotate("text", x = "1992-93", y = min(combined$Pts, na.rm=TRUE)+1.5,
           label = paste0("Min: ", min(combined$Pts, na.rm=TRUE), " poin"),
           color = red, size = 2.5, hjust = 0, fontface = "italic") +
  # Arsenal label
  geom_text(data = filter(combined, is_arsenal_2526),
            aes(label = paste0(Pts, "\n(Arsenal)")),
            vjust = -0.3, size = 2.8, color = orange, fontface = "bold") +
  scale_fill_manual(values = club_colors) +
  scale_alpha_identity() +
  scale_y_continuous(limits = c(0, 115), expand = expansion(mult = c(0, 0.05))) +
  scale_x_discrete(guide = guide_axis(angle = 45)) +
  labs(title = "Poin Total Juara Premier League Setiap Musim",
       subtitle = "Garis abu = median | Garis merah = minimum | Arsenal 2025-26 disorot",
       x = NULL, y = "Poin") +
  base_theme +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4),
        axis.text.x = element_text(color = grey, size = 7.5))

# --- Panel B: Top Scorer di Klub Juara? ---

scorer_sum <- combined %>%
  filter(!is.na(scorer_at_champ)) %>%
  mutate(result = ifelse(scorer_at_champ, "Ya — Top Scorer\ndi Klub Juara",
                          "Tidak — Top Scorer\ndi Klub Lain")) %>%
  count(result) %>%
  mutate(pct = n / sum(n))

pB <- ggplot(scorer_sum, aes(x = "", y = pct, fill = result)) +
  geom_col(width = 0.5, color = bg, linewidth = 0.5) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, " musim)")),
            position = position_stack(vjust = 0.5),
            color = white, fontface = "bold", size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = c("Ya — Top Scorer\ndi Klub Juara" = gold,
                                "Tidak — Top Scorer\ndi Klub Lain" = "#3a3a5a"),
                    name = NULL) +
  labs(title = "Apakah Juara Selalu Punya\nTop Scorer Liga?",
       subtitle = "Hanya ~1/3 juara miliki top scorer",
       x = NULL, y = "Proporsi") +
  base_theme +
  theme(panel.grid = element_blank(),
        axis.text  = element_blank(),
        axis.title = element_blank(),
        legend.position = "bottom",
        legend.background = element_rect(fill = "#1a1a2e", color = NA),
        legend.text = element_text(color = white, size = 8))

# --- Panel C: Top Keeper (Clean Sheet #1) di Klub Juara? ---

cs_sum <- combined %>%
  filter(!is.na(cs_at_champ)) %>%
  mutate(result = ifelse(cs_at_champ, "Ya — GK #1 di\nKlub Juara",
                          "Tidak — GK #1 di\nKlub Lain")) %>%
  count(result) %>%
  mutate(pct = n / sum(n))

pC <- ggplot(cs_sum, aes(x = "", y = pct, fill = result)) +
  geom_col(width = 0.5, color = bg, linewidth = 0.5) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, " musim)")),
            position = position_stack(vjust = 0.5),
            color = white, fontface = "bold", size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = c("Ya — GK #1 di\nKlub Juara"  = blue,
                                "Tidak — GK #1 di\nKlub Lain" = "#3a3a5a"),
                    name = NULL) +
  labs(title = "Apakah Juara Selalu Punya\nGolden Glove (Clean Sheet Terbanyak)?",
       subtitle = "Lebih dari separuh juara miliki GK terbaik",
       x = NULL, y = "Proporsi") +
  base_theme +
  theme(panel.grid = element_blank(),
        axis.text  = element_blank(),
        axis.title = element_blank(),
        legend.position = "bottom",
        legend.background = element_rect(fill = "#1a1a2e", color = NA),
        legend.text = element_text(color = white, size = 8))

# --- Panel D: Scorecard Arsenal 2025-26 vs Rata-rata Juara ---

hist_champs_stats <- combined %>%
  filter(!is_arsenal_2526) %>%
  summarise(
    avg_pts  = round(mean(Pts, na.rm=TRUE), 1),
    avg_gf   = round(mean(GF, na.rm=TRUE), 1),
    avg_ga   = round(mean(GA, na.rm=TRUE), 1),
    avg_gd   = round(mean(GD, na.rm=TRUE), 1),
    avg_w    = round(mean(W, na.rm=TRUE), 1),
    avg_l    = round(mean(L, na.rm=TRUE), 1),
    pct_top_scorer = paste0(round(mean(combined$scorer_at_champ, na.rm=TRUE)*100), "%"),
    pct_top_cs     = paste0(round(mean(combined$cs_at_champ, na.rm=TRUE)*100), "%")
  )

scorecard_data <- data.frame(
  metrik     = c("Poin Total","Gol Dicetak (GF)","Gol Kebobolan (GA)",
                  "Selisih Gol (GD)","Kemenangan (W)","Kekalahan (L)",
                  "Clean Sheets Terbanyak?","Top Scorer di Klub?"),
  rata_juara = c(hist_champs_stats$avg_pts, hist_champs_stats$avg_gf,
                  hist_champs_stats$avg_ga,  hist_champs_stats$avg_gd,
                  hist_champs_stats$avg_w,   hist_champs_stats$avg_l,
                  hist_champs_stats$pct_top_cs, hist_champs_stats$pct_top_scorer),
  arsenal    = c("85","78","34","44","26","5","✓ Ya (#1)","✗ Tidak"),
  status     = c("avg","avg","avg","avg","avg","avg","award","award"),
  row_y      = 8:1,
  stringsAsFactors = FALSE
)

pD <- ggplot(scorecard_data, aes(y = row_y)) +
  # baris background
  geom_tile(aes(x = 1,
                fill = ifelse(row_y %% 2 == 0, "#1a1a2e", "#0f0f1f")),
            width = 2, height = 0.82, color = "#2a2a3e", linewidth = 0.3) +
  # kolom label metrik
  geom_text(aes(x = 0.1, label = metrik), hjust = 0, color = grey, size = 2.9) +
  # kolom rata-rata juara
  geom_text(aes(x = 1.18, label = rata_juara), hjust = 0.5, color = grey,
            size = 2.9, fontface = "italic") +
  # kolom Arsenal
  geom_text(aes(x = 1.88, label = arsenal,
                color = ifelse(grepl("✓", arsenal), green,
                          ifelse(grepl("✗", arsenal), red, orange))),
            hjust = 1, size = 3.1, fontface = "bold") +
  # header
  annotate("text", x = 0.1,  y = 8.65, label = "Metrik",
           color = gold, size = 3.1, hjust = 0, fontface = "bold") +
  annotate("text", x = 1.18, y = 8.65, label = "Rata-rata\nJuara",
           color = gold, size = 2.8, hjust = 0.5, fontface = "bold") +
  annotate("text", x = 1.88, y = 8.65, label = "Arsenal\n2025-26",
           color = orange, size = 3, hjust = 1, fontface = "bold") +
  scale_fill_identity() +
  scale_color_identity() +
  scale_x_continuous(limits = c(0, 2), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 9.2), expand = c(0, 0)) +
  labs(title = "Arsenal 2025-26 vs Rata-rata Juara Historis",
       subtitle = "Bagaimana profil Arsenal dibanding 33 juara sebelumnya?") +
  base_theme +
  theme(panel.grid = element_blank(), axis.text = element_blank(),
        axis.title = element_blank(), axis.ticks = element_blank())

# --- Panel E: Distribusi poin juara + posisi Arsenal ---

pE <- ggplot(combined, aes(x = Pts, fill = is_arsenal_2526)) +
  geom_histogram(binwidth = 3, color = bg, linewidth = 0.4, boundary = 60) +
  geom_vline(xintercept = 85, color = orange, linewidth = 1.2, linetype = "solid") +
  geom_vline(xintercept = median(combined$Pts, na.rm=TRUE),
             color = grey, linewidth = 0.8, linetype = "dashed") +
  annotate("text", x = 85.5, y = 7, label = "Arsenal\n2025-26\n(85 poin)",
           color = orange, size = 2.6, hjust = 0, fontface = "bold") +
  annotate("text", x = median(combined$Pts, na.rm=TRUE) - 0.5, y = 7,
           label = paste0("Median\n", median(combined$Pts, na.rm=TRUE)),
           color = grey, size = 2.6, hjust = 1, fontface = "italic") +
  scale_fill_manual(values = c("FALSE" = purple, "TRUE" = orange), guide = "none") +
  scale_x_continuous(breaks = seq(60, 110, 5)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(title = "Distribusi Poin Total Juara (1992–2026)",
       subtitle = "85 poin Arsenal masuk kuartil berapa?",
       x = "Total Poin", y = "Frekuensi (musim)") +
  base_theme +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "#2a2a3e", linewidth = 0.4))

# ============================================================
# 6. GABUNGKAN SEMUA PANEL
# ============================================================

layout <- "
AAAAAAA
AAAAAAA
BBBCCDD
EEEEEEE
"

final <- (pA + pB + pC + pD + pE) +
  plot_layout(design = layout) +
  plot_annotation(
    title    = "Faktor Baru Juara Premier League & Perbandingan Arsenal 2025-26",
    subtitle = "Analisis: top scorer, clean sheet terbanyak, poin total — 33 musim (1992–2026)",
    caption  = "Sumber: Wikipedia, Arsenal.com, Premier League | Visualisasi: R/ggplot2",
    theme = theme(
      plot.background = element_rect(fill = bg, color = NA),
      plot.title      = element_text(color = white, face = "bold", size = 16,
                                      hjust = 0.5, margin = margin(b = 4)),
      plot.subtitle   = element_text(color = grey, size = 10,
                                      hjust = 0.5, margin = margin(b = 12)),
      plot.caption    = element_text(color = "#555577", size = 8,
                                      hjust = 1, margin = margin(t = 10)),
      plot.margin     = margin(20, 20, 15, 20)
    )
  )

ggsave("premier_league_goals/analisis_faktor_baru.png",
       final, width = 18, height = 14, dpi = 300, bg = bg)

message("\nSelesai! Tersimpan: analisis_faktor_baru.png")
message("Data: pl_faktor_baru.rda")
