library(ggplot2)
library(evd)
library(fitdistrplus)

ips.puts.ww <- read.csv("ips-puts-ww.dat")
ips.puts.ww.df <- data.frame(rank=1:nrow(ips.puts.ww),
                             puts=sort(ips.puts.ww$puts,decreasing=T))
this.fit <- fgev(ips.puts.ww$puts)
print(this.fit)
this.fit.plot <- data.frame(rank=1:length(ips.puts.ww$puts),
                            y=sort(rgev(length(ips.puts.ww$puts),
                                this.fit$estimate["loc"],
                                this.fit$estimate["scale"],
                                this.fit$estimate["shape"]),decreasing=T))
ggplot()+geom_point(data=ips.puts.ww.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.plot,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_discrete(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))
ggsave('gev-fit-ww.png',width=5,height=5)

print(fitdistr(ips.puts.ww$puts,"gamma"))
this.weibull <- fitdistr(ips.puts.ww$puts,"weibull")

this.fit.weib <- data.frame(rank=1:length(ips.puts.ww$puts),
y=sort(rweibull(length(ips.puts.ww$puts),
    this.weibull$estimate["shape"],
    this.weibull$estimate["scale"]),decreasing=T))
ggplot()+geom_point(data=ips.puts.ww.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.weib,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_discrete(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))
ggsave('weibull-fit-ww.png',width=5,height=5)
