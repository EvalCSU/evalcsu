# Grammar

1.大原则：只有字母（区分大小写）、数字、“_”（下划线）、“.”（英文句号）可以出现。

2.数字、下划线不能开头。

3.英文句号开头不能紧接数字。

## 1. 输入输出

### 1. 1 简单输出

```r
x <- 1.234
print(x)

# cat()函数打印输出
cat('1.1*1.2=',1.1*1.2,'?') # 默认以空格为分界，不会自动换行
## 1.1*1.2= 1.32 ?

# 输出到文件
cat("=== 结果文件 ===\n", file="res.txt")
cat("x =", x, "\n", file="res.txt", append=TRUE)

# 函数sink()可以用来把命令行窗口显示的运行结果转向保存到指定的文本文件中， 如果希望保存到文件的同时也在命令行窗口显示， 使用split=TRUE选项
# 用sink()函数打开一个文本文件开始记录文本型输出结果。结束记录时用空的sink()即可关闭文件不再记录
sink("D:/Compute Science/R/Learning/笔记/tmpres.txt", split=TRUE)
print(sin(pi/6))
print(cos(pi/6))
sink()
# 文件内容为
## [1] 0.5
## [1] 0.8660254

# 保存命令行环境中定义的变量，函数到文件
save(x, y, file="scores.RData")
# 或
save(list=c("x", "y"), file="scores.RData")
# 恢复到工作空间
load("scores.RData")

# 保存数据框到csv
da <- tibble("name"=c("李明", "刘颖", "张浩"),
                 "age"=c(15, 17, 16))
write_csv(da, path="mydata.csv")
```

### 1. 2 简单输入

```r
# 用scan()函数可以输入文本文件中的数值向量， 文件名用file=选项给出。 文件中数值之间以空格分开
cat(1:12, "\n", file="d:/work/x.txt")
x <- scan("d:/work/x.txt")

# 如果scan()中忽略输入文件参数， 此函数将从命令行读入数据。可以在一行用空格分开多个数值，可以用多行输入直到空行结束输入

# scan()读入矩阵
# quite=TRUE选项使得读入时不自动显示读入的数值项数
# 假设mat.txt存储内容如下
3  4  2
5 12 10
7  8  6
1  9 11
M <- matrix(scan("mat.txt", quiet=TRUE), ncol=3, byrow=TRUE)
```

### 1. 3 读取csv文件

`read_csv()`的`skip=`选项跳过开头的若干行。 当数据不包含列名时， 只要指定`col_names=FALSE`， 变量将自动命名为`X1, X2, ...`， 也可以用`col_names=`指定各列的名字

```r
d <- read_csv("testcsv.csv")
d <- read_csv("name,x,y
John, 33, 95
Kim, 21, 64
Sandy, 49, 100
")

d <- read_csv("John, 33, 95
Kim, 21, 64
Sandy, 49, 100
", col_names=c("name", "x", "y") )

# 编码设置
d <- read_csv("bp.csv", 
  locale=locale(encoding="GBK"))
# 缺失值设置
d <- read_csv("bp.csv", 
  locale=locale(encoding="GBK"))
d[["收缩压数值"]] <- as.numeric(d[["收缩压"]]) # 先将血压列按字符型读入， 再增加一列转换为数值型的列， 非数值转换为NA

# 各列值类型设置
d <- read_csv("bp.csv", locale=locale(encoding="GBK"),
              col_types=cols(
                `序号` = col_integer(),
                `收缩压` = col_character()
              ))
# 当猜测的文件类型有问题的时候， 可以先将所有列都读成字符型， 然后用type_convert()函数转换
d <- read_csv("filename.csv",
              col_types=cols(.default=col_character()))
d <- type_convert(d)

# 因子类型设置
d <- read_csv(
  "class.csv", col_types=cols(
  .default = col_double(),
  name=col_character(),
  sex=col_factor(levels=c("M", "F")) ))
```

### 1. 4 读写文件

```r
read.table(file, header=FALSE, sep="", fill=, row.names, col.names, encoding=, skip=, colClasses=, ...)

write.table(x, file = "", append = FALSE, quote = TRUE, sep = " ",eol = "\n", na = "NA", dec = ".", row.names = TRUE,col.names = TRUE, qmethod = c("escape", "double"))

header指定是否将第1行作为变量名，默认为FALSE；

sep指定分隔符；

fill设置是否填充，若为TRUE，则各行变量数目不同时，将用空白填充；

row.names, colnames设置行名、列名的向量；

encoding设置读取时的编码方式，避免出现乱码；

skip指定读取数据前跳过的行数；

colClasses指定各列的数据类型的一个字符型向量。
```

### 1. 5 执行脚本

```r
source('D:/Compute Science/R/Learning/笔记/script.txt')
## [1] 3 2 1
```

### 1. 6 包相关操作

```r
# 加载某个包中的数据集
data(Arthritis, package='vcd')
# 查看已加载的包
(.packages())
# 卸除已加载的包
detach("package:vcd")
# 安装包
install.packages('vcd')
# 卸载包
.libPaths()
## [1] "E:/App/R/R-4.1.1/library"
remove.packages("vcd", lib=file.path('E:/App/R/R-4.1.1/library'))
# 查看已安装的包
installed.packages()[,c('Package','Version','LibPath')]
# 查看某个包提供的函数
help(package='TSA')
# 查看某个函数属于哪个包
help(函数名)

# 删除某个变量
rm(变量名)
# 删除所有变量
rm(list = ls())

```



## 2. 程序控制结构

### 2. 1 分支

```r
# 一定要有 {} 否则 r 如果在第一句 if 就进入该分支了，后面的 else 就不认识了
# else if 一定要写在同一行，直接跟在后面，理由如上...
if (...) {
    
} else if (...) {
    
} else {
    
}

# switch() 语句
feelings <- c("sad", "happy")
for (i in feelings) {
    print(
        switch(i,
           happy = "I am happy",
           sad = "I am sad",
           angry = "Hmm...",
           "IDK..." # de
        )
    )
}
## [1] "I am sad"
## [1] "I am happy"
# ifelse函数
ifelse(score>90, print("Good"), print("Oops"))
ifelse((1:6) >= 3, 1:2, c(-1,-2)) # -1 -2  1  2  1  2
```

关于`ifelse`有两个注意点

- `ifelse` returns a value with the same shape as `test` which is filled with elements selected from either `yes` or `no` depending on whether the element of `test` is `TRUE` or `FALSE`.
- https://stackoverflow.com/questions/31630642/print-function-in-ifelse/31630908
- https://stackoverflow.com/questions/1335830/why-cant-rs-ifelse-statements-return-vectors

### 2. 2 循环

```r
for(循环变量 in 序列) {
    
}

for (i in 1:5) {}

repeat{
    ...
    if(...) break
}

while(cond) {}

# Example 下面三种情况结果都一样
x <- c("A", "B", "C")
for (i in 1:4) print(x[i])

for (i in seq_along(x)) print(x[i])
    
for (i in x) print(i)
```

### 2. 3 管道控制

比如，变量`x`先用函数`f(x)`进行变换，再用函数`g(x)`进行变换， 一般应该写成`g(f(x))`，用`%>%`运算符，可以表示成 `x %>% f() %>% g()`。 更多的处理，如`h(g(f(x)))`可以写成 `x %>% f() %>% g() %>% h()`。 这样的表达更符合处理发生的次序，而且插入一个处理步骤也很容易

处理用的函数也可以带有其它自变量，在管道控制中不要写第一个自变量。 某个处理函数仅有一个自变量时，可以省略空的括号

## 3. 函数

### 3. 1 基础

```r
f <- function(参数) {}

f <- function(x) 1/sqrt(1 + x^2)

f <- function() {
  a <- 1
  return(a) # 注意一定要用括号括起来，否则不认识 return
}

f <- function() {
  a <- 1
  a
}

f <- function() {
  a <- 1
  b <- 2
  c(a, b) # 不能写为 a, b；也不能写为 return(a, b)
}

# 支持默认参数
# 在定义函数时，没有缺省值的参数写在前面，有缺省值的参数写在后面。
fsub <- function(x, y=0){
  cat("x=", x, " y=", y, "\n")
  x - y
}
```

函数体的最后一个表达式是函数返回值。

除了用函数体的最后一个表达式作为返回值， 还可以用`return(y)`的方式在函数体的任何位置退出函数并返回`y`的值。 为了返回多个变量值， 将这些变量打包为一个列表返回即可； R的统计建模函数的返回值大多数都是列表

函数可以返回一个`invisible(y)`， 这表示其返回的值仍是`y`的值， 但直接在R命令行调用此函数时不自动显示返回值， `print()`或`cat()`显式地要求才显示。 当预期返回的结果显示无意义或者显示在命令行会产生大量的输出时可以用此方法。

一个自定义R函数由三个部分组成：

- 函数体`body()`，即要函数定义内部要执行的代码；
- `formals()`，即函数的形式参数表以及可能存在的缺省值；
- `environment()`，是函数定义时所处的环境， 这会影响到参数表中缺省值与函数体中非局部变量的的查找。

“环境”是R语言比较复杂的概念， 对于没有嵌套定义在函数内的函数， 环境一般是R的全局工作空间（全局环境）； 嵌套定义的函数则会有一个私有的环境， 而且对于利用“函数工厂”生成的函数， 还可以将其私有环境与函数对象一起保存下来， 生成带有状态的函数。 

实际上， “`function(参数表) 函数体`”这样的结构本身也是一个表达式， 其结果是一个函数对象

R的形参、实参对应关系可以写成一个列表， 如`fsub(3, y=1)`中的对应关系可以写成列表 `list(3, y=1)`， 如果调用函数的形参、实参对应关系保存在列表中， 可以用函数`do.call()`来表示函数调用

```r
do.call(fsub, list(3, y=1)) # 等价于fsub(3, y=1)
```

### 3. 2 递归调用

R中在递归调用时， 最好用 `Recall` 代表调用自身， 这样保证函数即使被改名（在R中函数是一个对象， 改名后仍然有效）递归调用仍指向原来定义

```r
fib1 <- function(n){
  if(n == 0) return(0)
  else if(n == 1) return(1)
  else if(n >=2 ) {
    Recall(n-1) + Recall(n-2)
  }
}
for(i in 0:10) cat("i =", i, " x[i] =", fib1(i), "\n")
```

### 3. 3 向量化

自定义的函数，如果其中的计算都是向量化的， 那么函数自动地可以接受向量作为输入，结果输出向量

但涉及`if`语句的条件必须是标量条件，无法实现向量化

```r
g <- function(x){
  if(abs(x) <= 1) {
    y <- x^2
  } else {
    y <- 1
  }
  y
}
```

可修改为

```r
gv <- function(x){
  ifelse(abs(x) <= 1, x^2, 1)
}

# 或
gv <- function(x){
  y <- numeric(length(x))
  sele <- abs(x) <= 1
  y[sele] <- x[sele]^2
  y[!sele] <- 1.0
  y
}

# 或
gv <- Vectorize(g)
gv(c(-2, -0.5, 0, 0.5, 1, 1.5))
```

### 3. 4 无名函数

```r
# 对前4列分别计算极差
vapply(iris[,1:4], function(x) max(x) - min(x), 0.0)
```

### 3. 5 作用域

函数内部可以读取全局变量的值，但一般不能修改全局变量的值

```r
x.g <- 9999
f <- function(x){
  cat("函数内读取：全局变量 x.g = ", x.g, "\n")
  x.g <- -1
  cat("函数内对与全局变量同名的变量赋值： x.g = ", x.g, "\n")
}
f()
# 可以发现，退出函数后原来的全局变量不变

```

在函数内部如果要修改全局变量的值，用 `<<-`代替`<-`进行赋值

### 3. 6 计算函数

#### 3. 6. 1 数学函数

常用数学函数包括`abs`, `sign`, `log`, `log10`, `sqrt`, `exp`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `atan2`, `sinh`, `cosh`, `tanh`。 还有`gamma`, `lgamma`(伽玛函数的自然对数)。

用于取整的函数有`ceiling`, `floor`, `round`, `trunc`, `signif`, `as.integer`等。 这些函数是向量化的一元函数。

`choose(n,k)`返回从中取的组合数。 `factorial(x)`返回结果。 `combn(x,m)`返回从集合中每次取出个的所有不同取法， 结果为一个矩阵，矩阵每列为一种取法的个元素值。

#### 3. 6. 2 统计函数

`sum`对向量求和, `prod`求乘积。

`cumsum`和`cumprod`计算累计， 得到和输入等长的向量结果。

`diff`计算前后两项的差分（后一项减去前一项）。

`mean`计算均值，`var`计算样本方差或协方差矩阵， `sd`计算样本标准差, `median`计算中位数， `quantile`计算样本分位数。 `cor`计算相关系数。

`colSums`, `colMeans`, `rowSums`, `rowMeans`对矩阵的每列或每行计算总和或者平均值， 效率比用`apply`函数要高。

`rle`和`inverse.rle`用来计算数列中“连”长度及其逆向恢复， “连”经常用在统计学的随机性检验中。

#### 3. 2. 3 最值

`max`和`min`求最大和最小， `cummax`和`cummin`累进计算。

`range`返回最小值和最大值两个元素。

对于`max`, `min`, `range`， 如果有多个自变量可以把这些自变量连接起来后计算。

`pmax(x1,x2,...)`对若干个等长向量计算对应元素的最大值， 不等长时短的被重复使用。 `pmin`类似。 比如，`pmax(0, pmin(1,x))`把`x`限制到内。

#### 3. 2. 4 排序

`sort`返回排序结果。 可以用`decreasing=TRUE`选项进行降序排序。 `sort`可以有一个`partial=`选项， 这样只保证结果中`partial=`指定的下标位置是正确的

```r
sort(c(3,1,4,2,5), partial=3)
## 2 1 3 4 5
```

在`sort()`中用选项`na.last`指定缺失值的处理， 取`NA`则删去缺失值， 取`TRUE`则把缺失值排在最后面， 取`FALSE`则把缺失值排在最前面。

`order`返回排序用的下标序列, 它可以有多个自变量， 按这些自变量的字典序排序。 可以用`decreasing=TRUE`选项进行降序排序。 如果只有一个自变量，可以使用`sort.list`函数。

`rank`计算秩统计量，可以用`ties.method`指定同名次处理方法， 如`ties.method=min`取最小秩。

`order`, `sort.list`, `rank`也可以有 `na.last`选项，只能为`TRUE`或`FALSE`。

`unique()`返回去掉重复元素的结果， `duplicated()`对每个元素用一个逻辑值表示是否与前面某个元素重复。 如

```r
unique(c(1,2,2,3,1))
## 1 2 3
duplicated(c(1,2,2,3,1))
## FALSE FALSE  TRUE FALSE  TRUE
```

