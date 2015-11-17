library(ggplot2)

rastrigin.IPs <- read.csv("rastrigin-IPs-per-minute.csv")
rastrigin.IPs$minute <-  as.POSIXct(rastrigin.IPs$Minute, "%Y-%m-%d %H:%M")
ggplot(data=rastrigin.IPs, aes(x=minute,y=IPs))+ scale_x_datetime()+geom_point()
ggsave("rastrigin-IPs.png",width=4,height=3)

rastrigin.IPs.hour <- read.csv("rastrigin-IPs-per-hour.csv")
rastrigin.IPs.hour$hour <-  as.POSIXct(rastrigin.IPs.hour$Hour, "%Y-%m-%d %H:%M:%S")
ggplot(data=rastrigin.IPs.hour, aes(x=hour,y=IPs))+ scale_x_datetime()+geom_line()
ggsave("rastrigin-IPs-hour.png",width=4,height=3)
