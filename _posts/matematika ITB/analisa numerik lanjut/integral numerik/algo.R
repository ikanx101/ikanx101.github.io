rm(list=ls())

# initial condition
a = 0
b = 2
c = 2
d = 3
nx = 10^3
ny = 10^3
f = function(x,y){2*x + y}

# serial
int_dobel_serial = function(f,a,b,c,d,nx,ny){
  mulai = Sys.time()
  hx = (b - a)/nx
  hy = (d - c)/ny
  int = 0
  for(i in 0:(nx-1)){
    for(j in 0:(ny-1)){
      xi = a + hx/2 + i*hx
      yj = c + hy/2 + j*hy
      int = int + hx*hy*f(xi, yj)
    }
  }
  output = list("Integral f(x,y) dy dx adalah:" = int,
                "Runtime" = Sys.time()-mulai)
  return(output)
}

# paralel
library(parallel)
numCores = detectCores()
fx = function(df){2*df[1] + df[2]}

# paralel
int_dobel_paralel = function(dummy){
  mulai = Sys.time()
  hx = (b - a)/nx
  hy = (d - c)/ny
  x = seq(a,b,by = hx)
  y = seq(c,d,by = hy)
  xy = expand.grid(x,y)
  xy = as.data.frame(xy)
  int = hx*hy*sum(fx(xy))
  output = list("Integral f(x,y) dy dx adalah:" = int,
                "Runtime" = Sys.time()-mulai)
  return(output)
}

print("Hasil Menggunakan Serial Processing:")
int_dobel_serial(f,a,b,c,d,nx,ny)

print("\n\nHasil Menggunakan Parallel Processing:")
mclapply(100,int_dobel_paralel,mc.cores = numCores)
