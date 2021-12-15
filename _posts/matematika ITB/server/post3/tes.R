rm(list=ls())
mulai = Sys.time()

n = 10^6
a = 1
b = 3
h = (b-a)/n
x = seq(a,b,h)

f = function(x)x^2

y = f(x)
int = mean(y)

print(int)
print(Sys.time()-mulai)
