rm(list = ls())
#********************************************************************************************************
#семейство функции вида _apply

#apply
#Returns a vector or array or list of values 
#obtained by applying a function 
#to margins of an array or matrix.
# create a matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
m
# mean of the rows
apply(m, 1, mean)
# mean of the columns
apply(m, 2, mean)
# divide all values by 2
apply(m, 1:2, function(x) x/2)
m
m/2
apply(m, 2:1, print)

data1 <- data.frame(col1 = m[,1], col2 = m[,2], col3 = sample(1:10, 10, replace = T))
data1

apply(data1, 1, mean)
dim(data1)
apply(data1, 2, mean)

list1 <- list(col1 = m[,1], col2 = m[,2], col3 = sample(1:10, 10, replace = T))
list1
apply(list1, 1, mean)
dim(list1)
apply(list1, 2, mean)

##lapply
#lapply returns a list of the same length as X, 
#each element of which is the result of applying FUN 
#to the corresponding element of X
l <- list(a = 1:10, b = 11:20)
# the mean of the values in each element
lapply(l, mean)
# the sum of the values in each element
lapply(l, sum)

lapply(m, mean)
lapply(1:5, sum)
lapply(data1, mean)

##sapply
#?????????? ??????, ??????? ??? ??????
l <- list(a = 1:10, b = 11:20)
l.mean <- sapply(l, mean)
class(l.mean)
l.mean
l.mean[['a']]
l.mean['a']

sapply(m, mean)
sapply(1:5, function(x) x^2) #??? ??????
(1:5)^2
sapply(data1, is.numeric)
is.numeric(data1)

#vapply
#vapply is similar to sapply, but 
#has a pre-specified type of return value, 
#so it can be safer (and sometimes faster) to use.
fivenum(1:4)
l <- list(a = 1:10, b = 11:20)
l.fivenum <- vapply(l, fivenum, c(Min.=0, "1st Qu."=0, Median=0, "3rd Qu."=0, Max.=0))
l.fivenum
l.fivenum <- vapply(l, fivenum, numeric(5))
l.fivenum
class(l.fivenum)
l.fivenum
sapply(l, fivenum)
vapply(l, fivenum) #????
vapply(l, mean, FUN.VALUE = c("M" = 0))

replicate(10, rnorm(10))
sapply(1:10, function(x) rnorm(10))
vapply(1:10, function(x) rnorm(10), numeric(10))

#mapply
#mapply is a multivariate version of sapply. 
#mapply applies FUN to the first elements of each argument, 
#the second elements, the third elements, and so on.

l1 <- list(a = c(1:10), b = c(11:20))
l1
l2 <- list(c = c(21:30), d = c(31:40))
l2
# sum the corresponding elements of l1 and l2
mapply(sum, l1$a, l1$b, l2$c, l2$d)
mapply(sum, data1)
mapply(sum, data1$col1, data1$col2, data1$col3)
apply(data1, 1, sum)

mapply(sum, l1)
mapply(sum, m)

mapply(rep, 1:4, 4:1)
mapply(rep, times = 1:4, x = 4:1)

#rapply
l <- list(a = 1:10, b = 11:20)
# log2 of each value in the list
rapply(l, log2)
l
rapply(l, log2, how = "list")
rapply(l, mean)
rapply(l, mean, how = "list")

#tapply
attach(iris)
# mean petal length by species
tapply(iris$Petal.Length, Species, mean)
detach(iris)

#**********************************************************************************************
#Options
#???????? ????????? R ????? ? ??????? ??????? options()
options()
options("digits")
options()$digits

options(digits = 15)
print(pi)
options(digits = 7)
print(pi^3)
print(10^8+1)

#**********************************************************************************************
#Conditions: message, warning, error

#За предупреждения отвечает параметр warn
options("warn")

#по умолчанию такая запись даст предупреждение
x <- 1:5 + 1:4
# если warn < 0, то предупреждения игнорируются
options(warn = -1)
x <- 1:5 + 1:4

# если warn >= 2, то предупреждения становяться ошибками 
# и выполнение программы прекращается
options(warn = 2)
x <- 1:5 + 1:4

# если warn = 1, то предупреждения будут возникать прямо в том месте, 
#где они были сгенерированы
options(warn = 1)
e = function(){
  x <- 1:5 + 1:4
  print(x)
}
e()

#если warn = 0, то предупреждения будут возникать, когда управление выйдет
#из функции
options(warn = 0)
e()

#для генерации предупреждения используется функция warning()
testit <- function() warning("testit")
testit() ## shows call
testit <- function() warning("problem in testit", call. = FALSE)
testit() ## no call

#для того, чтобы не было генерации предупреждений
#можно использовать функцию suppressWarnings()
suppressWarnings(testit())

options(warn = 2)
suppressWarnings(warning("testit"))
options(warn = 0)

#для генерации ошибки используется функция stop
iter <- 12
if(iter > 10) stop("too many iterations")

testit <- function(){
  stop("testit")
  print("yahoo!!!")
}
testit()

testit <- function(){
  stop("testit", call. = FALSE)
  print("yahoo!!!")
}
testit()

#функция suppressWarnings() не подавляет ошбики
suppressWarnings(testit())

# функция для перехвата ошибок и предупреждений
# result = tryCatch({
#   expr
# }, warning = function(w) {
#   warning-handler-code
# }, error = function(e) {
#   error-handler-code
# }, finally = {
#   cleanup-code
# })

r<-tryCatch(1, finally = print("Hello"))
r

out <- tryCatch(
  {
    # 'tryCatch()' will return the last evaluated expression 
    # in case the "try" part was completed successfully
    
    message("This is the 'try' part")
    readLines(con="http://127.0.0.1:31381/doc/html/index.html", warn = T) 
  },
  error=function(cond) {
    message(paste("URL does not seem to exist"))
    message("Here's the original error message:")
    message(cond)
    return(NA)
  },
  warning=function(cond) {
    message(paste("URL caused a warning"))
    message("Here's the original warning message:")
    message(cond)
    return(NULL)
  },
  finally={
    message("\nSome other message at the end")
  }
) 

out

options(warn = 2)

out <- tryCatch(
  {
    message("This is the 'try' part")
    readLines(con="12345", warn = T) 
  },
  error=function(cond) {
    message(paste("URL does not seem to exist"))
    message("Here's the original error message:")
    message(cond)
    return(NA)
  },
  finally={
    message("\nSome other message at the end")
  }
)

out
options(warn = 0)

library(tools)
f = function(){
  print("Hello world!!!")
  assertError(sqrt("abc"))
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertError(sqrt(4))
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertError(sqrt("abc"), verbose = T)
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertWarning(sqrt("abc"), verbose = F)
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertCondition(sqrt("abc"), "warning")
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertCondition(sqrt("abc"), "error")
  print("lalala")
}
f()

f = function(){
  print("Hello world!!!")
  assertCondition(message("1244!!"), "message")
  print("lalala")
}
f()
detach(package:tools)

f = function(){
  print("Hello world!!!")
  stopifnot(1>2)
  print("lalala")
}
f()