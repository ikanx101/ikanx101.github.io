library(dplyr)
library(ggplot2)

var = c(-4,0,1)
a = -4
b = 4
delta = 0.5

# mulai function di sini
power = 0:(length(var)-1)
x = seq(a,b,by = delta)
polyroot(var)
