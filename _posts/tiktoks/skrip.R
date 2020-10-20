library(tiktokr)
library(reticulate)
library(stringr)

rm(list=ls())

tk_init()


hestek_setinggi_bintang = tk_posts(scope = "hashtag", query = "SetinggiBintang", n = 300)

user_posts = tk_posts(scope = "user", query = "hiloteen", n = 50)

# py_install("requests", pip = TRUE) kalau ada error boleh pake ini




trends <- tk_posts(scope = "trends", n = 200)

library(jsonlite)
library(rjson)

data = read_json("new.json")

length(data$comments)

data$comments[[1]]$text

save(data,hestek_setinggi_bintang,user_posts,file = "toktok.rda")

