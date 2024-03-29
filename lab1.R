#Task 1

l <- nchar("Повколас")
l
v1 <- seq(from = 16, to = 6.5, length.out = l)
v1

i = 16

a = abs(13 - i) + 2
a

q = log(100/a, l-1)
q

v2 <- a * q ^ (0:(l-1))

v2

v3 <- sample(c(v1, v2), 3)
v3

#Task 2
#Задана некоторая строка текста, состоящая только из строчных символов русского языка. Например, s <- “приветмирр”. Алфавит можно задать в явном виде (alf <- "абвг...").
#1-ую букву строки s оставить без изменений, 2-ую – заменить на следующую в алфавите, 
#3-ую – заменить на стоящую через одну в алфавите и т.д. Например, s = "абвг" ответ должен быть "авдё".

alf <- 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
alf_v <- unlist(strsplit(alf, ''))
#s <- sample(alf_v, 10)
s <- unlist(strsplit('абвг', ''))

positions <- (0:(length(s) - 1))
alf_positions <- match(s, alf_v)
res_positions <- (alf_positions + positions) %% length(alf_v)
paste(alf_v[res_positions], collapse="")

#Task 3
v1
m_dim = 13
N = 16
n = (N-1) %% 12 + 1
names <- month.name[(n + (0:13)) %% 13]
data <- c(v1, v1[0:(m_dim - length(v1))])
m <- matrix(data = data, nrow = m_dim, ncol = m_dim, byrow = (v3[1] < 10), dimnames = list(names, names))
from_a_to_f <-c("April", "August", "December", "February")
to_remove <- which(rownames(m) %in% from_a_to_f)
m <- m[-to_remove, -to_remove]


m
(det(m))
(eigen(m))
(eigen(m)$values)
diag(m)

#Для матрицы m1 найти: определитель, собственные вектора и значения, 
#вектор диагональных элементов, v1^2 и матрицу v2, у которой v2[i][j] = (v1[i][j])2
# v1 - ??
m*m
#v2 = lapply(m, function(x) x*x)
#v2


#Task 4
#Создать произвольную таблицу данных, в которой должны присутствовать данные следующих типов: 
#числовые, текстовые, условные, факторы. Вывести все такие текстовые значения для заданного 
#фактора, для которых числовые значения больше заданного значения.


team.names <- c('Ronaldo', 'Messy', 'Domracheva', 'Ovechkin', 'Azarenko', 'Jordan')
team.gender <- c('M', 'M', 'F', 'M', 'F', 'M')
team.sport <- c('football', 'football', 'biathlon', 'hockey', 'tennis', 'basketball')
team.gender.factor <- factor(team.gender)
team.sport.factor <- factor(team.sport, levels = c('football', 'biathlon', 'hockey', 'tennis', 'basketball', 'chess'))
team.weight <- c(85, 70, 55, 100, 60, 95)
team.olympicChamp <- c(F, F, T, F, F, T)

team.frame <- data.frame(team.names, 
                         team.sport.factor, 
                         team.gender.factor, 
                         team.weight, 
                         team.olympicChamp, 
                         stringsAsFactors = F)

names(team.frame) <- c('Name', 'Sport', 'Gender', 'Weight', 'Olympic Champion')
(team.frame)
res <- subset(team.frame, Weight > 80 & Sport == 'football')
(team.frame[team.weight > 80 & team.sport == 'football', ])
res

team.gender.factor <- factor(team.gender)
team.gender.factor


#Task 5

d <- data.frame(c(1, 2, 3), 
                c(4, 5, 6), 
                c(7, 8, 9),
                stringsAsFactors = F)
names(d) <- c('x1', 'x2', 'x3')
d

res_v <- as.integer(d$x1 < d$x2 & d$x1 < d$x3) * (d$x3 - d$x1) * (d$x2 - d$x1) + as.integer(d$x2 > d$x3) * d$x1 * d$x1
sum(res_v)

calcS <- function(x) {
  as.integer(x[1] < x[2] & x[1] < x[3]) * (x[3] - x[1]) * (x[2] - x[1]) + as.integer(x[2] > x[3]) * x[1] * x[1]  
}

sum(apply(d, 1, calcS))
