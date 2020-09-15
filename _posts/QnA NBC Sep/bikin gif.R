library(dplyr)
library(ggplot2)
library(gganimate)

data = data.frame(saat = c(0,1,2),
                  detik = c("Saat awal","Pertengahan","Garis finish"),
                  Messi = c(0,0,12),
                  Ronaldo = c(8,9,10))

data = data %>% reshape2::melt(id.vars = c('saat','detik'))

data$detik = factor(data$detik,levels = c("Saat awal","Pertengahan","Garis finish"))

chart =
  data %>% 
  ggplot(aes(x = variable,
             y = value)) +
  geom_point(aes(shape = variable,color = variable),size = 10) +
  theme_minimal() +
  labs(title = "{closest_state}") +
  theme(axis.title = element_blank(),
        legend.position = "none",
        axis.text.x = element_text(face = "bold",size = 20)) +
  transition_states(detik, transition_length = 1, state_length = 1)
  
  
xx = animate(chart,duration = 10)
anim_save("animated.gif", xx)