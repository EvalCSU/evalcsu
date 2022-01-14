# Git/Github使用教程

author:Zhao Qihan

## 零.基础
Git里的三个概念：
- commit
- repository
- branch

## 一.看别人的代码 
### 1.基本操作
- git clone
- repository: README.md/ LICENSE/ Star 
- commit: 
- branch:
- issue

### 2.找开源项目的一些途径•
https://github.com/trending/•
https://github.com/521xueweihan/HelloGitHub• https://github.com/ruanyf/weekly• https://www.zhihu.com/column/mm-fe

### 3.特殊的查找资源小技巧-常用前缀后缀•
找百科大全 awesome xxx• 
找例子 xxx sample• 
找空项目架子 xxx starter / xxx boilerplate• 
找教程 xxx tutorial


## 二.自己发布项目
### 基本模式(ForkFlow工作流)
- 工作区 
git add<file>
- 暂存区
git commit
- 本地仓库
git push
- 云端（orgin Github）
pull request
- 云端（upstream Github）
***
- 云端（upstream Github）
git pull
- 本地仓库
***
TIP：每天工作开始之前，必须要先拉取
TIP：普通程序员，不应当执行merge操作


### 初始化
初始化本地仓库：git init
添加远端仓库：…

### 首次提交
添加文件到暂存区：git add -A（VS Code中有可视化操作）
把暂存区的文件提交到仓库：git commit -m（VS Code中有可视化操作）

* 关于分支
branchname列举所有的分支：git branch
单纯地切换到某个分支：git checkout [branchName]
删掉特定的分支：git branch -D [branchName]
合并分支：git merge [branchName]

### 修改 与 提交
以当**前分支为基础**新建分支并切换：git checkout -b [branchName]
添加文件到暂存区：git add -A（VS Code中有可视化操作）
把暂存区的文件提交到仓库：git commit -m（VS Code中有可视化操作）
推送**当前分支**最新的提交到远程：git push（ [remoReName] [branchName]）

### 查看提交的修改
提交信息查看提交的历史记录：git log --stat（有视图界面）

### 撤回提交的修改
工作区回滚：git checkout [fileName]
撤销最后一次提交：git reset HEAD^1
时间过于久远，则用fileHistory，找到曾经代码，手动修改，做一次新的提交

### 拉取最新分支
拉取远程分支最新的提交到本地：git pull （ [remoReName] [branchName]）

### 审核 与 合并
合并分支：git merge [branchName]


## Reference
[40 分钟学会 Git | 日常开发全程大放送&搭配Github_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1db4y1d79C)
[【保姆教程】小白团队如何通过Github进行协作开发_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1df4y1m7B1?from=search&seid=12428742913382340913&spm_id_from=333.337.0.0)
[ApacheCN-GitHub入门操作-Fork到PullRequests_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Hx411u7rK?from=search&seid=11898529149951406951&spm_id_from=333.337.0.0)


