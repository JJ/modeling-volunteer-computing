library(ggplot2)

rastrigin.IPs <- read.csv("rastrigin-IPs-per-minute.csv")
rastrigin.IPs$minute <-  as.POSIXct(rastrigin.IPs$Minute, "%Y-%m-%d %H:%M")
ggplot(data=rastrigin.IPs, aes(x=minute,y=IPs))+ scale_x_datetime()+geom_point()
ggsave("rastrigin-IPs.png",width=4,height=3)
