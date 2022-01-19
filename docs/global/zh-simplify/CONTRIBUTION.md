## 为EvalCSU贡献
### [English](CONTRIBUTION.md) [繁体中文](CONTRIBUTION_zh_tradition.md)

我们欢迎任何形式的贡献，包括但不限于下列:

- [修正任何文档的拼写错误或课设的臭虫，或将已有的内容翻译成其他语言](#fix)
- [提出任何你认为本项目不完善的地方](#suggest)
- [新增任何课堂或是考试的笔记以及思维导图](#new)
- [新增你制作的课设，最好包含课设实验报告](#new)
- [新增你对于课程，课设以及老师的评教](#eval)

## 注意事项

1. 做出任何贡献之前，请确保你已经仔细阅读了本说明，若本指南有任何模糊不清的地方，可以[透过 Issue 和我们反映](#suggest)，在完全了解工作流程之后再进行操作。
2. 假如你是协作者 (Collaborator) ，也应当遵守一般的工作流程，任何更动都**不应直接提交到本仓库内**。
3. 协作者的评审 (Review) 应当遵守我们的 [Review流程]()


## <a name="eval"></a>成为进行评教参与者
1. 请选择**evaluate-request**模板发起 Issue 来提交你的申请，你可以参阅[指南](#issue)
2. 向评教管理员发送email通知
3. 评教管理员于 Issue 同意

## 提交评教内容
1. 提交评教内容之前，请确保你已经成为了我们的参与者
2. 透过合并请求发起你的修改，如何发起合并请求请见[下方](#28-)
3. 在该 PR 内必须连结之前管理员同意你成为参与者的 Issue ，以进行核验

## <a name="fix"></a>提交你的修正与翻译
 
1. 若你要修正的拼写错误、臭虫已经有了对应的 Issue，于之后的合并请求内连接 (Link) 到该Issue，若无，则请先以**bug-report**模板发起一个关于该问题的Issue，并同样于之后的合并请求连接。
2. 提交你的合并请求，如何提交，请见，新增所有项目的协作者 (Collaborator) 作为 reviewer，指定 (assgin) 负责该专业的评教管理员

## <a name="suggest"></a>提交你的建议

1. 请先透过浏览过往的 Issue 确保你的问题是否已经被提交过，若无，请通过**fetcher-request**模板进行提交，若你不知道如何提交 Issue ，请参照[指南](#issue)。

## <a name="new"></a>提交你想要新增的课设、笔记以及思维导图

1. 请先透过**pull-request**模板提交一个 Issue ，描述你想要进行的工作。
2. 发起你的个合并请求，并连结到此 Issue，如何发请合并请求请参阅[指南](#pr)。

## 提交指南

### <a name="issue"></a> 提交 Issue

1. 进入议题 (Issue) 页面点击 New issue 按钮
2. 选择对应的模板来新增你的议题
3. 若是评教，请指定 (assign) 负责该专业的评教管理员，其他 Issue 请指定所有的协作者
4. 点击 Submit new issue 提交你的 Issue

### <a name="pr"></a> 提交合并请求 (Pull Request)

1. 复刻(fork)并拉取(pull)此仓库到你的github帐号下
2. 在你复刻的仓库内新增一个分支(请勿于主分支(master)上进行合并请求)
3. 于此分支上提交你的更改，提交时请遵守我们的[提交格式](#format)
4. 进入 Pull requests 页面，选择 New pull request
5. 选取本仓库的主分支 (main) 与你修改过的分支作为比较对象，依照以下方式描述你的修改
   1. 标题请依照 ```类型: --时间 简述```的方式命名
   2. 在内文概要的描述你修改的内容与目的
   3. 在内文新增Done标题，在标题下方详细叙述你具体的修改，以及每个修改的目的
   4. 具体请参考[范例](https://github.com/Jacob953/evalcsu/pull/3)
6. 点击 Create pull request 创建你的合并请求

请将你的合并请求与议题描述的尽可能清晰，并使用`NULL`去填写你不知道如何填写的栏位，而不是将其删除。

### 想要知道甚么是 Pull request 和 Issue
请参考我们的[新手指南](NOOBGUIDE.md)

### <a name="format"></a> EvalCSU 的提交格式

请遵循以下的提交(commit)格式

```
<类型>[可选区域]: <提交描述>
```

**提交类型**
<div>
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
