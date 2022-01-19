## Tag management

**理解**：

- 标签相当于指针，指向<commit_id>；
- 标签不可移动。

### Tag Creation

**命令**：

```
//为当前版本创建标签
git tag <tag_name>	//Creat <tag_name> tag for present branch
	eg:git tag v1.0

//为特定版本创建标签
git tag -a <tag_name> -m "<message>" <commit_id>	//Creat speacial tag
	eg:git tag -a v1.0 -m "version1.0" 4as2

//查看所有标签
git tag		//View all tags

//查看特定标签内容
git show <tag_name>		//Show message of <tag_name>
	eg:git show v1.0
```

**Attention**：

- 如果一个commit既出现在master分支，又出现在dev分支，那么在这两个分支上都可以看到这个conmit的标签。

### Tag Delete

**命令**：

```
//删除本地标签
git tag -d <tag_name>	//Delete local <tag_name>

//推送特定标签
git push <repository_name> <tag_name>	//Push <tag_name> to repository

//推送所有标签到远程
git push <repository_name> --tags	//Push all tags

//删除远程标签
git push <repository_name> :refs/tags/<tag_name>	//Delete remote <tag_name>
```

**Attention**：

- 删除远程库标签前记得先删除本地标签；
- 标签创建于本地，可以不用提交。