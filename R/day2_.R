
# rm(list = ls())
# ---------------------------------
# 6.1
st <- data.frame(state.x77)
colnames(st)
cat('변수:',dim(st)[2], '개\n관측값:',dim(st)[1],'개\n')

{cat('각 주별 소득 평균: \n')
apply(st, MARGIN = 1, FUN = function(r) r['Income'])
}
{cat('인구가 10,000보다 큰 주의 인구, 소득: \n')
subset(st, subset = st$Population > 10000,
       select = c('Population', 'Income'))
}
{cat('Florida 주의 인구와 소득: \n')
subset(st, subset = rownames(st)=='Florida',
       select = c('Population', 'Income'))
}
{cat('인구가 1,000보다 작고, 소득이 4,436보다 작은주: \n')
subset(st, subset = st$Population<1000 & st$Income <4436)
}
{cat('5,000 미만, 초과의 소득을 가진 주의 평균 문맹률률 : \n')
aggregate(st$Illiteracy, by = list(Pop_high = ifelse(st$Population < 5000, 'under_5000', 'over_5000')), FUN = mean)
}

# 6.2
cat('인구가 1,000보다 작고, 소득이 5,00보다 작은주: \n')
subset(st, subset = st$Population<1000 & st$Income <5000)

cat('5,000 미만, 초과의 소득을 가진 주의 평균 문맹률률 : \n')
aggregate(st$Illiteracy, by = list(Pop_high = ifelse(st$Population < 5000, 'under_5000', 'over_5000')), FUN = mean)

# 6.3
library(readxl)
df<-read_excel('scores.xlsx', sheet = 1)
str(df)
df$Sum <- apply(df[,3:5], MARGIN = 1, FUN = sum) 
df$Mean <- apply(df[,3:5], MARGIN = 1, FUN = mean) 

write.csv(df, 'result.csv')

# ---------------------------------
# 7.1
# install.packages('mice')
library(mice)
data('nhanes')
df <- nhanes

c{at('변수: ', dim(df)[2],'\n')
cat('관측값: ', dim(df)[1],'\n')
}
{cat('NA가 포함되지 않은 관측값: ', '\n')
df[complete.cases(df),]
}
{cat('NA가 포함된 관측값: ', '\n')
df[!complete.cases(df),]
}
cat('NA가 포함된 관측값의 수: ', dim(df[!complete.cases(df),])[1], '\n')

{cat('각각의 변수별 NA개수: ', '\n')
apply(df, MARGIN = 2, FUN = function(col) sum(is.na(col)))}

# install.packages('VIM')
library(VIM)
aggr(df, prop = F, numbers = T, sortVar = T)


# 7.2
df<- iris
outs = boxplot(Petal.Length ~ Species, 
        data = df,
        col = 'orange',
        border = 'brown'
        )
# 이상치 저장
out.set <- outs$out[outs$group == which(outs$names =='setosa')]
out.ver <- outs$out[outs$group == which(outs$names =='versicolor')]

# 이상치 포함 관측값 NA로 변경 후 제거
df$Petal.Length[df$Petal.Length %in% c(out.set, out.ver)] <-NA
df<-na.omit(df)
str(df)

# ---------------------------------
# 8.1
st <- data.frame(state.x77)

# 인구수 기준 오름차순
st[order(st$Population),]

# 소득 기준 내림차순
st[order(st$Income, decreasing = T),]

# 문맹률 기준 오름차순, 인구수 기준 내림차순
st[order(st$Illiteracy, -st$Population),]


# 8.2
df <- mtcars

# gear 개수에 따라 분할
df.split <-split(df, f= df$gear)
str(df.split)
class(df.split$`3`)

# gear 개수 3, 4 결합
dim(df.split$`3`)
binded_df <-rbind(df.split$`3`, df.split$`4`)
dim(binded_df)

# 8.3
data(airquality)
df <- subset(airquality, select = 1:4)
str(df)

# 결측치 resample로 채우기
# set.seed(493)
# df$Ozone[is.na(df$Ozone)] <- sample(na.omit(df$Ozone),sum(is.na(df$Ozone)), replace = T)
# df$Solar.R[is.na(df$Solar.R)] <- sample(na.omit(df$Solar.R),sum(is.na(df$Solar.R)), replace = T)

# 월별 평균
aggregate(df, by = list(airquality$Month), function (v) mean(v, na.rm = T))

# 일별 표준편차
df.day = aggregate(df, by = list(airquality$Day), function (v) sd(v, na.rm = T))
df.day







