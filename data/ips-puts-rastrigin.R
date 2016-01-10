library(ggplot2)
library(evd)
library(fitdistrplus)

ips.puts.ww.rastrigin <- read.csv("IPs-Rastrigin.csv")
ips.puts.ww.rastrigin.df <- data.frame(rank=1:nrow(ips.puts.ww.rastrigin),
                             puts=sort(ips.puts.ww.rastrigin$puts,decreasing=T))
this.fit <- fgev(ips.puts.ww.rastrigin$puts)
print(this.fit)
this.fit.plot <- data.frame(rank=1:length(ips.puts.ww.rastrigin$puts),
                            y=sort(rgev(length(ips.puts.ww.rastrigin$puts),
                                this.fit$estimate["loc"],
                                this.fit$estimate["scale"],
                                this.fit$estimate["shape"]),decreasing=T))

ggplot() +geom_point(data=ips.puts.ww.rastrigin.df,aes(x=rank,y=puts,color='Data',shape='Data')) +geom_point(data=this.fit.plot,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10() + scale_colour_grey(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))+ theme(text = element_text(size=20), axis.text.y = element_text(angle=90, vjust=0.5))

ggsave('../img/gev-fit-ww.rastrigin.png',width=5,height=5)

print(fitdistr(ips.puts.ww.rastrigin$puts,"gamma"))
this.weibull <- fitdistr(ips.puts.ww.rastrigin$puts,"weibull")

this.fit.weib <- data.frame(rank=1:length(ips.puts.ww.rastrigin$puts),
y=sort(rweibull(length(ips.puts.ww.rastrigin$puts),
    this.weibull$estimate["shape"],
    this.weibull$estimate["scale"]),decreasing=T))
ggplot()+geom_point(data=ips.puts.ww.rastrigin.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.weib,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_grey(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))
ggsave('../img/weibull-fit-ww.rastrigin.png',width=5,height=5)

ips.puts.ww.rastrigin.workers <- read.csv("IPs-worker-Rastrigin.csv")
ips.puts.ww.rastrigin.workers.df <- data.frame(rank=1:nrow(ips.puts.ww.rastrigin.workers),
                                               puts=sort(ips.puts.ww.rastrigin.workers$puts,decreasing=T))
this.fit <- fgev(ips.puts.ww.rastrigin.workers$puts,std.err=FALSE)
print(this.fit)
this.fit.plot <- data.frame(rank=1:length(ips.puts.ww.rastrigin.workers$puts),
                            y=sort(rgev(length(ips.puts.ww.rastrigin.workers$puts),
                                this.fit$estimate["loc"],
                                this.fit$estimate["scale"],
                                this.fit$estimate["shape"]),decreasing=T))

ggplot() +geom_point(data=ips.puts.ww.rastrigin.workers.df,aes(x=rank,y=puts,color='Data',shape='Data')) +geom_point(data=this.fit.plot,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10() + scale_colour_grey(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name  ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))

ggsave('../img/gev-fit-ww-rastrigin-workers.png',width=5,height=5)

print(fitdistr(ips.puts.ww.rastrigin.workers$puts,"gamma"))
this.weibull <- fitdistr(ips.puts.ww.rastrigin.workers$puts,"weibull")

this.fit.weib <- data.frame(rank=1:length(ips.puts.ww.rastrigin.workers$puts),
y=sort(rweibull(length(ips.puts.ww.rastrigin.workers$puts),
    this.weibull$estimate["shape"],
    this.weibull$estimate["scale"]),decreasing=T))
print(this.weibull)
ggplot()+geom_point(data=ips.puts.ww.rastrigin.workers.df,aes(x=rank,y=puts,color='Data',shape='Data'))+geom_point(data=this.fit.weib,aes(x=rank,y=y,color='Fit',shape='Fit'))+scale_y_log10()+ scale_colour_grey(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit")) + scale_shape_discrete(name ="Puts", breaks=c("Data", "Fit"), labels=c("Data", "Fit"))
ggsave('../img/weibull-fit-ww-rastrigin-workers.png',width=5,height=5)
