setwd("~/Documents/ikanx101/_posts/TensorFlow/Poto Set")
setwd("~/Documents/ikanx101/_posts/TensorFlow/")

load("bahan blog.rda")
img = list.files()

train = sapply(img[-id_train],readImage)

par(mfrow=c(2,3))
for(i in 1:6) plot(train[[i]])



train = train[[id_train]]
