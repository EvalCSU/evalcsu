# get Git tips

## Git  introduction

**本质**：C语言开发的分布式版本控制系统。

> 版本控制系统：能管理所有文件，但只能追踪文本文件的内容改动，而不能追踪二进制文件的内容变化。

**分布式vs集中式**：

- 结构：分布式控制系统没有中心服务器，每个人的电脑本身就是完整的数据库。
- 传输大小：分布式仅需要传输改动部分，集中式需要传输整个文件。
- 连接性：分布式不需要联网，集中式必须联网，极易受到网速的影响。
- 安全性：分布式只有破坏所有结点才会瘫痪，集中式只需要破坏中心服务器即可。

**参数**：	

```
--global	\\表示对指定用户的所有的Git仓库都会使用这个配置。
-m			\\提示说明
--pretty=oneline	\\单行显示
```

### Repository

**定义**：版本库又叫版本库，可以看作一个目录，里面的所有文件都被Git管理起来。

> 编码选择：UTF-8编码，不会引起冲突，又被所有平台支持。
>
> 软件选择：Notepad++，而不是记事本，因为记事本会在文件开头添加0xefbbbf，会导致语法错误等

**命令**：

```
mkdir ...	\\Create ... folder
	eg:mkdir LearningGit
cd ...		\\Enter ... folder
	eg:cd LearningGit
pwd			\\Show present locaiton
ls (-ah)	 \\Show (including the hidden) files 
git init	 \\Create a enpty repository
touch <filename>	  \\Creat new <file> file
	eg:touch readme.txt
git add <filename>	  \\Add <file> to repository
	eg:git add readme.txt
git commmit -m "..."	  \\Commit repository
	eg:git commit -m "Create a readme file"
```

**add & commit**:

`add`：多次提交不同的文件，仅把文件修改添加到暂存区。

`commit`：一次提交多个文件，把暂存区的所有内容题交到当前分支，且能附上说明。

**Attention**:

`fatal: not a git repository (or any of the parent directories)`：没有在repository中执行git指令，cd到repository中即可。

`fatal: pathspec '<filename>' did not match any files`：添加\<filename>与创建\<filename>不一样，存在才能添加，因此touch \<filename>即可。

## Time Travel

**命令**：

```
git status	\\Show presente status of repository
git diff <filename>	\\Check difference
	eg:git diff readme.txt
```

### back version

**命令**：

```
git log		\\Check log
	eg:git log (--pretty=oneline)
git reset <version/HEAD>	\\Reset to No.id version  
	eg:git reset --hard HEAD^/HEAD^^/HEAD~2/123a1s
cat <filename>	\\Show the imformation of <filename>
	eg:car readme.txt
git reflog	 \\Show command history
```

**Attention**：

`git log --pretty=oneline`：前面的一串16进制的是版本号，Git是分布式的版本控制系统，因此，不能采用1，2，3…的形式。

`HEAD`：HEAD表示当前版本，HEAD\^表示上1个版本，HEAD^^表示上2个版本，HEAD~n表示上n个版本。

`--hard`：

`version`：版本号只需要写开头就行，Git会自动检索。

### Working Directory & Stage/Index

**理解**：

- `LearningGit`文件夹就是一个工作区，但其中的`.git`并不算在工作区内，因为它是Git的版本库。
- `.git`中包含了暂存区，自动创建的第一个分支`mastter`，指针`HEAD`。
- `master`自动生成且唯一。

### Management of change

**理解**：Git仅管理的是修改，`git add`把工作区的修改放到暂存区中，准备提交，`git commit`是把暂存区的修改提交到分支中，因此，在`git add`后修改的内容无法提交。

### Undo modify

**命令**：

```
git checkout -- <filename>	\\Undo status once
	eg:git checkout -- readme.txt
git reset HEAD <filename>	\\Push back to Working Directory from Stage
	eg:git reset HEAD readme.txt
```

**理解**:

- 如果文件未放入暂存区，则恢复到版本库。
- 如果文件已经添加到暂存库，则恢复到暂存库。

**Attention**：

`--`：不可省略，否则将变为“切换到另外一个分支”的命令。

### Delete file

**命令**：

```
rm <filename>	\\Delete file from folder
git rm <filename>	\\Delete file from repository 
```

**Attention**：

- `git checkout -- <filename>`即可恢复误删文件。
- 未提交到版本库的文件无法恢复。

## Remote Repository

**Git vs SVN**：同一个Git仓库可以分布到不同的机器上

**步骤**：

1. 拥有自己的github账号

2. 创建SSH Key

   - 检查用户主目录下是否有.ssh：

     ```
     cd ~
     ls -ah
     ```

   - 如果没有，则打开Shell/Git Bash，创建一个：

     ```
     ssh-keygen -t rsa -C "youremail@example.com"
     ```

   - .ssh中有两个文件：id_rsa，id_rsa.pub，密钥和公钥，信安人不多做解释。

3. 在github中，Account setting -> SSH and GPG keys，中添加SSH key即可。

**Attention**：

- Github允许添加多个key。
- 保护Git库：
  1. 把版本库变为私有。
  2. 自己搭建Git服务器，内部开发必备。

### Add origin repository

**步骤**：

1. Github -> New repository

2. Repository name -> 填入\<repositoryname>

3. Create repository

4. 把一个本地仓库与之关联：

   ```
   git remote add origin https://github.com/Jacob953/BianSecurity.git
   ```

5. 把本地仓库的所有内容上传到远程库：

   ```
   git push -u origin master
   ```

**命令**：

```
git push <originrepository>		\\Push master to origin repository
	eg:git push (-u) origin master
```

**参数**：

```
-m	\\既能推送内容，又能关联分支，可以为以后推送和拉取简化命令
```

**Attention**：

- `origin`：远程库的Git默认叫法，可以更改。

### Clone repository

**命令**：

```
git clone <repository>	\\Clone a repository
	eg:git clone git@github.com:Jacob953/BianSecurity.git(git remote add origin https://github.com/Jacob953/BianSecurity.git)
```

**Attention**：

- Git支持其他协议，但一般使用`git://`。
- `https`：速度慢，每次推送都必须输入口令。

## Branch management

**理解**：一条时间线，不相互干扰，可创建、删除、切换和合并。

### Create and Merge Branch

**命令**：

```
git checkout -b <branchname>	\\Create and switch to a new dev branch
	eg:git checkout -b dev
	the same:git branch <branchname>
			git checkout <branchname>
git checkout <branchname>	\\Switch to <branchname> branchname
	eg:git checkout main
git branch	\\Show all and present branch
git merge <branchname>	\\Merge <branchname> to present branch
	eg:git merge dev
git branch -d <branchname>	\\Delete <branchname> branch
	get:git branch -d dev
git switch -c <branchname>	\\\\Create and switch to a new dev branch
	eg:git switch -c dev
git switch <branchname>		\\Switch to <branchname> branchname
	eg:git switch main
```

**Attention**：

- `git branch`：列出所有分支，当前分支前面会标一个*号。

### Resolve conflict

**理解**：当Git无法自动合并分支时，就必须要首先解决冲突，解决冲突后，再提交，完成合并。

**参数**：

```
--graph		\\以图的形式显示
	eg:git log --graph --pretty=oneline --abbrev-commit
```

**Attention**：

- 合并分支之后，记得删除多余分支。

### Branch management strategy

> 通常，合并分支时，如果可能，Git会用`Fast forward`模式，但这种模式下，删除分支后，会丢掉分支信息。

**理解**：

- `master`分支应该是稳定了，仅用来发布新版本，不能在上面干活。
- 其他分支是不稳定的。

**参数**：

```
--no-ff		\\参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并。
	eg:git merge --no-ff (-m "merge with --no-ff") dev
fast forward	\\合并就看不出来曾经做过合并。
	eg:git merge dev
```

### Bug Branch

**命令**：

```
git stash	\\Push in and stash
git stash pop	\\Pop up and reappear
git stash list	\\List elements of stash
git stash drop	\\Drop out top element
git stash apply stash@{...}		\\Reappear No.<...> element
	eg:git stash apply stash@{0}	\\Reappear No.0 element
git cherry-pick <commitid>	\\Merge dev with bug of master
	eg:git cherry-pick f32c45
```

**理解**：

- 修复bug，第一步是储存未完成的分支。
- 然后建立新的分支，bug修复后，合并并删除分支。

**Attention**：

- `git cherry-pick <commitid>`：在master上修复的bug，合并到dev，不可逆。

### Feature Branch

**理解**：

- 与bug分支相似。
- 开发一个新的feature，最好建立一个新的分支。

**参数**：

```
-D	\\强制删除
	eg:git branch -D <branchname>
```

### Collobration

**理解**：

1. 首先，可以试图用`git push origin <branch-name>`推送自己的修改；
2. 如果推送失败，则因为远程分支比你的本地更新，需要先用`git pull`试图合并；
3. 如果合并有冲突，则解决冲突，并在本地提交；
4. 没有冲突或者解决掉冲突后，再用`git push origin <branch-name>`推送就能成功！

如果`git pull`提示`no tracking information`，则说明本地分支和远程分支的链接关系没有创建，用命令`git branch --set-upstream-to <branch-name> origin/<branch-name>`。

- 查看远程库信息，使用`git remote -v`；
- 本地新建的分支如果不推送到远程，对其他人就是不可见的；
- 从本地推送分支，使用`git push origin branch-name`，如果推送失败，先用`git pull`抓取远程的新提交；
- 在本地创建和远程分支对应的分支，使用`git checkout -b branch-name origin/branch-name`，本地和远程分支的名称最好一致；
- 建立本地分支和远程分支的关联，使用`git branch --set-upstream branch-name origin/branch-name`；
- 从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突。

**指令**：

```
git remote (-v)		\\View remote repository (detailedly)
git push <remoterepositoryname> <branch>	\\Push <branchname> to <remoterepositoryname>
	eg:git push origin master
git pull	\\Pull index to repository

```

**Attention**：

- `master`分支是主分支，因此需要时刻与远程库同步。
- `dev`分支是开发分支，团队所有成员都需要在上面工作，因此也需要同步。
- bug分支只用于本低修复bug，不需要同步。
- feature分支取决于团队。
- 从远程库clone时，默认情况下，只能看到`master`分支。

### Rebase

**理解**：

- rebase操作可以把本地未push的分叉提交历史整理成直线；
- rebase的目的是使得我们在查看历史提交的变化时更容易，因为分叉的提交需要三方对比。

## Tag management

**理解**：

- 标签相当于指针，指向`commit_id`。
- 标签不可移动。

### Tag Creation

**命令**：

```
git tag <tag_name>	\\Creat a tag for present branch
git tag -a <tag_name> -m "<information>" <commit_id>	\\Creat speacial tag
git tag		\\View all tags
git show <tag_name>		\\Show information of <tag_name>
```

**Attention**：

- 标签总是和某个commit挂钩。如果这个commit既出现在master分支，又出现在dev分支，那么在这两个分支上都可以看到这个标签。

### Tag Delete

**命令**：

```
git tag -d <tag_name>	\\Delete local <tag_name>
git push <repository_name> <tag_name>	\\Push <tag_name> to repository
git push <repository_name> --tags	\\Push all tags
git push <repository_name> :refs/tags/<tag_name>	\\Delete remote <tag_name>
```

**Attention**：

- 删除远程库标签前记得先删除本地标签。
- 标签创建于本地，可以不用提交。

## Custom Git