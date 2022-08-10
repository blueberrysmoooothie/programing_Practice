
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

