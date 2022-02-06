[TOC]







## 一、实验目的



1. 掌握R语言数据结构； 

2. 掌握R语言绘制直方图、密度估计曲线、经验分布图和QQ图的方法；

3. 掌握R语言绘制茎叶图、箱线图的方法；

4. 掌握描述性统计分析中常用的统计量；

5. 掌握R语言简单线性回归分析；

6. 掌握R语言的各项功能和函数，能够通过完成试验内容对R语言有一定的了解，会运用软件对数据进行分析。

 



## 二、实验环境

Windows系统，RGui（32-bit）





## 三、实验内容

### 1.生成classscore数据框

```R
xuehao <- c(210222001:210222300)
xuehao
```

 set.seed()值设置为自己的上课序号。

```R
mySeed = 20;
set.seed(mySeed);
```

**经查阅资料可知，在每次调用rnorm()函数之前都要进行一次set.seed()，否则rnorm()函数就会用随机种子。**



#### 生成各科成绩

- #### 设高等数学成绩满足正态分布，平均分为70分，方差为10

```R
set.seed(mySeed)
gaoshu <- rnorm(300,70, sqrt(10));
gaoshu <- round(gaoshu);
gaoshu[gaoshu > 100] <- 100;
gaoshu[gaoshu < 0] <- 0;
```

- #### 线性代数成绩为高等数学成绩基础上加上一个均值为0，方差为2的扰动后取整的成绩

```R
set.seed(mySeed)
xiandai <- rnorm(300,0, sqrt(2));
xiandai <- round(xiandai);
xiandai <- xiandai + gaoshu;
xiandai[xiandai > 100] <- 100;
xiandai[xiandai < 0] <- 0;
```

- #### 英语成绩满足均匀分布，最低分为56分，最高分为99分

```R
set.seed(mySeed)
yingyu <- runif(300,56,99)
yingyu <- round(yingyu)
```

- #### 程序设计成绩满足正态分布，平均分85，方差为12

```R
set.seed(mySeed);
chengshe <- rnorm(300,85,sqrt(12));
chengshe <- round(chengshe);
chengshe[chengshe > 100] <- 100;
chengshe[chengshe < 0] <- 0;
```

- #### 生成数据框并写入文本文件中

```R
#生成数据框
classscore <- data.frame(xuehao,gaoshu,xiandai,yingyu,chengshe)

#写入文本文件
write.table(classscore,file = 'classscore.txt')
```



#### 生成数据框

```R
       xuehao gaoshu xiandai yingyu chengshe
1   210222001     75      77     96       90
2   210222002     69      69     88       84
3   210222003     69      68     73       84
4   210222004     71      71     89       86
5   210222005     68      67     70       83

.....

295 210222295     73      74     77       88
296 210222296     73      74     95       88
297 210222297     69      69     58       84
298 210222298     78      82     65       94
299 210222299     71      71     92       86
300 210222300     67      66     94       81
```



#### 写入classscore.txt文件



![image-20211115141757702](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115141804.png)





### 2. 计算求各种指标



#### 各科的平均成绩

```r
> subjectMean <- apply(classscore[,2:5],2,mean)
> subjectMean
  gaoshu  xiandai   yingyu chengshe 
70.03333 70.03667 78.39000 85.04667
```



#### 每个人的平均成绩

```R
> studentMean <- apply(classscore[,2:5],1,mean)
> studentMean
  [1] 84.50 77.50 73.50 79.25 72.00 71.00 79.00 74.75 75.75 78.50 73.75 77.00 73.25 80.50 67.50 70.25
 [17] 80.25 79.00 78.50 73.50 74.00 76.25 74.00 65.25 71.25 73.50 75.25 73.75 73.50 85.50 75.25 77.25
 [33] 80.25 81.50 75.00 79.25 77.00 79.50 73.25 72.00 71.25 75.50 79.75 79.00 73.50 74.50 74.00 77.75
 [49] 77.00 79.75 71.25 76.50 77.00 83.50 68.00 75.75 78.75 69.75 83.50 71.00 75.50 75.50 75.25 70.50
......
```



#### 每个人的最高分

```R
> studentMax <- apply(classscore[,2:5],1,max);
> studentMax
  [1] 96 88 84 89 83 81 88 85 89 89 87 86 90 94 80 85 93 91 89 87 86 88 84 77 86 83 83 84 88 97 85 85
 [33] 90 98 84 90 93 97 88 81 85 91 91 89 84 89 90 90 85 91 82 87 90 99 81 88 90 84 99 81 84 88 84 82
 [65] 95 79 90 82 89 83 95 90 91 97 82 79 90 89 90 86 87 89 97 96 85 83 94 79 86 89 93 88 96 83 96 93
......
```



#### 每个人的最低分

```R
> studentMin <- apply(classscore[,2:5],1,min);
> studentMin
  [1] 75 69 68 71 67 66 73 66 67 70 63 69 61 71 62 56 71 70 73 63 64 70 69 60 57 68 67 64 59 78 70 70
 [33] 74 71 68 74 66 68 58 64 60 57 71 74 69 59 56 69 70 71 66 72 66 73 61 68 70 57 73 61 69 67 69 65
......
```



#### 每个人的总成绩

```R
> studentSum <- apply(classscore[,2:5],1,sum)
> studentSum
  [1] 338 310 294 317 288 284 316 299 303 314 295 308 293 322 270 281 321 316 314 294 296 305 296 261
 [25] 285 294 301 295 294 342 301 309 321 326 300 317 308 318 293 288 285 302 319 316 294 298 296 311
......
```



#### 给每个人分数评级

首先计算出总成绩的4个五分位数，然后根据总成绩落在的区间将学生的成绩评为A,B,C,D四个区间

```R
> y <- quantile(studentSum, c(.8,.6,.4,.2))
> classscore$grade[studentSum >= y[1]] <- "A"
> classscore$grade[studentSum >= y[2] & studentSum < y[1]] <- "B"
> classscore$grade[studentSum >= y[3] & studentSum < y[2]] <- "C"
> classscore$grade[studentSum < y[3]] <- "D"
> classscore
       xuehao gaoshu xiandai yingyu chengshe grade
1   210222001     75      77     96       90     A
2   210222002     69      69     88       84     B
3   210222003     69      68     73       84     D
4   210222004     71      71     89       86     B
5   210222005     68      67     70       83     D
6   210222006     67      66     70       81     D
7   210222007     73      74     81       88     B
8   210222008     67      66     85       81     D
9   210222009     73      74     67       89     C
10  210222010     70      70     89       85     B
......
```



#### 求总分最高的同学的学号

```R
> classscore$xuehao[studentSum == max(studentSum)]
[1] 210222170
```

总分最高同学的学号，即分数等于最高分的同学的学号





### 3.图像的绘制



#### 绘高等数学成绩直方图

```R
hist(classscore$gaoshu,breaks = 9,main = '高等数学成绩直方图',xlab = '数学成绩')
```

![image-20211115151045603](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115151045.png)

#### 饼状图

先对数学成绩进行评级，并统计每个级别分别有多少人

```R
> y <- quantile(classscore$gaoshu, c(.8,.6,.4,.2))
> gaoshuGrade <- c(1:300)
> gaoshuGrade[classscore$gaoshu >= y[1]] <- "A"
> gaoshuGrade[classscore$gaoshu >= y[2] & classscore$gaoshu < y[1]] <- "B"
> gaoshuGrade[classscore$gaoshu >= y[3] & classscore$gaoshu < y[2]] <- "C"
> gaoshuGrade[classscore$gaoshu < y[3]] <- "D"
> gaoshuGrade
  [1] "A" "D" "A" "D" "C" "B" "D" "D" "C" "D" "C" "C" "D" "A" "D" "C" "A" "C" "C" "B" "B" "C" "B" "B" "C" "D" "D" "D"
 [29] "D" "D" "C" "A" "A" "A" "D" "D" "D" "A" "C" "B" "D" "D" "B" "C" "D" "C" "A" "A" "A" "C" "A" "C" "B" "A" "B" "C"
 [57] "A" "C" "D" "B" "C" "C" "C" "D" "A" "D" "A" "D" "A" "D" "B" "D" "A" "D" "A" "B" "C" "C" "D" "C" "C" "A" "C" "C"
 [85] "B" "D" "C" "C" "A" "A" "A" "D" "B" "C" "C" "B" "A" "A" "D" "C" "B" "C" "A" "B" "A" "C" "C" "C" "B" "D" "A" "A"

......

> gaoshuTable <- table(gaoshuGrade)
> gaoshuTable
gaoshuGrade
 A  B  C  D 
76 63 66 95 
```



画出饼状图：

```R
pie(gaoshuTable)
```

![image-20211116082510213](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211116082531.png)

可以看出，四个等级中，D级相对较多，C级相对较少



#### 柱状图

```R
barplot(gaoshuTable)
```

![image-20211116082846407](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211116082846.png)



#### 画高数和线代散点图

```R
plot(classscore$gaoshu,classscore$xiandai,xlab = '高数',ylab = '线代',main = '高数和线代')
```

![image-20211115190155514](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115190155.png)

#### 画高数和英语散点图

```R
plot(classscore$gaoshu,classscore$yingyu,xlab = '高数',ylab = '英语',main = '高数和英语')
```

![image-20211115190944588](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115190944.png)



#### 画各科成绩的箱尾图

```R
boxplot(classscore$gaoshu,classscore$xiandai,classscore$yingyu,classscore$chengshe,main = '高数，线代，英语，程设成绩的箱尾图')
```

![image-20211115191024537](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115191024.png)



#### 星象图

```R
stars(classscore[,2:5],full = TRUE,draw.segments = TRUE,key.loc=c(30,1.5))
```

![image-20211115191138286](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115191138.png)

按照右下角的图例，每个图的红色，黑色，蓝色，绿色分别代表线代、高数、程设、英语的成绩，色块的大小代表成绩的高低。



#### 绘制高等数学与线性代数关系图

```R
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=xiandai)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&xiandai", x="gaoshu", y="xiandai")
```

![image-20211115200724108](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115200724.png)



#### 高数和英语的关系图

```R
library(ggplot2)
ggplot(data=classscore, aes(x=gaoshu, y=yingyu)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="gaoshu&yingyu", x="gaoshu", y="yingyu")
```



![image-20211115200832356](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115200832.png)

#### 生成社会实践课成绩并进行统计

```R
level<- c("A","B","C","D","E")
shijian<- sample(level,300, replace = TRUE)
classscore$shijian <- shijian
```



**使用table()函数统计社会实践课程得（A，B，C，D，E）的人数**

```R
shijianTable <- table(classscore$shijian)
shijianTable
```

```R
 A  B  C  D  E 
57 61 64 65 53
```



**用plot()函数绘制社会实践课程得分分布情况。**

```R
plot(shijianTable)
```

![image-20211115203005337](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115203005.png)





**用pie()函数绘制社会实践课程得分分布情况。**

```R
pie(shijianTable)
```

![image-20211115203013249](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211115203013.png)

从饼状图可以看出，社会实践课中各个等级的成绩数量大概相等。



## 四.实验总结

通过本次实验，我更加熟练的掌握了R语言的数据结构，并且对各种图像的绘制有了更深的理解。掌握了描述性统计分析中常用的统计量，掌握了R语言的简单线性回归分析。并对常用的函数有了更熟练的掌握。

在实验过程中，也遇到了一些问题，主要的解决方式是查阅课本和老师发的PPT，并且在网上查阅相关资料。