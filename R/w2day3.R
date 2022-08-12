# 회귀분석 유형
# - 단순, 다중, 다항 



# 결정계수 - 변수들과 종속변수 간에 선형관계의 정도를 설명
# R^2 = SSE/SST
# adjusted R^2 - 다중 



# 연습문제 모델선택법
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

# 전진
model<- lm(SalePrice~ 1, data = df)
model
forward_model<- step(model,
                     direction = 'forward', 
                     scope = list(lower= lm(SalePrice~ 1, data = df), 
                                  upper = lm(SalePrice~ ., data = df)))
summary(forward_model)



# 단계
model<- lm(SalePrice~ ., data = df)
step_model<- step(lm(SalePrice~ ., data = df),
                     direction = 'both')
summary(step_model)

# 후진

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
