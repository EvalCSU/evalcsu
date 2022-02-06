#1. 假设有300 名学生，起始学号为210222001

xuehao <- c(210222001:210222300)
xuehao

mySeed <- 20

#2. 生成各科成绩

set.seed(mySeed)
gaoshu <- rnorm(300,70, sqrt(10));
gaoshu <- round(gaoshu);
gaoshu[gaoshu > 100] <- 100;
gaoshu[gaoshu < 0] <- 0;

set.seed(mySeed)
xiandai <- rnorm(300,0, sqrt(2));
xiandai <- round(xiandai);
xiandai <- xiandai + gaoshu;
xiandai[xiandai > 100] <- 100;
xiandai[xiandai < 0] <- 0;

set.seed(mySeed)
yingyu <- runif(300,56,99)
yingyu <- round(yingyu)

set.seed(mySeed);
chengshe <- rnorm(300,85,sqrt(12));
chengshe <- round(chengshe);
chengshe[chengshe > 100] <- 100;
chengshe[chengshe < 0] <- 0;


#3.把上述信息组合成数据框，并写到文本文件中


#生成数据框
classscore <- data.frame(xuehao,gaoshu,xiandai,yingyu,chengshe)

#写入文本文件
write.table(classscore,file = 'classscore.txt')

classscore
#4. 计算各科平均分，求出每人的平均成绩，总成绩

#各科的平均成绩
subjectMean <- apply(classscore[,2:5],2,mean)
subjectMean


#5.计算求各种指标

#每人的平均成绩
studentMean <- apply(classscore[,2:5],1,mean)
studentMean


#每人的最高分
studentMax <- apply(classscore[,2:5],1,max);
studentMax

#每人的最低分
studentMin <- apply(classscore[,2:5],1,min);
studentMin

#每人的总成绩
studentSum <- apply(classscore[,2:5],1,sum)
studentSum

#给每个人分数评级
y <- quantile(studentSum, c(.8,.6,.4,.2))
classscore$grade[studentSum >= y[1]] <- "A"
classscore$grade[studentSum >= y[2] & studentSum < y[1]] <- "B"
classscore$grade[studentSum >= y[3] & studentSum < y[2]] <- "C"
classscore$grade[studentSum < y[3]] <- "D"
classscore


#6. 求总分最高的同学的学号
classscore$xuehao[studentSum == max(studentSum)]

#7.绘高等数学成绩直方图、柱状图丶饼图；画高数和线代，高数和英语的散点图；画各科成绩的箱尾图
#直方图
hist(classscore$gaoshu,breaks = 9,main = '高等数学成绩直方图',xlab = '数学成绩')
#饼图???

y <- quantile(classscore$gaoshu, c(.8,.6,.4,.2))
gaoshuGrade <- c(1:300)
gaoshuGrade[classscore$gaoshu >= y[1]] <- "A"
gaoshuGrade[classscore$gaoshu >= y[2] & classscore$gaoshu < y[1]] <- "B"
gaoshuGrade[classscore$gaoshu >= y[3] & classscore$gaoshu < y[2]] <- "C"
gaoshuGrade[classscore$gaoshu < y[3]] <- "D"
gaoshuGrade
gaoshuTable <- table(gaoshuGrade)
gaoshuTable
pie(gaoshuTable)
barplot(gaoshuTable)

pie(classscore$gaoshu)
#柱状图???
barplot(classscore$gaoshu)

#画高数和线代散点图
plot(classscore$gaoshu,classscore$xiandai,pch = 20,xlab = '高数',ylab = '线代',main = '高数和线代')
  classscore$gaoshu
classscore$xiandai

classscore$gaoshu == classscore$xiandai

#画高数和英语散点图
plot(classscore$gaoshu,classscore$yingyu,xlab = '高数',ylab = '英语',main = '高数和英语')


#画各科成绩的箱尾图
boxplot(classscore$gaoshu,classscore$xiandai,classscore$yingyu,classscore$chengshe,main = '高数，线代，英语，程设成绩的箱尾图')

#星象图
stars(classscore[,2:5],full = TRUE,draw.segments = TRUE,key.loc=c(30,1.5))

#绘制高等数学与线性代数关系图
fit <- lm(classscore$xiandai ~ classscore$gaoshu,data = classscore)
plot(classscore$gaoshu,classscore$xiandai,xlab = '高数',ylab = '线代',main = '高数和线代')
abline(fit)

#install.packages("ggplot2")
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=xiandai)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&xiandai", x="gaoshu", y="xiandai")


#绘制高等数学与英语关系图
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=yingyu)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&yingyu", x="gaoshu", y="yingyu")

#10. 生成社会实践课成绩（A，B，C，D，E）并将其加入到classscore数据框
level<- c("A","B","C","D","E")
shijian<- sample(level,300, replace = TRUE)
classscore$shijian <- shijian
classscore

#15
shijianTable <- table(classscore$shijian)
shijianTable
plot(shijianTable)
pie(shijianTable)
