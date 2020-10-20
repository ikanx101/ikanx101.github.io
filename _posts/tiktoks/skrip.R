library(tiktokr)
library(reticulate)
library(stringr)

rm(list=ls())

tk_init()

hash_post <- tk_posts(scope = "hashtag", query = "SerunyaNutrisari", n = 300)

trends <- tk_posts(scope = "trends", n = 200)

# py_install("requests", pip = TRUE) kalau ada error boleh pake ini


save(hash_post,hash_post_2,file = "toktok.rda")
