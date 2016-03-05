library(ggplot2)
library(evd)
library(fitdistrplus)

ips.puts <- function( preffix ) {
    print(paste0("Processing ",preffix))
    print("==============================================")
    ips.puts <- read.csv(paste0("2016-PPSN/ips-time-cache-2016-",preffix,".csv"))
    print("Summary times")
    print(summary(ips.puts$milliseconds))
    print("Summary PUTs ratio")
    print(summary(ips.puts$actualPUTs/ips.puts$PUTs))
    print("Summary IPs ratio")
    print(summary(ips.puts$actualIPs/ips.puts$IPs))
    print("Summary IPs")
    print(summary(ips.puts$actualIPs))
    print("Summary PUTs")
    print(summary(ips.puts$actualPUTs))
    print("Summary total IPs")
    print(summary(ips.puts$IPs))
    print("Summary total PUTs")
    print(summary(ips.puts$PUTs))
    ips.puts.df <- data.frame(rank=1:nrow(ips.puts),
                              puts=sort(ips.puts$PUTs,decreasing=T))
    this.weibull <- try({
        fitdistr(ips.puts$PUTs,"weibull")
    });
    print( this.weibull )
    print(paste0("Fit ",preffix, " Weibull " ))
    print(this.weibull)
    this.fit.weib <- data.frame(rank=1:length(ips.puts$PUTs),
                                y=sort(rweibull(length(ips.puts$PUTs),
                                                this.weibull$estimate["shape"],
                                                this.weibull$estimate["scale"]),decreasing=T))
    
    ggplot()+geom_point(data=ips.puts.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.weib,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_manual(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"), values=c("#11AA99",'#EE3333')) + scale_shape_discrete(name ="PUTs", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))+ theme(text = element_text(size=20), axis.text.y = element_text(angle=90, vjust=0.5))
    ggsave(paste0('../img/weibull-fit-',preffix,'.png'),width=5,height=5)
    
}

suffix <- c("03-cache=32-nooverlap-1","03-cache=32-nooverlap-newgraph-2","03-cache=32-nooverlap-newgraph-3","03-cache=32-nooverlap-newgraph","03-cache=32-nooverlap-newgraph-reboot")
for ( i in suffix ) {
    ips.puts( i )
}
