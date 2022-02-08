# Data Analysis

## Statistical Analysis

### 1. 描述性分析统计

```r
myvars <- c("mpg", "hp", "wt")
# summary()
summary(mtcars[myvars])
      mpg              hp              wt       
 Min.   :10.40   Min.   : 52.0   Min.   :1.513  
 1st Qu.:15.43   1st Qu.: 96.5   1st Qu.:2.581  
 Median :19.20   Median :123.0   Median :3.325  
 Mean   :20.09   Mean   :146.7   Mean   :3.217  
 3rd Qu.:22.80   3rd Qu.:180.0   3rd Qu.:3.610  
 Max.   :33.90   Max.   :335.0   Max.   :5.424

# sapply(x, FUN, options)
myfun <- function(x) c(mean=mean(x), max=max(x), min=min(x))
sapply(mtcars[myvars], myfun)
##           mpg       hp      wt
## mean 20.09062 146.6875 3.21725
## max  33.90000 335.0000 5.42400
## min  10.40000  52.0000 1.51300

# Hmisc的describe()
library(Hmisc)
describe(mtcars[myvars])

# pastecs包的stat.desc()函数
library(pastecs)
stat.desc(mtcars[myvars])

# pysch包的describe()
library(pysch)
describe(mtcars[myvars]) # PS同名函数最后载入的包优先

# 分组统计
# aggregate
aggregate(mtcars[myvars], by=list(am=mtcars$am), mean)
##   am      mpg       hp       wt
## 1  0 17.14737 160.2632 3.768895
## 2  1 24.39231 126.8462 2.411000
aggregate(mtcars[myvars], by=list(mtcars$am), mean)
##   Group.1      mpg       hp       wt
## 1       0 17.14737 160.2632 3.768895
## 2       1 24.39231 126.8462 2.411000
# 但无法一次返回多个变量，所以采用by(data, INDICES, FUN)函数
by(mtcars[myvars], mtcars$am, function(x) sapply(x, myfun))
## mtcars$am: 0
##           mpg       hp       wt
## mean 17.14737 160.2632 3.768895
## max  24.40000 245.0000 5.424000
## min  10.40000  62.0000 2.465000
## ------------------------------------------------ 
## mtcars$am: 1
##           mpg       hp    wt
## mean 24.39231 126.8462 2.411
## max  33.90000 335.0000 3.570
## min  15.00000  52.0000 1.513

```

### 2. 频数表与列联表

```r
library(vcd)
# 生成一维列联表
mytable <- table(Arthritis$Improved)
## mytable
  None   Some Marked 
    42     14     28

# 转化为频率表
prop.table(mytable)
##      None      Some    Marked 
## 0.5000000 0.1666667 0.3333333

# 转化为百分数
prop.table(mytable) * 100

# ----------------------------

# 生成二维列联表
# 法一
mytable <- xtabs(~ Treatment+Improved, data=Arthritis)
##          Improved
## Treatment None Some Marked
##   Placebo   29    7      7
##   Treated   13    7     21
# 法二
mytable <- table(Arthritis$Treatment, Arthritis$Improved)
# 法三
# 使用gmodels包中的CrossTable()创建二位列联表
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# 生成边际频数
margin.table(mytable, 1) # 1指代table语句中的第一个变量
## Treatment
## Placebo Treated 
##      43      41
prop.table(mytable, 1)
##          Improved
## Treatment      None      Some    Marked
##   Placebo 0.6744186 0.1627907 0.1627907
##   Treated 0.3170732 0.1707317 0.5121951

# 添加边际和
addmargins(mytable) # 可以像上面有margin参数，默认是求所有和
##          Improved
## Treatment None Some Marked Sum
##   Placebo   29    7      7  43
##   Treated   13    7     21  41
##   Sum       42   14     28  84

# ----------------------------

# 多维列联表
# 上述函数均可推广到多维，但用ftable结果更好看
ftable(xtabs(~ Treatment+Improved+Sex, data=Arthritis))
##                    Sex Female Male
## Treatment Improved                
## Placebo   None             19   10
##           Some              7    0
##           Marked            6    1
## Treated   None              6    7
##           Some              5    2
##           Marked           16    5
```

### 3. 独立性检验

```r
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
# 对二维表的行变量与列变量进行卡方独立性检验
chisq.test(mytable)

##  	Pearson's Chi-squared test

## data:  mytable
## X-squared = 13.055, df = 2, p-value = 0.001463

## p<0.05, 拒绝原假设，即结果是Treatment与Improved不独立
## 说明是否改善与是否治疗有关，即药物的治疗是有效的

# Fisher独立性检验
fisher.test(mytable)
## 	Fisher's Exact Test for Count Data

## data:  mytable
## p-value = 0.001393
## alternative hypothesis: two.sided
```

### 4. 相关

```r
# 相关系数的计算
# 不加参数默认计算Pearson相关系数
cor(iris$Sepal.Length, iris$Sepal.Width)
## [1] -0.1175698
## 负相关

# 计算spearman相关系数
cor(iris$Sepal.Length, iris$Sepal.Width, method='spearman')
## [1] -0.1667777
```

### 5. t检验

```r
# 单样本t检验
# 单总体T检验，是检验一个样本平均值与一个已知的总体平均值的差异是否显著
# 原假设：无差异
data <- rnorm(20)  # 默认均值是0，标准差是1
# 由于T检验的前提条件，总体要符合正态分布，只是总体方差未知。所以，我们需要先对选定数据集进行进行正态分布检验。使用Shapiro-Wilk和qq图，作为正态分布检验的方法。
# 正态分布检验：原假设：符合正态分布
shapiro.test(data) # p>0.05 接受原假设，符合正态分布
# 画QQ图
qqnorm(data)
# 画出与qq图相对应的直线
qqline(data)
t.test(data, mu=0) # mu表示的是平均数 p>0.05 表示平均数是0


# 双总体t检验
# 双总体T检验，是检验两个样本平均值，与其各自所代表的总体的差异是否显著
# 双总体T检验又分为两种情况，一种是配对的样本T检验，用于检验两种同质对象，在不同条件下所产生的数据差异性；另一种是独立样本非配对T检验，用于检验两组独立的样本的平均数差异性

# 配对T检验
# 目标：检验两组同质样本，在不同的处理下的样本平均值，是否有显著的差异性。
# 原假设：无显著差异
t.test(extra ~ group, data = sleep, paired = TRUE) # 使用sleep数据集，按group分成2个组，形成配对的数据集。H0原假设，g1和g2两个样本组均值没有显著性差异，对治疗睡眠的效果是一致的。

# 非配对t检验
t.test(extra ~ group, data = sleep) # 按group分成2个组，形成独立的样本，病人按随机进行配对，去掉关联关系。H0原假设，随机选取g1和g2两个样本组均值没有显著性差异，对治疗睡眠的效果是一致的。


```

## Basic Workflow

### 1. 查看信息

```r
head(BreastCancer)
dim(BreastCancer)        # 相当于shape
unique(BreastCancer$Class) # 与 py 一样
levels(BreastCancer$Class) # 相当于 unique()
table(BreastCancer$Class)  # 相当于 value_counts()
```

### 2. 缺失值

```r
a <- c(NA, 1:5)
a
[1] NA  1  2  3  4  5

NA == NA
[1] NA
```

注意与`NaN`区分

```r
is.nan(0/0)
[1] TRUE
is.infinite(1/0)
[1] TRUE
```



检测

```r
is.na(a)
## [1]  TRUE FALSE FALSE FALSE FALSE FALSE
mean(a)
## [1] NA
mean(a, na.rm=T) # 个数取len-na的数量
## [1] 3
# sum 同理

# is.finite() 判断是否是inf值
```



```r
df <- data.frame(x1 = c(9, 6, NA, 9, 2, 5, NA),
                     x2 = c(NA, 5, 2, 1, 5, 8, 0),
                     x3 = c(1, 3, 5, 7, 9, 7, 5))
df                                       
  x1 x2 x3
1  9 NA  1
2  6  5  3
3 NA  2  5
4  9  1  7
5  2  5  9
6  5  8  7
7 NA  0  5

# 返回有缺失值的行
complete.cases(df)
## [1] FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE
df[!complete.cases(df), ]
##   x1 x2 x3
## 1  9 NA  1
## 3 NA  2  5
## 7 NA  0  5

# 删除数据中有缺失值的行
df <- na.omit(df)
##   x1 x2 x3
## 2  6  5  3
## 4  9  1  7
## 5  2  5  9
## 6  5  8  7 


a <- c(NA, 1:5)
b <- na.omit(a)
b
## [1] 1 2 3 4 5
```

