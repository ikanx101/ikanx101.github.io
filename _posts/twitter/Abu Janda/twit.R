library(rtweet)
library(dplyr)
library(ggplot2)

rm(list=ls())

target = "permadiaktivis1"

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

abu_janda = get_timelines(target, n = 500)
abu_janda_follower = get_followers(target, n = 7000)
detail_flwr = lookup_users(abu_janda_follower$user_id)
abu_janda_stream = stream_tweets(target,timeout = 60)
waktu = Sys.time()
save(abu_janda,abu_janda_follower,detail_flwr,abu_janda_stream,waktu,file = "abu_janda.rda")