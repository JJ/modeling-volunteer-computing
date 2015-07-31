ips.worker.cartones <- read.csv('ips-worker.csv')
p.ips.worker.cartones <- ips.worker.cartones$puts/sum(ips.worker.cartones$puts )

lzipf <- function(s,N) -s*log(1:N)-log(sum(1/(1:N)^s))

opt.f <- function(s) sum((log(p.ips.worker.cartones)-lzipf(s,length(p.ips.worker.cartones)))^2)

opt <- optimize(opt.f,c(0.5,10))
