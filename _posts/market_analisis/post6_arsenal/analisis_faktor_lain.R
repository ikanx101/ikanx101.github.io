# ============================================================
# Analisis Lanjutan: Faktor Selain Menang & Gol para Juara PL
# Fokus: Kekalahan, Seri, Kandang vs Tandang, Poin Gap
# ============================================================

library(rvest)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(forcats)
library(purrr)
library(stringr)
library(patchwork)

# ---- 1. Load data standings yang sudah ada ----

load("premier_league_goals/pl_all_standings.rda")

# ---- 2. Analisis: Kekalahan & Seri ----

ranked_extra <- all_standings %>%
  group_by(season_label) %>%
  mutate(
    rank_l      = rank(L,   ties.method = "min"),   # sedikit kalah = baik
    rank_d      = rank(D,   ties.method = "min"),   # sedikit seri  = baik (untuk juara)
    rank_d_desc = rank(-D,  ties.method = "min"),   # banyak seri juga relevan?
    n_teams     = n()
  ) %>%
  ungroup()

champions_extra <- ranked_extra %>% filter(Pos == 1)

# Poin gap ke runner-up
pts_gap <- all_standings %>%
  filter(Pos %in% c(1, 2)) %>%
  select(season_label, season_end, Pos, Team, Pts) %>%
  pivot_wider(names_from = Pos, values_from = c(Team, Pts)) %>%
  rename(champion = Team_1, runner_up = Team_2,
         pts_champ = Pts_1, pts_runner = Pts_2) %>%
  mutate(pts_gap = pts_champ - pts_runner)

message("Poin gap rata-rata ke runner-up: ", round(mean(pts_gap$pts_gap, na.rm=TRUE), 1))
message("Poin gap terkecil: ", min(pts_gap$pts_gap, na.rm=TRUE),
        " (", pts_gap$season_label[which.min(pts_gap$pts_gap)], ")")
message("Poin gap terbesar: ", max(pts_gap$pts_gap, na.rm=TRUE),
        " (", pts_gap$season_label[which.max(pts_gap$pts_gap)], ")")

# ---- 3. Scraping Home vs Away record dari Wikipedia ----

scrape_home_away <- function(season_start, season_end) {
  dash    <- "–"
  season  <- paste0(season_start, dash, substr(season_end, 3, 4))
  urls <- c(
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

  # Cari tabel cross-matrix (kolom pertama = "Home \\ Away" atau mirip)
  matrix_tab <- NULL
  for (i in seq_along(tabs)) {
    t <- tryCatch(html_table(tabs[[i]], fill = TRUE), error = function(e) NULL)
    if (!is.null(t) && ncol(t) >= 10) {
      first_col <- names(t)[1]
      if (grepl("Home|Away|away|home", first_col, ignore.case = TRUE)) {
        matrix_tab <- t; break
      }
    }
  }
  if (is.null(matrix_tab)) return(NULL)

  teams <- matrix_tab[[1]]
  teams <- teams[teams != ""]

  # Parse tiap sel skor: format "X–Y" atau "X-Y"
  parse_score <- function(s) {
    s <- str_trim(s)
    if (s == "—" || s == "-" || s == "" || s == "–") return(NULL)
    # ganti berbagai jenis dash
    s <- str_replace_all(s, "[–—‒]", "-")
    parts <- str_split(s, "-")[[1]]
    if (length(parts) != 2) return(NULL)
    hg <- suppressWarnings(as.integer(str_trim(parts[1])))
    ag <- suppressWarnings(as.integer(str_trim(parts[2])))
    if (is.na(hg) || is.na(ag)) return(NULL)
    list(hg = hg, ag = ag)
  }

  results <- list()
  for (home_i in seq_along(teams)) {
    home_team <- teams[home_i]
    row       <- matrix_tab[home_i, ]

    hw <- hd <- hl <- hgf <- hga <- 0L
    aw <- ad <- al <- agf <- aga <- 0L

    for (away_i in seq_along(teams)) {
      if (away_i == home_i) next
      away_team <- teams[away_i]

      # Home result: row = home_team, col = away_team
      home_cell <- as.character(row[[away_i + 1]])
      sc <- parse_score(home_cell)
      if (!is.null(sc)) {
        hgf <- hgf + sc$hg; hga <- hga + sc$ag
        if (sc$hg > sc$ag) hw <- hw + 1L
        else if (sc$hg == sc$ag) hd <- hd + 1L
        else hl <- hl + 1L
      }

      # Away result: row = away_team, col = home_team
      away_row  <- matrix_tab[away_i, ]
      away_cell <- as.character(away_row[[home_i + 1]])
      sc2 <- parse_score(away_cell)
      if (!is.null(sc2)) {
        # sc2$hg = gol away_team (the home side here), sc2$ag = gol home_team (the away side)
        agf <- agf + sc2$ag; aga <- aga + sc2$hg
        if (sc2$ag > sc2$hg) aw <- aw + 1L
        else if (sc2$ag == sc2$hg) ad <- ad + 1L
        else al <- al + 1L
      }
    }

    results[[home_team]] <- data.frame(
      season_label = paste0(season_start, "-", substr(season_end, 3, 4)),
      season_end   = as.integer(season_end),
      Team         = home_team,
      home_W = hw, home_D = hd, home_L = hl,
      home_GF = hgf, home_GA = hga,
      home_Pts = hw * 3L + hd,
      away_W = aw, away_D = ad, away_L = al,
      away_GF = agf, away_GA = aga,
      away_Pts = aw * 3L + ad,
      stringsAsFactors = FALSE
    )
  }

  if (length(results) == 0) return(NULL)
  bind_rows(results)
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

message("Scraping home/away records untuk ", length(seasons), " musim...")
ha_all <- map_dfr(seasons, function(s) {
  res <- scrape_home_away(s[1], s[2])
  if (!is.null(res)) message("  OK: ", s[1], "-", substr(s[2],3,4),
                              " (", nrow(res), " tim)")
  else message("  SKIP: ", s[1], "-", substr(s[2],3,4))
  Sys.sleep(1.5)
  res
})

message("Total baris home/away: ", nrow(ha_all))

# ---- 4. Gabung dengan standings & identifikasi juara ----

# Normalisasi nama tim dari standings agar match dengan matrix
all_standings_clean <- all_standings %>%
  mutate(Team_clean = trimws(gsub("\\s*\\(.*?\\)", "", Team)))

ha_all_clean <- ha_all %>%
  mutate(Team_clean = trimws(Team))

# Join: untuk tiap musim, tandai siapa juara (Pos==1)
champ_teams <- all_standings_clean %>%
  filter(Pos == 1) %>%
  select(season_label, Team_clean, W, D, L, GF, GA, GD, Pts)

ha_ranked <- ha_all_clean %>%
  group_by(season_label) %>%
  mutate(
    rank_home_pts  = rank(-home_Pts,  ties.method = "min"),
    rank_away_pts  = rank(-away_Pts,  ties.method = "min"),
    rank_home_w    = rank(-home_W,    ties.method = "min"),
    rank_away_w    = rank(-away_W,    ties.method = "min"),
    rank_away_loss = rank(away_L,     ties.method = "min"),   # sedikit = baik
    rank_home_loss = rank(home_L,     ties.method = "min"),
    away_win_rate  = away_W / (away_W + away_D + away_L),
    home_win_rate  = home_W / (home_W + home_D + home_L),
    n_teams        = n()
  ) %>%
  ungroup()

ha_champions <- ha_ranked %>%
  inner_join(
    champ_teams %>% select(season_label, Team_clean),
    by = c("season_label", "Team_clean")
  )

message("\nMusim dengan data juara home/away: ", nrow(ha_champions))

# ---- 5. Hitung statistik ringkasan ----

# Seri
message("\n--- KEKALAHAN & SERI ---")
message("% juara dengan kekalahan tersedikit (#1): ",
        round(mean(champions_extra$rank_l == 1, na.rm=TRUE)*100), "%")
message("% juara dengan kekalahan top-3          : ",
        round(mean(champions_extra$rank_l <= 3, na.rm=TRUE)*100), "%")
message("Median ranking kekalahan juara          : ",
        median(champions_extra$rank_l, na.rm=TRUE))

message("% juara dengan seri tersedikit (#1)     : ",
        round(mean(champions_extra$rank_d == 1, na.rm=TRUE)*100), "%")
message("% juara dengan seri top-3               : ",
        round(mean(champions_extra$rank_d <= 3, na.rm=TRUE)*100), "%")
message("Median jumlah seri juara                : ",
        median(champions_extra$D, na.rm=TRUE))
message("Median jumlah seri rata-rata semua tim  : ",
        round(median(all_standings$D, na.rm=TRUE), 1))

# Home/Away
if (nrow(ha_champions) > 10) {
  message("\n--- KANDANG vs TANDANG ---")
  message("% juara dengan poin kandang terbanyak (#1): ",
          round(mean(ha_champions$rank_home_pts == 1, na.rm=TRUE)*100), "%")
  message("% juara dengan poin kandang top-3         : ",
          round(mean(ha_champions$rank_home_pts <= 3, na.rm=TRUE)*100), "%")
  message("% juara dengan poin tandang terbanyak (#1): ",
          round(mean(ha_champions$rank_away_pts == 1, na.rm=TRUE)*100), "%")
  message("% juara dengan poin tandang top-3         : ",
          round(mean(ha_champions$rank_away_pts <= 3, na.rm=TRUE)*100), "%")
  message("Rata-rata win rate kandang juara          : ",
          round(mean(ha_champions$home_win_rate, na.rm=TRUE)*100, 1), "%")
  message("Rata-rata win rate tandang juara          : ",
          round(mean(ha_champions$away_win_rate, na.rm=TRUE)*100, 1), "%")
  message("Win rate kandang rata-rata semua tim      : ",
          round(mean(ha_ranked$home_win_rate, na.rm=TRUE)*100, 1), "%")
  message("Win rate tandang rata-rata semua tim      : ",
          round(mean(ha_ranked$away_win_rate, na.rm=TRUE)*100, 1), "%")
}

# ---- 6. Simpan data ----

save(champions_extra, ha_all_clean, ha_champions, ha_ranked, pts_gap,
     file = "premier_league_goals/pl_faktor_lain.rda")

# ---- 7. Visualisasi ----

bg    <- "#0d1117"
panel <- "#161b22"
gold  <- "#FFD700"
grey  <- "#aaaacc"

# --- 7a. Distribusi kekalahan & seri juara ---

dist_df <- champions_extra %>%
  select(season_label, Team, L, D, rank_l, rank_d) %>%
  pivot_longer(cols = c(rank_l, rank_d),
               names_to = "metric", values_to = "rank") %>%
  mutate(metric_label = ifelse(metric == "rank_l",
                                "Kekalahan (L)\n[sedikit = terbaik]",
                                "Hasil Seri (D)\n[sedikit = terbaik]"))

prop_dist <- dist_df %>%
  group_by(metric_label) %>%
  summarise(pct1 = mean(rank==1)*100, pct3 = mean(rank<=3)*100,
            med  = median(rank), .groups="drop")

p_dist <- ggplot(dist_df, aes(x=factor(rank), fill = rank==1)) +
  geom_bar(width=0.75) +
  geom_label(data=prop_dist,
             aes(x=1, y=Inf,
                 label=paste0(round(pct1),  "% juara = #1\n",
                               round(pct3),  "% juara ≤ Top 3")),
             inherit.aes=FALSE, hjust=0, vjust=1.1,
             fill="#1a1a2e", color=gold, size=3, fontface="bold",
             label.padding=unit(0.35,"lines"), label.r=unit(0.12,"lines")) +
  scale_fill_manual(values=c("TRUE"=gold,"FALSE"="#4a4a6a"), guide="none") +
  facet_wrap(~metric_label, scales="free_x") +
  scale_y_continuous(expand=expansion(mult=c(0,0.3))) +
  labs(title="Ranking Juara: Kekalahan & Hasil Seri",
       subtitle="Dari 33 musim (1992–2025) — batang emas = ranking #1",
       x="Ranking di antara semua tim (1=terbaik)", y="Frekuensi (musim)",
       caption="Sumber: Wikipedia | Visualisasi: R/ggplot2") +
  theme_minimal(base_family="sans") +
  theme(plot.background=element_rect(fill=bg,color=NA),
        panel.background=element_rect(fill=panel,color=NA),
        panel.grid.major.y=element_line(color="#2a2a3e",linewidth=0.4),
        panel.grid.major.x=element_blank(), panel.grid.minor=element_blank(),
        strip.background=element_rect(fill="#1a1a2e",color=NA),
        strip.text=element_text(color=gold,face="bold",size=10),
        axis.text=element_text(color=grey,size=8),
        axis.title=element_text(color=grey,size=9),
        plot.title=element_text(color="white",face="bold",size=13,hjust=0.5),
        plot.subtitle=element_text(color=grey,size=9.5,hjust=0.5,margin=margin(b=12)),
        plot.caption=element_text(color="#555577",size=8,hjust=1),
        plot.margin=margin(20,20,15,20))

ggsave("premier_league_goals/faktor_kalah_seri.png",
       p_dist, width=12, height=6, dpi=300, bg=bg)

# --- 7b. Poin gap ke runner-up ---

pts_gap_plot <- pts_gap %>% left_join(
  all_standings %>% filter(Pos==1) %>% select(season_label, Team),
  by="season_label")

# Warna berdasarkan klub
club_col <- c(
  "Manchester United"="#E74C3C","Manchester City"="#3498DB",
  "Arsenal"="#E67E22","Chelsea"="#9B59B6","Liverpool"="#F1C40F",
  "Blackburn Rovers"="#2ECC71","Leicester City"="#1ABC9C"
)

p_gap <- ggplot(pts_gap_plot, aes(x=season_label, y=pts_gap, fill=Team)) +
  geom_col(width=0.75, color="white", linewidth=0.25) +
  geom_hline(yintercept=mean(pts_gap$pts_gap,na.rm=TRUE),
             linetype="dashed", color=gold, linewidth=0.8) +
  annotate("text", x="2024-25", y=mean(pts_gap$pts_gap,na.rm=TRUE)+0.5,
           label=paste0("Rata-rata: ",round(mean(pts_gap$pts_gap,na.rm=TRUE),1)," poin"),
           color=gold, size=2.8, hjust=1, fontface="italic") +
  geom_text(aes(label=pts_gap), vjust=-0.5, size=2.5, color="white", fontface="bold") +
  scale_fill_manual(values=club_col, name="Juara") +
  scale_y_continuous(limits=c(0,22), expand=expansion(mult=c(0,0.1))) +
  scale_x_discrete(guide=guide_axis(angle=45)) +
  labs(title="Jarak Poin Juara ke Runner-Up, Setiap Musim",
       subtitle="Seberapa dominan para juara Premier League?",
       x="Musim", y="Selisih Poin",
       caption="Sumber: Wikipedia | Visualisasi: R/ggplot2") +
  theme_minimal(base_family="sans") +
  theme(plot.background=element_rect(fill=bg,color=NA),
        panel.background=element_rect(fill=panel,color=NA),
        panel.grid.major.y=element_line(color="#2a2a3e",linewidth=0.4),
        panel.grid.major.x=element_blank(), panel.grid.minor=element_blank(),
        axis.text.x=element_text(color=grey,size=7.5,angle=45,hjust=1),
        axis.text.y=element_text(color=grey,size=8),
        axis.title=element_text(color=grey,size=9),
        legend.background=element_rect(fill="#1a1a2e",color=NA),
        legend.text=element_text(color="white",size=8.5),
        legend.title=element_text(color=gold,size=9,face="bold"),
        legend.key=element_rect(fill=NA,color=NA),
        plot.title=element_text(color="white",face="bold",size=13,hjust=0.5),
        plot.subtitle=element_text(color=grey,size=9.5,hjust=0.5,margin=margin(b=12)),
        plot.caption=element_text(color="#555577",size=8,hjust=1),
        plot.margin=margin(20,20,15,20))

ggsave("premier_league_goals/faktor_poin_gap.png",
       p_gap, width=16, height=7, dpi=300, bg=bg)

# --- 7c. Kandang vs Tandang --- (hanya jika data tersedia)

if (nrow(ha_champions) > 10) {

  ha_long <- ha_champions %>%
    select(season_label, Team_clean, home_win_rate, away_win_rate) %>%
    pivot_longer(cols=c(home_win_rate, away_win_rate),
                 names_to="venue", values_to="win_rate") %>%
    mutate(venue_label = ifelse(venue=="home_win_rate","Kandang (Home)","Tandang (Away)"))

  # Rata-rata semua tim per musim
  ha_avg <- ha_ranked %>%
    group_by(season_label) %>%
    summarise(avg_home=mean(home_win_rate,na.rm=TRUE),
              avg_away=mean(away_win_rate,na.rm=TRUE), .groups="drop") %>%
    pivot_longer(cols=c(avg_home,avg_away), names_to="venue", values_to="avg_rate") %>%
    mutate(venue_label=ifelse(venue=="avg_home","Kandang (Home)","Tandang (Away)"))

  p_ha <- ggplot(ha_long, aes(x=season_label, y=win_rate, fill=venue_label)) +
    geom_col(position="dodge", width=0.7, color="white", linewidth=0.2) +
    geom_line(data=ha_avg, aes(x=season_label, y=avg_rate, group=venue_label,
                                color=venue_label),
              linewidth=0.9, linetype="dashed", inherit.aes=FALSE) +
    scale_fill_manual(values=c("Kandang (Home)"="#E74C3C","Tandang (Away)"="#3498DB"),
                      name="Venue Juara") +
    scale_color_manual(values=c("Kandang (Home)"="#ff9999","Tandang (Away)"="#99ccff"),
                       name="Rata-rata\nSemua Tim") +
    scale_y_continuous(labels=percent_format(accuracy=1),
                       limits=c(0,1), expand=expansion(mult=c(0,0.05))) +
    scale_x_discrete(guide=guide_axis(angle=45)) +
    labs(title="Win Rate Kandang vs Tandang: Juara vs Rata-rata Liga",
         subtitle="Bar = win rate juara | Garis putus = rata-rata semua tim",
         x="Musim", y="Win Rate",
         caption="Sumber: Wikipedia | Visualisasi: R/ggplot2") +
    theme_minimal(base_family="sans") +
    theme(plot.background=element_rect(fill=bg,color=NA),
          panel.background=element_rect(fill=panel,color=NA),
          panel.grid.major.y=element_line(color="#2a2a3e",linewidth=0.4),
          panel.grid.major.x=element_blank(), panel.grid.minor=element_blank(),
          axis.text.x=element_text(color=grey,size=7.5,angle=45,hjust=1),
          axis.text.y=element_text(color=grey,size=8),
          axis.title=element_text(color=grey,size=9),
          legend.background=element_rect(fill="#1a1a2e",color=NA),
          legend.text=element_text(color="white",size=8.5),
          legend.title=element_text(color=gold,size=9,face="bold"),
          legend.key=element_rect(fill=NA,color=NA),
          plot.title=element_text(color="white",face="bold",size=13,hjust=0.5),
          plot.subtitle=element_text(color=grey,size=9.5,hjust=0.5,margin=margin(b=12)),
          plot.caption=element_text(color="#555577",size=8,hjust=1),
          plot.margin=margin(20,20,15,20))

  ggsave("premier_league_goals/faktor_home_away.png",
         p_ha, width=16, height=7, dpi=300, bg=bg)

  # --- 7d. Ranking poin tandang juara ---
  p_away_rank <- ggplot(ha_champions, aes(x=season_label, y=rank_away_pts,
                                           fill=rank_away_pts==1)) +
    geom_col(width=0.75, color="white", linewidth=0.2) +
    geom_text(aes(label=rank_away_pts), vjust=-0.4, size=2.6,
              color="white", fontface="bold") +
    scale_fill_manual(values=c("TRUE"=gold,"FALSE"="#4a4a6a"), guide="none") +
    scale_y_continuous(expand=expansion(mult=c(0,0.15))) +
    scale_x_discrete(guide=guide_axis(angle=45)) +
    labs(title="Ranking Poin Tandang (Away) Juara Premier League",
         subtitle=paste0(round(mean(ha_champions$rank_away_pts==1,na.rm=TRUE)*100),
                          "% juara punya poin tandang terbanyak | ",
                          round(mean(ha_champions$rank_away_pts<=3,na.rm=TRUE)*100),
                          "% juara masuk Top 3"),
         x="Musim", y="Ranking Poin Tandang",
         caption="Sumber: Wikipedia | Visualisasi: R/ggplot2") +
    theme_minimal(base_family="sans") +
    theme(plot.background=element_rect(fill=bg,color=NA),
          panel.background=element_rect(fill=panel,color=NA),
          panel.grid.major.y=element_line(color="#2a2a3e",linewidth=0.4),
          panel.grid.major.x=element_blank(), panel.grid.minor=element_blank(),
          axis.text.x=element_text(color=grey,size=7.5,angle=45,hjust=1),
          axis.text.y=element_text(color=grey,size=8),
          axis.title=element_text(color=grey,size=9),
          plot.title=element_text(color="white",face="bold",size=13,hjust=0.5),
          plot.subtitle=element_text(color=gold,size=9.5,hjust=0.5,margin=margin(b=12)),
          plot.caption=element_text(color="#555577",size=8,hjust=1),
          plot.margin=margin(20,20,15,20))

  ggsave("premier_league_goals/faktor_away_rank.png",
         p_away_rank, width=16, height=7, dpi=300, bg=bg)
}

message("\nSemua file berhasil disimpan.")
