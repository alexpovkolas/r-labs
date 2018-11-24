rm(list = ls())
#t-test
#one-sample test
data.set <- c(5260,5470,5640,6180,6390,6515,
            6805,7515,7516,8230,8770)

(m <- mean(data.set))
(s <- sd(data.set))
(quantile(data.set))

#t-test для проверки на равенство среднего mu (по умолчанию 0)
#вообще говоря, требует нормальное распределение элементов выборки
t.test(data.set, mu=7725)

r <- t.test(data.set, mu=7725)
r$p.value

#t -- значение статистики
#df -- степень свободы (количество элементов выборки минус 1)
#p-value задает уровень значимости на котором можно принять 0 гипотезу
#если p-value < уровня значимости (0.05, 0.1, ...), то 0 гипотеза отклонятеся

#как вычисляется t статистика из предыдущего примера
t <- (m - 7725)/ (s/sqrt(length(data.set)))
#границы, в которые должна попадать математическое ожидание с вероятностью 0.95
t.left <- m - qt(0.975, length(data.set)-1)*(s/sqrt(length(data.set)))
t.right <- m + qt(0.975, length(data.set)-1)*(s/sqrt(length(data.set)))

t
t.left
t.right
m

#задать другой уровень значимости
t.test(data.set, mu=7725, conf.level = 0.99)
#задать другую альтернативу
t.test(data.set, mu=7725, alternative = "less")
t.test(data.set, mu=7725, alternative = "greater")

#Критерий Уилкоксона
#тест не требует нормальности
wilcox.test(data.set, mu=7725)

#чтобы получить доступ к конкретным результатам теста
#создадим объект класса htest
mytest <- wilcox.test(data.set, mu=7725)

#metest можно рассматривать как список со следующими полями
mytest$p.value
mytest$statistic
mytest$parameter
mytest$alternative
mytest$method

#two sample test - Двухвыборочный критерий
#0 гипотеза: математические ожидания в двух выборках равны
data2.set <- data.set + 1000

data.set1 <- rnorm(10, 6000, 1000)
data.set1
data2.set1 <- data.set1 + 1000
t.test(data.set1, data2.set1)

data.set1 <- rnorm(1000, 6000, 1000)
data2.set1 <- data.set1 + 1000
t.test(data.set1, data2.set1)


#первый способ
t.test(data.set, data2.set)

library(ISwR)
attach(energy)
head(energy)
class(energy$stature)

#второй способ
t.test(expend~stature, var.equal=T)
#классический двухвыборочный критерий предполагает, что дисперсии в выборках равны
#тест запускается для двух подвыборок, задаваемых фактором stature
#фактор должен состоять из двух уровней

#тест в случае, когда нет предположения на равенство дисперсий
t.test(expend~stature)
#в этом случае степень свободы обычно не целое число

#F-тест на равенство дисперсий
var.test(expend~stature)
#у F статистики две степени свободы
#p-value > большинства применимых на практике уровней значимости

wilcox.test(expend~stature)
detach(energy)

#regression
attach(thuesen)
summary(thuesen)

lm <- lm(short.velocity~blood.glucose)
sd(lm$residuals)
#lm -- line model
#lm возвращает объект класса "lm"

summary(lm(short.velocity~blood.glucose))
#R-squared -- коэффициент детерминации

#изобразим наши данные на плоскости
plot(blood.glucose,short.velocity)
#нарисуем линию получившейся регрессии
abline(lm(short.velocity~blood.glucose))
#(a, b)-line

lm.velo <- lm(short.velocity~blood.glucose)

#функции, позволяющие получить список приближенных значений и остатков
fitted(lm.velo)
resid(lm.velo)
lm.velo$residuals


plot(blood.glucose,short.velocity)

#еще один способ нарисовать почти линию регрессии
lines(blood.glucose,fitted(lm.velo))
lines(blood.glucose[!is.na(short.velocity)],fitted(lm.velo))

lm.velo <- lm(short.velocity~blood.glucose, na.action = na.exclude)
fitted(lm.velo)

cc <- complete.cases(thuesen)
cc

#рисовать линии координаты которых заданы векторами
segments(blood.glucose,fitted(lm.velo),blood.glucose,short.velocity)

#анализ остатков
plot(fitted(lm.velo),resid(lm.velo))
qqnorm(resid(lm.velo))

shapiro.test(resid(lm.velo))


predict(lm.velo)
predict(lm.velo, newdata = data.frame(blood.glucose=30))
predict(lm.velo,interval="c")#confidence
predict(lm.velo,interval="p")#prediction

#построение интересного рисунка
pred.frame <- data.frame(blood.glucose=4:20)
pp <- predict(lm.velo, int="p", newdata=pred.frame)
pc <- predict(lm.velo, int="c", newdata=pred.frame)
plot(blood.glucose,short.velocity,ylim=range(short.velocity, pp, na.rm=T))
pred.gluc <- pred.frame$blood.glucose
#matrix line
matlines(pred.gluc, pc, lty=c(1,2,2), col="black")
matlines(pred.gluc, pp, lty=c(1,3,3), col="black")

plot(blood.glucose,short.velocity)

matlines(blood.glucose, predict(lm.velo,int="c"), lty=c(1,2,2), col="black")
matlines(blood.glucose, predict(lm.velo,int="p"), lty=c(1,3,3), col="black")

ord1 <- order(blood.glucose)
ord1
blood.glucose[ord1]

pc1 <- predict(lm.velo,int="c")[ord1,]
pp1 <- predict(lm.velo,int="p")[ord1,]
pp1

plot(blood.glucose,short.velocity, ylim=range(short.velocity, pp1, na.rm=T))

matlines(blood.glucose[ord1], pc1, lty=c(1,2,2), col="black")
matlines(blood.glucose[ord1], pp1, lty=c(1,3,3), col="black")

#у корреляции нет na.rm=T
cor(blood.glucose,short.velocity)
cor(blood.glucose, short.velocity, use="complete.obs")
cor(thuesen,use="complete.obs")

cor.test(blood.glucose,short.velocity)
cor.test(blood.glucose,short.velocity,method="spearman")
cor.test(blood.glucose,short.velocity,method="kendall")

detach(thuesen)

attach(red.cell.folate)
head(red.cell.folate)

#anova(lm(folate~ventilation))
summary(lm(folate~ventilation))

xbar <- tapply(folate, ventilation, mean)
s <- tapply(folate, ventilation, sd)
n <- tapply(folate, ventilation, length)
sem <- s/sqrt(n)
stripchart(folate~ventilation, method="jitter",jitter=0.05, pch=16, vert=T)
arrows(1:3,xbar+sem,1:3,xbar-sem,angle=90,code=3,length=.1)
lines(1:3,xbar,pch=4,type="b",cex=2)

detach(red.cell.folate)

#множественная и полимиальная регрессия
attach(cystfibr)

head(cystfibr)

oldpar <- par(mex=0.5)
pairs(cystfibr, gap=0, cex.labels=0.9)
par(oldpar)

plot(cystfibr)

#полиномиальная регрессия
summary(lm(pemax~height))

summary(lm(pemax~height+I(height^2)))

#иллюстрация работы метода
pred.frame <- data.frame(height=seq(110,180,2))
lm.pemax.hq <- lm(pemax~height+I(height^2))
pp <- predict(lm.pemax.hq,newdata=pred.frame,interval="pred")
pc <- predict(lm.pemax.hq,newdata=pred.frame,interval="conf")
plot(height,pemax,ylim=c(0,200))
matlines(pred.frame$height,pp,lty=c(1,2,2),col="black")
matlines(pred.frame$height,pc,lty=c(1,3,3),col="black")

model.matrix(pemax~height+weight)



set.seed(123)
x <- matrix(runif(60), ncol = 3)
y <- x %*% c(1,2,0) + 0.1*rnorm(20)
d <- data.frame(x, y = y)
d

lm0 <- lm(y~1, data = d)
lm0

#lm1 <- lm(y ~ x1, data = d)
lm1 <- lm(y ~ x[,1])

lm2 <- lm(y ~ x[,1] + x[,2])

lm3 <- lm(y ~ x[,1] + x[,2] + x[,3])
lm4 <- lm(y~., data = d)

summary(lm3)
summary(lm4)

#anova(lm3)

head(cystfibr)

m1<-lm(height~., data = cystfibr)
summary(m1)

drop1(m1, test="F")
update(m1, ~.-weight)

m2 <- step(m1)

summary(m2)

detach(cystfibr)

install.packages("UsingR")
library("UsingR")
data(fat)
attach(fat)

head(fat)
fat$body.fat[fat$body.fat == 0] <- NA
fat <- fat[, -cbind(1,3,4,9)]
fat <- fat[-42, ] 
fat[,4] <- fat[,4] * 2.54

head(fat)

attach(fat)

model.lm <- lm(body.fat ~ ., data = fat)
summary(model.lm)

drop1(model.lm, test = "F")
summary(update(model.lm, ~ . - knee))

model.lmstep <- step(model.lm)

detach(fat)
