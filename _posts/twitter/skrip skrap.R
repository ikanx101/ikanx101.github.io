rm(list=ls())

library(rtweet)
library(dplyr)

# whatever name you assigned to your created app
appname <- ""

## api key (example below is not a real key)
key <- ""

## api secret (example below is not a real key)
secret <- ""

# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

# ==========================================
jokowi = get_timelines("jokowi")
jakarta <- get_trends("jakarta")
