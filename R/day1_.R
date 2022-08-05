# 연습문제

# 2.1
barplot(table(iris$Species),
        col = 'tomato',
        main = '품종의 막대그래프프',
        xlab = '품종',
        ylab = '개수')

# 2.2
c(mean(iris$Petal.Width),
  var(iris$Petal.Width),
  sd(iris$Petal.Width))

hist(iris$Petal.Width,
     col = 'orange',
     main = '꽃잎의 너비에 대한 히스토그램',
     xlab = '꽃잎의 너비',
     ylab = '빈도수')


# 2.3
hist(mtcars$hp,
     xlim = c(0,400),
     ylim = c(0,12))
plot(mtcars$hp, mtcars$mpg, col = 'blue', pch = '+')
# text( mtcars$hp, mtcars$mpg,'th', col = 'blue')

# 2.4
str(cars)
cars$speed
cars$dist
summary(cars)
plot(cars$speed, cars$dist, col = 'tomato', pch = 'X',
     xlim = c(0,30), ylim = c(0,150))

# --------------------------------------------
  # 3.1
  xs <-c(5,10,15)
for (x in xs){
  cat(x^2)
  cat('\n')
}

for (x in xs){
  cat(x, ':', x*2*3.14, x^2 * 3.14, '\n')
  
}

# 3.2
n <- 78
pizza_chicken <- function(n){
  if (n %% 3 == 0) {
    cat('피자')
    if (n%%5 == 0){
      cat('나라치킨공주')
    } 
  } else if(n%%5 == 0){
    cat('치킨')
  } else {cat('다이어트')}
  cat('\n\n')
}

pizza_chicken(n)

for (n in c(6,10,13,15)) pizza_chicken(n)


# 3.3
for (x in xs){
  s <- 0
  for (i in 1:x) {
    s <- s + i^3
  }
  cat(s)
  cat('\n')
}

for (x in xs){
  s <- 1
  for (i in 2:x) {
    s <- s * i
  }
  cat(s)
  cat('\n')
}

# 3.4
pizza_chicken <- function(n){
  result <- ''
  if (n %% 3 == 0) {
    result <- '피자'
    if (n%%5 == 0){
      result <- '피자나라치킨공주'
    } 
  } else if(n%%5 == 0){
    result <- '치킨'
  } else result <- '다이어트'
  cat(n, result, '\n')
  return(result)
}


n <- 15
mc <- sapply(1:n, pizza_chicken)
mc <- table(mc)
names(mc)
for (name in names(mc)) cat(switch(name, '피자'='pizza', '치킨'='chicken', '피자나라치킨공주'='combo', '다이어트'='diet')
                            ,"=", mc[name], "\n")



# 3.5
n=5

for (i in 1:n){
  for (j in 1:n){cat('*')}
  cat('\n')
}

for (i in 1:n){
  for (j in 1:i){cat('*')}
  cat('\n')
}

for (i in 1:n){
  for (j in 1:(i%%2 *4 +1)){cat('*')}
  cat('\n')
}

# 3.6
is_prime <- function(i){
  prime_tf <- T
  for (j in 2: as.integer(sqrt(i)+1)){
    if (i%%j == 0 ){prime_tf <- F}
  }
  return(prime_tf)
}

ns <- c(10,100, 1000)
for (n in ns){
  cat(n,'\n')
  if (n<2){
    # cat(0, '\n\n')
    next
  } 
  # cat(2,'')
  count_num <- 1
  for (i in 3:n){
    is_p <- is_prime(i)
    if (is_p){
      # cat(i,'')
      count_num <- count_num + 1
    }
  }
  cat('\n',count_num, '\n\n')
}



# 3.7
count_div <- function(i){
  count_num <- 0
  for (j in 1:i){
    if (i%%j == 0){count_num <-count_num + 1}
  }
  return(count_num)
}

for (n in ns){
  max_count = 0
  max_num = 0
  for (i in 1:n){
    count_num<-count_div(i)
    # cat(i,':',count_num,'\n')
    if (count_num >= max_count){
      max_count <-count_num
      max_num <- i
    }
  }
  cat(max_num,':', max_count, '\n')
}

# --------------------------------------------

# 4.1
n<-32
length(which(n %% 1:n == 0))

div <- c()
for (i in 1:15){
  div <- c(div, length((1:i)[which(i %% 1:i == 0)]))
}
div
sum(div == 2)
which(div==2)

# 4.2
height <- c(163, 175, 182, 178, 161)
weight <- c(65, 87, 74, 63, 51)
blood <-factor(c('A', 'B', 'AB', 'O', 'A'))
lst <- list(height=height, weight=weight, blood=blood)
mean(lst$height)
mean(lst$weight)
table(lst$blood)


# ---------------------------------------------------------------------------
# petal.length 가 평균보다 큰 데이터의 petal.width 평균
mean( iris$Petal.Width[ iris$Petal.Length >mean(iris$Petal.Length) ] )

# 5.1
# n의 약수 구하기
div.cnt <- function(n) length(which(n %% 1:n == 0 ))
sapply(1:15, div.cnt)

# 5.2

ns <- c(10,100,1000,10000,10000)


is.prime<- function(n) length(which(n %% 1:n == 0 )) ==2
prime.cnt<- function(n) sum(sapply(1:n, is.prime))

sapply(ns, prime.cnt)

is.prime(11)
n<-10001
which(n %% 1:n == 0 )
which(n %% 1:as.integer(sqrt(n)+1) == 0 )

# sqrt 수정
is.prime<- function(n) length(which(n %% 1:as.integer(sqrt(n)+1) == 0 )) == 1
prime.cnt<- function(n) sum(sapply(1:n, is.prime))
sapply(ns, prime.cnt)



