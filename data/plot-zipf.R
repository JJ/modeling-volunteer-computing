library(ggplot2)
ggplot()+ scale_x_continuous("Normalized # runs")+scale_y_log10()+scale_colour_hue(name = '# Runs') +geom_point(data=dt.puts.4,aes(x=x/length(dt.puts.4$x),y=y,color='~1400'),stat='Identity')+geom_point(data=dt.puts.3,aes(x=x/length(dt.puts.3$x),y=y,color='~ 800'),stat='Identity')+geom_point(data=dt.puts.1,aes(x=x/length(dt.puts.1$x),y=y,color='~ 500'),stat='Identity')
