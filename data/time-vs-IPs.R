library(ggplot2)

ips.time <- read.csv("ips-time.csv")
ips.time$howmany <- 1:nrow(ips.time)
for ( i in 1:nrow(ips.time) ) {
    ips.time[i,]$howmany <- length(ips.time[ips.time$IPs==ips.time[i,]$IPs,]$milliseconds)
}
ips.time$i <- 1:nrow(ips.time)
ggplot(data=ips.time, aes(x=IPs,y=milliseconds,color=howmany))+geom_point()+scale_y_log10()+ stat_summary(fun.data = "mean_cl_boot", colour = "red")
ggplot(data=ips.time, aes(x=i,y=milliseconds,color=IPs))+geom_point()+scale_y_log10() + scale_color_gradient(low='blue', high='yellow')

 print(paste("< 69s", length(ips.time[ips.time$milliseconds < 69000,]$milliseconds)/length(ips.time$milliseconds)))
print(paste("< 3.46s", length(ips.time[ips.time$milliseconds < 3460,]$milliseconds)/length(ips.time$milliseconds)))
ips.time.minus1 <- ips.time[c(1:length(ips.time$IPs)-1),]
ips.time.plus1 <- ips.time[c(2:length(ips.time$IPs)),]
print(cor(ips.time.minus1$IPs, ips.time.plus1$IPs))
