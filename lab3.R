#Task 1
#
#Сгенерировать выборку из N=100 4-х мерных векторов из нормального закона распределения с ненулевым вектором
#математического ожидания и недиагональной ковариационной матрицей. Ковариационная матрица должна генерироваться
#случайно перед генерацией выборки и должна удовлетворять всем свойствам ковариационной матрицы.
#
#Затем, считая первые компоненты элементов сгенерированной выборки зависимыми переменными, а остальные компоненты
#-- независимыми в модели линейной регрессии, найти оценки коэффициентов регрессии и дисперсии случайных ошибок. 
#Проверить остатки модели на нормальность.
#
#Найти истинные значения коэффициентов регрессии (см. доп. файл) и сравнить их с полученными оценками.


library(MASS)

size <- 100
n <- 4

#https://stats.stackexchange.com/questions/215497/how-to-create-an-arbitrary-covariance-matrix
p <- qr.Q(qr(matrix(rnorm(n^2), n)))
Sigma <- crossprod(p, p*(4:1))

Sigma
det(Sigma)

Mu <- c(1, 2, 3, 4)

sample.data <- mvrnorm(n = size, mu = Mu, Sigma = Sigma, empirical = FALSE)
colnames(sample.data) <- c('Y', 'X1', 'X2', 'X3')
sample.data.frame <- data.frame(sample.data)

lm <- lm(Y~X1+X2+X3, data=sample.data.frame)
summary(lm)

shapiro.test(sample.data.frame$X1)
shapiro.test(sample.data.frame$X2)
shapiro.test(sample.data.frame$X3)

#истинные значения
m1 <- Mu[1]
m2 <- matrix(Mu[2:4], 3, 1)
Sigma12 <- Sigma[1, c(2:4)]
Sigma22 <- Sigma[c(2:4), c(2:4)]

sample.coefficients <- Sigma12 %*% solve(Sigma22)
sample.intercept <- m1 - Sigma12 %*% solve(Sigma22) %*% m2

summary(lm)
sample.intercept
sample.coefficients

#Task 2
#
#Из файла Lab2Task2Var[16].scv загрузить данные. Данные содержат как значения зависимых переменных, 
#так и независимых. Вид зависимости известен и задан в таблице. Однако кроме коэффициентов регрессии неизвестен 
#и коэффициент α. Предложите метод оценивания всех неизвестных коэффициентов с использованием функции lm, и оцените их. 
#Приведите графическую иллюстрацию полученных результатов (график рассеяния с полученной линией регрессии). Воспользуйтесь
#функцией nlm, сравните полученные результаты.

sample.df <- read.csv(file="data/Lab3Task2Var16.csv")
sample.df

# lm

lm.result <- function(alpha, sample) {
  df <- sample
  df$x <- sin(alpha * df$x)
  return( lm(y ~ x, data = df) )
}

lm.cor <- function(alpha, b0, b1, sample) {
  test <- b0 + b1*sin(alpha*sample$x)
  return( cor(test, sample$y) )
}


alpha <- 3.5
step <- 0.1
max.cor <- 0
alpha.best <- alpha

for (i in 1:20) {
  res <- lm.result(alpha, sample.df)  
  cor <- lm.cor(alpha, res$coefficients[1], res$coefficients[2], sample.df)
  
  if (cor > max.cor) {
    params.best <- res
    alpha.best <- alpha
    max.cor <- cor
  }
  
  alpha <- alpha + step
}

result.lm <- params.best$coefficients[1] + params.best$coefficients[2]*sin(alpha.best*sample.df$x)
alpha.best
params.best
result.lm
# nlm
fn <- function(par,  x) {
  mean((x$y - par[1] - par[2]*sin(par[3]*x$x))^2)
}

result.nlm.params <- nlm(p = c(03, 0.5, 5), f = fn, x = sample.df)
result.nlm <- result.nlm.params$estimate[1] + result.nlm.params$estimate[2]*sin(result.nlm.params$estimate[3]*sample.df$x)
result.nlm.params
plot(y~x, data = sample.df)
p.order = order(sample.df$x)

lines(sample.df$x[p.order], result.lm[p.order], col = 'red')
lines(sample.df$x[p.order], result.nlm[p.order], col = 'blue')


#Task 3
#
#Из файла Lab2Task3Var16.scv загрузить данные. Данные содержат как значения зависимых переменных, так и независимых в модели 
#множественной линейной регрессии. В случайно выбранные 10 значений y внести пропуски. По полностью наблюдаемым значениям оценки 
#коэффициентов регрессии, определить какие из них статистически значимые, а какие нет. Кроме этого провести "пошаговую оценку коэффициентов 
#регрессии" как с добавлением переменных, так и с удалением. Выберете на ваш взгляд наиболее адекватную модель (если модели получились
#различные) и спрогнозируйте те значения y, в которые были внесены пропуски, сравните с исходными значениями.

#install.packages("caret")
#install.packages("combinat")

library(caret)
sample.df <- read.csv(file="data/Lab3Task3Var16.csv")

sample.miss <- sample.df
miss.index <- sample(1:100, 10)
sample.miss$y[miss.index] <- NA
sample.omit <- na.omit(sample.df.miss)


sample.omit.lm <- lm(y ~.,data = sample.df.omit)
sample.omit.predict <- predict(sample.omit.lm, sample.df.omit)

varImp(sample.omit.lm, scale = TRUE)

imp.index = c(2, 4, 6, 9, 12)
sample.imp <- sample.omit[imp.index]
sample.imp.lm <- lm(y ~., data = sample.imp)
sample.imp.lm
sample.omit.lm
sample.imp.predict <- predict(sample.imp.lm, sample.imp)

sample.imp.cor <- cor(sample.imp.predict, sample.omit$y)
sample.imp.cor

library(combinat)

max.cor <- sample.imp.cor
best.cols <- imp.index
best.lm <- sample.imp.lm
cols.all <- c(3, 5, 7, 8, 10, 11)

for (i in 1:3) {
  #str(i)
  t <- combn(cols.all, i)
  #str(t)
  for (j in 1:ncol(t)) {
    used.cols <-t[,j]
    #str(used.cols)
    cols <- sort(c(imp.index, used.cols))
    #str(cols)
    df <- sample.omit[cols]
    lm <- lm(y ~.,data = df)
    predict <- predict(lm, df)
    cor <- cor(predict, df$y)
    #str(cor)
    if (cor > max.cor) {
      max.cor <- cor
      best.cols <- cols
      best.lm <- lm
    }
  }
}

colnames(sample.df)[best.cols]
max.cor
sample.imp.cor

missed <- sample.df[miss.index, ]

missed.predict <- predict(best.lm, missed)

cor(missed.predict, missed$y)

missed.predict
missed$y


