# 회귀분석 유형


## - 단순, 다중, 다항 
model <- lm( numeric ~ vars)
summary(model)
confint(model)
anova(model)



#회귀모델의 기본 전제 조건
# 선형성 - 독립 변수와 종속변수 간의 선형관계가 존재
# Residuals vs Fitted
plot(model)

# 정규성 - 종속변수는 정규분포를 따른다
qqplot()
shapiro.test()

# 등분산성 - 종속변수 값들의 분포는 모두 동일한 분산을 가진다
# Scale-Location Plot

# + 잔차의 독립성
library(car)
durbinWatsonTest(residuls(model))

# 독립성 - 모든 독립변수의 관측값들은 서로 독립
library(car)
vif(model)


# 회귀모델의 설명력
library(car)
scatterplotMatrix(df, cex = 1.2,
                  regLine = list(method = lm, lwd = 2, col = 'tomato'),
                  smooth = list(smoother =loessLine, spread = F,
                                lwd.smooth = 2, col.smooth = 'orange'))

## 결정계수 - 변수들과 종속변수 간에 선형관계의 정도를 설명
## R^2 = SSE/SST  ( 모형 예측 찬차 합 / 전체 잔차 합)
## adjusted R^2 - 다중 
summary(model)

## AIC : 모델의 적합도와 파라미터 수를 고려, 적을 수록 적합하다 
## - 2(log-likelihood) + 2k
AIC(model)

## 연습문제 모델선택법
df <- read.csv('./HousePrice/train.csv')[,-1]
str(df)


numeric_cols<-c()
inter_col <-c()
colnames(df)
for ( col in colnames(df)) {
  
  if (is.numeric(df[,col])) {
    numeric_cols<-c(numeric_cols, col)
  }
  if (class(df[,col])=='integer'){
    inter_col <- c(inter_col, col)
  }
}
cat(length(numeric_cols),length(inter_col))

df<-df[,numeric_cols]
dim(df)
dim(na.omit(df))
df<-na.omit(df)

### 전진
model<- lm(SalePrice~ 1, data = df)
model
forward_model<- step(model,
                     direction = 'forward', 
                     scope = list(lower= lm(SalePrice~ 1, data = df), 
                                  upper = lm(SalePrice~ ., data = df)))
summary(forward_model)



### 단계
model<- lm(SalePrice~ ., data = df)
step_model<- step(lm(SalePrice~ ., data = df),
                     direction = 'both')
summary(step_model)

### 후진

model<- lm(SalePrice~., data = df)
backward_model<- step(model, direction = 'backward',
                      scope = list(lower=~1, upper = ~.))

df

coefficients(forward_model)
forward_model$coefficients
cat(length(coefficients(forward_model)))
cat(length(coefficients(backward_model)))
cat(length(coefficients(step_model)))

summary(forward_model)
summary(backward_model)
forward_model$qr

## 더미변수 
lm(numeric ~ factor)
{
relevel(factor, ref = ?)
contrasts(relevel(factor, ref=?))}

# 선형모델의 일반화
# 일반화 선형모델 generalized linear model
# 최대 우도법(MLE) 이용 회귀 계수 추정


## 포아송 회귀
## 결과변수가 특정 기간 동안의 사건 발생 횟수인 경우
## link func : ln(lambda) = a + b1*x1 + b2*x2...
glm(Y ~ Xs , family = poisson)

### 결과변수의 원래 척도로 예측변수의 회귀계수 해석
exp(coef(model))

## 이항 로지스틱 회귀분석
## 결과변수가 이분형 범주일 때 특정 사건이 발생할 확률 추정
## link func : ln(p / 1-p) = a + b1*x1 + b2*x2...
## odds = p / 1-p

e <- exp(1)
z <- seq(-6,6, length = 200)
p<- 1/(1+e^(-z))
plot(z, p, type = 'l')


glm(Y ~ Xs, family = binomial(link = 'logit'))

### 오즈비 odds ratio
### 다른 독립변수가 동일하다는 가정 하에서 
### 특정 독립변수 한 단위 증가에 따른 사건 발생확률 대 미 발생확률 비율의 변화율

coef(model)
exp(coef(model))

## 로지스틱 모형을 통한 예측
## p = 1/(1_e^-(a + b1*x1 + b2*x2...))

predict(model, test_data, type = 'response')
predict(model, test_data, type = '')

## 예측 결과 혼동행렬
table(true_Y, predicted_Y , dnn = c('', ''))

# 혼동행렬
# 정확도 - Accuracy = (TP + TN)/(TP + TN + FP + FN)
# 정밀도 - Precision = (TP)/(TP + FP)
# 재현율 - Recall = (TP)/(TP + FN)
# f1-Score - F1 = 2*(Precision * Recall)/(Precision + Recall)

# ROC 곡선 - 혼동행렬에서 FP 비율과 TP 비율의 관계
# AUC - ROC 곡선의 하부 면적
library(pROC)
prf <- roc(Y, predicted_prob)
plot.roc(prf)
prf$auc


# ex
library(MASS)
df<- na.omit(survey[,c('Sex','Height')])
df$Sex <- ifelse(df$Sex == 'Male', 1, 0)
model<- glm(Sex ~ Height, data = df, family = binomial(link = 'logit'))
model

pr <- predict(model, newdata = data.frame(list(Height = df$Height)), type = 'response')
pr

install.packages('pROC')
library(pROC)
prf <- roc(df$Sex, pr)
plot.roc(prf)

plot(prf)
str(prf)
prf$auc

## 다항로지스틱 회귀분석
## 세 개 이상의 사건을 갖는 결과변수의 사건 발생확률 예측
## ln(p_k / 1-p) = a_k + b1_k*x1 + b2_k*x2...
## p_k = (e^z * k)/(1+ sum(e^z * i) )
library(VGAM)
vglm(Y ~ Xs, family = multinomial())

#  모형 적합 자료를 이용한 예측치
fitted(model)







