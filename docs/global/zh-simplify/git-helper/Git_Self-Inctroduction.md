# Git  introduction

**本质**：C语言开发的分布式版本控制系统。

> 版本控制系统：能管理所有文件，但只能追踪文本文件的内容改动，而不能追踪二进制文件的内容变化。

**分布式 vs 集中式**：

- 结构：分布式控制系统没有中心服务器，每个人的电脑本身就是完整的数据库。
- 传输大小：分布式仅需要传输改动部分，集中式需要传输整个文件。
- 连接性：分布式不需要联网，集中式必须联网，极易受到网速的影响。
- 安全性：分布式只有破坏所有结点才会瘫痪，集中式只需要破坏中心服务器即可。

## Download

**Linux**：

1. 命令行安装：
   - `git`：检查系统是否安装Git；
   - `sudo apt-get install git(git-core)`：直接安装Git，Debian或者较老的Ubuntu需要用`git-core`，因为还有一个软件叫GIT。
2. 手动安装：
   - 从官网下载源码，并进入对应文件夹，打开命令行；
   - `./config`：配置文件；
   - `make`：生成make文件；
   - `sudo make install`：安装Git。

**Mac OS X**：

利用集成软件下载即可：

1. homebrew：
   - `brew install git`：下载Git。
2. Xcode：
   - `Xcode`$\rightarrow$`Preferences`$\rightarrow$`Download`$\rightarrow$`Command Line Tools`。

**Windows**：

1. [Git官网下载直通车](https://git-scm.com/downloads)；
2. 在命令行中输入Git，有帮助提示则说明下载成功。

**命令**：

```
//输入你的名字
git config --global user.name "Yourname"
	eg:git config --global user.name "Loptr"

//输入你的邮箱
git config --global user.email "email@example.com"
	eg:git config --global user.email "710297349@qq.com"
```

**参数**：	

```
--global	//表示对指定用户的所有的Git仓库都会使用这个配置。
```

**Attention**：

- 输入的名字和邮箱只是为你的机器提供了一种确定的身份。

## Repository

**定义**：仓库又叫版本库，可以看作一个目录，里面的所有文件都被Git管理起来。

> 编码选择：UTF-8编码，不会引起冲突，又被所有平台支持。
>
> 软件选择：Notepad++，而不是记事本，因为记事本会在文件开头添加0xefbbbf，会导致语法错误等

**命令**：

```
//创建文件加
mkdir <folder_name>	//Create <folder_name> folder
	eg:mkdir BianTeam

//载入文件夹（目录）
cd <folder_name>	//Enter <folder_name> folder
	eg:cd BianTeam/
	
//显示当前目录
pwd			//Show present catalog

//刷新（并显示所有文件）
ls (-ah)	 //Refresh and （show all files）

//初始化仓库
git init	 \\Create and initial a enpty repository

//创建文件
touch <file_name>	  \\Create a new <file_name> file
	eg:touch readme.md
	
//提交文件到暂存区
git add <file_name>	  \\Add <file_name> to index
	eg:git add readme.md
	
//提交文件到分支
git commmit -m "<message>"	  \\Commit all files to branch
	eg:git commit -m "Create a readme file"
```

**理解**：

1. `add`&`commit`：

- `add`：多次提交不同的文件，仅把文件修改添加到暂存区。
- `commit`：一次提交多个文件，把暂存区的所有内容题交到当前分支，且能附上说明。

**Attention**:

- `fatal: not a git repository (or any of the parent directories)`：没有在repository中执行git指令，cd到repository中即可。
- `fatal: pathspec '<filename>' did not match any files`：添加\<filename>与创建\<filename>不一样，存在才能添加，因此touch \<filename>即可。