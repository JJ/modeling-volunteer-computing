library(ggplot2)
library(evd)
library(fitdistrplus)

ips.puts <- function( preffix ) {
    ips.puts.ww <- read.csv(paste0("2016-alife/ips-time-openshift-2016-02-cache=",preffix,".csv"))
    ips.puts.ww.df <- data.frame(rank=1:nrow(ips.puts.ww),
                                 puts=sort(ips.puts.ww$PUTs,decreasing=T))

    this.weibull <- fitdistr(ips.puts.ww$PUTs,"weibull")
    print(paste0("Fit ",preffix, " Weibull " ))
    print(this.weibull)
    this.fit.weib <- data.frame(rank=1:length(ips.puts.ww$PUTs),
                                y=sort(rweibull(length(ips.puts.ww$PUTs),
                                                this.weibull$estimate["shape"],
                                                this.weibull$estimate["scale"]),decreasing=T))
    ggplot()+geom_point(data=ips.puts.ww.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.weib,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_manual(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"), values=c("#11AA99",'#EE3333')) + scale_shape_discrete(name ="PUTs", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))+ theme(text = element_text(size=20), axis.text.y = element_text(angle=90, vjust=0.5))
    ggsave(paste0('../img/weibull-fit-cache=',preffix,'.png'),width=5,height=5)
    print("Summary times")
    print(summary(ips.puts.ww$milliseconds))

}

suffix <- c("128","64","32")
for ( i in suffix ) {
    ips.puts( i )
}
