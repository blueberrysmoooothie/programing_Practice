### 독립성/ 적합성 검정
#### 카이제곱 검정

##### 독립성 검정  
- 두 범주형 변수 간의 관련성이 모집단에서 존재하는지 검정   
- ( 관측값 - 기대값)^2 / 기대값  
chisq.test(survivors, 2)  

##### 적합성 검정
- 범주별 비율의 분포를 관측  
chisq.test(counts, p = c())  


### 분산분석 ANOVA  
- 세개 이상의 표본집단에서 여러 모집단의 평균과 동일성을 검정  
- 귀무가설 : 모집단평균이 모두 동일  
- F = (집단 간 분산)/ (집단 내 분산)  

#### 분산 분석의 가정
- 정규성 : 종속변수가 정규분포를 따른다 shapiro  
qqPlot()  
shapiro.test()  
outlierTest(aov())  

- 등분산성 : 각 집단의 분포는 모두 동일한 분포를 가진다.   
leveneTest()  
bartlett.test()  

- 등분산 미 충족시 
oneway.test()  


#### 일원분산분석
- 집단 간, 집단 내  
aov(numeric ~ factor)  
model.tables(aov(), type = '')    

##### 사후검정
TukeyHSD(aov())  
plot(TukeyHSD(aov()))  
plot(cld(TukeyHSD(aov())))      
glht(TukeyHSD(aov()))    

#### 이원분산분석  
- 주효과, 상호작용 효과  
aov(numeric ~ factor * factor)  
model.tables(aov(), type = '')  
interaction.plot(x.factor = factor, trace.factor = factor, response = numeric)  

- 시각화  
library(gplots)  
plotmeans(numeric ~ interaction(factor, factor, sep = ' '))  
coplot(numeric  ~ factor | factor)  
library(HH)  
interaction2wt(numeric ~ factor * factor)  

- 사후분석  
TukeyHSD(aov(), which = c(''))  


### 상관분석
- 주로 연속형 변수 간의 연관성을 분석
- 피어슨, 스피어만(순위), 켄달(순위비교) 상관계수  
cor(co1, col2, method = '')   
cor.test(col1,col2)  
cor.test(~ col1 + col2)  
cor.test(~ col1 + col2, subset = (col3 == ''))  

- 세 개 이상의 변수 간의 상관계수 유의성 검정
library(psych)   
corr.test(df)  
  
- 시각화
pairs.panels(df)  
library(corrgram)  
corrgram(df, order = T, lower.panel= '', upper.panel = 'panel.pie')  


- 편상관 관계 partial correlation
  - 두 변수가 다른 제 3의 변수와의 연관이 커 두 변수간의 상관관계가 높게 나타남
  - 이를 제거하기위해 제 3의 변수를 통제하여 편상관계수를 구한다.
library(ggm)  
pcor(c('',''), cov(df))  
  
pcor.test(pcor(), q = _, n = nrows(df))  




