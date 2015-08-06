library(ggplot2)

                        
time.vs.IPs <- function( data, preffix ) {
    data$howmany <- 1:nrow(data)
    for ( i in 1:nrow(data) ) {
        data[i,]$howmany <- length(data[data$IPs==data[i,]$IPs,]$milliseconds)
    }
    data$i <- 1:nrow(data)
    ggplot(data=data, aes(x=IPs,y=milliseconds,color=howmany))+geom_point()+scale_y_log10()+ stat_summary(fun.data = "mean_cl_boot", colour = "red")
    ggsave(paste0("time-vs-ips-OS-",preffix,".png"))
    ggplot(data=data, aes(x=i,y=milliseconds,fill=IPs))+geom_bar(stat='identity')+scale_y_log10()
    ggsave(paste0("duration-vs-time-OS-",preffix,".png"))
    ggplot(data=data, aes(x=i,y=milliseconds,color=IPs))+geom_point()+scale_y_log10() + scale_color_gradient(low='blue', high='yellow')
    ggsave(paste0("duration-vs-time-OS-bar-",preffix,".png"))
    ggplot(data=data, aes(x=reorder(i,-milliseconds),y=milliseconds,color=IPs)) +geom_point()+scale_y_log10() + scale_color_gradient(low='blue', high='yellow')+theme(axis.ticks = element_blank(), axis.text.x = element_blank(),axis.text.x=element_text("Ordered experiments"))
    ggsave(paste0("time-vs-rank-OS-",preffix,".png"))
}

suffix <- c("4-4","4-24","7-31")

for ( i in suffix ) {
    ips.time <- read.csv(paste0("ips-duration-openshift-",i,".dat"))
    time.vs.IPs(ips.time, i)
    print(paste(i, summary(ips.time)))
    print(paste("< 69s", length(ips.time[ips.time$milliseconds < 69000,]$milliseconds)/length(ips.time$milliseconds)))
    print(paste("< 3.46s", length(ips.time[ips.time$milliseconds < 3460,]$milliseconds)/length(ips.time$milliseconds)))
}
 
