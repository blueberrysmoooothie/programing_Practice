
# 대수의 법칙
for (i in c(1, 10, 100, 1000, 10000)) { print(mean(rbinom(i, 1, 0.7)))}


# 중심극한정리
mo<-c(1,2,3,4,5,6,7,8,9,10,11)
mo
cat(mean(mo), sd(mo),'\n')

for ( i in seq(3,100, 3)){
  m <- c()
  for (t in 1:i){
    samp<- sample(mo,5,replace = F)
    m <- c(m, mean(samp))
  }
  cat(i,'번 반복',mean(m), sd(m),'\n')
  # qqnorm(m)
  cat('shapiro p-value :',shapiro.test(m)$p.value, '\n\n')
}
cat(mean(mo), sd(mo),'\n')

# 통계적 추정과 가설검정
lower <- -1.96
upper <- 0.5
x<- seq(-5,5, length = 1000)
y<-dnorm(x)
plot(x,y,type = 'l', lwd = 2, col = 'tomato')
# abline(0,0,col = 'tomato', lwd = 2)
xlim <- x[lower <= x & x<= upper]
ylim <- y[lower <= x & x<= upper]
xlim <- c(xlim[1], xlim, tail(xlim,1))
ylim <- c(0, ylim, 0)
polygon(xlim, ylim, col = 'darkorange')


# 이항분포 검정
binom.test(x=60, n=100, p = 0.5)

random_binom <- rbinom(1000, 100, 0.5)
cat(mean(random_binom), sd(random_binom))
# np, sqrt(npq)
1-(2*pbinom(60,100,0.5, lower.tail = F))
pnorm(60,50,5, lower.tail = F)


# 정규성 검정 
x<- rnorm(1000, 30, 7)
shapiro.test(x)

qqnorm(x, col = 'lightgray')
qqline(x)


# t 검정
# - t분포 : 정규분포를 따르는 모집단으로 부터 추출한 표본의 확률분포
x<- seq(-3,3, length = 1000)
curve(dt(x, df = 30), min(x), max(x), lty = 1, lwd = 1, col = 'darkblue')
curve(dt(x, df = 20), min(x), max(x), lty = 2, lwd = 1, col = 'lightgray', add = T)
curve(dt(x, df = 10), min(x), max(x), lty = 3, lwd = 1, col = 'orange', add = T)
curve(dt(x, df = 1), min(x), max(x), lty = 4, lwd = 1, col = 'steelblue', add = T)

t<- (135 - 115)/(25/sqrt(20))
pt(t,df = 19)
1-pt(t,df = 19, lower.tail = F)*2 

library(MASS)
## 단일표본 평균검정
result <-t.test(x=cats$Bwt, mu = 2.6)
result

result$estimate
2*pt(result$statistic, result$parameter, lower.tail = F)

result <-t.test(x=cats$Bwt, mu = 2.6, alternative = 'greater', conf.level = 0.99)
result

result$estimate
pt(result$statistic, result$parameter, lower.tail = F)


## 독립표본 평균검정
result <- t.test(cats$Bwt ~cats$Sex)
result


## 대응표본 평균검정
result <- t.test(extra ~ group, data = sleep, paired = T)
result

result$method
