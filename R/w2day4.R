# 로지스틱 회귀분석

model <- glm( Y(2진 분류) ~ Xs , family = binomial(link = 'logit'))

# 적합, 예측 확률
train_pred_p <- model$fittied.values
test_pred_p <- predicct(model, test_Xs, type = 'response')

train_pred <- factor(ifelse(train_pred_p > 0.5, 'yes', 'no'))
test_pred <- factor(ifelse(test_pred_p > 0.5, 'yes', 'no'))

# 혼동행렬
tab <- table(Y, train_pred)
tab <-table(test_Y, test_pred)

TP <- tab[2,2]
TN <- tab[1,1]
FP <- tab[1,2]
FN <- tab[2,1]

acc <-  (TP +TN) / (TP +TN +FP + FN)
precision <- (TP)/(TP +FP)
recall <- (TP)/(TP + FN)

# ROC 곡선, AUC 지표
library(pROC)
train_roc_cur <- roc(Y ~ train_pred_p, plot = T)
test_roc_cur <- roc(test_Y ~ test_pred_p, plot = T)

train_roc_cur$auc
test_roc_cur$auc

# 조건부 확률
# 베이즈 정리
# 나이브 베이즈 


# 반복측정

# 공분산 분석
library(HH)
ancova(Y ~ X1 + X2)

# 다중 분산 분석
manova(~)
summary.aov(manova)

