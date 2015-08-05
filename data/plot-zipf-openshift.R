library(ggplot2)
puts.4.4 <- read.csv("ips-puts-openshift-4-4.dat")
puts.4.24 <- read.csv("ips-puts-openshift-4-24.dat")
puts.7.31 <- read.csv("ips-puts-openshift-7-31.dat")

dt.puts.4.4 <- data.frame( x=1:nrow(puts.4.4),puts=sort(puts.4.4$puts,decreasing=T))
dt.puts.4.24 <- data.frame( x=1:nrow(puts.4.24),puts=sort(puts.4.24$puts,decreasing=T))
dt.puts.7.31 <- data.frame( x=1:nrow(puts.7.31),puts=sort(puts.7.31$puts,decreasing=T))
ggplot()+ scale_x_continuous("Normalized # runs")+scale_y_log10()+scale_colour_hue(name = '# Runs') +geom_point(data=dt.puts.4.4,aes(x=x/length(dt.puts.4.4$x),y=puts,color='4/4'),stat='Identity')+geom_point(data=dt.puts.4.24,aes(x=x/length(dt.puts.4.24$x),y=puts,color='4/24'),stat='Identity')+geom_point(data=dt.puts.7.31,aes(x=x/length(dt.puts.7.31$x),y=puts,color='7/31'),stat='Identity')
