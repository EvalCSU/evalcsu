# Time Travel

**命令**：

```
//查看状态
git status	//View presente status of working tree

//查看文件具体修改内容
git diff <file_name>	View difference of <file_name>
	eg:git diff README.md
```

## back version

**命令**：

```
//查看历史记录
git log		//View history log( in oneline)
	eg:git log (--pretty=oneline)

//版本退回
git reset --hard <commit_id/HEAD>		//Reset to No.id version  
	eg:git reset --hard HEAD^/HEAD^^/HEAD~2/123a1s

//查看文件内容
cat <file_name>	//View imformation of <file_name>
	eg:cat readme.txt
	
//查看所有命令
git reflog	 //View history of commit

//找回所有 git-add 的文件
git fsck --lost-found
```

**参数**：

```
--pretty=oneline	//美化并用一行显示
--hard	//强制
```

**理解**：

- 版本退回指的是退回到特定地址，或者 `HEAD` 指针所在位置；
- Git是分布式的版本控制系统，因此，\<commit_id> 不能采用1，2，3…的形式，而是16进制字符。

**Attention**：

`HEAD`：HEAD表示当前版本
  - HEAD\^ 表示上1个版本
  - HEAD^^ 表示上2个版本
  - HEAD~n 表示上n个版本

`version`：版本号只需要写开头就行，Git会自动检索。

## Working Directory & Stage/Index

**理解**：

- `LearningGit` 文件夹就是一个工作区，但其中的 `.git` 并不算在工作区内，因为它是 Git 的版本库
- `.git` 中包含了暂存区，自动创建的第一个分支——主分支 `master`，指针 `HEAD`
- 主分支 `master` 自动生成且唯一，并且名称可以自定义

## Management of change

**理解**：

- Git 仅管理的是修改：
  - `git add` 把工作区的修改放到暂存区中，准备提交；
  - `git commit` 是把暂存区的修改提交到分支中。
- 在 `git add` 后,再次修改的内容就无法提交到分支，需要再次 `git add`

## Undo Modify

**命令**：

```
//撤销一次
git checkout -- <file_name>	//Undo status once
	eg:git checkout -- readme.txt
	
//把暂存区的修改撤销掉
git reset HEAD <file_name>	//Push <file_name> file back to Working Directory from Stage
	eg:git reset HEAD readme.txt
```

**理解**:

- `git checkout -- <file_name>`：
  - 如果文件未放入暂存区，则恢复到版本库时的版本；
  - 如果文件已经添加到暂存区，则恢复到添加到暂存区后的版本。

**Attention**：

`--`：不可省略，否则将变为“切换到另外一个分支”的命令。

## Delete file

**命令**：

```
//删除本低文件
rm <filename>	\\Delete file from folder

//删除仓库文件
git rm <filename>	\\Delete file from repository 
```

**理解**：

- `git checkout -- <filename>`：可恢复误删文件，前提是文件已被添加到暂存区
- 未提交到版本库的文件无法恢复