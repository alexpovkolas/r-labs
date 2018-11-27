rm(list=ls())
#присваивание
a <- 50
a
(a<-59)
b <- c <- 10
b
c
(a<-b+c)
a<-(b+c)

110+12 -> c
c

a <- (b <- 10) + 5

d = c = 11
d
c

assign("a",12)#более сложное присвоение, но пока пусть так
a

#типы данных
#numeric, integer, double
a<-5
mode(a)
is.integer(a)
is.double(a)

a<-as.integer(5)
a
is.integer(a)
is.numeric(a)
is.double(a)
mode(a)

a<-integer(5)
a
is.integer(a)
is.numeric(a)
#как кратко ввести integer?
a<-25L
is.integer(a)

#as.integer = усечение != round
as.integer(2.4)
as.integer(2.6)
round(2.6)
is.integer(round(2.4))
trunc(2.6)
#truncate для работы с файлами!!!
is.integer(trunc(2.6))

(a<-5)
is.double(a)
is.numeric(a)
#single нет
a<-as.single(6)#для совместимости с другими языками программирования
is.double(a)

a<-5.5
mode(a)

x <- 10/-0
y <- -log(0)
z <- x + y
x; y; z;
is.double(x)
is.character(x)

(x <- -0)

is.nan(x)#является ли не числом
is.nan(z)
is.infinite(x)#является ли бесконечностью
is.finite(a)

#complex
a<-complex(2,3)#так писать не надо, создается вектор длины 2 состоящий из числе 3+0i
a<-as.complex(2,3)#2+0i
a
a<-complex(real = 2, imaginary = 3)
a
(a<- 5 + 10i)
is.integer(a)
is.double(a)
is.numeric(a)#complex != numeric
is.complex(a)

Re(a)
Im(a)
Mod(a)
Arg(a)
Conj(a)#сопряженное
Arg(5)

#logical
a<-(5<4)
a
mode(a)
a<- TRUE
a
#(TRUE, FALSE) = (T, F)
a <- T
a
as.integer(TRUE)
as.integer(F)

#character
a <-'ab'#текст помещается между одинарными или двойными кавычками
a
mode(a)

a <- "lection on R"
mode(a)
a

a <- "можно 'так' писать"
print(a)
b <- 'и "так" можно'
print(b)

a <-5
as.character(a)

as.integer("-65.4")

#Создание векторов
#функция c(concatenate)
x <- c(3, 1, 4)
x
(y <- c(5, 9, 2))
p <- c(x, 1, y)
p

#создание вектора с именами
salary <- c(Ivanov = 300, Petrov = 500, Sidorov = 250)
salary

#просмотр имен
names(salary)
attributes(salary)

#изменение имен
names(salary) <- c("one", "two", "three")
salary

names(salary) <- c("one", "two")
salary

names(salary) <- c("one", "two", "three", "four")
salary
salary[3]
a<-salary["two"]
a

#Вектор всегда содержит элементы одного типа
#при конкатинации векторов разных типов, все значения
#приводятся к наиболее общему
y
c(FALSE, y)
c(y, names(salary))

#функция seq (sequence)
x<-seq(2,11)# from = 2, to = 11
x

seq(2.2,11.5)
seq("a","z")#Ошибка, нельзя привести к числам
seq("1","5")
seq(2+5i, 5+5i)

#с шагом
(y<-seq(2,11,4))
(seq(from = 2, to = 11, by = 4))

#с заданным количеством выходных элементов
(seq(from = 2, to = 11, length.out = 5))

#ошибка, если данные протеворечивы
(seq(from = 2, to = 11, length.out = 3, by = 2))

#оператор :  (a:b) ~ seq(a,b)
z<-2:11
z
2.4:11

#функция rep ("replicate") используется для создания 
#повторяющихся значений
x<-c(1,2,3)
(y<-rep(x,3))

print(z<-rep(x,c(3,2,1)))
print(z<-rep(x,c(2,1)))
print(z<-rep(x,c(3,3,3)))
(rep(x, each=3))
(rep(x, times = 3))
(rep(x, times = 3, len = 7))

#имена аргументов
?seq
seq(from = 2, to = 17, by = 5) # seq(2,17,5)
seq(to = 17, by = 5, from = 2)
seq(to = 10, from = 19, length.out = 11)
seq(to = 10, from = 19, length.out = 11, by = -0.9)
seq(from = 19, length.out = 11, by = -0.9)
seq(to = 10, length.out = 11, by = -0.9)
seq(2,3,4)

#создание пустых векторов заданного типа
q <- integer(5)
q
z <- numeric(3)
z

vars <-paste(c("x", "y", "z"), 1:3, sep="")
vars
vars <-paste(2:4, 1:3, sep="-")
vars

x
is.vector(x)
is.vector(x, mode = "logical")

#**********************************************************************************************************************
#Создание матриц
#1) изменение размерности вектора
x <- 1:6
dim(x)
dim(x) <- c(2,3)
x
class(x)
is.vector(x)
is.matrix(x)

#2) использование функции matrix
matrix(1:6, nrow=2)
matrix(1:6, nrow=2, byrow=T)
#byrow определяет как заполняется матрица

matrix(1:7, nrow = 2)

matrix(rep(1:5,3), nrow=3, ncol=5, byrow=F)
matrix(1:5, nrow=3, ncol=5, byrow=F)
matrix(1:5, nrow=2, ncol=4)
matrix(1:5, nrow=2, ncol=2)
x<-matrix(0,2,4)#матрица, состоящая из нулей размерности 2 на 4
x[1,1] <- "q"
x

m<-matrix(1:5, nrow=3, ncol=5, byrow=F)
m
#получить диагональные элементы матрицы
diag(m)

#создать диагональную матрицу
diag(c(1,5,7))

#создание единичной матрицы
diag(rep(1,4))
diag(4)

diag(4.5)

#имена столбцов и строк
rownames(m) <- c("a", "b", "c")
m
colnames(m)

#транспонирование матрицы
t(m)

#добавление столбца
m
v<-c(10,20,30)
m1<-cbind(m,v)
m1
colnames(m1)
cbind(c(10,20,30),m)

#добавление строки
d <- c(11,12,13,14,15,16)
m2 <- rbind(m1,d)
print(m2)

m2 <- cbind(m2,c(1,3,5))
m2

#**********************************************************************************************************************
#вектора - одномерные
#матрицы - двумерные
#массивы (array) - n-мерные, n=1,2,3,...

#1) изменить размерность
m<-matrix(1:30, nrow = 3)
m
class(m)

dim(m)<-c(3,5,2)
m
class(m)

#2) использование функции array
array(1:30, c(3,5,2))

#**********************************************************************************************************************
#доступ к элементам вектора, матрицы, массива
#[]
v <- seq(0, 1, length.out = 11)
v[5]
v[5] <- 10
v

#индекс - вектор
v[c(2,5,6)]
v[2,5,6]
#но не v[2,5,6]
v[3:6]
#все кроме
v[c(-2,-5,-6)]
v[-c(2,5,6)]

v[c(5,-3)] #ошибка
v[0]

#по имени
salary <- c(Ivanov = 300, Petrov = 500, Sidorov = 250)
salary["Ivanov"]

#в многомерном случае индексы указываются через запятую
m<-array(1:30,c(3,5,2))
m
m[1,,]
m[1,]
m[,1,]
m[,,1]
m[3,2,1]
m[3,c(1,4),-1][1]

m <- matrix(1:15, 3, 5)
rownames(m) <- c("a", "b", "c")
colnames(m) <- c("A", "B", "C", "D", "E")
m
m["a","D"]
m[1,"D"]

#по условию
v <- 1:10
cond <- c(T, F, T, T, F, T, F, F, T, F)
v[cond]
cond <- c(T, F, T, T, F, T, F, F, T, F, T)
v[cond]
v[c(T, F, T, NA, F, T, NA, F, T, F)]

cond <- c(T, F, T, T, F)
v[cond]

v
v>3
v[v>3 & v<7]#&& - логическое "и", которое возвращает только первое значение
v>3 & v <7

v[v%%3>0]

v[v%%c(3,2)>0]

v[v%%c(3,2)>c(0,1,2)]

#встроенные вектора
LETTERS[1:5]
letters[seq(2,12,2)]
month.name[9]
month.abb[9]

#*********************************************************************************************************************
#манипуляции с данными
seq(-5,6)
length(seq(-5,6))
rnorm(12)
(s <- seq(-5, 6) + rnorm(12))
plot(s)
segments(1,-5,12,6)

(s <- seq(-5,6) + c(-0.5, 0.3, 0.2))
plot(s)
segments(1,-5,12,6)

(s <- seq(-5, 6) + rnorm(3))
plot(s)
segments(1,-5,12,6)
(s <- seq(-5, 6) + rnorm(5))
plot(s)
segments(1,-5,12,6)

2^c(1,2,3)
c(2,3)^c(1,2,3)
s
mean(s)
(s - mean(s))
(s - mean(s))^2
sum((s - mean(s))^2)/(length(s)-1)
#вычисление дисперсии
var(s)


#+, -, *, /, ^
#log, exp, sin, cos, tan, sqrt, acos, asin, atan, cospi, sinpi, tanpi
cospi(.25)
cos(pi/4)

min(s)
max(s)
range(s)

#находхится первое появление минимального и максвимального элемента в векторе s
s
which.min(s)
which.max(s)
s <- c(s, min(s))
s
which.min(s)

pmin(seq(-5,7),s)#из заданных векторов поэлементно выбирает минимальные
pmax(s,0)

sqrt(16)
sqrt(-16)
sqrt(-16+0i)
sqrt(as.complex(16))

s
median(s)

log(2:4)
log(2:4, base = 3)
log10(2:4)
log2(2:4)

exp(s)

#вектор кумулятивных сумм
cumsum(s)
#вектор накопленных произведений
cumprod(s)
cummin(s)
cummax(s)

#Номера первых вхождений элементов первого аргумпнта во второй
z <- match(c(2,7,10), c(7,8,9,2,1,2))
z

c(2,7,10) %in% c(7,8,9,2,1,2)

s<-rpois(10,5)
s
(s == 6)
#нахождение вектора индексов для которых выполнено условие
s<-c(s,6)
s
which(s == 6)
seq(1,length(s))[s == 6]
#удаление повторяющихся элементов
unique(s)

choose(5, 3)#С из n по k

#выбор из выборки случайной подвыборки
sample(1:10, 3)
(s <- sample(1:10, replace = T, size = 7))
#приведение данных к стандартному виду
scale(s)

x <- c(1:10, 10:1)
x
x[is.element(x, c(9, 99, 999))] <- NA
x

x <- rnorm(10)
x
sort(x)

(a <- matrix(6:11, c(3,2)))
(b <- matrix(-3:4, c(2,4)))
a*b
(c<-a %*% b)
#определение размерности матрицы
dim(c)
nrow(c)
ncol(c)


a<- c(1,2,3)
b<- c(-1,2,5)
a*b
crossprod(a,b)
t(a)%*%b

a %*% t(b)
a %o% b

a <- matrix(c(1,4,3,2), c(2,2))
a
b <- c(2,5)
b
solve(a,b)
solve(a)

eigen(a)
e.values <- eigen(a)$values
e
e.values
e.values <- eigen(a, only.values = TRUE)$values
e.values

svd(matrix(1:6,nrow = 2))

#Порядок выполнения вычислений
#1) ^ - возведение в степень
#2) -+ - унарные операции
#3) : - оператор последовательности
#4) %/% %% - целочисленное умножение и деление
#5) * / - деление
#6) +- - бинарное сложение и умножение

2^3^2
(2^3)^2
2 + 3*3
2 + 1:3*3
