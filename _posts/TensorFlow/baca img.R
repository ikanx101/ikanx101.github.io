setwd("~/Documents/ikanx101/_posts/TensorFlow/Poto Set")

img = list.files()

train = sapply(img,readImage)
par(mfrow=c(4,8))
for(i in 1:31) plot(train[[i]])
