rm(list = ls())
#*****************************************************************
#управляющие конструкции в R
#констрвкция if в R
#if (expr1) expr2 else expr3
#expr может состоять более чем из одной команды, в этом случае они заключаются в {}

#пример, нахождение минимума из трех чисел
x1 <- 1;
x2 <- 5;
x3 <- -2;
if(x1 < x2){
  if(x1 < x3) min <- x1 else min <- x3
  print("!!!")
} else {
  if(x2 < x3) min <- x2 else min <- x3
}
print(min)
show(min)
str(min)

#но лучше так
min(c(x1,x2,x3))

#if (expr1) expr2
if(x1 > x2) print(x2)

#Надо быть аккуратным и писать код так, чтобы R понимал, к чему относится else
if(x1 > x2) print(x2) 
else print(x1)

{if(x1 > x2) print(x2) 
else print(x1)}

if(x1 > x2)  
  print(x2) else print(x1)

#Какие значения приводятся к logic
if(1) {"Truth!"} else {"Falsehood!"} #"Truth!"

if(-1) {"Truth!"} else {"Falsehood!"} #"Truth!"

if(0) {"Truth!"} else {"Falsehood!"} #"Falsehood!"

if("TRUE") {"Truth!"} else {"Falsehood!"} #"Truth!"

if("TRUTH") {"Truth!"} else {"Falsehood!"}
#Error in if ("TRUTH") { : argument is not interpretable as logical
if(T) {"Truth!"} else {"Falsehood!"} #"Truth!"

if(F) {"Truth!"} else {"Falsehood!"} #"Falsehood!"

if("T") {"Truth!"} else {"Falsehood!"} #"Truth!"

if("F") {"Truth!"} else {"Falsehood!"} #"Falsehood!"

if("c") {"Truth!"} else {"Falsehood!"}
#Error in if ("c") { : argument is not interpretable as logical
if(NULL) {"Truth!"} else {"Falsehood!"}
#Error in if (NULL) { : argument is of length zero
if(NA) {"Truth!"} else {"Falsehood!"}
#Error in if (NA) { : missing value where TRUE/FALSE needed
if(NaN) {"Truth!"} else {"Falsehood!"}
#Error in if (NaN) { : argument is not interpretable as logical

if(c(T, F)) {"Truth!"} else {"Falsehood!"}

if(c(F, T)) {"Truth!"} else {"Falsehood!"}

#логические операции
x <- c(1,0,0,1)
y <- c(1,1,0,0)

#|| логическое ИЛИ в случае применению в вектору 
#возвращает результат для первых компонент
z <- x||y
z
#| - поэлементное логическое ИЛИ
q <- x|y
q
#аналогично с & и &&

if(x|y) print(x) else print(y)

x <- c(x,1)
if(x && y) print(x) else print(y)

#цикл for
#for (index in loopvector) expr
x <- c(1, -2, 3, -4, 0)
y <- vector(length = length(x))

#пример: вернуть абсолютные значения вектора x
for(i in 1:length(x)) {
  if(x[i]>=0) y[i] = x[i]
  else y[i] = -x[i]
}
show(y)

#или даже так
x <- c(1, -2, 3, -4, 0)
y <- vector(length = length(x))
j <- 1;
for(i in x) {
  if(i>=0) y[j] = i
  else y[j] = -i
  j <- j + 1
}
show(y)

#но лучше
abs(y)

#цикл while
#while(condition) expr

#пример: все элементы вектора x уменьшаются до тех пор,
#пока хотя бы 1 не станет отрицательным
x <- c(3, 4.5, 2.5, 7,4)
while(min(x) >= 0) {
  x <- x - 1
}
str(x)

#цикл repeat
#repeat - бесконечный цикл, 
#break - выход из текущего цикла

#пример, делающий тоже и самое
x <- c(3, 4.5, 2.5, 7,4)
repeat {
  if(min(x) < 0) break()
  x <- x - 1
}
show(x)

#next - переход к следующей итерации текущего цикла

for(i in 1:5) {
  if(i == 3) next()
  print(i)
}

#логическое индексирование
x <- c(1, -2, 3, -4, 0)
y <- numeric(length = length(x))
c <- x>=0
c
y[c] <- x[c];
y
y[!c] <- -x[!c];
cat("The result", y, "\n", sep = "~")

#ifelse (conditionvector, vectorT, vectorF)
rm(list = c("x", "y"))
#rm(c("x", "y"))
x <- c(1, -2, 3, -4, 0)
y <- ifelse(x<0, -x, x)
print(y)


#replicate(n, expr)
set.seed(123) # always we will have the same random numbers
t0 <- proc.time()
N <- 10000;
t <- 10000;
y <- var(replicate(N, mean(rnorm(t, 1, 2))))
t1 <- proc.time()
print(y)
print(t1-t0)
#7.79

set.seed(123)
t0 <- proc.time()
N <- 10000;
t <- 10000;
x <- numeric(length = N)
for(i in 1:N) x[i] = mean(rnorm(t, 1, 2))
y <- var(x)
t1 <- proc.time()
print(y)
print(t1-t0)
#7.55

#****************************************************************
#создание собственных функций
fun1 <- function(a,b,c){
  res <- a+b*c;
  return (res)
}

fun1(c(1,2,3), 2, c(4,5,6))

#функции return может не быть, в этом случае
#создаваемая функция возвращает результат выполения последней команды
fun1 <- function(a,b,c){
  a+b*c
}

fun1(c(1,2,3), 2, c(4,5,6))

#return -- функция!!!
fun1 <- function(a,b,c){
  res <- a+b*c;
  print(res)
  return (res+1)*2     #вернется res+1, а не 2*res+5
}

fun1(c(1,2,3), 2, c(4,5,6))

#функция с произвольным числом параметров
fun1 <- function(s, ...){
  res <- s+..1;
  return (res)
}

fun1(c(1,2,3), 2, 3)

fun1 <- function(...) return (length(list(...)))
fun1(c(1,2,3), 2, 5)

fun1 <- function(...){
  #i <- 1
  #print(..i)
  l <- list(...)
  return (l[[1]] + l[[length(l)]])
}
fun1(c(1,2,3), 2, 3)

fun1 <- function(..., b){
  return (..1 + b)
}
fun1(c(1,2,3), 2, b = 3)
fun1(c(1,2,3), 2, 3)

#локальные и глобальные переменные
a <- 10
b <- 20
c <- 30

f <-function (a){
  b <- 2 * a + 1
  print(a)
  print(b)
  print(c)
  return(b)
}
#переменные a,b локальные

f(5)

print(a)
print(b)
print(c)

#суперприсваивание
f1 <- function (a){
  b <<- 2 * a + 1 #superassignment
  print(a)
  print(b)
  print(c)
  return(b)
}

f1(5)

print(a)
print(b)
print(c)

#рекурсия
sumsqr <- function (n) {
  if(n == 1) return(1)
  else return(n^2 + sumsqr(n-1))
}
sumsqr(2)

#функция, возвращающая функцию
power <- function(exponent) {
  function(x) x ^ exponent
}

square <- power(2)
square(2) # -> [1] 4
square(4) # -> [1] 16

cube <- power(3)
cube(2) # -> [1] 8
cube(4) # -> [1] 64

#функция, принимающая функцию в качестве аргумента
fun1 <- function(calc, a){
  print(a)
  return(calc(a))
}

incr <- function(a) return(a+1)
decr <- function(a) return(a-1)

fun1(incr, 5)
fun1(decr, 5)

fun1(1,2)
#ошибка - 1 - это не функция!

#значения аргументов по умолчанию
f <- function(x, y, condition = identical(x, y), scale = 100){
  if(condition) return(x^{2} * scale / 100)
  else return((x + y) * scale / 100)
}
f(1:3, 1:3)
f(1:3, 1:3, condition = FALSE)
f(1:3, 1:6, scale = 50)
f(1:3, 1:6, TRUE, scale = 50)

#создание собственных бинарных операций
#"%operator%" <- function (x, y) {...}

"%plus%" <- function (x,y) return(ifelse(x>y, 2*x+y, 2*y + x))
a <- c(1,3,5)
b <- c(6,3,2)
a %plus% b
%plus%(a,b)

#если не использовать знак %, то получим обычную функцию
"plus" <- function (x,y) return(ifelse(x>y, 2*x+y, 2*y + x))
a plus b
plus(a,b) #????? ?????? ???

#можно переопределять стандартные операторы, но не стоит этого делать
"+" <- function(x,y) return(x-y)
a + b
rm('+')
a + b

mysqr <- function (x) {
  stopifnot(is.numeric(x))
  return(x^2)
}
mysqr(1:3)
mysqr("q")