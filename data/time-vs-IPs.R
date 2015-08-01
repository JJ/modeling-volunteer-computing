library(ggplot2)

ips.time <- read.csv("ips-time.csv")
for ( i in 1:nrow(ips.time) ) {
    ips.time[i,]$howmany <- length(ips.time[ips.time$IPs==ips.time[i,]$IPs,]$milliseconds)
}
ggplot(data=ips.time, aes(x=IPs,y=milliseconds,color=howmany))+geom_point()+scale_y_log10()+ stat_summary(fun.data = "mean_cl_boot", colour = "red")
