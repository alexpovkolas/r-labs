rm(list = ls())
#********************************************************************************************************
#factors

wellness <- c(1,0,2,1,1,2)
wellness.f <- factor(wellness, levels=0:2)
wellness.f
levels(wellness.f) <- c("good", "medium", "bad")
wellness.f

#по умолчанию сортирует значения wellness в порядке возрастания
wellness.f <- factor(wellness)
levels(wellness.f) <- c("good", "medium", "bad")
wellness.f

wellness.f <- factor(wellness, levels=c(2,1,0))
levels(wellness.f) <- c("good", "medium", "bad")
wellness.f

#Узнать какие числа R ставит в соответствие фактору
as.numeric(wellness.f)

#узнать тукущие уровни вектора факторов
levels(wellness.f)

#статистика по вектору факторов
table(wellness.f)

#Другой способ создания факторов
gender <- c("male", "female", "female", "female", 
"male", "male", "female", "male", "female", "male")
gender.f <- factor(gender)
gender.f #уже не строки
gender
as.numeric(gender.f)

income <- c(100, 25, 45, 56, 40, 70, 80, 50, 88, 35)
#пример, где возникают факторы
tapply(income, gender.f, mean)
tapply(1:9, gender.f, mean) # размеры векторов должны совпадать

#Еще один способ задания факторов
(income.range <- cut(income, breaks = c(0, 40, 70, 100)))
levels(income.range) <- c("Low", "Medium", "High")
income.range
table(income.range)

table(gender.f, income.range)

#Упорядоченные факторы
#уровни необходимо задавать в возрастающем порядке
clsf1 <- ordered(c("first", "third", "second", "first", "second", "first", "fourth",
      "third", "fourth", "second", "third"), 
      levels <- c("fourth", "third", "second", "first"))
clsf1

#иначе
clsf2 <- ordered(c("first", "third", "second", "first", "second", "first", "fourth",
                   "third", "fourth", "second", "third"))
clsf2

#можно по другому
clsf1 <- factor(c("first", "third", "second", "first", "second", "first", "fourth",
                   "third", "fourth", "second", "third"), ordered = TRUE,
                 levels <- c("fourth", "third", "second", "first"))

clsf1

#*****************************************************************************************************************
#list хранит данные разных типов
#vector хранит данные только одного простого типа
m1 <- matrix(1:4, nrow = 2)
m2 <- matrix(2:5, nrow = 2)
m3 <- c(m1,m2) 
m3
class(m3)
#конкатинация 2-х матриц дает вектор чисел,
#а не вектор двух матриц

#list можно создать с помощью одноименной функции
ls <- list(name = "List", condition = FALSE, number = 1,
           vector = c(10, 20, 30, 50, 80))

ls <- list(name = "List", condition = FALSE, number = 1,
           vector = c(10, 20, 30, 50, 80), number = 2)
ls

#Получить доступ к i-ой компоненте с помощью [[]]
ls[[1]]
ls[1]
ls[[4]]
ls[4]
#однако это не самый удобный вариант, особенное если не 
#мы создавали список и не знаем в каком порядке идут компоненты

#2-ой способ использоть запись name$componentname
ls$condition <- TRUE
ls$number

#3-ий способ [["componentname"]]
ls[["condition"]]
#такое обращение может понадобится, если имя компоненты,
#к которой нам необходимо обратиться, храниться в переменной
x<-"vector"
ls[[x]][1]

#количество компонент можно узнать с помощью
length(ls)

#[[]] отличается от []
ls[[1]]
ls[1]
ls[[4]][1]
ls[4][1]

#R Допускает использовать не всё название поля
ls$c #ls$condition
ls$number

#The components used to form the list are copied 
#when forming the new list and the originals are not affected.

#К листы можно объединять
ls <- c(ls, list(matrix = diag(1:4)))
c(ls, c(1,2,3))
ls[[6]]

names(ls)

#Пример списка

m<-array(1:30,c(3,5,2))
dimnames(m)
dimnames(m) <- dimname<-list(letters[1:3],
     c("I", "II", "III", "IV", "V"), c("i", "ii"))
m

#********************************************************************************************************
#data frames

#A data frame is a list with class "data.frame". 
#There are restrictions on lists that may be made into data frames

#1) The components must be vectors (numeric, character, or logical), 
#factors, numeric matrices, lists, or other data frames.

#2) Matrices, lists, and data frames provide as many variables 
#to the new data frame as they have columns, elements, or variables, respectively.

#3) Numeric vectors, logicals and factors are included as is, 
#and by default character vectors are coerced to be factors, 
#whose levels are the unique values appearing in the vector.

#4) Vector structures appearing as variables of the data frame 
#must all have the same length, 
#and matrix structures must all have the same row size.

i <- seq(1,10,3)
n <- c("Igor", "Ivan", "Sam", "Jack")
c <- c(T, T, F, F)
d <- data.frame(ind = i, name = n, cond = c, stringsAsFactors = F)
d
d$name
d$name[2]

d[1]
d[1,]

d[[1]]
d[,1]

#добавление строки
(d <- rbind(d, list(13, "Petr", F)))

#еще один способ добавления строки
d[6,] <- list(16, "Olga", T)
d

#summary() дает статистику по каждому столбцу
summary(d)

#добавление новой "переменной"
(d <- cbind(d, c(1.5, 1.6, 1.7, 1.4, 1.3))) #ERROR!!!
#неправильная длина вектора.
(d <- cbind(d, c(1.5, 1.6, 1.7, 1.4, 1.3, 2.0)))
names(d)
names(d)[4] <- "Numbers"
d

#можно изменять имена строк (наблюдений)
rownames(d)


#Чтобы не использовать $
#можно data frame "присоединить" к текущему рабочему ...

rm(cond, ind)
cond <- FALSE
attach(d)


#теперь к переменным датафрэйма можно обращаться на прямую
ind
cond  #как обратиться к cond, которая пришла из d???
rm(cond)
cond

#Внимение! присоедененные переменные являются копиями 
#переменных исходного дата фрэйма
ind[1] <- ind[2]+ind[3]
ind
d$ind

d$ind[1] <- ind[3]+ind[4]
d$ind[1]
ind

#Отсоединить дата фрэйм
detach(d)
ind
cond

search()
attach(d)
search()

ls(1)
ls(2)
ls(3)

detach()

#**********************************************************************************************
#Access to internal data

#просмотр текущих доступных таблиц данных
data()

#просмотреть данные из пакета
data(package="survival")
attach(survival::cancer)
search()
detach(survival::cancer)

#присоединить данные из пакета
data(Machines, package="nlme")
Machines
detach(Machines)
detach(nlme::Machines)
search()
rm(Machines)

#Посмотреть первые записи таблицы
head(d)

#Посмотреть сруткуру объекта
str(d)
n <- 5
str(n)
