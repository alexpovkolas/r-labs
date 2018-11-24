set.seed(100)
x1 <- runif(100)
y <- x1 + 0.5 * rnorm(100)
model1 <- lm(y~x1) 
summary(model1)

x2 <- runif(100)
model2 <- lm(y~x1 + x2) 
summary(model2)
anova(model2)
anova(model1, model2)

x3 <- x1 + 0.1*runif(100)
summary(lm(y~x1 + x3))

model3 <- lm(y ~ x1 + x2 + x3)
anova(model1, model3)

cor(x3, x1)  
summary(lm(x3~x1))

library("UsingR")
data(fat)
attach(fat)

head(fat)
fat$body.fat[fat$body.fat == 0] <- NA
fat <- fat[, -cbind(1,3,4,9)]
fat <- fat[-42, ] 
fat[,4] <- fat[,4] * 2.54

head(fat)

plot(fat)

model.lm <- lm(body.fat ~ ., data = fat)
summary(model.lm)

round(cor(fat[, -1]), 3)
model.lmstep <- step(model.lm)
summary(model.lmstep)

summary(lm(weight ~ . - body.fat, data = fat))$r.squared

summary(lm(BMI ~ . - body.fat, data = fat))$r.squared

summary(lm(chest ~ . - body.fat, data = fat))$r.squared

summary(lm(abdomen~ . - body.fat, data = fat))$r.squared

summary(lm(hip ~ . - body.fat, data = fat))$r.squared

summary(lm(body.fat ~ ., data = fat))$r.squared
summary(lm(body.fat ~ . - weight - chest - BMI - hip, data = fat))

#метод главных компонент
x <- scale(fat[, -1], T, T)#приведение данных к "стандартному виду"
y <- scale(fat[, 1], T, F)
head(x)
head(y)

#install.packages("pls")
library(pls)

model.pcr <- pcr(y ~ x, ncomp = 14, validation = "CV", segments = 10, segment.type = "random")
summary(model.pcr)
plot(model.pcr, plottype = "validation", val.type = "RMSEP", legend = "topright")

#PLS regression
#https://en.wikipedia.org/wiki/Partial_least_squares_regression
model.plsr <- plsr(y ~ x, ncomp = 14, validation = "CV", segments = 10, segment.type = "random")
plot(RMSEP(model.plsr), legend = "topright")
summary(model.plsr)

par(mfrow=c(1,2))
plot(y[is.na(y[,1]) == F,1], model.pcr$validation$pred[,1, 12])
abline(c(0,1))
plot(y[is.na(y[,1]) == F,1], model.plsr$validation$pred[, 1, 6])
abline(c(0,1))
par(mfrow=c(1,1))

#shrinkage methods
#https://en.wikipedia.org/wiki/Lasso_(statistics)
library(MASS)
model.ridge <- lm.ridge(body.fat ~ ., data = fat, lambda = 1)
model.ridge$coef

plot(y,x %*% model.ridge$coef,xlab="y",ylab=expression(hat(y)))
abline(c(0,1))

model.ridge <- lm.ridge(body.fat ~ ., data = fat, lambda = seq(0, 15, by = 0.2))
select(model.ridge)
plot(model.ridge$lambda, model.ridge$GCV, type = "l")
plot(model.ridge)

model.ridge <- lm.ridge(body.fat ~ ., data = fat, lambda = 10)
lmrbest<-lm.ridge(body.fat ~ ., data = fat, lambda = 1.2)

par(mfrow=c(1,2))
plot(y,x %*% model.ridge$coef,xlab="y",ylab=expression(hat(y)))
abline(c(0,1))
plot(y,x %*% lmrbest$coef,xlab="y",ylab=expression(hat(y)))
abline(c(0,1))
par(mfrow=c(1,1))

x <- x[is.na(y[,1]) == F,]
y <- na.omit(y)

#ручная реализация кросс-валидации
#https://en.wikipedia.org/wiki/Cross-validation_(statistics)
n<-nrow(x)
split<-rep(1:10,length=n)
split
splitrandom<-sample(split,n)
splitrandom
yhat<-rep(NA,n)
yhat
for(i in 1:10){
  Xi <- x[splitrandom!=i,]
  Yi <- y[splitrandom!=i]
  lmi <- lm.ridge(Yi~Xi,lambda=1.2)
  yhat[splitrandom==i]<-x[splitrandom==i,]%*%lmi$coef
}
mean((y-yhat)^2)

repl<-100
Msep<-rep(NA,repl)
for(i in 1:repl){
  train<-sample(1:n,n,replace=TRUE)
  test<-(1:n)[-unique(train)]
  
  Xi<-x[train,]
  Yi<-y[train]
  lmi<-lm.ridge(Yi~Xi,lambda=6.6)
  yhat<-x[test,]%*%lmi$coef
  Msep[i]<-mean((y[test]-yhat)^2)
}
Msep
mean(Msep)

install.packages("lars")
library(lars)
model.lars <- lars(x,y)
plot(model.lars)

cv.lasso <- cv.lars(x,y, K=10, index=seq(0,1,by = 0.05))

min<-which.min(cv.lasso$cv)
abline(h=cv.lasso$cv[min],col="red")
abline(h=cv.lasso$cv[min]+cv.lasso$cv.error[min],col="green")
abline(h=cv.lasso$cv[min]-cv.lasso$cv.error[min],col="blue")
