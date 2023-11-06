# ==============================================================================
rm(list=ls())

# libraries
library(dplyr)
library(tidyr)
library(tidytext)

setwd("~/ikanx101.github.io/_posts/web scraping/palestina/scraper")
# ==============================================================================


# ==============================================================================
# ambil stopwords
stop = readLines("https://raw.githubusercontent.com/stopwords-iso/stopwords-id/master/stopwords-id.txt")

# kita list dulu kata-kata yang terafiliasi dengan konflik palestina
kata_konflik = c("palestina","gaza","israel","yahudi","zionis","hamas")

# ambil semua data
load("detikcom.rda")
df_detik = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()

load("kompascom.rda")
df_kompas = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()

load("cnn.rda")
df_cnn    = do.call(rbind,temp_df) %>% janitor::clean_names() %>% distinct()


# kita buat function untuk membersihkan stopwords dari semua data yang ada
bersihkan = function(input){
  # menambahkan id
  input$id = 1:nrow(input)
  # membersihkan
  output = 
    input %>%
    unnest_tokens("words",judul) %>% 
    filter(!words %in% stop) %>% 
    group_by(id) %>% 
    summarise(judul = paste(words,collapse = " ")) %>% 
    ungroup() %>% 
    distinct()
  # ambil berita palestina only
  id_palestin = 
    output |>
    unnest_tokens("words",judul) |>
    filter(words %in% kata_konflik) |>
    pull(id) |>
    unique()
  output = output |> filter(id %in% id_palestin)
  
  return(output)
}

# proses pembersihan
df_detik  = bersihkan(df_detik)
df_kompas = bersihkan(df_kompas)
df_cnn    = bersihkan(df_cnn)
# ==============================================================================

detik_wc = 
  df_detik |>
  unnest_tokens("words",judul) |>
  group_by(words) |>
  count(sort = T) |>
  ungroup() |>
  rename(freq = n)

detik_wc

png("detik cloud.png",width = 900,height = 750,res = 150)
wordcloud::wordcloud(words = detik_wc$words, 
                     freq  = detik_wc$freq, 
                     min.freq. = 0,
                     max.words =150, 
                     use.r.layout=FALSE,
                     random.order=FALSE,
                     rot.per = .25)
dev.off()





```{r,fig.retina = 10,echo=FALSE,message=FALSE,warning=FALSE}
pre_data %>% 
  filter(produk == "Diabetasol") %>% 
  unnest_tokens("bigrams",komen,token = "ngrams",n = 2) %>% 
  group_by(bigrams) %>% 
  count(sort = T) %>% 
  ungroup() %>% 
  filter(n > 3) %>% 
  separate(bigrams,into = c("from","to"),sep = " ") %>% 
  graph_from_data_frame() %>% 
  ggraph(layout = 'fr') +
  geom_edge_bend(aes(edge_alpha=n),
                 show.legend = F,
                 color='darkred') +
  geom_node_point(size=1,color='steelblue') +
  geom_node_text(aes(label=name),alpha=0.4,size=3,repel = T) +
  theme_void()
```


```{r,echo=FALSE,warning=FALSE,message=FALSE}
library(NLP)
library(tm)
library(topicmodels)

topik_dia = pre_data %>% filter(produk == "Diabetasol")
NAME = topik_dia$komen
NAME = Corpus(VectorSource(NAME))
NAME = tm_map(NAME, content_transformer(tolower))
NAME = tm_map(NAME,removePunctuation)
NAME = tm_map(NAME, stripWhitespace)
NAME = tm_map(NAME,removeNumbers)
tdm = TermDocumentMatrix(NAME)
dtm = as.DocumentTermMatrix(tdm) 
rowTotals = apply(dtm , 1, sum) 
dtm = dtm[rowTotals> 0, ]           
lda = LDA(dtm, k = 5)  
term = terms(lda, 3)  
term = apply(term, MARGIN = 2, paste, collapse = ", ")
print("5 Topics dari Reviews Diabetasol")
cbind(term)


topik_dia = pre_data %>% filter(produk == "TS Stevia")
NAME = topik_dia$komen
NAME = Corpus(VectorSource(NAME))
NAME = tm_map(NAME, content_transformer(tolower))
NAME = tm_map(NAME,removePunctuation)
NAME = tm_map(NAME, stripWhitespace)
NAME = tm_map(NAME,removeNumbers)
tdm = TermDocumentMatrix(NAME)
dtm = as.DocumentTermMatrix(tdm) 
rowTotals = apply(dtm , 1, sum) 
dtm = dtm[rowTotals> 0, ]           
lda = LDA(dtm, k = 5)  
term = terms(lda, 3)  
term = apply(term, MARGIN = 2, paste, collapse = ", ")
print("5 Topics dari Reviews Tropicana Slim Stevia")
cbind(term)
```