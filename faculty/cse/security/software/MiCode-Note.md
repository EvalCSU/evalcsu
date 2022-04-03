# [MiCode/Note] 结合CSU-软工浅谈泛读理解



> 通常情况下，同一层 package 所打包的内容对于上层 package 的作用是一样的，因此，可以认为一个 package 就可以代表一层。
> 

首先，观察 MiCode/Note 的代码结构：

```cpp
├── AndroidManifest.xml
├── res
└── java
    └── net.micode.notes
				├── data
				├── model
				├── tool
				├── ui
				├── widget
				└── gtask
						├── data
						├── exception
				 		└── remote
```

然后，查看实验指导书的要求：

画出小米便签的体系结构图

- 界面层
- 业务层
- 模型层
- 数据层

对于软件工程来说，体系结构应该有个更加准确定义 Architecture，也就是架构，因此，即使是绘制体系结构图，不论是风格还是模式，都应当蕴含架构模式。

从代码结构中的 package model 和指导书中明确给出的模型层，按照先入为主的习惯，初步判断这是一个 MVC 架构模式：

- **模型（Model）** 用于封装与应用程序的业务逻辑相关的数据以及对数据的处理方法
- **视图（View）**能够实现数据有目的的显示（理论上，这不是必需的）
- **控制器（Controller）**起到不同层面间的组织作用，用于控制应用程序的流程

但是，同样也存在另一个 package ui，尽管对于 package 的命名主要目的为了方便开发，但同时存在的业务层和数据层让我警觉起来另一个架构模式——三层结构：

- **表示层（USL，User Show Layer）**：主要表示 WEB 方式，也可以表示成 WINFORM 方式，如果逻辑层相当强大和完善，无论表现层如何定义和更改，逻辑层都能完善地提供服务。
- **业务逻辑层（BLL，Business Logic Layer）**：主要是针对具体的问题的操作，也可以理解成对数据层的操作，对数据业务逻辑处理，如果说数据层是积木，那逻辑层就是对这些积木的搭建。
- **数据访问层（DAL，Data Access Layer）**：主要是对原始数据（数据库或者存放数据）的操作层，是对数据的操作，而不是数据库，具体为业务逻辑层或表示层提供数据服务。

尽管都是三层，但 MVC 架构和三层结构是两种完全不同的架构：

1. 不单单是其中蕴含的设计模式、设计理念的不同；
2. 直观的， MVC 中的 View 和 Controller 由于高度贴近，可以合并到三层结构的 USL 中。

为了辨别主要的架构模式，需要具体看看 package ui 中的类：

```cpp
ui
├── AlarmAlertActivity.java
├── AlarmInitReceiver.java
├── AlarmReceiver.java
├── DateTimePicker.java
├── DateTimePickerDialog.java
├── DropdownMenu.java
├── FoldersListAdapter.java
├── NoteEditActivity.java
├── NoteEditText.java
├── NoteItemData.java
├── NotesListActivity.java
├── NotesListAdapter.java
├── NotesListItem.java
└── NotesPreferenceActivity.java
```

不需要直接阅读代码，从 Adapter 等关键字中便可以看出，开发者有意将 View 和 Controller 有意结合到了 package ui 中，似乎可以推翻刚刚的推论，如果将 package model 视为 BLL，那么 package data 自然就是 DAL 了。

但是，从软件体系结构严格意义上来说，数据层应该分为数据库和数据操作两个结构和功能，仅有 package data 是不够的，从代码结构中可以发现，res 即代表数据库结构。

那么现在便剩下 tool、widget 和 gtask 了，这三个 package 的初步鉴别方式很简单。

首先，看一下 tool ：

```cpp
tool
├── BackupUtils.java
├── DataUtils.java
├── GTaskStringUtils.java
└── ResourceParser.java
```

包含了 Utils 和 Parser 两个关键字，显然是贯穿多层的工具箱；

widget 和 gtask 几乎可以不用看，在第一步测试功能的时候，很显然对应了桌面小组件和谷歌账户同步的功能，并且在看 package gtask：

```cpp
gtask
├── data
├── exception
└── remote
```

显然是一个客户端的结构，即主从式架构，典型的 RPC（远程服务调用）。

现在，可以对 MiCode/Note 有个初步的认识了，它采用了四层结构，在三层结构的 DAL 与 BLL 中添加了一层 Model：

![System context diagram v1](/img/cse/security/software/system-context-diagram-v1.png)

但它真的是这样吗？我觉得还需要通过代码来进一步验证。在进行代码分析前，我还有几个疑点：

- 按照多层架构的特点，USL 一定需要经过 BLL 和 DAL 才能进行获得数据，然而，为什么在 package ui 中出现了类似 Reciver 这样的类？
- Model 在四层结构中的作用还是数据处理嘛？如果不是，那应该是什么？

举个例子，从 package ui 中的 AlarmInitReceiver.java 中便可以发现，该类直接调用了 package data 中的类，很明显，这是 MVC 的特点，View 能直接从 Model 获得想要的数据，而不一定需要通过 Controller。

这就像一个披着多层结构外皮的 MVC 代码实现。

再看 package model，如果 model 起到的作用是数据处理，那 package data 的作用不就不攻自破了嘛？

将两种意义相同的 package 分为两层，显然有悖架构体系的原则，那 model 到底意味着什么呢？

将注意力从 model 移开，先来看看 gtask 和 widget ：

- 仔细看看这两个 package，很容易便能发现他们都是直接利用 tool 与 data 进行交互，根本没有经过 model；
- 同样，model 也是直接与 data 进行交互，由此便可以发现，三者应该不存在所谓的逻辑关系；
- 并且，仔细看看 model 中的代码便能发现，不管是 Note.java 还是 WorkingNote.java，都是为了响应 ui 中请求的数据，model 的作用依然是数据处理。

现在一看，上述体系结构就被推翻了，但现在还有一个特别重要的角色 package tool。

直接看其中的类名就能确定其地位：

```sql
tool
├── BackupUtils.java
├── DataUtils.java
├── GTaskStringUtils.java
└── ResourceParser.java
```

BackupUtils.java、DataUtils.java、GTaskUtils.java 和 ResourceParser.java，比较特别的就是这个 Parser 关键字。

> Parser. A parser is a software component that takes input data (frequently text) and builds a data structure – often some kind of parse tree, abstract syntax tree or other hierarchical structure, giving a structural representation of the input while checking for correct syntax.
> 

我也是通过这个特别类发现了 package tool 在该体系结构中是一个贯穿整体的辅助函数库。

到了这里，对于实验指导书提供的信息和 MiCode/Note 的代码结构，终于可以得出结论了：

从架构模式的角度来看，MiCode/Note 的代码结构无疑是糟糕头顶了，不仅没能有效地降低耦合，还会导致级联效应。

但是，从软件功能的角度来看：

- 业务层指的是与系统和第三方的同步业务功能，就像需要一直保持同步的桌面小组件和 Google 远程备份和同步；
- 模型层指的是对便签和进行时便签的数据显示模式化。

每块的分类都是及其合理的，并且从代码的扩展性和阅读性也非常好，拥有一定的复用性。

因此，MiCode/Note 的体系结构图应该是功能模型，并且应如下绘制：

![System context diagram v2](/img/cse/security/software/system-context-diagram-v2.png)