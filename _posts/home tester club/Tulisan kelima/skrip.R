rm(list=ls())

setwd("~/ikanx101.github.io/_posts/home tester club/tulisan kelima")

load("hasil komen.rda")

library(dplyr)
library(tidyr)

komeng = c(temp[[1]],temp[[2]],temp[[3]])
komeng

library(tidyverse)
library(reticulate)
library(furrr)
library(future)
library(tictoc)

# Load Model --------------------------------------------------------------

# Importing transformers into R session
transformers <- reticulate::import("transformers")


# Instantiate a pipeline
indonesia_sentiment_classifier <- transformers$pipeline(
  task = "text-classification",
  model = transformers$AutoModelForSequenceClassification$from_pretrained("mdhugol/indonesia-bert-sentiment-classification"), 
  tokenizer = transformers$AutoTokenizer$from_pretrained("mdhugol/indonesia-bert-sentiment-classification"))


text <- c("Kamu kok gitu", 
          "aku sih oke")

# Labelling ---------------------------------------------------------------

outputs <- komeng %>% 
  map(~ indonesia_sentiment_classifier(.x)) %>% 
  bind_rows() %>% 
  mutate(label = case_when(label == "LABEL_0" ~ "Positive", 
                           label == "LABEL_1" ~ "Neutral", 
                           label == "LABEL_2" ~ "Negative"))

outputs$komen = komeng
save(outputs,file = "output.rda")
