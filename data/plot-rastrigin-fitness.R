library(ggplot2)

rastrigin.fitness <- read.csv("rastrigin-fitness.csv")
rastrigin.fitness$date <-  as.POSIXct(rastrigin.fitness$timestamp, "%Y-%m-%d %H:%M:%S")
qplot(date,-Fitness,data=rastrigin.fitness)+ scale_x_datetime()
ggsave("rastrigin-fitness.png",width=4,height=3)
