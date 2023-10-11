rm(list=ls())

library(dplyr)
library(ggplot2)
library(rayshader)

options("cores"=5)

#Here, we will create a 3D plot of the mtcars dataset. This automatically detects 
#that the user used the `color` aesthetic instead of the `fill`.
mtplot = ggplot(mtcars) + 
  geom_point(aes(x=mpg,y=disp,color=cyl)) + 
  scale_color_continuous(limits=c(0,8)) +
  labs(title = "Uji Coba")

#Preview how the plot will look by setting `preview = TRUE`: We also adjust the angle of the light.
plot_gg(mtplot, width=3.5, sunangle=225, preview = TRUE)

plot_gg(mtplot, width=3.5, multicore = TRUE, windowsize = c(1400,866), sunangle=225,
        zoom = 0.6, phi = 45, theta = 45)
render_snapshot()
