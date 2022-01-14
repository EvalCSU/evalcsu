## 为EvalCSU贡献
## Contribute to EvalCSU
### [English](CONTRIBUTION.md) [繁體中文](CONTRIBUTION_zh_tradition.md)

我们欢迎任何形式的贡献，包括但不限于下列:

- 修正任何文档的拼写错误或课设的臭虫
- 新增任何课堂或是考试的笔记以及心智图，或将已有的内容翻译成其他语言
- 新增你制作的课设，最好包含课设实验报告
- 新增你对于课程，课设以及老师的评教

### 工作流程
**进行评教**
1. 申请成为评教参与者
   1. 进入议题(issue)页面点击New issue按钮
   2. 选择***申请评教***模板来新增你的议题(issue)
   3. 指定(assign)负责该专业的评教管理员
   4. 向评教管理员发送email通知
   5. 评教管理员于issue同意
2. 提交评教内容
   1. 透过合并请求发起你的修改，如何发起合并请求请见[下方](#28-)
   2. 在该pr内必须连结之前管理员同意你成为参与者的issue，以进行核验

**提供实验课设或实验报告**
 
1. 发起一个合并请求，新增所有项目的协作者(Collaborator)作为reviewer，指定(assgin)负责该专业的评教管理员

**如何发起合并请求(Pull Request)**

1. 复刻(fork)并拉取(pull)此仓库的最新版本
2. 新增一个分支(请勿于主分支(master)上进行合并请求)
3. 提交你的更改
4. 进入Pull requests页面，选择new pull request
5. 选取主分支与你修改过的分支作为比较对象，依照以下方式描述你的修改
   1. 标题请依照 ```类型: --时间 简述```的方式命名
   2. 在内文概要的描述你修改的内容与目的
   3. 在内文新增Done标题，在标题下方详细叙述你具体的修改，以及每个修改的目的
   4. 具体请参考[范例](https://github.com/Jacob953/evalcsu/pull/3)
6. 点击Create pull request创建你的合并请求

请将你的合并请求与议题描述的尽可能清晰，并使用`NULL`去填写你不知道如何填写的栏位，而不是将其删除。

### 想要知道甚么是"pull request"和"issue"
请参考我们的[新手指南](NOOBGUIDE.md)

### EvalCSU 的提交格式

请遵循以下的提交(commit)格式

```
<类型>[可选区域]: <提交描述>
```

**提交类型**

  <table margin="center">
    <thead>
        <tr>
            <th>类型</th>
          	<th>解释</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>feat</td>
            <td>新增新的功能</td>
        </tr>
      	<tr>
            <td>fix</td>
            <td>修正bug</td>
     		</tr>
     	 	<tr>
            <td>docs</td>
            <td>更新文档</td>
      	</tr>
      	<tr>
            <td>test</td>
            <td>新增或更新测试</td>
      	</tr>
      	<tr>
            <td>style</td>
            <td>格式化文档或代码</td>
      	</tr>
      	<tr>
            <td>chore</td>
            <td>其他提交类型</td>
      	</tr>
    </tbody>
  </table>
</div>

