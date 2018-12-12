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

Mu <- c(1, 1, 1, 1)

sample.data <- mvrnorm(n = size, mu = Mu, Sigma = Sigma, empirical = FALSE)
colnames(sample.data) <- c('Y', 'X1', 'X2', 'X3')
sample.data.frame <- data.frame(sample.data)

lm <- lm(Y~X1+X2+X3, data=sample.data.frame)
summary(lm)

shapiro.test(sample.data.frame$X1)
shapiro.test(sample.data.frame$X2)
shapiro.test(sample.data.frame$X3)

#истинные значения
m1 = Mu[1]
Sigma12 = Sigma[2, c(2:4)]
Sigma22 = Sigma[c(2:4), c(2:4)]


sample.coefficients = Sigma12 %*% solve(Sigma22)
sample.intercept = 


