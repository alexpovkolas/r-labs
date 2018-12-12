library(MASS)

mu <- c(4.23, 3.01, 2.91)
stddev <- c(1.23, 0.92, 1.32)

corMat <- matrix(c(1, 0.78, 0.23,
                   0.78, 1, 0.27,
                   0.23, 0.27, 1),
                 ncol = 3)
covMat <- stddev %*% t(stddev) * corMat

res <- mvrnorm(n = 100, mu = mu, Sigma = covMat, empirical = FALSE)
res<-as.data.frame(matrix(res, nrow =10, ncol = 4, byrow=T))


# ???????????????? ????????????????????????????????????????
cor(res)
regmodel <- lm(data = res)
summary(regmodel)

shapiro.test(res$V2)
shapiro.test(res$V3)
shapiro.test(res$V4)


df <- read.csv(file="c:\\Projects\\R\\1\\Lab3Task2Var6.csv")
head(df, 2)
#plot(y~x, data = df, pch = 20)

# we use taylor sequence for sin(ax)
# ax-(ax)^3/3! + (ax)^5/5!.... = b0 + b1x+b2*x^3 +b3*x5+.....
lm.fit <- lm(y ~ poly(x, degree = 11), data = df)
summary(lm.fit)

df$predicted <- predict(lm.fit)
head(df)

#plot(y~x, data = df, pch = 20)
#lines(df$x[order(df$x)], df$predicted[order(df$x)], col = 'red', lwd = 2)


fn <- function(par,  x) {
  mean((x$y - par[1] - par[2]*sin(par[3]*x$x))^2)
}

# nlm optimization 
nlm.optim <- nlm(p = c(1, 0.5, 10), f = fn, x = df, iterlim =1e3)
y.hat <- nlm.optim$estimate[1] + nlm.optim$estimate[2]*sin(nlm.optim$estimate[3]*df$x)

# plot
plot(y~x, data = df, pch = 16)
lines(df$x[order(df$x)], df$predicted[order(df$x)], col = 'red')
lines(df$x[order(df$x)], y.hat[order(df$x)], col = 'blue')



df_initial <- read.csv(file="c:\\Projects\\R\\1\\Lab3Task3Var6.csv")


df<-na.omit(df_initial)
cor(df)

lm.fit <- lm(y ~.,data = df)
df$predicted <- predict(lm.fit)


i<-1
copy <- df_initial
copy[,sprintf("x.%d",i)]<-0
first_y<-predict(lm.fit, copy)

i<-2
copy <- df_initial
copy[,sprintf("x.%d",i)]<-0
second_y<-predict(lm.fit, copy)

i<-3
copy <- df_initial
copy[,sprintf("x.%d",i)]<-0
third_y<-predict(lm.fit, copy)

i<-4
copy <- df_initial
copy[,sprintf("x.%d",i)]<-0
foth_y<-predict(lm.fit, copy)

res<- data.frame(first_y,second_y, third_y, foth_y)
res



