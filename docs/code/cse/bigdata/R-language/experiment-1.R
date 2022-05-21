#1. ������300 ��ѧ������ʼѧ��Ϊ210222001

xuehao <- c(210222001:210222300)
xuehao

mySeed <- 20

#2. ���ɸ��Ƴɼ�

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


#3.��������Ϣ��ϳ����ݿ򣬲�д���ı��ļ���


#�������ݿ�
classscore <- data.frame(xuehao,gaoshu,xiandai,yingyu,chengshe)

#д���ı��ļ�
write.table(classscore,file = 'classscore.txt')

classscore
#4. �������ƽ���֣����ÿ�˵�ƽ���ɼ����ܳɼ�

#���Ƶ�ƽ���ɼ�
subjectMean <- apply(classscore[,2:5],2,mean)
subjectMean


#5.���������ָ��

#ÿ�˵�ƽ���ɼ�
studentMean <- apply(classscore[,2:5],1,mean)
studentMean


#ÿ�˵���߷�
studentMax <- apply(classscore[,2:5],1,max);
studentMax

#ÿ�˵���ͷ�
studentMin <- apply(classscore[,2:5],1,min);
studentMin

#ÿ�˵��ܳɼ�
studentSum <- apply(classscore[,2:5],1,sum)
studentSum

#��ÿ���˷�������
y <- quantile(studentSum, c(.8,.6,.4,.2))
classscore$grade[studentSum >= y[1]] <- "A"
classscore$grade[studentSum >= y[2] & studentSum < y[1]] <- "B"
classscore$grade[studentSum >= y[3] & studentSum < y[2]] <- "C"
classscore$grade[studentSum < y[3]] <- "D"
classscore


#6. ���ܷ���ߵ�ͬѧ��ѧ��
classscore$xuehao[studentSum == max(studentSum)]

#7.��ߵ���ѧ�ɼ�ֱ��ͼ����״ͼؼ��ͼ�����������ߴ���������Ӣ���ɢ��ͼ�������Ƴɼ�����βͼ
#ֱ��ͼ
hist(classscore$gaoshu,breaks = 9,main = '�ߵ���ѧ�ɼ�ֱ��ͼ',xlab = '��ѧ�ɼ�')
#��ͼ???

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
#��״ͼ???
barplot(classscore$gaoshu)

#���������ߴ�ɢ��ͼ
plot(classscore$gaoshu,classscore$xiandai,pch = 20,xlab = '����',ylab = '�ߴ�',main = '�������ߴ�')
  classscore$gaoshu
classscore$xiandai

classscore$gaoshu == classscore$xiandai

#��������Ӣ��ɢ��ͼ
plot(classscore$gaoshu,classscore$yingyu,xlab = '����',ylab = 'Ӣ��',main = '������Ӣ��')


#�����Ƴɼ�����βͼ
boxplot(classscore$gaoshu,classscore$xiandai,classscore$yingyu,classscore$chengshe,main = '�������ߴ���Ӣ�����ɼ�����βͼ')

#����ͼ
stars(classscore[,2:5],full = TRUE,draw.segments = TRUE,key.loc=c(30,1.5))

#���Ƹߵ���ѧ�����Դ�����ϵͼ
fit <- lm(classscore$xiandai ~ classscore$gaoshu,data = classscore)
plot(classscore$gaoshu,classscore$xiandai,xlab = '����',ylab = '�ߴ�',main = '�������ߴ�')
abline(fit)

#install.packages("ggplot2")
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=xiandai)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&xiandai", x="gaoshu", y="xiandai")


#���Ƹߵ���ѧ��Ӣ���ϵͼ
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=yingyu)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&yingyu", x="gaoshu", y="yingyu")

#10. �������ʵ���γɼ���A��B��C��D��E����������뵽classscore���ݿ�
level<- c("A","B","C","D","E")
shijian<- sample(level,300, replace = TRUE)
classscore$shijian <- shijian
classscore

#15
shijianTable <- table(classscore$shijian)
shijianTable
plot(shijianTable)
pie(shijianTable)