[English](../en/CONTRIBUTION.md) [简体中文](../zh-simplify/CONTRIBUTION.md)
## 為 EvalCSU 貢獻

> **請確保你已經仔細閱讀了本指南，在工作流程清晰後再進行操作!**
> 
> 我們歡迎任何形式的貢獻，包括但不限於下列:
> 
> 1. 提出或申請並修正任何 EvalCSU 的內容錯誤 
> 2. 提出任何關於 EvalCSU 的疑惑和建議
> 3. 申請優化或新增課堂筆記、考點思維導圖或實驗課設
> 4. 申請參與課程、實驗或老師的評教
> 5. 申請參與校級、院級或專業級經驗分享
> 6. 將已有的內容翻譯成其他語言
> 
> 若你是我們的協作者，請務必遵循 [Collaborator](#collaborator-協作者) 的要求。
> 
> 若本指南有任何模糊不清的地方，請通過 Issue 和我們反映。

- [為 EvalCSU 貢獻](#為-evalcsu-貢獻)
  - [Issue 模塊](#issue-模塊)
    - [新增 Issue](#新增-issue)
    - [Bug report 模版](#bug-report-模版)
    - [Evaluate request 模版](#evaluate-request-模版)
    - [Feature request 模版](#feature-request-模版)
  - [Pull Request 模塊](#pull-request-模塊)
    - [Pull Request 準備工作](#pull-request-準備工作)
    - [Pull Request 合併分支](#pull-request-合併分支)
  - [Collaborator 協作者](#collaborator-協作者)
    - [注意事項](#注意事項)
    - [Review 流程](#review-流程)
  - [EvalCSU 的 commit 注意事項](#evalcsu-的-commit-注意事項)

> 為了便於指導小白操作，我們將根據 GitHub 的操作模塊進行詳細指導，儘管如此，我們還是建議你多參考已有的 Issue 或者 PR

### Issue 模塊
> Issue 是一種非常好的可沉澱的交流方式，能幫助 EvalCSU 實現答疑交流、反饋缺陷和提出新需求，歡迎你通過 Issue 與我們交流

提出新的 Issue 之前，請你檢查 Open 和 Closed 中是否存在相似 Issue：
- 若 Open 中存在，且無法解決你的疑惑，請在該 Issue 下提出你的問題
- 若 Closed 中存在，但依然無法解決你的疑惑，可以重新新增一個 Issue
- 若都不存在，則在新增你的 Issue 

#### 新增 Issue

1. 進入 Issue 頁麵點擊 `New issue` 按鈕
2. 選擇 `Bug report`, `Evaluate request`, `Feature request` 或新建一個空白模版來初始化你的 Issue
   - Bug report：指出 EvalCSU 中存在的內容錯誤，並提出修正建議，詳細請參考 [Bug report 模版](#bug-report-模版)
   - Evaluate request：向 Manager 提交評教、經驗分享的申請，詳細請參考 [Evaluate request 模版](#evaluate-request-模版)
   - Feature request：向 Manager 提交課堂筆記、考點思維導圖或實驗課設的優化或新增的申請，詳細請參考 [Feature request 模版](#feature-request-模版)
3. 在禁止刪除 **題目（加粗字體）** 的前提下，簡述你的 Issue 內容，面對無法填寫的部分，請以 `NULL.` 代替內容，而非刪除題目
4. 修改標題中的 `<description>` 部分，建議參考已有 Issue
5. 點擊 `Submit new issue` 按鈕提交你的 Issue

#### Bug report 模版

- 仔細閱讀 **題目（加粗字體）** ，盡可能保證 Bug 描述的簡潔性和準確性

**特別注意**

- 通常情況下，Bug report 模版不需要 Email 管理員
- Bug report 模版中，你可以申請參與：
  1. 修正拼寫、詞語錯誤
  2. 修正課堂筆記錯誤
  3. 修正考點思維導圖錯誤（考點更新不納入修正範圍）
  4. 修正實驗課設錯誤
  5. 提出你的建議、疑惑
- 待管理員在該 Issue 下批准，便可移步 [Pull Request 模塊](#pull-request-模塊) 進行下一步操作。

#### Evaluate request 模版

1. 在提交 Issue 前，請到你所在的學院查詢 **管理員** 表格
   - 若不存在對應學院，請重新申請 [Feature request](#feature-request-模版)
   - 若存在對應學院，請 Email 當前年級相近的管理員
2. 在 **Describe the evaluation you want to join** 中簡述你希望參與的內容，務必包含年級、學院和模塊（評教或經驗分享）
3. 在 **Assign the manager you email** 中：
   - 如果未獲得評教、經驗分享資格，@ 所發郵件的管理員
   - 如果已獲得評教、經驗分享資格，填 `NULL.`

**特別注意**

- Evaluate request 模版中，你可以申請參與：
  1. 新增多個課程評教
  2. 新增多級經驗分享
- 為了保護貢獻者的隱私，Issue 和郵件中嚴禁出現個人信息
- 填寫郵件內容時，請前往 `CSU 教務系統` -> `培養管理` -> `我的培養方案`，郵件內容附加全屏截圖即可，建議包含系統時間
- 待管理員在該 Issue 下批准，便可移步 [Pull Request 模塊](#pull-request-模塊) 進行下一步操作。

#### Feature request 模版

1. 在提交 Issue 前，請到你所在的學院查詢 **管理員** 表格
   - 若不存在對應學院，請優先 Email 一級 Reviewer(Rick Lin、jzndd)，同時在該 Issue 中申請添加對應學院
   - 若存在對應學院，請 Email 當前年級相近的管理員
2. 在 **Is your feature request related to a problem? Please describe.** 中簡述你希望參與的內容，務必包含年級、學院和模塊（課堂筆記、考點思維導圖或實驗課設）
3. 在 **Describe the solution you'd like** 中簡述你的最優想法
   - 如果有代替方案，則在 **Describe alternatives you've considered** 中簡述
   - 如果無代替方案， 填 `NULL.`
   - 如果有其他內容，則在 **Additional context** 中簡述
   - 如果無其他內容， 填 `NULL.`
4. 無論是否有相應資格，都需要在 **Assign the manager you email** 中 @ 所發郵件的管理員

**特別注意**

- Feature request 模版中，你可以申請參與且不止於：
  1. 優化或新增多個課堂筆記
  2. 優化或新增多個考點思維導圖
  3. 優化或新增多個實驗課設
  4. 新增新的學院、專業
  5. 將已有內容翻譯為其他語言
- 為了保護貢獻者的隱私，Issue 和郵件中嚴禁出現個人信息
- 填寫郵件內容時，請前往 `CSU 教務系統` -> `培養管理` -> `我的培養方案`，郵件內容附加全屏截圖即可，建議包含系統時間
- 待管理員在該 Issue 下批准，便可移步 [Pull Request 模塊](#pull-request-模塊) 進行下一步操作。

### Pull Request 模塊

> PR 即將你的貢獻合併、發佈到主倉庫中，任何 PR 都需要鏈接到已存在的 Issue，因此，建議你優先閱讀 [Issue 模塊](#issue-模塊)

#### Pull Request 準備工作

1. `fork` 主倉庫到你的 GitHub 倉庫中，並 `git clone` 個人倉庫到本地
2. 在本地新建一個分支
   - 分支命名規則：
      ```
      <your github id>/<optional scope>/<faculty>
      // e.g. jacob953/docs/security
      ```
   - `<optional scope>` 建議參考 [提交類型](#evalcsu-的-commit-注意事項)
3. 在本地新建的分支上完成你的修改，修改要求詳細請參考 **項目搭建原則**
4. 在本地提交 commit 時，請嚴格遵循 [EvalCSU 的 commit 注意事項](#evalcsu-的-commit-注意事項)

**項目搭建原則**

- 禁止修改 .github 文件夾中的任何內容
- 根據提交的內容，可以更改項目目錄結構，但不能修改三個主目錄：
  - code：放置所有課設代碼
  - docs：放置所有文檔，包括：
    - evaluation：評教部分
    - faculty：學院、專業的筆記、考點導圖、課設報告和經驗分享部分
    - global：項目組織文檔等
  - img：放置所有文檔和代碼中的圖片
- 文件類型要求：
  - code 中不能放置壓縮包類型文件，應展示代碼結構
  - docs 中除實驗指導書等內容固定的文件，不能放置 .docx, .pdf, .excl 等類型文件，應使用 .md 類型文件，便於更新和維護
- 文件、文件夾命名要求：
  - 禁止包含中文、特殊字符或空格
  - 需要簡述文檔、文件夾含義，而不是亂碼
- 文件優化、新增要求：
  - 處理的文檔有多個自然語言版本時，請將文件放入 global 中的對應文件夾下，目前僅支持: en, zh-simplify, zh-tradition
    - 應採用同一文件名，不需要添加解釋性後綴
  - 處理的文檔有多個編程語言版本時，請重新構建 code 目錄，並按照語言分類
- 筆記、課設的優化、新增要求：
  - 禁止出現多版本筆記：
    - 若筆記已存在，則應在已有版本上進行迭代
    - 若筆記不存在，則應申請添加新筆記
  - 發生課改時，應在合適的 README.md 中做解釋
- 評教、經驗分享要求：
  - 措辭中肯，評價公正，遵守 [行為準則](../../../README.md#41-行為準則)

#### Pull Request 合併分支

1. 打開 GitHub，從個人倉庫中選擇 `New pull request` 按鈕
2. 選取本倉庫的主分支與你修改過的分支作為比較對象，依照以下方式描述你的修改：
   1. 標題可以按照 `<type>[optional scope]: <description>` 的方式命名
   2. 添加 **Follow** 題目，鏈接到你的 Issue，可請參考 [範例](https://github.com/Jacob953/evalcsu/pull/3)
   3. 添加 **Done** 題目，在題目下方簡述你的修改，可請參考 [範例](https://github.com/Jacob953/evalcsu/pull/3)
   4. 在末尾 @ 對應的管理員
3. 點擊 `Create pull request` 按鈕創建你的合併請求

**特別注意**

- 禁止對本倉庫的 gh-pages 進行任何操作
- 如果參與了評教（或經驗分享）部分，請在 [EVALUATOR.md](../EVALUATOR.md) (或 [SHARER.md](../SHARER.md) ) 中添加你的信息
  - 嚴禁出現個人信息，具有權威性即可

### Collaborator 協作者

#### 注意事項

1. 熟悉 [Issue 模塊](#issue-模塊) 和 [Pull Request 模塊](#pull-request-模塊) 中的所有流程
2. 禁止直接對主分支做任何操作
3. 積極維護平台環境環境，嚴格遵守 [貢獻準則](../../../README.md#31-) 和 [行為準則](../../../README.md#41-)
4. 積極承擔授權和審核的責任，完成授權和審核的工作
5. 積極承擔 Review 的責任，完成 Review 工作

#### Review 流程

1. 進入需要 Review 的 PR 頁面，點擊 `Files changed` 分頁，查看其更改
2. 查看修改後，點擊 `Review changes` 按鈕，輸入你的評論，並依照你的想法選擇下列選項:
   1. Comment：不確定是否通過，只想提供建議
   2. Approve：通過修改
   3. Request changes：否定修改，需要再進行修改
3. 點擊 `Submit review` 按鈕提交個人的看法

**特別注意**

- 此過程為交叉互審，除 Jacob953(owner) 外，至少需要兩名以上的協作者 Approved 後才能合併
### EvalCSU 的 commit 注意事項

1. 請盡量於本地進行 commit，有較大的操作空間與彈性。
2. 對於有關聯的更改，請通過 `git commit` 記錄，然後再一次性提交 PR。
3. 遵循以下的提交 commit 格式

```
<type>[optional scope]: <description>
```

**提交類型**
<div>
  <table margin="center">
    <thead>
        <tr>
            <th>type</th>
          	<th>description</th>
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