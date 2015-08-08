library(ggplot2)
library(evd)

process.puts <- function(suffix ) {
    these.puts <- read.csv(paste0("ips-puts-openshift-",suffix,".dat"))
    this.df <- data.frame(x=1:nrow(these.puts),
                          puts=sort(these.puts$puts,decreasing=T))
    this.fit <- fgev(this.df$puts)
    print(this.fit)
    this.fit.plot <- data.frame(x=1:length(this.df$puts),
                                y=sort(rgev(length(this.df$puts),
                                    this.fit$estimate["loc"],
                                    this.fit$estimate["scale"],
                                    this.fit$estimate["shape"]),decreasing=T))
    ggplot()+geom_point(data=this.df,aes(x=x,y=puts))+geom_point(data=this.fit.plot,aes(x=x,y=y,color='red'))+scale_y_log10()
    ggsave(paste0("puts-openshift-",suffix,".png"))
    return(this.df)
}
    

dt.puts.4.4 <- process.puts("4-4")
dt.puts.4.24 <- process.puts("4-24")
dt.puts.7.31 <- process.puts("7-31")


ggplot()+ scale_x_continuous("Normalized # runs")+scale_y_log10()+scale_colour_hue(name = '# Runs') +geom_point(data=dt.puts.4.4,aes(x=x/length(dt.puts.4.4$x),y=puts,color='4/4'),stat='Identity')+geom_point(data=dt.puts.4.24,aes(x=x/length(dt.puts.4.24$x),y=puts,color='4/24'),stat='Identity')+geom_point(data=dt.puts.7.31,aes(x=x/length(dt.puts.7.31$x),y=puts,color='7/31'),stat='Identity')

all.puts <- data.frame(Experiment=rep("4-4",length(dt.puts.4.4$puts)),
                       x = dt.puts.4.4$x,
                       puts = dt.puts.4.4$puts )
all.puts <- rbind(all.puts,
                  data.frame(Experiment=rep("4-24",length(dt.puts.4.24$puts)),
                             x = dt.puts.4.24$x,
                             puts = dt.puts.4.24$puts ))
all.puts <- rbind(all.puts,
                  data.frame(Experiment=rep("7-31",length(dt.puts.7.31$puts)),
                             x = dt.puts.7.31$x,
                             puts = dt.puts.7.31$puts ))
