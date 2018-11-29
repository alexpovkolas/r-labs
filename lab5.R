library(Rcpp)
library(tictoc)
sourceCpp("lab5.cpp")
source("lab2.R")


args <- sample.int(5000)
#args <- c(1071, 462, 42, 84, 12)

tic()

res.cpp <- gcd_v_cpp(args)


print('C++ result')
res.cpp
toc()


tic()

res.rr <- gcd_v(args)


print('R result ')
res.rr
toc()


