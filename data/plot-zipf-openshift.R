library(ggplot2)
library(MASS)
library(fitdistrplus)

process.puts <- function(suffix ) {
    these.puts <- read.csv(paste0("ips-puts-openshift-",suffix,".dat"))
    this.df <- data.frame(x=1:nrow(these.puts),
                          puts=sort(these.puts$puts,decreasing=T))
    this.hist <- hist(this.df$puts)
    this.fit <- fitdistr(this.hist$density,"weibull")
    this.weibull <- rweibull(length(this.hist$density),this.fit$estimate["shape"],this.fit$estimate["scale"])
    this.w.df <- data.frame(x=1:length(this.weibull),fit=this.weibull)
    ggplot(this.df,aes(x=x,y=puts))+geom_point(this.w.df,aes(x=x,y=fit))
    print(this.fit)

    return(this.df)
}
    

dt.puts.4.4 <- process.puts("4-4")
dt.puts.4.24 <- process.puts("4-24")
dt.puts.7.31 <- process.puts("7-31")


ggplot()+ scale_x_continuous("Normalized # runs")+scale_y_log10()+scale_colour_hue(name = '# Runs') +geom_point(data=dt.puts.4.4,aes(x=x/length(dt.puts.4.4$x),y=puts,color='4/4'),stat='Identity')+geom_point(data=dt.puts.4.24,aes(x=x/length(dt.puts.4.24$x),y=puts,color='4/24'),stat='Identity')+geom_point(data=dt.puts.7.31,aes(x=x/length(dt.puts.7.31$x),y=puts,color='7/31'),stat='Identity')
