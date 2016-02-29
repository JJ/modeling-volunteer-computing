library(ggplot2)
library(grid)
                        
time.vs.IPs <- function( data, preffix ) {
    data$howmany <- 1:nrow(data)
    for ( i in 1:nrow(data) ) {
        data[i,]$howmany <- length(data[data$IPs==data[i,]$IPs,]$milliseconds)
    }
    data$i <- 1:nrow(data)
    ggplot(data=data, aes(x=IPs,y=milliseconds,color=howmany))+ scale_colour_gradient(name  ="Count", low="#11AA99",high='#EE3333')+geom_point(size=4)+scale_y_log10()+ stat_summary(fun.data = "mean_cl_boot", colour = "black")+ theme(text = element_text(size=25), legend.key.height=unit(2, "line"), axis.text.y = element_text(angle=90, vjust=0.5)) 
    ggsave(paste0("../img/time-vs-ips-alife-",preffix,".png"))
    ggplot(data=data, aes(x=i,y=milliseconds,fill=IPs))+geom_bar(stat='identity')+scale_y_log10()
    ggsave(paste0("../img/duration-vs-time-alife-",preffix,".png"))
    ggplot(data=data, aes(x=i,y=milliseconds,color=IPs))+geom_point()+scale_y_log10() + scale_color_gradient(low='blue', high='yellow')
    ggsave(paste0("duration-vs-time-alife-bar-",preffix,".png"))
    ggplot(data=data, aes(x=reorder(i,-milliseconds),y=milliseconds,color=IPs)) +geom_point()+scale_y_log10() + scale_color_gradient(low='#11AA99', high='#EE3333') + theme(axis.ticks = element_blank(), axis.text.x = element_blank(), text = element_text(size=30), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.text.y = element_text(angle=90, vjust=0.5) )+labs( x="Ordered experiments")
    ggsave(paste0("../img/time-vs-rank-alife-",preffix,".png"))
}

suffix <- c("128","64","32")
all.openshift <- data.frame(Experiment=as.Date(character()),
                            IPs=character(), 
                            milliseconds=character()) 
for ( i in suffix ) {
    ips.time <- read.csv(paste0("2016-alife/ips-time-openshift-2016-02-cache=",i,".csv"))
    all.openshift <- rbind(all.openshift,
                           data.frame( Experiment=rep(paste0("cache=",i),length(ips.time$IPs)),
                                      IPs = ips.time$IPs,
                                      milliseconds = ips.time$milliseconds))
    time.vs.IPs(ips.time, i)
    print(paste(i, summary(ips.time)))
    ips.time.minus1 <- ips.time[c(1:length(ips.time$IPs)-1),]
    ips.time.plus1 <- ips.time[c(2:length(ips.time$IPs)),]
    print(cor(ips.time.minus1, ips.time.plus1))
}


all.openshift.minus1 <- all.openshift[c(1:length(all.openshift$IPs)-1),]
all.openshift.plus1 <- all.openshift[c(2:length(all.openshift$IPs)),]
print(cor(all.openshift.minus1$IPs, all.openshift.plus1$IPs))

