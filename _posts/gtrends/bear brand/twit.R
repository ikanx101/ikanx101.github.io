setwd("~/ikanx101 BLOG/_posts/gtrends/bear brand")

rm(list=ls())

library(rtweet)
library(dplyr)
library(ggplot2)

rm(list=ls())

appname <- "ikanx_r"

## api key (example below is not a real key)
key <- "DaBrL7DcOHmz8CfjgFxAWaL3h"

## api secret (example below is not a real key)
secret <- "OBhNzwBc0kFwSc7IiWp9innDoKk7kwaQoGO864VZoW0XMq6lUd"

access_token = "920366929-gpApN0yTFlKOKQbLTcozvokJDFs8Ek4BzDgzAnd6"

access_secret = "NBR5Ux1019VMxblP1M3I3FaEu1JWwy4PdUgXK2VlJRPpD"


twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)


rt <- search_tweets(
  "#bearbrand", n = 18000, include_rts = FALSE
)

save(rt,file = "twit.rda")