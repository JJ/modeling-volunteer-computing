library(ggplot2)

ips.time <- read.csv("ips-duration-openshift-7-31.dat")
ips.time$howmany <- 1:nrow(ips.time)
for ( i in 1:nrow(ips.time) ) {
    ips.time[i,]$howmany <- length(ips.time[ips.time$IPs==ips.time[i,]$IPs,]$milliseconds)
}
ips.time$i <- 1:nrow(ips.time)
ggplot(data=ips.time, aes(x=IPs,y=milliseconds,color=howmany))+geom_point()+scale_y_log10()+ stat_summary(fun.data = "mean_cl_boot", colour = "red")
ggplot(data=ips.time, aes(x=i,y=milliseconds,fill=IPs))+geom_bar(stat='identity')+scale_y_log10()
ggplot(data=ips.time, aes(x=i,y=milliseconds,color=IPs))+geom_point()+scale_y_log10() + scale_color_gradient(low='blue', high='yellow')

