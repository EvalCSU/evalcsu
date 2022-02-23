
[> Back](./CONTRIBUTION.md)
# Git新手指导教程
本教程本着以简易明了的语言向 Git & Github 新手解释基本概念与流程，如有错误和疏漏，请以谅解和更改

更多 Git 相关操作，请参考[Git Helper](./git-helper/README.md)
<!-- TOC -->

- [Git新手指导教程](#git新手指导教程)
	- [零、理解基础概念](#零理解基础概念)
		- [工作区](#工作区)
		- [暂存区](#暂存区)
		- [仓库](#仓库)
		- [版本](#版本)
		- [分支](#分支)
	- [一、 Pull Request 的基本流程](#一-pull-request-的基本流程)
		- [克隆目标仓库代码](#克隆目标仓库代码)
		- [克隆代码到本地](#克隆代码到本地)
		- [创建自己的分支](#创建自己的分支)
		- [提交修改到本地仓库](#提交修改到本地仓库)
		- [提交修改到远程仓库](#提交修改到远程仓库)
		- [远端合并分支](#远端合并分支)
	- [二、 git 命令总结](#二-git-命令总结)
		- [基本模式（ ForkFlow 工作流）](#基本模式-forkflow-工作流)
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

工作区是使用主机进行代码和文件编写的区域。使用者若对文件进行增删改操作，其均发生在工作区。

### 暂存区

暂存区是暂时存储工作区修改操作的区域。使用者所有的文件改动均需要先添加入暂存区（ 对应操作为 add ），再由暂存区提交到当前仓库（ 对应操作为 commit ）。
	
需要注意的是，暂存区可以包含多个文件的多次改动，可以在工作区修改文件后，进行多次 add 操作，然后再进行一次 commit 操作，将多次同目的的文件修改包含在一次 commit 之中。

### 仓库

Git 仓库分为两类仓库：本地仓库和远程仓库。

本地仓库，存储在本地主机上，里面所有文件皆被 Git 管理。暂存区提交 commit 后，对应的文件改动会最终保存在本地仓库之中。

远程仓库，代码和文件均寄存在远端服务器上，如 Github 和码云。其也是多地办公、多人协作办公以及文件开源的基础之一。


### 版本

仓库又称为版本库，在 Git 仓库中的每一次 commit 操作均可以成为一次版本更新， Git 仓库也会存储每次版本的信息，以便日后根据版本对仓库进行回滚和查看等操作。

默认情况下，在 Git/Github 建立仓库时，会建立主分支 main 分支，在其中所有的版本按提交时间先后呈线性排列，由 HEAD 指针和 main 指针共同指向最新的版本，可以通过修改 HEAD 指针的指向改变当前仓库的版本。
	
值得一提的是， Git 是通过根目录下的隐藏文件夹 .git 文件夹进行版本控制操作和其他操作的，所以谨慎删除该文件夹！

### 分支

分支是 Git 多人协作的基础，可以通过建立不同的分支，使同时间多人对仓库的修改和操作便利化。

在多人协作的情况下，为了避免冲突，需要建立不同的分支。在使用建立分支的操作（ branch ）建立分支 example 后，当前 HEAD 指针所指的版本会添加一个 example 指针指向当前版本。在使用切换分支的操作（ checkout ）后，HEAD指针会指向 example 指针所指向的版本，并后续跟随 example 指针一同移动，而 main 会停留在切换分支前 HAED 指针所指的版本上。

在完成在对应分支上的工作后，可以通过 merge 操作将该分支合并至主分支 main 。


## 一、 Pull Request 的基本流程

**注意**：请先看完[理解基础概念](#零理解基础概念)再跟随本部分进行操作。

### 克隆目标仓库代码

在目标仓库点击 fork 按钮，可以生成一个属于自己的同名仓库，并与原始仓库关联。

![fork](../../../img/git-helper/noodGuideToGit/fork.png)

操作后，可以在自己的主页看到克隆的仓库

![fork_result](../../../img/git-helper/noodGuideToGit/fork_result.png)

### 克隆代码到本地

进入自己的仓库后，点击绿色的 Code 按钮，获取本仓库的 HTTPS 链接。

![clone_local](../../../img/git-helper/noodGuideToGit/clone_local.png)

在你打算存放该代码仓库的目录下，打开 git bash 程序，输入命令 git clone \<repository> ,即可在本地获取到对应代码仓库，并自动与远程仓库关联。

![clone_code](../../../img/git-helper/noodGuideToGit/clone_code.png)

### 创建自己的分支

以当前分支为基础新建分支并切换：
```
git checkout -b <branch_name>
e.g. git checkout -b feat/docs/tfm
```
分支名命名规则：
```
<type>/[faculty]/<your github id>/
e.g. feat/docs/tfm
```
`<type>` 建议参考[提交类型](./CONTRIBUTION.md/#evalcsu-的-commit-注意事项)

### 提交修改到本地仓库

在修改完毕仓库中的代码后，可以通过两种方式将修改后的文件
- 添加单个文件到暂存区：git add \<file_name>
- 添加所有修改后的文件到暂存区：git add -A

把所有提交到暂存区的文件提交到仓库：git commit -m "..."

-m 后的字符串为伴随本次提交的提示信息

**注意**：尽量单次 commit 完成单个任务，不要一个 commit 完成了多个任务或多个 commit 完成单个任务。

### 提交修改到远程仓库

**建议**在每次修改代码前，在 Github 的自己 fork 的仓库中向原始仓库拉取最新的版本，再在本地仓库中执行 git pull 操作，将最新版本获取到本地，防止版本冲突的情况出现。

![fetch_merge](../../../img/git-helper/noodGuideToGit/fetch_merge.png)

拉取远程分支最新的提交到本地：
```
git pull <remote_repository> <branch_name>	
eg: git pull origin main  
```

推送当前分支最新的提交到远程：
```
git push <remote_repository> <branch_name>	
eg: git push origin feat/docs/tfm    
```

### 远端合并分支

打开 GitHub，从个人仓库中选择 `New pull request` 按钮
![github_button](./../../../img/git-helper/noodGuideToGit/github_button.png)

选取本仓库的主分支与你修改过的分支作为比较对象，依照以下方式描述你的修改：
   1. 标题可以按照 `<type>[optional scope]: <description>` 的方式命名
   2. 在 **Related Issue** 中链接到相关 Issue，不可缺失
   3. 在 **Propose changes** 中简述你的改动，不可缺失
   4. 在 **Additional information** 中添加额外信息，可选
   5. 在 **Checklist** 中检查你的任务，不可缺失，但不要求一定完成
   6. 在 **Screenshoot** 中贴上对应截图
   7. 在 **Reviewers** 处添加数个检查者

![github_pull](../../../img/git-helper/noodGuideToGit/github_pull.png)

点击 `Create pull request` 按钮创建你的合并请求

## 二、 git 命令总结

**注意**：以下 git 命令均在 git bash 上运行，请在主机上下载 Git 程序。另外，有需要的可下载 VScode 配合使用。相关教程在各大搜索引擎均可搜取

### 基本模式（ ForkFlow 工作流）

- 工作区 git add <file_name>
- 暂存区 git commit
- 本地仓库 git push
- 云端（ orgin Github ）pull request
- 云端（ upstream Github ）git pull

*******

TIP：每天工作开始之前，必须要先拉取

TIP：普通程序员，不应当执行 merge 操作

### 初始化

- 初始化本地仓库：git init

- 克隆远端仓库到本地：
```
git clone <repository>
eg: git clone git@github.com:the-fall-moon/evalcsu.git
(https://github.com/the-fall-moon/evalcsu.git)
```
- 添加远端仓库：
```
git remote add <remote_repository> <SSH>
eg: git remote add origin https://github.com/the-fall-moon/evalcsu.git    
\\ origin 为默认的远程仓库名称
```

### 删除文件

- 从文件夹中删除文件：rm \<files_name>
- 从工作区中移除文件：git rm \<files_name>

### 本地提交

- 添加文件到暂存区：
```
git add <file_name>
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
- 重命名分支：git branch -m <old_branch_name> <new_branch_name>
- 以当前分支为基础新建分支并切换：git checkout -b <branch_name>
- 单纯地切换到某个分支：git checkout <branch_name>
- 删掉特定的分支：git branch -D <branch_name>
- 合并分支：git merge <branch_name>

### 远端仓库

- 推送当前分支最新的提交到远程：
```
git push <remote_repository> <branch_name>	
eg: git push (-u) origin main    
\\ -u 可以推送内容并关联分支，关联后则可使用 git push 代替上述操作
```

- 拉取远程分支最新的提交到本地：
```
git pull <remote_repository> <branch_name>	
eg: git pull origin main  
```

### 查看提交的修改

- 查看提交的历史记录：git log
- 查看简易信息的历史记录：git log --oneline
- 查看附带索引值的简易历史记录：git reflog


### 撤回提交的修改

- 将暂存区文件回滚至工作区：git checkout <files_name>
- 将仓库最后一次提交回滚至暂存区：git reset HEAD^1
- 将按索引值回滚至仓库的某次版本：git reset <index_value>


### 特殊的查找资源小技巧-常用前缀后缀

- 找百科大全 awesome xxx
- 找例子 xxx sample
- 找空项目架子 xxx starter / xxx boilerplate
- 找教程 xxx tutorial


