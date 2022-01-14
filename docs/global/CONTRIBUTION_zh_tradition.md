## 爲EvalCSU貢獻
## Contribute to EvalCSU
### [English](CONTRIBUTION.md) [简体中文](CONTRIBUTION_zh_simplify.md)

我們歡迎任何形式的貢獻，包括但不限於下列:

- 修正任何文檔的拼寫錯誤或課設的臭蟲
- 新增任何課堂或是考試的筆記以及心智圖，或將已有的內容翻譯成其他語言
- 新增你製作的課設，最好包含課設實驗報告
- 新增你對於課程，課設以及老師的評教
- 
### 工作流程
**進行評教**
1. 申請成為評教參與者
   1. 進入議題(issue)頁面點擊New issue按鈕
   2. 選擇***申請評教***模板來新增你的議題(issue)
   3. 指定(assign)負責該專業的評教管理員
   4. 向評教管理員發送email通知
   5. 評教管理員於issue同意
2. 提交評教內容
   1. 透過合併請求發起你的修改，如何發起合併請求請見[下方](#28-)
   2. 在該pr內必須連結之前管理員同意你成為參與者的issue，以進行核驗

**提供實驗課設或實驗報告**
 
1. 發起一個合併請求，新增所有項目的協作者(Collaborator)作為reviewer，指定(assgin)負責該專業的評教管理員

**如何發起合併請求(Pull Request)**

1. 復刻(fork)並拉取(pull)此倉庫的最新版本
2. 新增一個分支(請勿於主分支(master)上進行合併請求)
3. 提交你的更改
4. 進入Pull requests頁面，選擇new pull request
5. 選取主分支與你修改過的分支作為比較對象，依照以下方式描述你的修改
   1. 標題請依照 ```類型: --時間 簡述```的方式命名
   2. 在內文概要的描述你修改的內容與目的
   3. 在內文新增Done標題，在標題下方詳細敘述你具體的修改，以及每個修改的目的
   4. 具體請參考[範例](https://github.com/Jacob953/evalcsu/pull/3)
6. 點擊Create pull request創建你的合併請求

請將你的合併請求與議題描述的盡可能清晰，並使用`NULL`去填寫你不知道如何填寫的欄位，而不是將其刪除。

### EvalCSU 的提交格式

請遵循以下的提交(commit)格式

```
<類型>[可選區域]: <提交描述>
```

**提交類型**

  <table margin="center">
    <thead>
        <tr>
            <th>類型</th>
          	<th>解釋</th>
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
            <td>更新文檔</td>
      	</tr>
      	<tr>
            <td>test</td>
            <td>新增或更新測試</td>
      	</tr>
      	<tr>
            <td>style</td>
            <td>格式化文檔或代碼</td>
      	</tr>
      	<tr>
            <td>chore</td>
            <td>其他提交類型</td>
      	</tr>
    </tbody>
  </table>
</div>
