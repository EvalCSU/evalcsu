## Branch management

**理解**：

- 一条时间线，不相互干扰，可创建、删除、切换和合并。

**CVS vs SVN**：

- 集中式控制系统的分支管理开销极大。

### Create and Merge Branch

**命令**：

```
//创建新分支
git branch <branch_name>	//Create <branch_name> branch

//转换到分支上
git checkout <branch_name>	//Switch to <branch_name> branch
	eg:git checkout main
git switch <branch_name>		//Switch to <branch_name> branch
	eg:git switch main
	
//创建并转换到新建分支
git checkout -b <branch_name>	//Create and switch to a new <branch_name> branch
	eg:git checkout -b dev	   <=> git branch <branch_name>
        						 git checkout <branch_name>
git switch -c <branchname>	//Create and switch to a new dev branch
	eg:git switch -c dev

//显示所有分支
git branch	//Show all and present branch

//把分支合并到当前分支
git merge <branch_name>	//Merge <branch_name> to present branch
	eg:git merge dev
	
//删除分支
git branch -d <branch_name>	//Delete <branch_name> branch
	get:git branch -d dev
```

**Attention**：

- `git branch`：列出所有分支，当前分支前面会标一个*号。

### Resolve conflict

**理解**：

- 当Git无法自动合并分支时，就必须要首先解决冲突，解决冲突后，再提交，完成合并。

**参数**：

```
--graph		\\以图的形式显示
	eg:git log --graph (--pretty=oneline --abbrev-commit)
```

**Attention**：

- 合并分支之后，记得删除多余分支。

### Branch management strategy

**理解**：

- Git默认会用`Fast forward`模式合并分支，在这种模式下，删除分支后，会丢掉分支信息；
- `master`分支应该是稳定了，仅用来发布新版本，不能在上面干活；
- 其他分支是不稳定的。

**参数**：

```
--no-ff		\\参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并。
	eg:git merge --no-ff (-m "merge with --no-ff") dev

fast forward	\\合并就看不出来曾经做过合并。
	eg:git merge dev
```

### Bug Branch

**理解**：

- 修复bug：
  1. 储存未完成的分支；
  2. 然后建立Bug分支；
  3. bug修复后；
  4. 合并并删除Bug分支。

**命令**：

```
//储存工作现场
git stash	//Stash working Dictionary

//弹出顶端工作现场
git stash pop	//Pop up top working Dictionary

//列出工作现场
git stash list	//List elements of stash

//删除stash中的工作现场
git stash drop	\\Drop out top element

//恢复指定工作现场
git stash apply stash@{...}		\\Reappear No.<...> element
	eg:git stash apply stash@{0}	\\Reappear No.0 element

//复制修改到当前分支
git cherry-pick <commit_id>	\\Merge dev with bug of master
	eg:git cherry-pick f32c45
```

**Attention**：

- 必须保证当前分支的工作区干净，才能转换到其他分支。

### Feature Branch

**理解**：

- 与bug分支相似；
- 开发一个新的feature，最好建立一个新的分支。

**参数**：

```
-D	\\强制删除
	eg:git branch -D <branchname>
```

### Collaboration

**理解**：

- 推送分支：
  - `master`分支是主分支，因此需要时刻与远程库同步；
  - `dev`分支是开发分支，团队所有成员都需要在上面工作，因此也需要同步；
  - bug分支只用于本低修复bug，不需要同步；
  - feature分支是否推送取决于团队；
  - 本地新建的分支如果不推送到远程，对其他人就是不可见的。
- 抓取分支：
  - 从远程库clone时，默认情况下，只能看到`master`分支；
  - 要建立链接才能抓取分支；
  - 本地和远程分支的名称最好一致。

**指令**：

```
//查看远程库（及地址）
git remote (-v)		//View remote repository (detailedly)

//把暂存区放入仓库
git pull	//Pull index to repository

//建立与远程分支对应的分支
git checkout -b <branch_name> <repository_name>/<branch_name>
	eg:git checkout -b dev origin/dev
	
//建立链接
git branch --set-upstream-to=<repository>/<branch_name> <branch_name>
	eg:git branch --set-upstream-to=origin/dev dev
```

**Attention**：

- 推送分支：
  1. 如果推送失败，则因为远程分支比你的本地更新，需要先用`git pull`试图合并；
  2. 如果合并有冲突，则解决冲突，并在本地提交。
- 抓取分支：
  - `no tracking information`：则说明本地分支和远程分支的链接关系没有创建，用命令`git branch --set-upstream-to <branch-name> origin/<branch-name>`；
  - 如果推送失败，先用`git pull`抓取远程的新提交；
  - 如果有冲突，要先处理冲突。

### Rebase

**理解**：

- rebase操作可以把本地未push的分叉提交历史整理成直线；
- rebase的目的是使得我们在查看历史提交的变化时更容易，因为分叉的提交需要三方对比。

**命令**：

```
//整理分支
git rebase	//Rebase branshes
```





























