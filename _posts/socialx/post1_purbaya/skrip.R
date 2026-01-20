setwd("~/ikanx101.github.io/_posts/socialx/post1_purbaya")

rm(list=ls())
gc()

library(dplyr)
library(tidyr)
library(tidytext)
library(janitor)

df = read.csv("raw.csv") |> janitor::clean_names()

colnames(df)

df |> tabyl(author)
df |> tabyl(date)

# ============================================
# SKRIP ANALISIS SENTIMEN BERITA EKONOMI
# ============================================

# 1. INSTALASI DAN LOAD PACKAGE YANG DIPERLUKAN
# ============================================
# Jika belum terinstall, install package berikut:
# install.packages(c("tidyverse", "tidytext", 
# "textdata", "sentimentr", "syuzhet", "wordcloud", 
# "RColorBrewer", "ggplot2", "dplyr", "stringr"))

library(tidyverse)
library(tidytext)
library(textdata)
library(sentimentr)
library(syuzhet)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)

# 2. PREPROCESSING TEKS
# ============================================
# Fungsi untuk membersihkan dan mempersiapkan teks
preprocess_text <- function(text) {
  text %>%
    # Ubah ke lowercase
    tolower() %>%
    # Hapus karakter khusus dan angka
    str_remove_all("[[:punct:]]") %>%
    str_remove_all("[[:digit:]]") %>%
    # Hapus whitespace berlebih
    str_squish() %>%
    # Tokenisasi (opsional, untuk analisis lebih lanjut)
    str_split("\\s+") %>%
    unlist()
}

# Terapkan preprocessing pada kolom title
df_clean <- df %>%
  mutate(
    title_clean = map_chr(title, 
                          ~paste(preprocess_text(.), collapse = " ")),
    # Ekstrak tanggal untuk analisis temporal
    date_parsed = as.Date(date, format = 
                            "%d/%m/%Y")
  )

# 3. ANALISIS SENTIMEN DENGAN BEBERAPA METODE
# ============================================

# Metode 1: Menggunakan Lexicon Bahasa Indonesia 
# (SentiWordNet)
# Catatan: Untuk analisis lebih akurat, Anda perlu
# lexicon Bahasa Indonesia
# Berikut contoh dengan lexicon Inggris sebagai 
# alternatif

# Load lexicon sentimen (Bahasa Inggris sebagai 
# contoh)
afinn <- get_sentiments("afinn")
bing <- get_sentiments("bing")
nrc <- get_sentiments("nrc")

# Tokenisasi judul untuk analisis lexicon
title_tokens <- df_clean %>%
  unnest_tokens(word, title_clean) %>%
  anti_join(stop_words, by = "word")  # Hapus stopwords Bahasa Inggris

# Analisis sentimen dengan AFINN (skor numerik)
sentiment_afinn <- title_tokens %>%
  inner_join(afinn, by = "word") %>%
  group_by(date_parsed, title) %>%
  summarise(
    afinn_score = sum(value),
    n_words = n(),
    .groups = 'drop'
  ) %>%
  mutate(afinn_sentiment = case_when(
    afinn_score > 0 ~ "positif",
    afinn_score < 0 ~ "negatif",
    TRUE ~ "netral"
  ))

# Analisis sentimen dengan BING (kategorikal)
sentiment_bing <- title_tokens %>%
  inner_join(bing, by = "word") %>%
  count(date_parsed, title, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from 
              = n, values_fill = 0) %>%
  mutate(
    bing_score = positive - negative,
    bing_sentiment = case_when(
      bing_score > 0 ~ "positif",
      bing_score < 0 ~ "negatif",
      TRUE ~ "netral"
    )
  )

# Metode 2: Menggunakan sentimentr (lebih cocok untuk kalimat lengkap)
sentiment_sentimentr <- df_clean %>%
  mutate(
    sentimentr_score = 
      sentiment_by(title_clean)$ave_sentiment,
    sentimentr_label = case_when(
      sentimentr_score > 0.1 ~ "positif",
      sentimentr_score < -0.1 ~ "negatif",
      TRUE ~ "netral"
    )
  )

# Metode 3: Menggunakan syuzhet (NRC Emotion Lexicon)
sentiment_syuzhet <- df_clean %>%
  mutate(
    # Ekstrak berbagai emosi
    emotion_scores = 
      get_nrc_sentiment(title_clean),
    # Hitung skor sentimen keseluruhan
    syuzhet_score = emotion_scores$positive - 
      emotion_scores$negative,
    syuzhet_label = case_when(
      syuzhet_score > 0 ~ "positif",
      syuzhet_score < 0 ~ "negatif",
      TRUE ~ "netral"
    )
  ) %>%
  bind_cols(.$emotion_scores) %>%
  select(-emotion_scores)

# 4. GABUNGKAN HASIL DARI BERBAGAI METODE
# ============================================
final_sentiment <- df_clean %>%
  left_join(sentiment_afinn %>% select(title, 
                                       afinn_score, afinn_sentiment), 
            by = "title") %>%
  left_join(sentiment_bing %>% select(title, 
                                      bing_score, bing_sentiment), 
            by = "title") %>%
  left_join(sentiment_sentimentr %>% select(title,
                                            sentimentr_score, sentimentr_label), 
            by = "title") %>%
  left_join(sentiment_syuzhet %>% select(title, 
                                         syuzhet_score, syuzhet_label, 
                                         anger, 
                                         anticipation, disgust, fear, 
                                         joy, 
                                         sadness, surprise, trust), 
            by = "title") %>%
  # Buat konsensus sentimen
  mutate(
    consensus_score = rowMeans(
      select(., afinn_score, bing_score, 
             sentimentr_score, syuzhet_score),
      na.rm = TRUE
    ),
    consensus_sentiment = case_when(
      consensus_score > 0.5 ~ "sangat positif",
      consensus_score > 0.1 ~ "positif",
      consensus_score < -0.5 ~ "sangat negatif",
      consensus_score < -0.1 ~ "negatif",
      TRUE ~ "netral"
    )
  )

# 5. VISUALISASI HASIL
# ============================================

# Visualisasi 1: Distribusi Sentimen
ggplot(final_sentiment, aes(x = 
                              consensus_sentiment, fill = consensus_sentiment)) 
+
  geom_bar() +
  labs(
    title = "Distribusi Sentimen Berita Ekonomi",
    x = "Kategori Sentimen",
    y = "Jumlah Berita",
    fill = "Sentimen"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

# Visualisasi 2: Sentimen Berdasarkan Waktu
ggplot(final_sentiment, aes(x = date_parsed, y = 
                              consensus_score, color = consensus_sentiment)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Tren Sentimen Berita Ekonomi 
Berdasarkan Waktu",
    x = "Tanggal",
    y = "Skor Sentimen",
    color = "Sentimen"
  ) +
  theme_minimal()

# Visualisasi 3: Word Cloud untuk Kata-Kata 
Positif/Negatif
# Ekstrak kata-kata positif
positive_words <- title_tokens %>%
  inner_join(bing %>% filter(sentiment == 
                               "positive"), by = "word") %>%
  count(word, sort = TRUE)

# Ekstrak kata-kata negatif
negative_words <- title_tokens %>%
  inner_join(bing %>% filter(sentiment == 
                               "negative"), by = "word") %>%
  count(word, sort = TRUE)

# Word Cloud Positif
wordcloud(
  words = positive_words$word,
  freq = positive_words$n,
  max.words = 100,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2"),
  scale = c(3, 0.5)
)

# Word Cloud Negatif
wordcloud(
  words = negative_words$word,
  freq = negative_words$n,
  max.words = 100,
  random.order = FALSE,
  colors = brewer.pal(8, "Set1"),
  scale = c(3, 0.5)
)

# Visualisasi 4: Emosi yang Dominan
emotion_summary <- final_sentiment %>%
  summarise(
    anger = mean(anger, na.rm = TRUE),
    anticipation = mean(anticipation, na.rm = 
                          TRUE),
    disgust = mean(disgust, na.rm = TRUE),
    fear = mean(fear, na.rm = TRUE),
    joy = mean(joy, na.rm = TRUE),
    sadness = mean(sadness, na.rm = TRUE),
    surprise = mean(surprise, na.rm = TRUE),
    trust = mean(trust, na.rm = TRUE)
  ) %>%
  pivot_longer(everything(), names_to = "emotion",
               values_to = "score")

ggplot(emotion_summary, aes(x = reorder(emotion, 
                                        score), y = score, fill = emotion)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Distribusi Emosi dalam Berita 
Ekonomi",
    x = "Emosi",
    y = "Rata-rata Skor"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# 6. ANALISIS TOPIK SPESIFIK EKONOMI
# ============================================
# Identifikasi topik-topik ekonomi spesifik
economic_keywords <- c(
  "ekonomi", "investasi", "saham", "pasar", 
  "modal", "bisnis",
  "uang", "bank", "kredit", "pajak", "inflasi", 
  "pertumbuhan",
  "ekspor", "impor", "rupiah", "dolar", "bunga", 
  "utang"
)

# Analisis sentimen berdasarkan topik ekonomi
topic_sentiment <- final_sentiment %>%
  mutate(
    # Identifikasi topik dalam judul
    contains_economic = str_detect(tolower(title),
                                   paste(economic_keywords, collapse = "|")),
    economic_topic = ifelse(contains_economic, 
                            "ekonomi", "non-ekonomi")
  ) %>%
  filter(contains_economic) %>%
  group_by(economic_topic) %>%
  summarise(
    avg_sentiment = mean(consensus_score, na.rm = 
                           TRUE),
    n_articles = n(),
    .groups = 'drop'
  )

# 7. OUTPUT DAN EKSPOR HASIL
# ============================================
# Tampilkan summary statistik
cat("=== SUMMARY ANALISIS SENTIMEN BERITA EKONOMI 
===\n")
cat("Total berita dianalisis:", 
    nrow(final_sentiment), "\n")
cat("\nDistribusi Sentimen:\n")
print(table(final_sentiment$consensus_sentiment))

cat("\nRata-rata Skor Sentimen:", 
    mean(final_sentiment$consensus_score, na.rm = 
           TRUE), "\n")
cat("Standar Deviasi:", 
    sd(final_sentiment$consensus_score, na.rm = TRUE),
    "\n")

cat("\nTop 5 Berita Paling Positif:\n")
print(
  final_sentiment %>%
    arrange(desc(consensus_score)) %>%
    select(title, consensus_score, 
           consensus_sentiment) %>%
    head(5)
)

cat("\nTop 5 Berita Paling Negatif:\n")
print(
  final_sentiment %>%
    arrange(consensus_score) %>%
    select(title, consensus_score, 
           consensus_sentiment) %>%
    head(5)
)

# Ekspor hasil ke CSV
write.csv(final_sentiment, 
          "hasil_analisis_sentimen_berita_ekonomi.csv", 
          row.names = FALSE)

# 8. REKOMENDASI UNTUK ANALISIS LEBIH LANJUT
# ============================================
cat("\n=== REKOMENDASI UNTUK ANALISIS LEBIH AKURAT
===\n")
cat("1. Gunakan lexicon Bahasa Indonesia untuk 
hasil lebih akurat\n")
cat("2. Pertimbangkan untuk menggunakan model 
machine learning (BERT, etc.)\n")
cat("3. Lakukan analisis konteks spesifik 
ekonomi\n")
cat("4. Integrasikan dengan data pasar saham untuk
korelasi\n")

# 9. FUNGSI UTILITY TAMBAHAN
# ============================================
# Fungsi untuk analisis sentimen real-time
analyze_sentiment <- function(text) {
  clean_text <- preprocess_text(text)
  
  # Multiple method analysis
  scores <- list(
    afinn = tryCatch({
      tokens <- unlist(str_split(clean_text, 
                                 "\\s+"))
      sum(afinn$value[match(tokens, afinn$word)], 
          na.rm = TRUE)
    }, error = function(e) 0),
    
    sentimentr = 
      sentiment_by(clean_text)$ave_sentiment,
    
    syuzhet = {
      emotions <- get_nrc_sentiment(clean_text)
      emotions$positive - emotions$negative
    }
  )
  
  avg_score <- mean(unlist(scores), na.rm = TRUE)
  
  sentiment_label <- case_when(
    avg_score > 0.5 ~ "Sangat Positif",
    avg_score > 0.1 ~ "Positif",
    avg_score < -0.5 ~ "Sangat Negatif",
    avg_score < -0.1 ~ "Negatif",
    TRUE ~ "Netral"
  )
  
  return(list(
    text = text,
    clean_text = paste(clean_text, collapse = " 
"),
    scores = scores,
    average_score = avg_score,
    sentiment = sentiment_label
  ))
}

# Contoh penggunaan fungsi
contoh_analisis <- analyze_sentiment("Ekonomi 
Indonesia tumbuh positif di kuartal terakhir")
print(contoh_analisis)
```

## **Catatan Penting:**

1. **Lexicon Bahasa**: Skrip di atas menggunakan 
lexicon Bahasa Inggris. Untuk hasil yang lebih 
akurat untuk berita Bahasa Indonesia, Anda perlu:
  - Menggunakan lexicon Bahasa Indonesia seperti 
`sentiment.id` atau `lexiconID`
- Atau membuat custom lexicon berdasarkan 
domain ekonomi

2. **Instalasi Package**: Pastikan semua package 
sudah terinstall sebelum menjalankan skrip.

3. **Optimasi untuk Bahasa Indonesia**:
  ```r
# Jika menggunakan lexicon Bahasa Indonesia
# install.packages("sentiment.id")  # jika 
tersedia
# library(sentiment.id)
```

4. **Custom Stopwords**: Untuk Bahasa Indonesia, 
buat custom stopwords:
  ```r
stopwords_id <- c("yang", "dan", "di", 
                  "dengan", "untuk", "pada", "dari", "dalam", 
                  "adalah", "itu")
```

5. **Analisis Lebih Lanjut**: Skrip ini bisa 
dikembangkan untuk:
  - Analisis korelasi dengan data ekonomi riil
- Predictive modeling untuk pasar saham
- Analisis topik (topic modeling) dengan LDA
- Analisis jaringan kata (word network 
                          analysis)

Skrip ini memberikan analisis sentimen 
komprehensif dengan multiple methods untuk 
meningkatkan akurasi dan memberikan berbagai 
visualisasi untuk interpretasi hasil.