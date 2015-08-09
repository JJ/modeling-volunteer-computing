library(ggplot2)
library(evd)
ips.puts.ww <- read.csv("ips-puts-ww.dat")
ips.puts.ww.df <- data.frame(x=1:nrow(ips.puts.ww),
                             puts=sort(ips.puts.ww$puts,decreasing=T))
this.fit <- fgev(ips.puts.ww$puts)
print(this.fit)
this.fit.plot <- data.frame(x=1:length(ips.puts.ww$puts),
                            y=sort(rgev(length(ips.puts.ww$puts),
                                this.fit$estimate["loc"],
                                this.fit$estimate["scale"],
                                this.fit$estimate["shape"]),decreasing=T))
ggplot()+geom_point(data=ips.puts.ww.df,aes(x=x,y=puts,color='Data'))+geom_point(data=this.fit.plot,aes(x=x,y=y,color='Fit'))+scale_y_log10()
