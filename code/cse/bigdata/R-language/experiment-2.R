install.packages("caret")

data(iris)
iris

train_list <- sample(nrow(iris), 0.7*nrow(iris))
train <- iris[train_list,]
test <- iris[-train_list,]

dim(iris)

sapply(iris, class)

head(iris)

a <- factor(iris$Species)
levels(a)

percentage <- prop.table(table(iris$Species)) * 100
percentage
cbind(freq=table(iris$Species), percentage=percentage)
freq=table(iris$Species)
iris$Species

summary(iris)

x <- iris[,1:4]
y <- iris[,5]

par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main=names(iris)[i])
}

plot(y)
