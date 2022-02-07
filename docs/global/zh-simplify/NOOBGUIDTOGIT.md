
[> Back](./git-helper/README.md)
# Git新手指导教程
本教程本着以简易明了的语言向git/github新手解释基本概念与流程，如有错误和疏漏，请以谅解和更改
<!-- TOC -->

- [Git新手指导教程](#git新手指导教程)
	- [零、理解基础概念](#零理解基础概念)
		- [工作区](#工作区)
		- [暂存区](#暂存区)
		- [仓库](#仓库)
		- [版本](#版本)
		- [分支](#分支)
	- [一.编写上传项目](#一编写上传项目)
		- [基本模式(ForkFlow工作流)](#基本模式forkflow工作流)
		- [初始化](#初始化)
		- [删除文件](#删除文件)
		- [本地提交](#本地提交)
		- [分支](#分支-1)
		- [远端仓库](#远端仓库)
		- [查看提交的修改](#查看提交的修改)
		- [撤回提交的修改](#撤回提交的修改)
		- [特殊的查找资源小技巧-常用前缀后缀](#特殊的查找资源小技巧-常用前缀后缀)

<!-- /TOC -->
--------------------
## 零、理解基础概念
Git中需要理解基础概念：
- 工作区
- 暂存区
- 仓库
- 版本
- 分支

### 工作区
>工作区是使用主机进行代码和文件编写的区域。使用者若对文件进行增删改操作，其均发生在工作区。
### 暂存区
>暂存区是暂时存储工作区修改操作的区域。使用者所有的文件改动均需要先添加入暂存区（ 对应操作为 add ），再由暂存区提交到当前仓库（ 对应操作为 commit ）。<br>
需要注意的是，暂存区可以包含多个文件的多次改动，可以在工作区修改文件后，进行多次 add 操作，然后再进行一次 commit 操作，将多次同目的的文件修改包含在一次 commit 之中。
### 仓库
>Git 仓库分为两类仓库：本地仓库和远程仓库。<br>
本地仓库，存储在本地主机上，里面所有文件皆被 Git 管理。暂存区提交 commit 后，对应的文件改动会最终保存在本地仓库之中。<br>
远程仓库，代码和文件均寄存在远端服务器上，如 Github 和码云。其也是多地办公、多人协作办公以及文件开源的基础之一。

### 版本
>仓库又称为版本库，在 Git 仓库中的每一次 commit 操作均可以成为一次版本更新， Git 仓库也会存储每次版本的信息，以便日后根据版本对仓库进行回滚和查看等操作。<br>
默认情况下，在 Git/Github 建立仓库时，会建立主分支 main 分支，在其中所有的版本按提交时间先后呈线性排列，由 HEAD 指针和 main 指针共同指向最新的版本，可以通过修改 HEAD 指针的指向改变当前仓库的版本。<br>
值得一提的是， Git 是通过根目录下的隐藏文件夹 .git 文件夹进行版本控制操作和其他操作的，所以谨慎删除该文件夹！
### 分支
>分支是 Git 多人协作的基础，可以通过建立不同的分支，使同时间多人对仓库的修改和操作便利化。<br>
在多人协作的情况下，为了避免冲突，需要建立不同的分支。在使用建立分支的操作（ branch ）建立分支 example 后，当前 HEAD 指针所指的版本会添加一个 example 指针指向当前版本。在使用切换分支的操作（ checkout ）后，HEAD指针会指向 example 指针所指向的版本，并后续跟随 example 指针一同移动。<br>
在完成在对应分支上的工作后，可以通过 merge 操作将该分支合并至主分支。

## 一.编写上传项目
**注意**：以下git命令均在 git bash 上运行，请在主机上下载 Git 程序。另外，有需要的可下载VScode配合使用。相关教程在各大搜索引擎均可搜取
### 基本模式(ForkFlow工作流)
- 工作区 
git add <fileName>
- 暂存区
git commit
- 本地仓库
git push
- 云端（orgin Github）
pull request
- 云端（upstream Github）git pull
***
TIP：每天工作开始之前，必须要先拉取 <br>
TIP：普通程序员，不应当执行merge操作
### 初始化

- 初始化本地仓库：git init

- 克隆远端仓库到本地：
```
	git clone <repository>
	eg: git clone git@github.com:the-fall-moon/evalcsu.git(https://github.com/the-fall-moon/evalcsu.git)
```
添加远端仓库：
```
	git remote add <remote_repository> <SSH>
   	eg: git remote add origin https://github.com/the-fall-moon/evalcsu.git    \\ origin 为默认的远程仓库名称
```

### 删除文件

- 从文件夹中删除文件：rm \<filename>
- 从工作区中移除文件：git rm \<filename>

### 本地提交

- 添加文件到暂存区：
```
	git add <filename>
	eg: git add readme.txt
```

- 把暂存区的文件提交到仓库：
```
	git commmit -m "..." 
    \\-m 后的字符串为伴随本次提交的提示信息
	eg: git commit -m "Create a readme file"
```

### 分支

- 列举所有的分支：git branch
- 重命名分支：git branch -m [oldBranchName] [newBranchName]
- 以当前分支为基础新建分支并切换：git checkout -b [branchName]
- 单纯地切换到某个分支：git checkout [branchName]
- 删掉特定的分支：git branch -D [branchName]
- 合并分支：git merge [branchName]

### 远端仓库

- 推送当前分支最新的提交到远程：
```
	git push <remote_repository> <branch_name>	
	eg: git push (-u) origin master     
    \\ -u 可以推送内容并关联分支，关联后则可使用 git push 代替上述操作
```

- 拉取远程分支最新的提交到本地：
```
	git pull <remote_repository> <branch_name>	
    eg: git pull  origin master  
```

### 查看提交的修改

- 查看提交的历史记录：git log
- 查看简易信息的历史记录：git log --oneline
- 查看附带索引值的简易历史记录：git reflog


### 撤回提交的修改

- 将暂存区文件回滚至工作区：git checkout [fileName]
- 将仓库最后一次提交回滚至暂存区：git reset HEAD^1
- 将按索引值回滚至仓库的某次版本：git reset [索引值]


### 特殊的查找资源小技巧-常用前缀后缀
- 找百科大全 awesome xxx
- 找例子 xxx sample
- 找空项目架子 xxx starter / xxx boilerplate
- 找教程 xxx tutorial


