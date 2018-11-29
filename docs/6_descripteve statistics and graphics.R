rm(list = ls())

#Генерация псевдо-случайных последовательностей
?Distributions
#dxxx - p.d.f. (плотность)
#pxxx - c.d.f. (функция распределения)
#qxxx - quantile function (квантили)
#rxxx - random generation (генерация псевдо-случайных величин)
rnorm(50)
qexp(0.35, 1)

#Summary statistics for a single group
x <- rnorm(50)
x
#выборочное математическое ожидание (среднее арифметическое)
mean(x)

#выборочная дисперсия
v <- var(x)
v
#стандартное отклонение
sd(x)
sqrt(v)

#выборочная медиана
median(x)

#выборочные квантили
quantile(x)
fivenum(x)

quantile(x, type = 1)

quantile(x, probs = seq(0,1,0.1))

install.packages("ISwR")
library(ISwR)
#Пример простейшено анализа данных
juul
head(juul)
#Показать еще один способ просмотра данных

attach(juul)
mean(igf1)

#В данных есть пропуски, которые не плохо было бы игнорировать
mean(igf1, na.rm = T)

length(igf1)

#узнать количество наблюдаемых значений
sum(!is.na(igf1))

#Краткий отчет о векторе
summary(igf1)
summary(igf1)["NA's"]
#????? ?????????? ? ???????
summary(juul)

detach(juul)
juul$sex <- factor(juul$sex,labels=c("M","F"))
juul$menarche <- factor(juul$menarche,labels=c("No","Yes"))
juul$tanner <- factor(juul$tanner,labels=c("I","II","III","IV","V"))
attach(juul)
summary(juul)

#тоже и самое можно получить и другим путем
juul <- transform(juul,
                  sex=factor(sex,labels=c("M","F")),
                  menarche=factor(menarche,labels=c("No","Yes")),
                  tanner=factor(tanner,labels=c("I","II","III","IV","V")))

head(juul, n = 6)
summary(juul)

#Построение гистограммы
hist(x)
#можно указывать количесвто столбцов
hist(x, breaks = 1)
hist(x, breaks = 30) 
#и задавать границы в явном виде
hist(x, breaks = c(min(x), -2, -1, -0.5, 0 , 0.2, 0.4, 2, max(x)))

#Empirical cumulative distribution
n <- length(x)
plot(sort(x),(1:n)/n,type="s",ylim=c(0,1))

plot(sort(x),(1:n)/n,ylim=c(0,1))
plot.ecdf(x)

#Q–Q plots
qqnorm(x)

#boxplot
#несколько графиков на одном рисунке
par(mfrow=c(1,2))
#mfcol = c(1,2)
boxplot(IgM)
boxplot(log(IgM))
par(mfrow=c(1,1))

#Summary statistics by groups
attach(red.cell.folate)
head(red.cell.folate)
tapply(folate,ventilation,mean)
tapply(folate,ventilation,sd)
tapply(folate,ventilation,length)

xbar <- tapply(folate, ventilation, mean)
s <- tapply(folate, ventilation, sd)
n <- tapply(folate, ventilation, length)
cbind(mean=xbar, std.dev=s, n=n)

detach(red.cell.folate)

tapply(igf1, tanner, mean)
tapply(igf1, tanner, mean, na.rm=T)

aggregate(juul[c("age","igf1")],
          by = list(sex=juul$sex), mean, na.rm=T)

by(juul, juul["sex"], summary)

#Graphics for grouped data
attach(energy)
head(energy)
expend.lean <- expend[stature=="lean"]
expend.obese <- expend[stature=="obese"]

par(mfrow=c(2,1))
hist(expend.lean,breaks=10,xlim=c(5,13),ylim=c(0,4),col="white")
hist(expend.obese,breaks=10,xlim=c(5,13),ylim=c(0,4),col="grey")
par(mfrow=c(1,1))

boxplot(expend ~ stature)
#y ~ x should be read "y described using x"

boxplot(expend.lean,expend.obese)

#Stripcharts
opar <- par(mfrow=c(2,2), mex=0.8, mar=c(3,3,2,1)+.1)
stripchart(expend ~ stature)
stripchart(expend ~ stature, method="stack")
stripchart(expend ~ stature, method="jitter")
stripchart(expend ~ stature, method="jitter", jitter=.03)
par(opar)

#table(factor)
table(sex)

#table(factor1, factor2)
table(sex, tanner)

xtabs(~ tanner + sex, data=juul)

xtabs(~ dgn + diab + coma, data=stroke)

ftable(coma + diab ~ dgn, data=stroke)

#Marginal tables and relative frequency
tanner.sex <- table(tanner,sex)
tanner.sex

margin.table(tanner.sex,1)
margin.table(tanner.sex,2)

prop.table(tanner.sex,1)
prop.table(tanner.sex,2)

tanner.sex/sum(tanner.sex)
#Graphical display of tables
total.caff <- margin.table(caff.marital,2)
total.caff

barplot(total.caff, col="white")
par(mfrow=c(2,2))
barplot(caff.marital, col="white")
barplot(t(caff.marital), col="white")
barplot(t(caff.marital), col="white", beside=T)
barplot(prop.table(t(caff.marital),2), col="white", beside=T)
par(mfrow=c(1,1))

barplot(prop.table(t(caff.marital),2),beside=T,
        legend.text=colnames(caff.marital),
        col=c("white","red","blue","green"))

dotchart(t(caff.marital), lcolor="black")

opar <- par(mfrow=c(2,2),mex=0.8, mar=c(1,1,2,1))
slices <- c("white","red","blue","green")
pie(caff.marital["Married",], main="Married", col=slices)
pie(caff.marital["Prev.married",], main="Previously married", col=slices)
pie(caff.marital["Single",], main="Single", col=slices)
par(opar)

plot(rnorm(10),type="o")

data(iris)
iris
pairs(iris[101:150, 1:4])

f <- function(x,y){
  z <- (1/(2*pi))*exp(-0.5*(x^2+y^2))
}
x <- y <- seq(-3,3,length = 50)
z <- outer(x,y,f)
persp(x,y,z)
persp(x,y,z, theta = 45, phi = 30, expand = 0.6)
