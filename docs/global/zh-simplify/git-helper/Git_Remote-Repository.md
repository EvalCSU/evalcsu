## Remote Repository

**Git vs SVN**：分布式版本控制系统下，同一个Git仓库可以分布到不同的机器上。

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

3. 在github中，Account setting  $\rightarrow$ SSH and GPG keys，中添加SSH key即可。

**Attention**：

- Github允许添加多个key；
- 保护Git库：
  1. 把版本库变为私有；
  2. 自己搭建Git服务器，内部开发必备。

### Add origin repository

**步骤**：

1. Github $\rightarrow$ New repository

2. Repository name $\rightarrow$ 填入\<repositoryname>

3. Create repository

4. 把一个本地仓库与之关联：

   ```
   git remote add <remote_repository> <SSH>
   	eg:git remote add origin https://github.com/Jacob953/BianTeam.git 
   ```

5. 把本地仓库的所有内容上传到远程库：

   ```
   git push （-u） origin master
   ```

**命令**：

```
//将本地库推送到远程库的分支
git push <remote_repository> <branch_name>		//Push local to remote branch
	eg:git push (-u) origin master
```

**参数**：

```
-u	//既能推送内容，又能关联分支，可以为以后推送和拉取简化命令
```

**Attention**：

- `origin`：远程库的Git默认叫法，可以更改。

### Clone repository

**命令**：

```
//克隆远程库到本地
git clone <repository>	//Clone a repository
	eg:git clone git@github.com:Jacob953/BianSecurity.git(https://github.com/Jacob953/BianSecurity.git)
```

**理解**：

- Git支持其他协议，但一般使用`git://`。
- `https`：速度慢，每次推送都必须输入口令。