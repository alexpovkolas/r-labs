#Генерация случайных величин
set.seed(100)
#для воспроизводимости результатов
#генерация выборки из равномерного распределения
x <- runif(100, 0, 1)
#генерация выборки из нормального распределения с параметрами 1, 4
y <- rnorm(100, 1, 4)
#генерация выборки из экспоненциального закона распределения с параметром 2
z <- rexp(100, 2)

set.seed(proc.time())

v <- rbinom(100, 7, .3)
v
#столбиковая диаграмма
barplot(v)
table(v)
barplot(table(v))



#проверка теоретического факта, что сумма случайных величин 
#из экспоненциального распределения, есть случайная величина из гамма-рпспределения

reps <- 50000
nexps <- 20
rate <- 0.1
set.seed(0)
system.time(
  x1 <- replicate(reps, sum(rexp(n=nexps, rate=rate)))
)

head(x1)
hist(x1, freq = F)

x <- seq(from = min(x1), to = max(x1), 
         length.out = 1000)
lines(x,dgamma(x, shape = nexps, 
               scale=1/rate), col = "red")

set.seed(0)
system.time(x1 <- sapply(1:reps, function(i){sum(rexp(n=nexps, rate=rate))}))

set.seed(0)
system.time(x1 <- lapply(1:reps, function(i){sum(rexp(n=nexps, rate=rate))}))

set.seed(0)
system.time(x1 <- apply(matrix(rexp(n=nexps*reps, rate=rate), nrow=nexps),2,sum))

set.seed(0)
system.time(x1 <- colSums(matrix(rexp(n=nexps*reps, rate=rate), nrow=nexps)))

sample(x = 1:10, size = 5, replace=T)
sample(x = 1:10, size = 5, replace=T, prob = 1:10/sum(1:10))
#Так можно генерировать дискретные случайные величины или цепь Оаркова

#Генерация выборки из многомерного нормального закона распределения
#способ 1
library(MASS)
Sigma <- matrix(c(10,3,3,2),2,2)
Sigma
v <- mvrnorm(n=100, c(2,0), Sigma)
v
class(v)
var(v)
mean(v)
apply(v, 2, mean)

#способ 2
install.packages("mnormt")
library(mnormt)

v2 <- rmnorm(n=100, c(2,0), Sigma)
v2
class(v2)
var(v2)
apply(v2, 2, mean)

z <- rexp(100, 2)
e1 <- 1/mean(z)
e1

#Тест Колмогорова-Смирнова на принадлежность выборки непрерывному закону распределения
ks.test(z,"pexp", e1)
ks.test(z,"pexp", 2)
ks.test(z,"pexp", 3)
ks.test(z,"pnorm", 0, 1)

ks.test(z, y)
y <- z - 0.5
ks.test(z, y)

#Тест на нормальность Шапиро-Уилка (обём выборки до 5000)
v[,1] <- v[,1] - mean(v[,1])
shapiro.test(v[,2])
shapiro.test(v2[,2])

x.poi<-rpois(n = 100,lambda=2.5)
head(x.poi)
hist(x.poi)
barplot(table(x.poi))
install.packages("vcd")
library(vcd)## loading vcd package
gf <- goodfit(x.poi, type= "poisson", method = "MinChisq")
gf
summary(gf)
plot(gf, main="Count data vs Poisson distribution")

gf1 <- goodfit(x.poi, type = "poisson", par = list(lambda = 2.5))
gf1
summary(gf1)

gf2 <- goodfit(x.poi, type= "poisson", method = "ML") 
gf2
summary(gf2)


x.gam <- rgamma(n = 200, rate = 0.5, shape = 3.5)
head(x.gam)
x.gam.cut <- cut(x.gam, breaks = c(0,3,6,9,12,18))
table(x.gam.cut)

f.os<-vector()
for(i in 1:5) f.os[i]<- table(x.gam.cut)[[i]] 

p<-c((pgamma(3,shape=3.5,rate=0.5)-pgamma(0,shape=3.5,rate=0.5)),
     (pgamma(6,shape=3.5,rate=0.5)-pgamma(3,shape=3.5,rate=0.5)),
     (pgamma(9,shape=3.5,rate=0.5)-pgamma(6,shape=3.5,rate=0.5)),
     (pgamma(12,shape=3.5,rate=0.5)-pgamma(9,shape=3.5,rate=0.5)),
     (1-pgamma(12,shape=3.5,rate=0.5)))

p

#хи-квадрат тест
chisq.test(x=f.os,p=p)

breaks <- seq(from = 0, to = max(x.gam), length.out = 7)
breaks
x.gam.cut <- cut(x.gam, breaks = breaks)
f.os <- table(x.gam.cut)

prob <- sapply(breaks, pgamma, shape = 3.5, rate = 0.5)
prob[length(prob)] <- 1
prob

p <- prob[2:length(prob)] - prob[1:(length(prob)-1)]
p

chisq.test(x = f.os, p = p)

