library(Rcpp)
library(tictoc)
sourceCpp("lab5.cpp")
source("lab2.r")


args <- sample(1:10000, 50)


tic()

res.cpp <- gcd_v_cpp(args)


print('C++ result')
res.cpp
toc()


tic()

res.r <- gcd_v(args)


print('R result ')
res.r
toc()


