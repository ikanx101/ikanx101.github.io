rm(list=ls())
mulai = Sys.time()

n = 10^6
a = 1
b = 2
h = (b-a)/n
x = seq(a,b,h)

f = function(x)x^2

y = sapply(x,f)
int = mean(y)

print(paste0("Integral f(x) dx adalah: ",int))
print(Sys.time()-mulai)
