# Basic Structure

## 1. Basic

### 1. 1 运算

```r
2^10
## [1] 1024
2**10
## [1] 1024

7 / 2
## [1] 3.5
7 %/% 2 # C语言除法
## [1] 3
7 %% 2  # 取余
## [1] 1

# 比较运算符<   <=   >=  ==  !=  %in% 
# %in%是比较特殊的比较，x %in% y的运算把向量y看成集合，运算结果是一个逻辑型向量，x中的元素是否属于y

# 函数match(x, y)起到和x %in% y运算类似的作用，但是其返回结果不是找到与否，而是对x的每个元素，找到其在y中首次出现的下标，找不到时取缺失值，如
match(c(2,5,0), c(1,5,2,5))
## [1]  3  2 NA

isTRUE(c(1,2,3))
## FALSE

# intersect(x,y)求交集，结果中不含重复的元素
intersect(c(5, 7), c(1, 5, 2, 5))

# union(x,y)求并集，结果中不含重复元素
union(c(5, 7), c(1, 5, 2, 5))

# setdiff(x, y)求差集，结果中不含重复元素
# setequal(x, y)判断两个集合是否相等，不受次序与重复元素的影响

# 逻辑运算符 | & || && xor(x,y) 
# AD | 与 || 区别在于后者有短路
```

### 1. 2 数学函数

运算类

```r
# 四舍五入函数
round(8.5)
## [1] 8
round(8.555, digits=2)	
## [1] 8.55
round(8.556, digits=2)
## [1] 8.56

signif(3.55, 2)
## [1] 3.6
signif(3.54, 2)
## [1] 3.5
signif(3.53, 2)
## [1] 3.5

# 值域函数
range(c(1,2,3))
## [1] 1 3
```

### 1. 3 常用函数

查看类型

```r
a <- matrix(1:20, 4)
typeof(a)
## "integer"
class(a)
## "matrix" "array"     其余可能值： "list"
mode(a)
## "numeric"


> a <- 1:3
> class(a)
[1] "integer"
> mode(a)
[1] "numeric"
> typeof(a)
[1] "integer"
```

```r
sort(c(2,3,4,1,2))
## [1] 1 2 2 3 4
order(c(99,100,89,101))
## [1] 3 1 2 4

x <- 1:10
subset(x, x > 2)
## [1]  3  4  5  6  7  8  9 10
```



### 1. 4 其他函数

```r
options() # 查看当前选项设置
options(digits=3) # 显示3位有效数字
help("pretty") # 帮助文档

m <- matrix(1:20,4)
df <- data.frame(m)
arr <- array(1:24, dim=c(2,3,4))
length(m)
## [1] 20
length(df) # 返回列数
## [1] 5
length(arr)
## [1] 24
length("abc")
## [1] 1
length(list(1:20, m, df))
## [1] 3
```



### 1. 5 formula 表达式

- `~`: `~`连接公式两侧，左侧是因变量，右侧是自变量
- `+`: 模型中的不同项用`+`分隔；AD R 语言中默认表达式带常数项
- `-`：`-`表示从模型中移除某一项，y~x-1表示从模型中移除常数项，估计的是一个不带截距项的过原点的回归方程。此外，y~x+0或y~0+x也可以表示不带截距项的回归方程
- `:`: 表示交互项，类似xy（数学意义上的）
- `*`: 不表示乘法；a * b 等价于 a + b + a:b；(a+b+c)*(a+b+c)与 a + b + c + a:b + b:c  + c:a 等价
- `^`: (a+b)^2 与 (a+b) * (a+b)

<img src="https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112142051766.png" alt="image-20211214205110338" style="zoom: 67%;" />



例如

- y~x+I(z^2) 表示：$y=\beta_0+\beta_1x+\beta_2z^2$
- y~x+z^2    表示：$y=\beta_0+\beta_1x+\beta_2z$（因为z没法和自己交互）

## 2. 向量

### 2. 1 创建向量

```r
# 初始化空向量
v <- vector("character",3)
## [1] "" "" ""
a1 <- c(1,2,3,4,5)
a2 <- c("one", "two", 'three')
a3 <- c(TRUE, F, T)
# AD 若只有一个元素，不用c也可以，此时不是向量，是标量

# AD 这样也是可以的
a <- 1:2
b <- c(33, a)
## [1] 33  1  2

# 通过切片构建等差数列
a1 <- c(1:10)
# AD 上面这种等差数列形式也可以不用加c()
a2 <- 1:10
## [1]  1  2  3  4  5  6  7  8  9 10


# 或者通过seq()
a2 <- seq(from=1, to=10) # 等价于seq(10)
## [1]  1  2  3  4  5  6  7  8  9 10
a3 <- seq(from=1, to=10, by=2) # 等价于seq(1,10,by=2)
## [1] 1 3 5 7 9
a4 <- seq(from=1, to=10, length.out=3)
## [1]  1.0  5.5 10.0

# AD seq(10) 结果是integer，带by参数的结果是double
# seq(along=x) 会生成由x的下标组成的向量
x <- c(2,3,4)
seq(along=x)
## [1]  1  2  3

# 重复
x <- c(1,2,3)
a1 <- rep(2, 5) # 2 rep 5 times
a2 <- rep(x, 5) # x rep 5 times
a3 <- rep(x, each=5) # each of x rep each times
a4 <- rep(x, each=5, times=2) # the result of rep(x, each=5) rep 'times' times 
a5 <- rep(c(1, 2), c(3,4)) #[1 1 1 2 2 2 2] 注意次数要对应
a2
## [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3
a3
## [1] 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3
a4
## [1] 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 1 1 1 1 1 2 2 2 2 2 3
##[27] 3 3 3 3

```

### 2. 2 索引

```r
# 从1开始
x <- 1:10
x[1]
# 负索引表示除了该index的元素不输出，其余都输出
x[-2]
# 批量索引
x[c(-5:-1)]
# x[c(-2, 3)] 会报错，因为逻辑上讲不通

# 空下标
x[]
## [1]  1  2  3  4  5  6  7  8  9 10

# 零下标
## x[0] # 返回类型相同，长度为0的向量，相当于numeric(0)，为空集
# 当0与正整数下标一起使用时会被忽略
# 当0与负整数下标一起使用时也会被忽略

# 布尔索引, 类似py
a1 <- c(1:10, NA)
a1 > 3
[1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
[11]    NA
a1[a1 > 3 & a1 < 9]
## [1]  4  5  6  7  8 NA 
# 要注意的是，如果逻辑下标中有缺失值，对应结果也是缺失值。所以，在用逻辑下标作子集选择时，一定要考虑到缺失值问题。正确的做法是加上!is.na前提
x[!is.na(x) & x > 2]

a1[c(T,F,F,T,F,F,T,F,F,T,T,T)] # 超出长度的部分输出NA
a1[c(T,F,F)] # 广播为T F F T F F T F F T
# a1[T,T,T,T,T,T,T,T,T,T] # 会报错，因为没写成向量形式


# 判断一个元素是否在向量中, 进而使用布尔索引
a1 <- c('one', 'two', 'three', 'four', 'five')
'one' %in% a1
## [1] TRUE
a1 %in% c('one', 'tww')
## [1]  TRUE FALSE FALSE FALSE FALSE
a1[a1 %in% 'one']
## [1] "one"
```

### 2. 3 赋值操作

```r
a1 <- c(1:5)
a1[1] <- 2
a1[c(1,2,3)] <-  c(4:6) # 批量赋值
a1[10] <- 20 # a1会扩展长度，其中6~9会填充NA
```

### 2. 4 插入数据

```r
# 插入数据
a1 <- c(1:10)
a1 <- append(x=a1, values=99, after=1) # 在index=1后面插入99
# AD 不是原地操作，需重新赋值

a1
## [1]  1 99  2  3  4  5  6  7  8  9 10
```

### 2. 5 删除数据

```r
a1 <- c(1:10)
a1 <- a1[-c(1:3)]

a1
## [1]  4  5  6  7  8  9 10
```

### 2. 6 向量化运算

```r
# 向量化运算
# 缺失值运算后仍是缺失值
a1 <- c(1,2,3)
a2 <- c(4,5,6)
print(a1 * 2 + a2)
print(a1 * a2)   # 对应位置相乘
print(a1 ** a2)  # 求幂
print(a1 %/% a2) # 整数除法，即C语言除法
print(a1 %% a2)  # 求余

# 若长度不同的向量之间运算，会将短的翻倍到长的
# AD 不必保证成倍数
a1 <- c(1:10)
a2 <- c(1:4)
a1 + a2
## [1]  2  4  6  8  6  8 10 12 10 12
a1 > a2
## [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
## [10]  TRUE
a1 == a2 # AD 不是=
## [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE
## [10] FALSE

# %in% 运算
a1 <- c(1:7)
a2 <- seq(from=10, to=5, by=-1)
a1 %in% a2
## [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE

# 运算函数: abs, sqrt, log, exp, log10
# ceiling, floor, round, trunc 去掉小数点，sinif
# sin cos ...
# sum max mean median quantile range var sd标准差 prod连乘的积 cumsum cumprod
a1 <- abs(-5:5)
a2 <- log(2:5, base=2)
round(c(1.1, 3.33, 5.555), digits=2) # 默认digits=0
## [1] 1.10 3.33 5.56
signif(c(1.1, 3.33, 5.555), digits=2) # 保留有效数字
## [1] 1.1 3.3 5.6
quantile(c(1:100))
##  0%    25%    50%    75%   100% 
##  1.00  25.75  50.50  75.25 100.00
quantile(c(1:100), c(0.4, 0.5, 0.6))
##  40%  50%  60% 
##  40.6 50.5 60.4

# 逻辑运算函数
y <- ifelse(c(-1,0,1)>=0, 1, 0)
y
## [1] 0 1 1

# 通过which返回值的索引
which.max(c(1,3,4,2)) # 3
which(a1 == 0)
which(a1 > 2)

all(c(1, NA, 3) > 2) # FALSE
any(c(1, NA, 3) > 2) # TRUE
any(NA) # NA
# 比较两个R对象是否完全相同
identical(c(1,2,3), c(1,3,2)) # FALSE 
identical(c(1L,2L,3L), c(1,2,3)) # FALSE
# 比较两个R对象是否在数值上完全相同
all.equal(c(1L,2L,3L), c(1,2,3)) # TRUE
# 返回每个元素是否为重复值的结果
duplicated(c(1,2,1,3,NA,4,NA))
## [1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE
# unique()可以返回去掉重复值的结果
```

### 2. 7 给向量命名，类似`Series` `df`

```r
ages <- c(30, 25, 28)
names(ages) <- c("李明", "张聪", "刘颖")
# 或
ages <- c("李明"=30, "张聪"=25, "刘颖"=28)
# 或
ages <- setNames(c(30, 25, 28), c("李明", "张聪", "刘颖"))
## 李明 张聪 刘颖 
##  30   25   28

# R允许仅给部分元素命名，这时其它元素名字为空字符串。不同元素的元素名一般应该是不同的，否则在使用元素作为下标时会发生误读，但是R语法允许存在重名。
# names(x)返回去掉了元素名的x的副本，用names(x) <- NULL可以去掉x的元素名。	
```

### 2. 8 其他

```r
# length(x)函数返回向量的长度；长度为零的向量表示为numeric(0)
# numeric()函数可以用来初始化一个指定元素个数而元素都等于零的数值型向量, 如numeric(10)会生成元素为10个零的向量
# sort(x) 默认升序，非原地操作
# sort(x, decreasing = T) 降序
# order(x) 返回排序后的下标，即x[order(x)] 的结果与sort(x)相同
# rev(x) 非原地操作
```

## 3. 字符串

 ```r
 # 大小写
 toupper(c("Aaa", "Bbb"))
 tolower(c("Aaa", "Bbb"))
 
 # 统计字符串的长度
 nchar("Hello World")
 nchar(c("AAA", "BB", "C")) # [1] 3 2 1
 length(c("AAA", "BB", "C")) # 3
 nchar(c(12, 2, 123)) # 转换为字符串处理
 
 # join字符串
 paste("Hello", "World") # 默认以空格为sep
 ## [1] "Hello World"
 paste("Hello", "World", sep='-')
 ## [1] "Hello-World"
 paste(c("Alex", "Rosie", "Greg"), "Hi!") # 分别追加
 ## [1] "Alex Hi!"  "Rosie Hi!" "Greg Hi!"
 paste(c("ab", "cd"), c("ef", "gh"))
 ## [1] "ab ef" "cd gh"
 paste("x", 1:3, sep="_")
 ## [1] "x_1" "x_2" "x_3"
 
 # collapse：an optional character string to separate the results
 paste(c("Hello", "World")) # 什么都没做
 ## [1] "Hello" "World"
 paste(c("Hello", "World"), collapse=" ")
 ## [1] "Hello World"
 
 
 # substr(str, 起始, 终止)  取[起始，终止]
 substr(x=month.name, start=1, stop=3)
 substr(c('JAN07', 'MAR66'), 1, 3)
 
 # substring(x, start) 可以从字符串x中取出从第start个到末尾的子串
 substring("123456",2)
 ## [1] "23456"
 
 # strsplit
 strsplit("A/BB/CCC", "/") # 返回一个列表！！！
 ## [[1]]
 ## [1] "A"   "BB"  "CCC"
 strsplit('10w,9w,8w', '*')[[1]] # 默认fixed=FALSE，表示使用re
 ## [1] "1" "0" "w" "," "9" "w" "," "8" "w"
 strsplit('10w,9w,8w', '*', fixed=TRUE)[[1]]
 ## [1] "10w,9w,8w"
 
 
 # 模式匹配
 pattern <- ' '
 x <- 'AAA BB C'
 grep(pattern, x, fixed=TRUE) # 寻找X所有元素中包含空格的下标
 ## [1] 1
 pattern <- ' '
 x <- c('AAA BB C', 'AA', 'B B')
 grep(pattern, x, fixed=TRUE) # 寻找X所有元素中包含空格的下标
 ## [1] 1 3
 
 # 字符串替换
 gsub(';',',','1;2;3',fixed=TRUE) # 把;替换为,
 ## [1] "1,2,3"
 sub(';',',','1;2;3',fixed=TRUE)
 ## [1] "1,2;3"
 # sub和gsub的区别在于，前者只替换第一次匹配的字符串，而后者会替换掉所有匹配的字符串
 
 # 字符串笛卡尔积
 suit <- c("space", "clubs")
 face <- 1:3
 outer(suit, face, FUN=paste)
      [,1]      [,2]      [,3]     
 [1,] "space 1" "space 2" "space 3"
 [2,] "clubs 1" "clubs 2" "clubs 3"
 
 # as.numeric()把内容是数字的字符型值转换为数值
 as.numeric(substr('JAN07', 4, 5)) + 2000 # 2007
 as.numeric(substr(c('JAN07', 'MAR66'), 4, 5)) # 7 66
 
 # as.character()函数把数值型转换为字符型
 as.character((1:5)*5)
 ## [1] "5"  "10" "15" "20" "25"
 
 # 指定格式打印到字符串
 sprintf('file%03d.txt', c(1, 99, 100))
 ```

## 4. 日期时间

### 4. 1 日期与日期时间

R日期可以保存为Date类型，一般用整数保存，数值为从1970-1-1经过的天数。

R中用一种叫做POSIXct和POSIXlt的特殊数据类型保存日期和时间，可以仅包含日期部分，也可以同时有日期和时间。

 技术上，POSIXct把日期时间保存为从1970年1月1日零时到该日期时间的时间间隔秒数，所以数据框中需要保存日期时用POSIXct比较合适，需要显示时再转换成字符串形式

POSIXlt把日期时间保存为一个包含年、月、日、星期、时、分、秒等成分的列表，所以求这些成分可以从POSIXlt格式日期的列表变量中获得。日期时间会涉及到所在时区、夏时制等问题，比较复杂。

```r
library(lubridate)
```

### 4. 2 字符串与日期数据

```r
# 获得当前日期
today()
## [1] "2021-10-04"
Sys.Date()
## [1] "2021-10-04"
# 获得当前日期时间
now()
## [1] "2021-10-04 19:38:03 CST"
Sys.time()
## [1] "2021-10-04 20:50:16 CST"
date()
## [1] "Sun Oct 24 20:31:38 2021"

# 字符串转换为日期
as.Date(c("1970-1-5", "2017-9-12"))
as.Date("1/5/1970", format="%m/%d/%Y")
as.POSIXct(c('1998-03-16'))
as.POSIXct(c('1998/03/16'))
as.POSIXct(c('1998-03-16 13:15:45'))
as.POSIXct('3/13/15', format='%m/%d/%y')
# 批量生成
seq(as.Date("2020-2-2"), as.Date("2020-4-2"), by=5)

sales <- round(runif(48, min=50, max=100))
ts(sales, start=c(1010,5), end=c(2014,4), frequency=12) # 12代表月，4代表季度，1代表年

# 用lubridate::ymd(), lubridate::mdy(), lubridate::dmy()将字符型向量转换为日期型向量
# 在年号只有两位数字时，默认对应到1969-2068范围。
ymd(c("1998-3-10", "2018-01-17", "18-1-17"))
## [1] "1998-03-10" "2018-01-17" "2018-01-17"


# 字符串转换为日期时间
# lubridate包的ymd、mdy、dmy等函数添加hms、hm、h等后缀，可以用于将字符串转换成日期时间
ymd_hms("1998-03-16 13:15:45")
## [1] "1998-03-16 13:15:45 UTC"

# 构造日期
make_date(1998, 3, 10)
## [1] "1998-03-10"
# 构造日期时间
make_datetime(1998, 3, 16, 13, 15, 45.2)
## [1] "1998-03-16 13:15:45 UTC"

# 将日期转换为日期时间
as_datetime(as.Date("1998-03-16"))
## [1] "1998-03-16 UTC"
# 将日期时间转换为日期 
as_date(as.POSIXct("1998-03-16 13:15:45"))
## [1] "1998-03-16"
## [1] "1998-03-16"

# as.character()函数把日期型数据转换为字符型
x <- as.POSIXct(c('1998-03-16', '2015-11-22'))
as.character(x)
# 可以指定格式 %Y 代表四位数的年份，%y代表两位数的年份
as.character(x, format='%m/%d/%Y') # "03/16/1998" "11/22/2015"
as.character(x, format='%H:%M:%S') # "13:15:45"

# 指定类似Mar98这样的格式
x <- as.POSIXct(c('1998-03-16', '2015-11-22'))
old.lctime <- Sys.getlocale('LC_TIME')
Sys.setlocale('LC_TIME', 'C')
as.character(x, format='%b%y') # "Mar98" "Nov15"
Sys.setlocale('LC_TIME', old.lctime)
```

### 4. 3 访问日期时间的成分

- 把一个R日期时间值用`as.POSIXlt()`转换为POSIXlt类型，就可以用列表元素方法取出其组成的年、月、日、时、分、秒等数值：`year`, `mon`, `mday`

  ```r
  x <- as.POSIXct(c('1998-03-16', '2015-11-22'))
  as.POSIXlt(x)$year + 1900 # 1998 2015
  ```

- `year()`取出年

- `month()`取出月份数值

- `mday()`取出日数值

- `yday()`取出日期在一年中的序号，元旦为1

- `wday()`取出日期在一个星期内的序号，但是一个星期从星期天开始，星期天为1,星期一为2，星期六为7。

- `hour()`取出小时

- `minute()`取出分钟

- `second()`取出秒

lubridate的这些成分函数还允许被赋值，结果就修改了相应元素的值

```r
month(as.POSIXct("2018-1-17 13:15:40")) # 1

x <- as.POSIXct("2018-1-17 13:15:40")
year(x) <- 2000
month(x) <- 1
mday(x) <- 1
```

`update()`可以对一个日期或一个日期型向量统一修改其组成部分的值

`update()`函数中可以用`year`, `month`, `mday`, `hour`, `minute`, `second`等参数修改日期的组成部分

```r
x <- as.POSIXct("2018-1-17 13:15:40")
y <- update(x, year=2000) # "2000-01-17 13:15:40 CST"
```

### 4. 4 日期计算

在lubridate的支持下日期可以相减，可以进行加法、除法。lubridate包提供了如下的三种与时间长短有关的数据类型：

- 时间长度(duration)，按整秒计算
- 时间周期(period)，如日、周
- 时间区间(interval)，包括一个开始时间和一个结束时间

#### 4. 4. 1 时间长度

R的POSIXct日期时间之间可以相减，如

```r
d1 <- ymd_hms("2000-01-01 0:0:0")
d2 <- ymd_hms("2000-01-02 12:0:5")
di <- d2 - d1; di # Time difference of 1.500058 days
# 结果类型是duration

# lubridate包提供了duration类型
as.duration(di) # "129605s (~1.5 days)"

# lubridate的dseconds(), dminutes(), dhours(), ddays(), dweeks(), dyears()函数可以直接生成时间长度类型的数据
dhours(1) # [1] "3600s (~1 hours)"

# lubridate的时间长度类型总是以秒作为单位，可以在时间长度之间相加，也可以对时间长度乘以无量纲数
dhours(1) + dseconds(5) # "3605s (~1 hours)"

# 可以给一个日期加或者减去一个时间长度，结果严格按推移的秒数计算
d2 <- ymd_hms("2000-01-02 12:0:5")
d2 - dhours(5) # "2000-01-02 07:00:05 UTC"


# 时间的前后推移在涉及到时区和夏时制时有可能出现未预料到的情况。
# 用unclass()函数将时间长度数据的类型转换为普通数值
unclass(dhours(1)) # 3600
```

#### 4. 4. 2 时间周期

lubridate包的`seconds()`, `minutes()`, `hours()`, `days()`，`weeks()`, `years()`函数可以生成以日历中正常的周期为单位的时间长度，不需要与秒数相联系，可以用于时间的前后推移。这些时间周期的结果可以相加、乘以无量纲整数

```r
years(2) + 10*days(1) # "2y 0m 10d 0H 0M 0S"
```

为了按照日历进行日期的前后平移，而不是按照秒数进行日期的前后平移，应该使用这些时间周期。例如，因为2016年是闰年，按秒数给2016-01-01加一年，得到的并不是2017-01-01

```r
ymd("2016-01-01") + dyears(1) # "2016-12-31"
```

使用时间周期函数则得到预期结果：

```r
ymd("2016-01-01") + years(1) # "2017-01-01"
```

#### 4. 4. 3 时间区间

lubridate提供了`%--%`运算符构造一个时间期间。时间区间可以求交集、并集等。

构造如：

```r
d1 <- ymd_hms("2000-01-01 0:0:0")
d2 <- ymd_hms("2000-01-02 12:0:5")
din <- (d1 %--% d2); din # 2000-01-01 UTC--2000-01-02 12:00:05 UTC
```

生成时间区间，也可以用`lubridate::interval(start, end)`函数

```r
interval(ymd_hms("2000-01-01 0:0:0"), ymd_hms("2000-01-02 12:0:5"))

# 可以指定时间长度和开始日期生成时间区间
d1 <- ymd("2018-01-15")
din <- as.interval(dweeks(1), start=d1); din # 2018-01-15 UTC--2018-01-22 UTC
# 注意这个时间区间表面上涉及到8个日期，但是实际长度还是只有7天，因为每一天的具体时间都是按零时计算，所以区间末尾的那一天实际不含在内

# 用lubridate::int_start()和lubridate::int_end()函数访问时间区间的端点
int_start(din) # "2018-01-15 UTC"
int_end(din)   # "2018-01-22 UTC"
```

运算

```r
# 对一个时间区间可以用除法计算其时间长度
din / ddays(1) # 1.500058
din / dseconds(1) # 129605

# 用lubridate::int_shift()平移一个时间区间
din2 <- int_shift(din, by=ddays(3)); din2 # 2018-01-18 UTC--2018-01-25 UTC

# 用lubridate::int_overlaps()判断两个时间区间是否有共同部分
int_overlaps(din, din2) # TRUE

# lubridate()现在没有提供求交集的功能，一个自定义求交集的函数如下：

```

![image-20211004203634432](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20211004203634432.png)

时间区间允许开始时间比结束时间晚，用`lubridate::int_standardize()`可以将时间区间标准化成开始时间小于等于结束时间

`Sys.date()`返回Date类型的当前日期。`Sys.time()`返回POSIXct类型的当前日期时间。

#### 4. 4. 4 Date型日期计算

```r
# 因为Date类型是用数值保存的，所以可以给日期加减一个整数，如：
x <- as.Date("1970-1-5")
x1 <- x + 10; x1 # "1970-01-15"

# 所有的比较运算都适用于日期类型。可以给一个日期加减一定的秒数
as.POSIXct(c('1998-03-16 13:15:45')) - 30

# 但是两个日期不能相加。给一个日期加减一定天数，可以通过加减秒数实现
as.POSIXct(c('1998-03-16 13:15:45')) + 3600*24*2

# 用difftime(time1, time2, units='days')计算time1减去time2的天数；函数结果用c()包裹以转换为数值, 否则会带有单位。
x <- as.POSIXct(c('1998-03-16', '2015-11-22'))
c(difftime(x[2], x[1], units='days')) # Time difference of 6460 days
# 调用difftime()时如果前两个自变量中含有时间部分，则间隔天数也会带有小数部分
# difftime()中units选项还可以取为 'secs', 'mins', 'hours'等。
```

#### 4. 4. 5 日期的舍入计算

lubridate包提供了`floor_date()`, `round_date()`, `ceiling_date()`等函数，对日期可以用`unit=`指定一个时间单位进行舍入。时间单位为字符串，如`seconds`, `5 seconds`, `minutes`, `2 minutes`, `hours`, `days`, `weeks`, `months`, `years`等。

比如，以`10 minutes`为单位，`floor_date()`将时间向前归一化到10分钟的整数倍，`ceiling_date()`将时间向后归一化到10分钟的整数倍，`round_date()`将时间归一化到最近的10分钟的整数倍，时间恰好是5分钟倍数时按照类似四舍五入的原则向上取整。例如

```r
x <- ymd_hms("2018-01-11 08:32:44")
floor_date(x, unit="10 minutes") 
# "2018-01-11 08:30:00 UTC"
```

如果单位是星期，会涉及到一个星期周期的开始是星期日还是星期一的问题。用参数`week_start=7`指定开始是星期日，`week_start=1`指定开始是星期一。

##  5. 因子

```r
# 离散型变量组成的向量
# eg: [china usa uk]

# 创建
f <- factor(c("red", "blue", "red", "green", "blue"))
```

因子的`levels`属性可以看成是一个映射，把整数值 1,2 映射成这些水平值，因子在保存时会保存成整数值 1,2 等与水平值对应的编号。这样可以节省存储空间，在建模计算的程序中也比较有利于进行数学运算

用`as.numeric()`查看对应的整数值

用`as.character()`可以把因子转换成原来的字符型

```r
sex <- factor(c("Male", "Female"))
as.character(sex)
## [1] "Male"   "Female"
as.numeric(sex)
## [1] 2 1
```

#### 5. 1 创建

```r
factor(x, levels = sort(unique(x), na.last = TRUE), 
       labels, exclude = NA, ordered = FALSE)
'''
levels: 指定各水平值；不指定时由x的不同值来求得
labels: 指定各水平的文本标签，eg：Male，Female；不指定时用各水平值的对应字符串；输出时打印labels
exclude: 指定要转换为缺失值(NA)的元素值集合
ordered: 取真值时表示因子水平是有次序的(按编码次序)
'''

# 因子分为名义型变量（如身份）与有序型变量（如poor，good）
# 对于由字符串构成的名义型变量，指定水平level没有意义，此时缺省，默认按字典序
x <- factor(c("B","C","A"))
x
## [1] B C A
Levels: A B C

# 对于由数字构成的名义型变量，指定labels后输出将映射到label指定内容
x <- factor(c(1,2,3),label=c("AA","BB","CC"))
x # 即1->"AA",...,levels缺省，为字典序
## [1] AA BB CC
## Levels: AA BB CC

# 对有序型变量，指定ordered，表明这是一个有序型
# ordered默认level指定的内容按升序排列
x <- factor(c("good","poor","excellent"),ordered=T)
x
## [1] good      poor      excellent
## Levels: excellent < good < poor

# 对于上例，显然我们希望的顺序需要自己通过level指定
x <- factor(c("good","poor","excellent"),level=c("poor","good","excellent"),ordered=T)
x
## [1] good      poor      excellent
## Levels: poor < good < excellent
# 对于上例，假设文件里没有"poor","good","excellent", 而是被替换为C""B""A"，我们可以指定label打印期望的输出
x <- factor(c("A","B","C", "A"),level=c("A","B","C"),label=c("poor","good","excellent"),ordered=T)
x
## [1] poor good excellent poor     
## Levels: poor < good < excellent

# 注意level必须与unique(x)内容一致
factor(c("A","B","C"),level=c("AA","BB","CC"))
## [1] <NA> <NA> <NA>
## Levels: AA BB CC
factor(c("A","B","C"),level=c("AA","BB","CC"), labels=c("A", "B", "C"))
## [1] <NA> <NA> <NA>
## Levels: AA BB CC

# 注意labels的顺序必须和level一致
```

AD: 因为一个因子的levels属性是该因子独有的，所以合并两个因子有可能造成错误

```r
li1 <- factor(c('男', '女'))
li2 <- factor(c('男', '男'))
c(li1, li2) # 1 2 1 1
# 结果不再是因子，正确的做法是
factor(c(as.character(li1), as.character(li2)))
```

#### 5. 2 相关函数

```r
# tabel() 统计因子各水平的出现次数; 也可以对一般的向量统计每个不同元素的出现次数
table(factor(c("A","B","C","A","B")))
## A B C 
## 2 2 1
# 返回值是一个series(有名字的向量)
x <- table(factor(c("A","B","C","A","B")))
x["A"]
## A 
## 2

# tapply()函数 可以按照因子分组然后每组计算另一变量的概括统
sex <- c("male","male","female","male","female")
h <- c(165, 170, 168, 172, 159)
tapply(h, sex, mean)
## female   male 
##  163.5  169.0
# 这里第一自变量h与与第二自变量sex是等长的，对应元素分别为同一人的身高和性别，tapply()函数分男女两组计算了身高平均值

# forcats包的因子函数
...
```

```r
# 通过下例可以看出向量输出散点图，因子输出频率图
plot(mtcars$cyl) # 横轴是1:len，纵轴是值
plot(factor(mtcars$cyl))

# cut 函数进行区间分割
cut(1:10, c(seq(0, 10, 2)))
## [1] (0,2]  (0,2]  (2,4]  (2,4]  (4,6]  (4,6]  (6,8] 
## [8] (6,8]  (8,10] (8,10]
## Levels: (0,2] (2,4] (4,6] (6,8] (8,10]

levels(factor(c("A", "B", "C"), level=c("B", "C", "A")))
## [1] "B" "C" "A"
```

## 6. 列表

```r
# 类似py的一维列表

# 创建列表
a1 <- 1:20
a2 <- matrix(1:20,4)
a3 <- mtcars[1,]  # 是一个列表
a4 <- "Hello World"
mlist <- list(a1, a2, a3, a4)
# 指定列表各项名（默认是1 2 ...）
mlist2 <-list(first=a1, second=a2, third=a3, forth=a4)
# 通过names(mlist)查看和修改元素名
names(mlist2) 
## [1] "first"  "second" "third"  "forth"
names(mlist2)[names(mlist2)=="first"] <- "ffirst" 

# 索引
mlist <- list(a1, a2, a3, a4)
mlist2 <-list(first=a1, second=a2, third=a3, forth=a4)
mlist[1] # 相当于访问a1；仍然是一个列表
mlist[-1] # 访问除a1外的所有；仍然是一个列表
mlist[c(1, 4)] # 相当于访问a1 a4 AD 不可以写为mlist[1, 4]；仍然是一个列表
mlist2['third'] # 通过列名访问；仍然是一个列表
mlist2$third # 通过索引名访问列表，更高效；不是列表

# 给列表不存在的元素名定义元素值就添加了新元素，而且不同于使用向量，对于列表而言这是很正常的做法

class(mlist2[1])  # 返回 list
class(mlist2[[1]])# [[]]内只能写一个东西 返回integer

# [] 与 [[]]
# 列表的一个元素也可以称为列表的一个“变量”，单个列表元素必须用两重方括号格式访问
mlist2[1] # 返回列表的第一个成分，仍为一个列表
mlist2[[1]] # 返回列表的第一个成分的元素值，不是列表
mlist2$first # 同mlist2[[1]]
mlist2$second <- matrix(1:20, 4) # T
mlist2[2] <- matrix(1:20, 4) # 与预期结果相背
mlist2[[2]] <- matrix(1:20, 4)


# 删除元素
mlist2 <-list(first=a1, second=a2, third=a3, forth=a4)
mlist2 <- mlist2[-2]
mlist2[[1]] <- NULL # AD mlist2[1] <- NULL 结果与预期相背
# 因为在list()函数中允许定义元素为NULL，这样的元素是存在的

# 若我们要把已经存在的元素修改为NULL值而不是删除此元素，
# 或者说给列表增加一个取值为NULL的元素
# 这时需要用单重的方括号取子集，这样的子集会保持其列表类型，给这样的子列表赋值为list(NULL)
li["b"] <- list(NULL)
li["d"] <- list(NULL)
li

# 列表类型转换
li <- list(x=1, y=c(2,3))
unlist(li)
## x y1 y2 
## 1  2  3 

# 一些返回值是列表的函数
x <- "A,B,C"
strsplit(x, ",")
## [[1]]
## [1] "A" "B" "C"

x <- c("10, 8, 7", "5, 2, 2", "3, 7, 8", "8, 8, 9")
res <- strsplit(x, ",")
## [[1]]
## [1] "10" " 8" " 7"
## 
## [[2]]
## [1] "5"  " 2" " 2"
## 
## [[3]]
## [1] "3"  " 7" " 8"
## 
## [[4]]
## [1] "8"  " 8" " 9"

# 为了把拆分结果进一步转换成一个数值型矩阵，可以使用sapply()函数如下：
t(sapply(res, as.numeric))
##      [,1] [,2] [,3]
## [1,]   10    8    7
## [2,]    5    2    2
## [3,]    3    7    8
## [4,]    8    8    9
```

## 7. 矩阵与数组

### 7. 1 创建矩阵

```r
# 创建矩阵
# x <- 1:20
# m <- matrix(x, nrow=4, ncol=5)
m1 <- matrix(1:20, 4, 5) # 从上到下，从左到右填充
m2 <- matrix(1:20, 5, 5) # 广播：会循环对齐，任意情况均可
m3 <- matrix(1:20, 3, 3)  
m5 <- matrix(1:20, 3)    # 可自动分配至用完1:20, 即col=7，如下

##     [,1] [,2] [,3] [,4] [,5] [,6] [,7]
## [1,]    1    4    7   10   13   16   19
## [2,]    2    5    8   11   14   17   20
## [3,]    3    6    9   12   15   18    1


m6 <- matrix(1:20, 4, byrow=F) # 默认按列进行填充
# m7 <- matrix(1:20, 4, byrow=T) # 没有bycol参数

# 定义行列名称
m <- matrix(1:20,4,5)
dimnames(m) <- list(c("R1", "R2", "R3", "R4"), c("C1", "C2", "C3", "C4", "C5"))
# 或者
m <- matrix(1:20,nrow=4,ncol=5, dimnames=list(c("R1", "R2", "R3", "R4"), c("C1", "C2", "C3", "C4", "C5"))) 
# 或者
colnames(A) <- c("R1", "R2", "R3", "R4")
rownames(A) <- c("C1", "C2", "C3", "C4", "C5")
# 或者
cnames(A) <- c("R1", "R2", "R3", "R4")
rnames(A) <- c("C1", "C2", "C3", "C4", "C5")

# 查看维数
x <- 1:20
dim(x) # NULL
m <- matrix(x, 4, 5)
dim(m) # [1] 4 5
nrow(m) # 4
ncol(m) # 5

# reshape
x <-  1:20
dim(x) <- c(4,5)
dim(x)
```

### 7. 2 索引

```r
# 索引
m <- matrix(1:20, 4, 5, byrow=T) # 4行5列
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    2    3    4    5
## [2,]    6    7    8    9   10
## [3,]   11   12   13   14   15
## [4,]   16   17   18   19   20
m[1, 2] # 第一行第二列
m[2, ] # 访问第二行
m[, 2] # 访问第二列
m[-1, 2] # 去除第一行，再取第二列
m[1,c(2,3,4)] # 第一行，第二三四列
m[c(2:4), c(2, 3)]
##      [,1] [,2]
## [1,]    7    8
## [2,]   12   13
## [3,]   17   18
m[11] # 相当于按列flatten后的一维索引
## [1] 13
# 通过索引名访问
dimnames(m) <- list(c("R1", "R2", "R3", "R4"), c("C1", "C2", "C3", "C4", "C5"))
m["R1", "C2"]
m["R1", ] # m["R1"] 结果是NA
m[, "C2"]
# m["C2"] m["R1"] # 与预期不符，报错 

# AD 注意在对矩阵取子集时，如果取出的子集仅有一行或仅有一列，结果就不再是矩阵而是变成了R向量
# R向量既不是行向量也不是列向量。如果想避免这样的规则起作用，需要在方括号下标中加选项drop=FALSE
m[1,]
## [1]  1  5  9 13 17
m[1,,drop=FALSE] # 作为列向量取出
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    5    9   13   17

# 为了挑选矩阵的任意元素组成的子集而不是子矩阵，可以用一个两列的矩阵作为下标，矩阵的每行的两个元素分别指定一个元素的行号和列号
ind <- matrix(c(1,1,2,2,3,2), 3, 2, byrow=T)
##      [,1] [,2]
## [1,]    1    1
## [2,]    2    2
## [3,]    3    2
m[ind]
[1] 1 7 12
```

### 7. 3 相关函数

```r
# 相关函数
m <- matrix(1:20, 4, 5)
t(m) # 转置，非原地操作
diag(m) # 返回向量：A(i, i) i=1, ...
c(m) # 返回矩阵的所有元素，效果相当于按列flatten后的向量
m[]  # 相当于m，如果要修改矩阵m的所有元素，可以对m[]赋值
solve(m) # m的逆矩阵
solve(A,b) # 求解Ax=b
apply(A, 2, FUN) # 把矩阵A的每一列分别输入到函数FUN中，得到对应于每一列的结果
apply(A, 1, FUN) # 把矩阵A的每一行分别输入到函数FUN中，得到与每一行对应的结果
# 如果函数FUN返回多个结果，则apply(A, 1或2, FUN)结果为矩阵，矩阵的每一列是输入矩阵相应列输入到FUN的结果，结果列数等于A的列数
D <- matrix(c(6,2,3,5,4,1), nrow=3, ncol=2)
##      [,1] [,2]
## [1,]    6    5
## [2,]    2    4
## [3,]    3    1
apply(D, 2, range)
##      [,1] [,2]
## [1,]    2    1
## [2,]    6    5
# 如果函数FUN返回多个结果，为了对每行计算FUN的结果，结果存入一个与输入的矩阵行数相同的矩阵，应该用t(apply(A, 1, FUN))的形式
t(apply(D, 1, range))
##      [,1] [,2]
## [1,]    5    6
## [2,]    2    4
## [3,]    1    3



# cbind(x): 若x是向量，cbind(x)把x变成列向量，即列数为1的矩阵
# rbind(x): rbind(x)把x变成行向量
# cbind(x1,x2,x3): 若x1, x2, x3是等长的向量，cbind(x1, x2, x3)把它们看成列向量并在一起组成一个矩阵
# cbind()的自变量可以同时包含向量与矩阵，向量的长度必须与矩阵行数相等;
# cbind()的自变量中也允许有标量，这时此标量被重复使用
```

### 7. 4 矩阵运算

```r
# 矩阵运算
m <- matrix(1:20, 4, 5, byrow=T)
m + 1 # 每个元素+1
m + m # 对应位置相加
n <- matrix(1:20, 5, 4, byrow=T)
# m + n 报错，矩阵运算**必须**形状一致, 无法广播
n2 <- matrix(1:25, 5, 5)
m + n2
m * m # 点乘
m %*% t(m) # 线代意义的乘法

# 按axis计算
m <- matrix(1:10, 4, 5)
rowSums(m)
colMeans(m)

# 矩阵与向量进行乘法运算时，向量按需要解释成列向量或行向量。当向量左乘矩阵时，看成行向量；当向量右乘矩阵时，看成列向量
# 此时运算符仍是%*%

# 注意矩阵乘法总是给出矩阵结果，即使此矩阵已经退化为行向量、列向量甚至于退化为标量也是一样。如果需要，可以用c()函数把一个矩阵转换成按列拉直的向量。
```

内积：设`x`, `y`是两个向量，计算向量内积，可以用`sum(x*y)`表示

设$A$​, $B$​是两个矩阵，是广义的内积，也称为叉积(crossprod)，结果是一个矩阵，元素为$A$​的每列与$B$​的每列计算内积的结果。$A^TB$​在R中可以表示为`crossprod(A, B)`, $A^TA$​​可以表示为`crossprod(A)`。要注意的是，`crossprod()`的结果总是矩阵，所以计算两个向量的内积用`sum(x,y)`而不用`crossprod(x,y)`。

外积：R向量支持外积运算，记为`%o%`, 结果为矩阵。`x %o% y`的第 i 行第 j 列元素等于x[i]乘以y[j]。

这种运算还可以推广到`x`的每一元素与`y`的每一元素进行其它的某种运算，而不限于乘积运算，可以用`outer(x,y,f)`完成，其中`f`是某种运算，或者接受两个自变量的函数。

### 7. 5 数组

```r
# 数组(理解为多维矩阵)
x <- 1:20
dim(x) <- c(2,2,5)
# 或
x <- array(1:20, dim=c(2,2,5))

# array()创建数组
dim1 <- c("A1", "A2")
dim2 <- c("B1", "B2", "B3")
dim3 <- c("C1", "C2", "C3", "C4")
x <- array(1:24, c(2,3,4), dimnames = list(dim1, dim2, dim3))
, , C1

   B1 B2 B3
A1  1  3  5
A2  2  4  6

, , C2

   B1 B2 B3
A1  7  9 11
A2  8 10 12

, , C3

   B1 B2 B3
A1 13 15 17
A2 14 16 18

, , C4

   B1 B2 B3
A1 19 21 23
A2 20 22 24
```

多维数组可以利用下标进行一般的子集操作，比如`ara[,2, 2:3]`

多维数组在取子集时如果某一维下标是标量，则结果维数会减少，可以在方括号内用`drop=FALSE`选项避免这样的规则发生作用

类似于矩阵，多维数组可以用一个矩阵作为下标，如果是三维数组，矩阵就需要有3列，四维数组需要用4列矩阵。下标矩阵的每行对应于一个数组元素



注意多维数组不能用`$`选择元素

## 8. 数据框

-   实际上是一个列表，列表中的元素是**向量**或**因子**
-   这些向量组成数据框的列
-   每列的长度必须相同，所以 df 是矩阵结构
-   数据框的列必须命名，每一列必须统一类型
-   事实上，数据框还允许一个元素是一个矩阵，但这样会使得某些读入数据框的函数发生错误
-   字符串向量会自动转换为因子

### 8. 1 创建

```r
# 1. 通过list直接创建
name <- c("Alex", "Rosie", "Greg")
gender <- c("M", "W", "M")
age <- c(18,19,20)
# list1 <- list(name, gender, age) 与预期相背
list2 <- list(name=name,
              gender=gender,
              age=age)
df <- data.frame(list2)
# data.frame()函数会将字符型列转换成因子，加选项stringsAsFactors=FALSE可以避免这样的转换
# 如果数据框的某一列为常数，可以在data.frame()调用中仅给该列赋一个值，生成的结果会自动重复这个值使得该列与其他列等长


# 2. 通过一个个指定df的向量创建
# 行可以不指定索引名,默认使用123; 列会默认使用变量名
# df <- data.frame(name=name,
#                  gender=gender,
#                  age=age)
df <- data.frame(name, gender, age)

# 3. as.data.frame(x) 将x转换为数据框
# 若x是向量，转换结果是以x为唯一一列的数据框
# 若x是矩阵，转换结果把矩阵的每列变成数据框的一列。
# 若x是一个列表且满足df的要求，转换结果中每个列表变成数据框的一列

# 4. 创建时指定行名
df <- data.frame(gender, age, row.names=name)
##       gender age
## Alex       M  18
## Rosie      W  19
## Greg       M  20

# 5. 创建后将某一列改为行索引
df <- data.frame(name, gender, age)
names(df) <- c("AA", "BB", "CC") # 指定的是列索引名
row.names(df) <- df$AA # 或rownames(df) <- df$name
df$name <- NULL
##       gender age
## Alex       M  18
## Rosie      W  19
## Greg       M  20

# 6. 指定字符串列为factor类型，默认不转换为factor
df <- data.frame(name, gender, age, stringsAsFactors=T)


# 通过table生成df
data.frame(table(grad))
     grad Freq
1 (60,70]  174
2 (70,80]  125
3 (80,90]    0
```

### 8. 2 访问

```r
df[1] # 访问第一列, 也是df
df[,1] # 访问第一列, 不是df, 是元素，即向量
df[c(1,3)] # 输出第一列与第二列，是df
df[-c(2,4)]

df["NO1",]
df$name
df[c("name", "gender")] # 输出name列与gender列

# 同时取行子集与列子集
df[1:2, "age"]
df[1:2, c("age", "height")]
d[d[,"age"]>=30,]

# AD 以下几种访问列的输出结果均相同，且均为数据本身的类型
df[, 1]
df[, "name"]
df[[1]]
df[[c(1)]]
df$name
df[["name"]] # 不建议使用

# AD 访问含的结果仍是数据框，不是向量，因为数据类型不一定相同
df[1,]

# AD 与矩阵类似地是，用如d[,"age"], d[,2]这样的方法取出的数据框的单个列是向量而不再是数据框
# 但是，如果取出两列或者两列以上，结果则是数据框
# 如果取列子集时不能预先知道取出的列个数，则子集结果有可能是向量也有可能是数据框，容易造成后续程序错误
# 对一般的数据框，可以在取子集的方括号内加上drop=FALSE选项，确保取列子集的结果总是数据框

# 当使用attach加载数据框，则无需$符号
attach(mtcars)
mpg
colnames(mtcars)
detach(mtcars) # 取消加载

# with也可以
with(mtcars, {mpg})
with(mtcars, {
  stats <- summary(mpg)
  stats
})
# AD stats作用域仅在{}内
# 要想改为全局，可将 <- 换为<<-

# within 和with一样，唯一区别在于可以修改df
df <- within(df, {
    age <- NA
})
##    name gender age
## 1  Alex      M  NA
## 2 Rosie      W  NA
## 3  Greg      M  NA

# subset()函数
new_df <- subset(df, gender="Male" | age < 20, select=c("name", "gender"))
new_df <- subset(df, gender="Male" | age < 20, select=name : gender) # 效果一样


m1 <- head(mtcars, n=5)
m2 <- mtcars[1:5,]
identical(m1, m2)
## [1] TRUE

m1 <- tail(mtcars, n=5)
m2 <- mtcars[(nrow(mtcars)-4) : nrow(mtcars),] # AD nrow一定要用()括起来
identical(m1, m2)
## [1] TRUE
# 这是因为
nrow(mtcars)-4 : nrow(mtcars)
## [1] 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
```

### 8. 3 删除

```r
df
##    name gender age
## 1  Alex      M  18
## 2 Rosie      W  19
## 3  Greg      M  20

# 删除一列
df <- df[, -which(colnames(df) %in% c("gender", "age"))]
# 删除一行
df <- df[-which(rownames(df) %in% c("1", "2")), ]
```

[参考网站](https://liuyang0681.github.io/2019/04/28/R-%E6%8C%89%E7%85%A7%E8%A1%8C%E5%90%8D%E6%88%96%E5%88%97%E5%90%8D%E5%88%A0%E9%99%A4%E5%AF%B9%E5%BA%94%E7%9A%84%E8%A1%8C%E5%88%97/)

### 8. 4 相关函数

```r
names(d): 访问列名；可用作修改
colnames(d): 访问列名；可用作修改
nrow(d): 求行数
ncol(d): 求列数
length(d): 求列数 
as.matrix(df): 转换为矩阵
head(df, n = 6): 默认打印前6行
```

## 9. 数据类型的性质

### 9. 1 存储模式与基本类型

R中数据的最基本的类型包括logical, integer, double, character, complex, raw, 其它数据类型都是由基本类型组合或转变得到的

character类型就是字符串类型，raw类型是直接使用其二进制内容的类型。为了判断某个向量`x`保存的基本类型，可以用`is.xxx()`类函数，如`is.integer(x)`, `is.double(x)`, `is.numeric(x)`, `is.logical(x)`, `is.character(x)`, `is.complex(x)`, `is.raw(x)`。其中`is.numeric(x)`对integer和double内容都返回真值。

```r
typeof(1:3)
## [1] "integer"
typeof(c(1:3))
## [1] "integer"
typeof(c(1,2,3))
## [1] "double"
typeof(c(1,2,3,NA))
## [1] "double"
typeof('ABC')
## [1] "character"
typeof(factor(c('F', 'M', 'M', 'F')))
## [1] "integer"
```

整数型的缺失值是`NA`，而double型的特殊值除了`NA`外，还包括`Inf`, `-Inf`和`NaN`，其中`NaN`也算是缺失值, `Inf`和`-Inf`不算是缺失值。

```r
# 对于double类型
is.infinite(): 判断是否是Inf或-Inf
is.finite(): 判断是否是NA，Inf，-Inf，NaN
is.na(): 判断是否NA或NaN
is.nan(): 判断是否NaN
```

在R的向量类型中，integer类型、double类型、logical类型、character类型、还有complex类型和raw类型称为原子类型(atomic types)，原子类型的向量中元素都是同一基本类型的。比如，double型向量的元素都是double或者缺失值。

R有一个特殊的`NULL`类型，这个类型只有唯一的一个`NULL`值，表示不存在。`NULL`长度为0，不能有任何属性值。用`is.null()`函数判断某个变量是否取`NULL`。

`NULL`值可以用来表示类型未知的零长度向量，如`c()`没有自变量时返回值就是`NULL`； 也经常用作函数缺省值，在函数内用`is.null()`判断其缺省后再用一定的计算逻辑得到真正的缺省情况下的数值。

要把`NULL`与`NA`区分开来，`NA`是有类型的（integer、double、logical、character等), `NA`表示存在但是未知。数据库管理系统中的NULL值相当于R中的NA值。

### 9. 2 类型转换与类型升档

可以用`as.xxx()`类的函数在不同类型之间进行强制转换。

```r
as.numeric(c(FALSE, TRUE)) # 0 1
as.character(sqrt(1:4))
```

类型转换也可能是隐含的，比如，四则运算中数值会被统一转换为double类型，逻辑运算中运算元素会被统一转换为logical类型。

逻辑值转换成数值时，`TRUE`转换成1，`FALSE`转换成0。

在用`c()`函数合并若干元素时，如果元素基本类型不同，将统一转换成最复杂的一个，复杂程度从简单到复杂依次为：`logical<integer<double<character`。

这种做法称为类型升档

### 9. 3 属性

#### 9. 3. 1 attributes()

- 除了`NULL`以外，R的变量都可以看成是对象，都可以有属性。

- 在R语言中，属性是把变量看成对象后，除了其存储内容（如元素）之外的其它附加信息，如维数、类属等。R对象一般都有`length`和`mode`两个属性。

- 常用属性有`names`, `dim`，`class`等。

对象`x`的所有属性可以用`attributes()`读取，也可以用`attributes()`函数修改属性

```r
x <- array(1:24,dim=c(2,3,4))
attributes(x) <- NULL
x
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
## [21] 21 22 23 24
```

#### 9. 3. 2 attrs()

可以用`attr(x, "属性名")`的格式读取或定义`x`的属性；可以让向量`x`额外地保存一个`theta`属性，这样的属性常常成为“元数据”(meta data)，比如，用来保存数据的说明、模拟数据的真实模型参数

```r
x <- c(1,3,5)
attr(x, "theta") <- c(0, 1)
print(x)
## [1] 1 3 5
## attr(,"theta")
## [1] 0 1
attributes(x)
## $theta
## [1] 0 1
```

#### 9. 3. 3 names属性

有元素名的向量、列表、数据框等都有`names`属性，许多R函数的输出本质上也是列表，所以也有`names`属性。

#### 9. 3. 4 dim属性

`dim`属性的存在表明对象是矩阵或一维、多维数组

R允许`dim`仅有一个元素，这对应于一维向量，与普通的没有`dim`属性的向量有区别。

另外要注意，取矩阵子集时如果结果仅有一列或一行，除非用了`drop=FALSE`选项，结果不再有`dim`属性，退化成了普通向量。

### 9. 4 类属

R具有一定的面向对象语言特征，其数据类型有一个`class`属性，函数`class()`可以返回变量类型的类属

```r
typeof(factor(c('F', 'M', 'M', 'F'))) # "integer"
class(factor(c('F', 'M', 'M', 'F')))  # "factor"
class(as.numeric(factor(c('F', 'M', 'M', 'F')))) # "numeric"
```

class属性是特殊的。如果一个对象具有class属性，某些所谓“通用函数(generic functions)”会针对这样的对象进行专门的操作，比如，`print()`函数在显示向量和回归结果时采用完全不同的格式。这在其它程序设计语言中称为“重载”(overloading)。

### 9. 5 str()函数

用`str()`函数可以显示对象的类型和主要结构及典型内容

```r
s <- 101:200
attr(s,'author') <- '李小明'
attr(s,'date') <- '2016-09-12'
str(s)

##  int [1:100] 101 102 103 104 105 106 107 108 109 110 ...
##  - attr(*, "author")= chr "李小明"
##  - attr(*, "date")= chr "2016-09-12"
```

## 10. 工作空间与变量赋值

- 用`ls()`命令可以查看工作空间中的内容
- 用`rm()`函数删除工作空间中的变量

- R的变量名要求由**字母、数字、下划线、小数点**组成，开头不能是数字、下划线、小数点，中间不能使用空格、减号、井号等特殊符号，变量名不能与`if`、`NA`等保留字相同
- 有时为了与其它软件系统兼容，需要使用不符合规则的变量名，这只要将变量名两边用反向单撇号“` ”保护
- 如果变量名（元素名、列名等）是以字符串形式使用，就不需要用“`”保护，如x <- c("score a"=85, "score b"=66)

- 在R中赋值本质上是把一个存储的对象与一个变量名“绑定”(bind)在一起
- 对于`x <- c(1,2,3)`，实际上，`<-`右边的`c(1,2,3)`是一个表达式，其结果为一个R对象(object)，而`x`只是一个变量名，并没有固定的类型、固定的存储位置，赋值的结果是将`x`绑定到值为`(1,2,3)`的R对象上
- R对象有值，但不必有对应的变量名； 变量名必须经过绑定才有对应的值和存储位置
- 同一个R对象可以被两个或多个变量名绑定
- 对于基本的数据类型如数值型向量，两个指向相同对象的变量当一个变量被修改时自动制作副本
- `tracemem(x)`可以显示变量名`x`绑定的地址并在其被制作副本时显示地址变化

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <0000000018288290>

y <- x    # 这时y和x绑定到同一R对象
cat(tracemem(y), "\n")
## <0000000018288290与x一样

y[3] <- 0 # 这时y制作了副本
## tracemem[0x0000000018288290 -0x00000000183c5190]:..
x
## [1] 1 2 3
y
## [1] 1 2 0
untracemem(x); untracemem(y)
可见y <- x并没有制作副本，但是修改y[3]值时就对y制作了副本
```

如果某个变量名所指向的对象没有被其他变量名绑定，则修改其元素值并不需要制作副本

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <00000000188C09D0>
x[3] <- 0
## tracemem[0x00000000188c09d0 -0x000000001895b270]:..
x
## [1] 1 2 0
untracemem(x)
```

在调用函数时，如果函数内部不修改自变量的元素值，输入的自变量并不制作副本，而是直接被函数使用实参绑定的对象。

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <0000000018DA05A0>
f <- function(v){ return(v) }
z <- f(x)
cat(tracemem(z), "\n")
## <0000000018DA05A0与x相同
untracemem(x); untracemem(z)

从上面的例子可以看出，函数f以x为实参，但不修改x的元素，不会生成x的副本，返回的值是x指向的对象本身，再次赋值给z，也不制作副本，z和x绑定到同一对象
```

如果函数内部修改自变量的元素值，则输入的自变量也会制作副本

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <000000001931EE70>
f2 <- function(v){ v[1] <- -999; return(v) }
z <- f2(x)
## tracemem[0x000000001931ee70 -0x00000000193d8880]:..
cat(tracemem(z), "\n")
## <00000000193D8880与变化后的x相同
untracemem(x); untracemem(z)

从程序输出看，函数f2()以x为实参，并修改x的内部元素，就制作了x的副本，返回的结果赋给变量z，绑定的是修改后的副本
```

如果在函数中对自变量重新赋值，这实际是重新绑定，也不会制作输入的实参的副本。

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <000001698AA77730
f2 <- function(v){ v <- -999; return(v) }
z <- f2(x)
cat(tracemem(z), "\n")
## <0000016989BDB780
untracemem(x); untracemem(z)

可以看见x地址并没有变化
```

如果修改`x`的元素值时还修改了其存储类型，比如整型改为浮点型，则会先制作`x`的副本，然后制作类型改变后的副本，然后再修改其中的元素值

```r
x <- c(1,2,3)
cat(tracemem(x), "\n")
## <000001698CA2B108
f2 <- function(v){ v[1] <- FALSE; return(v) }
z <- f2(x)
## tracemem[0x000001698ca2b108 -0x0000016988bc8aa8]:..
cat(tracemem(z), "\n")
## <0000016988BC8AA8
untracemem(x); untracemem(z)
x
## [1] 1 2 3

可见x地址发生变化但内容不变，且地址和z不同
```

在当前的R语言中，一个对象的引用（如绑定的变量名）个数，只区分0个、1个或多个这三种情况。在没有引用时，R的垃圾收集器会定期自动清除这些对象。`rm(x)`只是删除绑定，并不会马上清除`x`绑定的对象。如果已经有多个引用，即使是只有2个，减少一个引用也还是“多个”状态，不会变成1个

垃圾收集器是在R程序要求分配新的对象空间时自动运行的，R函数`gc()`可以要求马上运行垃圾收集器，并返回当前程序用道的存储量； lobstr包的`mem_used()`函数则报告当前会话内存字节数。

在上面的示例中，用了基本类型的向量讲解是否制作副本。考虑其它类型的复制。

如果`x`是一个有5个元素的列表，则`y <- x`使得`y`和`x`指向同一个列表对象。但是，列表对象的每个元素实际上也相当于一个绑定，每个元素指向一个元素值对象。所以如果修改`y`：`y[[3]] <- 0`，这时列表`y`首先被制作了副本，但是每个元素指向的元素值对象不变，仍与`x`的各个元素指向的对象相同； 然后，`y[[3]]`指向的元素值进行了重新绑定，不再指向`x[[3]]`，而是指向新的保存了值`0`的对象，但`y`的其它元素指向的对象仍与`x`公用。列表的这种复制方法称为浅拷贝，表格对象及各个元素绑定被复制，但各个元素指向（保存）的对象不变。这种做法节省空间也节省运行时间。在R的3.1.0之前则用的深拷贝方法，即复制列表时连各个元素保存的值也制作副本。

如果`x`是一个数据框，这类似于一个列表，每个变量相当于一个列表元素，数据框的每一列实际绑定到一个对象上。如果`y <- x`，则修改`y`的某一列会对`y`进行浅拷贝，然后仅该列被制作了副本并被修改，其它未修改的列仍与`x`共用值对象。

但是如果修改数据框`y`的一行，因为这涉及到所有列，所以整个数据框的所有列都会制作副本。

对于字符型向量，实际上R程序的所有字符型常量都会建立一个全局字符串池，这样有许多重复值时可以节省空间。

用lobstr包的`obj_size()`函数可以求变量的存储大小，如`obj_size(x)`，也可以求若干个变量的总大小，如`obj_size(x,y)`。因为各种绑定到同一对象的可能性，所以变量的存储大小可能会比想象要少，比如，共用若干列的两个数据框，字符型向量，等等。基本R软件的`object.size()`则不去检查是否有共享对象，所以对列表等变量的存储大小估计可能会偏高。

从R 3.5.0版开始，`1:n`这种对象仅保存其开始值和结束值。

在自定义函数时，自变量通常是按引用使用的，函数内部仅使用自变量的值而不对其进行修改时不会制作副本，但是如果函数内部修改了自变量的值，就会制作副本，当自变量的存储很大而且返回调用这个函数时就会造成运行速度缓慢。在函数内应慎重修改自变量的值。

在循环中修改数据框的列，也会造成反复的复制。

## Reference

https://www.math.pku.edu.cn/teachers/lidf/docs/Rbook/html/_Rbook/



