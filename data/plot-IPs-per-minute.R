library(ggplot2)


ips.per.minute <- function( suffix ) {
    file.name <- paste0("ips-per-minute-cache=",suffix)
    IPs <- read.csv(paste0("2016-alife/",file.name,".csv"))
    IPs$minute <-  as.POSIXct(IPs$time, "%Y-%m-%dT%H:%M")
    ggplot(data=IPs, aes(x=minute,y=IPs))+ scale_x_datetime()+geom_line()+stat_smooth()
    ggsave(paste0("../img/",file.name,".png"),width=4,height=3)
    
}

suffix <- c("128","64","32")
for ( i in suffix ) {
    ips.per.minute( i )
}
