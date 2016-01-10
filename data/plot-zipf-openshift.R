library(ggplot2)
library(evd)

process.puts <- function(suffix ) {
    these.puts <- read.csv(paste0("ips-puts-openshift-",suffix,".dat"))
    this.df <- data.frame(rank=1:nrow(these.puts),
                          puts=sort(these.puts$puts,decreasing=T))
    this.fit <- fgev(this.df$puts)
    print(this.fit)
    this.fit.plot <- data.frame(rank=1:length(this.df$puts),
                                y=sort(rgev(length(this.df$puts),
                                    this.fit$estimate["loc"],
                                    this.fit$estimate["scale"],
                                    this.fit$estimate["shape"]),decreasing=T))
    ggplot()+geom_point(data=this.df,aes(x=rank,y=puts,color='data',shape='data'))+geom_point(data=this.fit.plot,aes(x=rank,y=y,color='fit',shape='fit'))+scale_y_log10()+ scale_colour_manual(name  ="Puts", breaks=c("data", "fit"), labels=c("Data", "Fit"), values=c("#11AA99",'#EE3333')) + scale_shape_discrete(name  ="Puts", breaks=c("data", "fit"), labels=c("Data", "Fit"))+theme(text = element_text(size=30), axis.text.y = element_text(angle=90, vjust=0.5))
    ggsave(paste0("../img/puts-openshift-",suffix,".png"),width=5,height=5)
    return(this.df)
}
    

dt.puts.4.4 <- process.puts("4-4")
dt.puts.4.24 <- process.puts("4-24")
dt.puts.7.31 <- process.puts("7-31")

ggplot()+ scale_x_continuous("Normalized # runs")+scale_y_log10()+scale_colour_grey(name = '# Runs') +geom_point(data=dt.puts.4.4,aes(x=rank/length(dt.puts.4.4$rank),y=puts,color='4/4'),stat='Identity')+geom_point(data=dt.puts.4.24,aes(x=rank/length(dt.puts.4.24$rank),y=puts,color='4/24'),stat='Identity')+geom_point(data=dt.puts.7.31,aes(x=rank/length(dt.puts.7.31$rank),y=puts,color='7/31'),stat='Identity')

all.puts <- data.frame(Experiment=rep("4-4",length(dt.puts.4.4$puts)),
                       x = dt.puts.4.4$rank,
                       puts = dt.puts.4.4$puts )
all.puts <- rbind(all.puts,
                  data.frame(Experiment=rep("4-24",length(dt.puts.4.24$puts)),
                             x = dt.puts.4.24$rank,
                             puts = dt.puts.4.24$puts ))
all.puts <- rbind(all.puts,
                  data.frame(Experiment=rep("7-31",length(dt.puts.7.31$puts)),
                             x = dt.puts.7.31$rank,
                             puts = dt.puts.7.31$puts ))
