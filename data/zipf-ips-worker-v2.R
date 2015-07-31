ips.worker.cartones.v2 <- read.csv('ips-worker-v2.csv')
p.ips.worker.cartones.v2 <- ips.worker.cartones.v2$puts/sum(ips.worker.cartones.v2$puts )

lzipf <- function(s,N) -s*log(1:N)-log(sum(1/(1:N)^s))

opt.f <- function(s) sum((log(p.ips.worker.cartones.v2)-lzipf(s,length(p.ips.worker.cartones.v2)))^2)

opt <- optimize(opt.f,c(0.5,10))
