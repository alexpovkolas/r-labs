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
paste(alf_v[res], collapse="")

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
m*m
v2
#Для матрицы m1 найти: определитель, собственные вектора и значения, 
#вектор диагональных элементов, v1^2 и матрицу v2, у которой v2[i][j] = (v1[i][j])2
# v1 - ??


#Task 4





