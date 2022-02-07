[TOC]



# 1.实验目的

通过设计并实现一个简单全栈系统的方式提升对Web相关技术的理解、掌握及应用。

# 2.实验任务

本次实验任务为实现一个登录页面。具体要求如下：

1.  实现前端页面的基本布局。要求：
   1.  布局类似于学校门户http://my.csu.edu.cn/login/index.jsp
   2. 顶部需有LOGO栏目；
   3. 左侧提供轮播图；
   4. 提供账号密码登录方式；
   5. 提供手机号码（邮箱）+验证码登录方式；
   6. 登录成功后跳到显示“登录成功”四字的页面（简单设计）；
   7. 提供忘记密码和修改密码功能；
   8. 提供用户的增删改查。
2.  完成前后端数据交互

3.  数据操作要求：
   1. 数据统一存储在后端数据库中；
   2. 账号密码登录方式需进行验证，验证通过方能登录；
   3. 邮箱验证码需调用第三方短信接口发送验证码并进行验证；
   4. 后端实现技术不限、数据库系统不限。

# 3.实验展示



## 3.1邮箱登录



登录界面：

![image-20211207085249172](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207085249.png)



输入邮箱并点击“点击获取验证码”

![image-20211207091521134](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207091521.png)



输入验证码并点击“登录”

![image-20211207091557646](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207091557.png)





![image-20211207090013814](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090014.png)

## 3.2账号密码登录

![image-20211207090137616](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090137.png)



![image-20211207090013814](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090014.png)

## 3.3修改密码

点击修改密码，进入密码修改界面

![image-20211207090056674](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090057.png)



输入旧密码和新密码

![image-20211207090404422](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090404.png)



点击保存：

![image-20211207090431744](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090431.png)

点击上面提示框中的"确定"，返回登录界面

![image-20211207090552124](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090552.png)



从数据库中可以看到，密码已经修改成功了：



![image-20211207090534281](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090534.png)



## 3.4 忘记密码

点击忘记密码：

![image-20211207090916401](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090916.png)



进入忘记密码界面：

![image-20211207090948788](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207090949.png)



输入邮箱，并点击获取验证码

![image-20211207092053342](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092053.png)



输入新密码

![image-20211207092201257](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092201.png)

点击“设置新密码”



![image-20211207092137791](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092138.png)

点击“确定”，返回登录界面
![image-20211207092249773](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092250.png)



## 3.5管理员登录

输入的账号为"admin"

![image-20211207092626888](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092626.png)



进入管理员界面

![image-20211207092941007](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207092941.png)



### 3.5.1增加用户

点击”ADD User“：

![image-20211207093054386](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093054.png)

进入添加用户界面：

![image-20211207093128416](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093128.png)

输入用户信息：

![image-20211207093251143](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093251.png)

![image-20211207093305844](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093305.png)

点击“确定”返回管理员界面，可以看到新增的用户：

![image-20211207093433760](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093433.png)



### 3.5.2删除用户

直接点击相应用户后面的“DELETE”

![image-20211207093541370](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093541.png)

![image-20211207093608448](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093608.png)



点击“确定”，返回管理员界面，可以看到“李五”用户已经被删除

![image-20211207093721295](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093721.png)

### 3.5.3修改用户信息

点击相应用户后面的EDIT：

![image-20211207093754416](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093754.png)

点击“李四”后面的“EDIT”按钮，进入李四的用户信息编辑界面

![image-20211207093836133](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093836.png)

修改李四的名字为“李四四”，点击submit按钮

![image-20211207093907349](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093907.png)

![image-20211207093939818](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207093940.png)

点击弹窗的“确定”按钮，返回管理员界面，可以看到李四的名字已经改为李四四

![image-20211207094018220](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207094018.png)

### 3.5.4查找用户

点击"Search User"

![image-20211207094149215](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207094149.png)

进入查找用户界面

![image-20211207094211874](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207094211.png)

**按照userID查找**



查找userID中所有带“2”的用户

![image-20211207094550353](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207094550.png)

点击“search”，查看查找结果

![image-20211207094708018](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207094708.png)



**按照userName查找**

查找所有用户名字中带“四”的

![image-20211207095510447](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207095510.png)

查找结果



![image-20211207095458019](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207095458.png)

**按照userID和userName查找**

查找所有userID带2且userName带“四”的用户

![image-20211207100005489](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207100005.png)





![image-20211207100034997](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207100035.png)



**查找所有用户**

若在输入时什么也不输入，则是查找所有用户

![image-20211207100118123](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207100118.png)



![image-20211207100133113](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207100133.png)







# 4.实验过程



## 4.1在mySql里创建数据库及表格

创建webhomeword数据库并在其中创建users表格

![image-20211207081508534](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207081508.png)

表的结构如下

![image-20211207081540800](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207081540.png)

先插入一些数据

![image-20211207081609747](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207081609.png)







## 4.2搭建 WEB 应用框架;



### 4.2.1.创建一个maven web项目

![image-20211207132628170](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207132628.png)

### 4.3.2.修改配置

![image-20211207132643243](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207132643.png)

### 4.2.3.在main里创建java和recourse目录

![image-20211207132852076](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207132852.png)



### 4.2.4.导入项目中会遇到的jar包

jsp,Servlet,mysql,jstl,taglibs

```xml
<dependency>
    <groupId>javax.servlet.jsp</groupId>
    <artifactId>javax.servlet.jsp-api</artifactId>
    <version>2.3.3</version>
</dependency>

<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>servlet-api</artifactId>
  <version>2.5</version>
</dependency>

<dependency>
  <groupId>mysql</groupId>
  <artifactId>mysql-connector-java</artifactId>
  <version>8.0.27</version>
</dependency>

<dependency>
  <groupId>javax.servlet.jsp.jstl</groupId>
  <artifactId>jstl-api</artifactId>
  <version>1.2</version>
</dependency>

<dependency>
    <groupId>taglibs</groupId>
    <artifactId>standard</artifactId>
    <version>1.1.2</version>
</dependency>
```

### 4.2.5.更改web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
</web-app>
```

### 4.2.6.配置Tomcat

![image-20211207133104653](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207133104.png)

### 4.2.7导入项目中会遇到dependency

```xml
<dependencies>
  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.11</version>
    <scope>test</scope>
  </dependency>


  <dependency>
    <groupId>javax.servlet.jsp</groupId>
    <artifactId>javax.servlet.jsp-api</artifactId>
    <version>2.3.3</version>
  </dependency>

  <dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>servlet-api</artifactId>
    <version>2.5</version>
  </dependency>

  <dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.27</version>
  </dependency>

  <dependency>
    <groupId>javax.servlet.jsp.jstl</groupId>
    <artifactId>jstl-api</artifactId>
    <version>1.2</version>
  </dependency>

  <dependency>
    <groupId>taglibs</groupId>
    <artifactId>standard</artifactId>
    <version>1.1.2</version>
  </dependency>

  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
  </dependency>
```



## 4.3 前端页面设计

前端目录结构如下：

![image-20211207134044073](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207134044.png)



### 4.3.1登录界面 login.jsp



```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <meta charset="utf-8">
    <title>login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/pageChange.css" />
    <script src="${pageContext.request.contextPath }/js/pageChange.js">

    </script>

</head>

<body  style=" background-repeat:repeat ;background-size:auto auto;
background-attachment: fixed; background: url('${pageContext.request.contextPath }/images/bg2.jpg');">

<%
    Object message = request.getAttribute("message");
    if(message!=null && !"".equals(message)){
%>
<script type="text/javascript">
    alert("<%=request.getAttribute("message")%>");
</script>
<%} %>


<div class="head">
    <img src="${pageContext.request.contextPath }/images/head.png" alt="">
</div>

<div class="control">

    <div class="item">
        <div class="active" style="float: left;">邮箱登录</div>
        <div>账号密码登录</div>
    </div>

    <div class="content">

        <div style="display: block;">
            <form action="${pageContext.request.contextPath}/getIdentifyCode.do" method="post">
                <p>邮箱</p>
                <input type="text" placeholder="email" name="email" value="${email}">
                <input type="submit" class='verifyCode' value="点击获取验证码">
            </form>
            <form  method = "post" action="${pageContext.request.contextPath}/emailLogin.do">
                <p>验证码</p>
                <input type="text" placeholder="code" name="inputIdentifyCode">
                <br />
                <input type="submit" value="登录">
            </form>
        </div>

        <div>
            <form action="${pageContext.request.contextPath}/login.do" method="post">
                <p>账号:${error}</p><input type="text" name="userID" placeholder = "userID">
                <p>密码:</p><input type="password" name="password" placeholder="password">
                <input type="submit" value="登录"><input type="reset" value="重置">
            </form>
            <a href="${pageContext.request.contextPath}/jsp/forgetPwd.jsp">忘记密码</a>
        </div>
    </div>
</div>

<!--轮播图 https://blog.csdn.net/weixin_43751022/article/details/84330552 -->
<div id="slideBox" onmouseover="stop()" onmouseout="start()">
    <div id="red" class="slide"><img src="${pageContext.request.contextPath }/images/slide1.jpg" alt="slide1" width="500" height="500"></div>
    <div id="green" class="slide"><img src="${pageContext.request.contextPath }/images/slide2.jpg" alt="slide2" width="500" height="500"></div>
    <div id="blue" class="slide"><img src="${pageContext.request.contextPath }/images/slide3.jpg" alt="slide3" width="500" height="500"></div>
</div>

</body>
</html>
```

### 4.3.2登录成功界面 successLogin.jsp



```jsp
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2021/11/22
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>successLogin</title>

    <style>
        .content {
            position: relative;
            left: 40%;
            top: 20%;
        }

        .pwdmodify {
            width: 100px;
            height: 40px;

            position: relative;
            left: 6%;
            top: 50px;
        }

        #modifyBtn {
            width: 100px;
            height: 50px;
            background-color: rgb(223, 52, 52);
        }

        h1 {
            color: blanchedalmond;
        }
    </style>
</head>


<body  style=" background-size:auto 100%;background-attachment: fixed; background: url('${pageContext.request.contextPath }/images/background4.jpg');">

<div class="content">
    <h1>用户：${userSession.userName}</h1>
    <h1>登陆成功</h1>

    <div class="pwdmodify">
        <a href="/smbms_war/jsp/changePwd.jsp"><button id="modifyBtn">修改密码</button></a>
    </div>

</div>

</body>

</html>
```



### 4.3.3修改密码界面 changePwd.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2021/11/24
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>修改密码</title>

    <style>
        .location {
            width: 350px;
            height: 150px;
            position: relative;
            top: 10%;
            left: 40%;
            /* left: 600; */
            /* border: #e7c9a7 10px solid; */

        }

        strong {
            color: hsla(0, 0%, 99%, 0.966);
            font-size: x-large;
        }

        .providerAdd {
            width: 150px;
            height: 400px;
            position: relative;
            top: 50px;
            /* left: 700; */
            left: 45%;
            /* border: #e7c9a7 10px solid; */
        }

        h2 {
            color: hsla(0, 0%, 99%, 0.966);
        }

        #save {
            position: relative;
            width: 55%;

        }
    </style>

</head>

<body  style=" background-repeat:repeat ;background-size:50%;
background-attachment: fixed; background: url('${pageContext.request.contextPath }/images/background2.jpg');">

<%
    Object message = request.getAttribute("message");
    if(message!=null && !"".equals(message)){
%>
<script type="text/javascript">
    alert("<%=request.getAttribute("message")%>");
</script>
<%} %>

<div class="location">
    <h2>${userSession.userID}</h2>
    <strong>您现在的位置是：</strong>
    <strong>密码修改界面</strong>
</div>

<div class="providerAdd">
    <form action="${pageContext.request.contextPath}/changePwd.do" id="userFrom" name="userForm" method="post">
        <input type="hidden" name="method" value="savepwd">
        <div class="info">
        </div>
        <div>
            <label for="oldPassword">
                <h2>旧密码：</h2>
            </label>
            <input type="password" name="oldpassword" id="oldPassword" value="">
        </div>

        <div>
            <label for="newPassword">
                <h2>新密码：</h2>
            </label>
            <input type="password" name="newpassword" id="newPassword" value="">
        </div>

        <div>
            <label for="rnewPassword">
                <h2>确认新密码：</h2>
            </label>
            <input type="password" name="rnewpassword" id="rnewPassword" value="">
        </div>

        <div class="providerAddBtn">
            <h2></h2>
            <input type="submit" name="save" id="save" value="保存" class="input-button">
        </div>
    </form>
</div>
</body>

</html>
```



### 4.3.5忘记密码界面 forgetPwd.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2021/11/26
  Time: 22:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <title>Document</title>
  <!-- <%-- <link rel="stylesheet" type="text/css" href="../css/pageChange.css" />--%> -->
  <style>
    .my-content {
      width: 280px;
      background: rgba(255, 255, 255, 0.1);
      position: absolute;
      left: 40%;
      top: 20%;
      border: 1px solid #ce3e3e;
    }

    p {
      color: white;
    }

    h2 {
      color: white;
    }
  </style>
</head>

<body style=" background-repeat:repeat ;background-size:100% 100%;
        background-attachment: fixed; background: url('${pageContext.request.contextPath }/images/bg3.jpg');">

<%
  Object message = request.getAttribute("forgetPwd");
  if(message!=null && !"".equals(message)){
%>
<script type="text/javascript">
  alert("<%=request.getAttribute("forgetPwd")%>");
</script>
<%} %>

<div class="my-content" style="display: block;">
  <form action="${pageContext.request.contextPath}/getIdentifyCodeServlet2.do" method="post">
    <p>用户名</p>
    <input type="text" placeholder="userID" name="userID" value="${userID}">
    <p>邮箱</p>
    <input type="text" placeholder="email" name="email2" value=${email2}>
    <input type="submit" class='verifyCode' value="点击获取验证码">
  </form>
  <form action="${pageContext.request.contextPath}/forgetPwd.do" method="post">
    <p>验证码</p>
    <input type="text" placeholder="identifyCode" name="identifyCode">
    <p>新密码</p>
    <input type="password" placeholder="newPassword" name="newPassword">
    <input type="submit" class='submitChangePwd' value="设置新密码">
  </form>

</div>
</div>
</body>

</html>
```



### 4.3.6管理员界面 CURDindex.jsp

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZHENGZHIQIANG
  Date: 2019/3/2
  Time: 9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Show</title>
    <style type="text/css">
        table {
            border: 1px solid pink;
            margin: 0 auto;
        td{
            width: 150px;
            border: 1px solid pink;
            text-align: center;
        }
    </style>
</head>
<body>

<h1>欢迎管理员登录</h1>
<%
    Object message = request.getAttribute("message");
    Object grade_list = request.getAttribute("grade_list");
    if(message!=null && !"".equals(message)){

%>
<script type="text/javascript">
    alert("<%=request.getAttribute("message")%>");
</script>
<%} %>

<table>
    <tr>
        <td>userID</td>
        <td>userName</td>
        <td>password</td>
        <td>email</td>
    </tr>
    <c:forEach items="${userList}" var="user">
        <tr>
            <td>${user.userID}</td>
            <td>${user.userName}</td>
            <td>${user.password}</td>
            <td>${user.email}</td>
            <td><a href="DeleteServlet?userID=${user.userID}">DELETE</a>-----<a href="UpdateServlet?userID=${user.userID}">EDIT</a> </td>
        </tr>

    </c:forEach>
    <tr>
        <td colspan="2" style="text-align: left"><a href="${pageContext.request.contextPath }/jsp/add.jsp">ADD User</a> </td>
        <td colspan="2" style="text-align: right"><a href="${pageContext.request.contextPath }/jsp/search.jsp">Search User</a> </td>
        <td colspan="2" style="text-align: right"><a href="${pageContext.request.contextPath }/jsp/login.jsp">HOME</a> </td>
    </tr>
</table>

</body>
</html>
```

### 4.3.7添加用户界面 add.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: ZHENGZHIQIANG
  Date: 2019/3/2
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>ADD</title>
</head>
<body>
<div align="center">
<form action="${pageContext.request.contextPath}/AddServlet" method="post">
  <table border="1" >
    <tr>
      <td colspan="2"><h1>Add User</h1></td>
    </tr>
    <tr>
      <td>Add userID </td>
      <td><input type="text" name="userID"/></td>
    </tr>
    <tr>
      <td>Add userName </td>
      <td><input type="text" name="userName"/></td>
    </tr>
    <tr>
      <td>Add password </td>
      <td><input type="password" name="password"/></td>
    </tr>
    <tr>
      <td>Add email</td>
      <td><input type="text" name="email"/></td>

    </tr>
    <tr>
      <td colspan="2">
        <input type="submit" value="submit">
        <input type="reset" value="Flush">
      </td>
    </tr>
  </table>
</form>
</div>
</body>
</html>
```

### 4.3.8修改用户信息界面 update.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: ZHENGZHIQIANG
  Date: 2019/3/2
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Edit</title>
</head>
<body>
<div align="center">
<form action="${pageContext.request.contextPath}/UpdateServlet" method="post" style="align-items: center">
  <table border="1" >
    <tr>
      <td colspan="2"><h1>Edit User</h1></td>
    </tr>
    <tr>
      <td>userID</td>
      <td><input type="text" name="userID" value="${user.userID}"/></td>
    </tr>
    <tr>
      <td>userName</td>
      <td><input type="text" name="userName" value="${user.userName}" /></td>
    </tr>
    <tr>
      <td>password</td>
      <td><input type="password" name="password" value="${user.password}" /></td>
    </tr>
    <tr>
      <td>email</td>
      <td><input type="text" name="email" value="${user.email}" /></td>
    </tr>
    <tr>
      <td colspan="2">
        <input type="submit" value="Submit"/>
        <input type="button" value="Back" onclick="history.go(-1)"/>
      </td>
    </tr>
  </table>
</div>
</form>
</body>
</html>
```

### 4.3.9 查找用户界面 search.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2021/12/3
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Title</title>
</head>

<body>
<div align="center">
<form action="${pageContext.request.contextPath}/SearchServlet" method="post" style="align-items: center">
    <table border="1">
        <tr>
            <td colspan="2">
                <h1>Search User</h1>
            </td>
        </tr>
        <tr>
            <td>userID:</td>
            <td><input name = "userID" type="text"></td>
        </tr>
        <tr>
            <td>userName:</td>
            <td><input name="userName" type="text"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="search">
                <input type="reset" value="flush">
            </td>
        </tr>
    </table>

</form>
</div>
</body>

</html>
```



### 4.3.10 界面样式pageChange.css

```css
*{
    margin:0;
    padding: 0;
}
body{
    background: #f3f3f3;
}

.control{
    width: 340px;
    background: white;
    /*background: rgba(255, 255, 255, 1);*/
    position: absolute;
    top: 60%;
    left: 75%;
    transform: translate(-50%,-50%);
    border-radius: 5px;

}

.item{
    width: 340px;
    height: 60px;
    background: #eeeeee;
}

.item div{
    width: 170px;
    height: 60px;
    display: inline-block;
    color: black;
    font-size: 18px;
    text-align: center;
    line-height: 60px;
    cursor:pointer;
}

.content div{
    margin: 20px 30px;
    display: none;
    text-align: left;
    margin-bottom: 6px;
    font-size: 15px;
}

p{
    color: #4a4a4a;
    margin-top:30px;
    margin-bottom: 6px;
    font-size: 15px;
}

.content input[type = "text"], .content input[type="password"]{
    width: 100%;
    height: 40px;
    border-radius: 3px;
    border:1px solid #adadad;
    padding:0 10px;
    box-sizing: border-box;
}

.content input[type="submit"]
{
    margin-top :40px;
    width: 100%;
    height: 40px;
    border-radius: 5px;
    color:white;
    border:1px solid #adadad;
    background: #00dd60;
    cursor: pointer;
    letter-spacing: 4px;
    margin-bottom: 40px;

}


.active{
    background: white;
}

.item div:hover{
    background: #f6f6f6;
}

#slideBox{
    width:500px;
    height:500px;
    border:1px solid black;
    position:absolute;
    top: 160px;
    left: 200px;
    overflow:hidden;
}
.slide{
    width:500px;
    height:500px;
    position:absolute;
}

#red{
    /*background-color:red;*/
    width:500px;
}

#green{
    /*background-color:green;*/
    width:500px;
}
#blue{
    /*background-color:blue;*/
    width:500px;
}
```

### 4.3.11 轮播图 pageChange.js

```js
window.onload = function () {
    var arr = document.getElementsByClassName("slide");
    for (var i = 0; i < arr.length; i++) {
        arr[i].style.left = i * 500 + "px";
    }

    var item = document.getElementsByClassName("item");
    var it = item[0].getElementsByTagName("div");
    var content = document.getElementsByClassName("content");
    var con = content[0].getElementsByTagName("div");

    for (let i = 0; i < it.length; i++) {
        it[i].onclick = function () {
            for (let j = 0; j < it.length; j++) {
                it[j].className = '';
                con[j].style.display = "none";
            }
            this.className = "active";
            it[i].index = i;
            con[i].style.display = "block"
        }
    }
}

function LeftMove() {
    var arr = document.getElementsByClassName("slide");//获取三个子div
    originLeft = document.getElementById("slide");

    for (var i = 0; i < arr.length; i++) {
        var left = parseFloat(arr[i].style.left);
        left -= 2;
        var width = 500;//图片的宽度
        var pos_left = document.getElementById("slideBox").offsetLeft;
        var pos_top = document.getElementById("slideBox").offsetTop;

        // console.log(pos_left);
        // console.log(pos_top);

        if (left <= originLeft - width) {
            left = (arr.length - 1) * width;//当图片完全走出显示框，拼接到末尾
            clearInterval(moveId);
        }
        arr[i].style.left = left + "px";
    }
}

function divInterval() {
    moveId = setInterval(LeftMove, 10);//设置一个10毫秒定时器
}


timeId = setInterval(divInterval, 5000);

function stop() {
    clearInterval(timeId);
}
function start() {
    clearInterval(timeId);
    timeId = setInterval(divInterval, 5000);
}

//页面失去焦点停止
onblur = function () {
    stop();
}
//页面获取焦点时开始
onfocus = function () {
    start();
}
```



## 4.4 Dao模块

### 4.4.1 操作数据库的最基本模块：BaseDao.class

```java
package com.qi.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

//操作数据库的公共类
public class BaseDao {
    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    //静态代码块，类加载时就初始化
    static{
        Properties properties = new Properties();
        //通过类加载器读取对应的资源
        InputStream is = BaseDao.class.getClassLoader().getResourceAsStream("db.properties");

        try {
            properties.load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }

        driver = properties.getProperty("driver");
        url = properties.getProperty("url");
        username = properties.getProperty("username");
        password = properties.getProperty("password");
    }

    //获取数据库的连接
    public static Connection getConnection(){
        Connection connection = null;
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    //编写查询公共类
    public static ResultSet execute(Connection connection,PreparedStatement preparedStatement,ResultSet resultSet,String sql,Object[] params) throws SQLException {
        //预编译sql,在后面直接执行就可以了
        preparedStatement = connection.prepareStatement(sql);

        for (int i = 0; i < params.length; i++) {
            preparedStatement.setObject(i+1,params[i]);
        }
//        System.out.println(sql);
        resultSet = preparedStatement.executeQuery();
        return resultSet;
    }

    //编写增删改公共方法
    public static int execute(Connection connection,PreparedStatement preparedStatement,String sql,Object[] params) throws SQLException {
        preparedStatement = connection.prepareStatement(sql);

        for (int i = 0; i < params.length; i++) {
            preparedStatement.setObject(i+1,params[i]);
        }
        int updateRows = preparedStatement.executeUpdate();
        return updateRows;
    }

    //关闭资源
    public static boolean closeRecourse(Connection connection,PreparedStatement preparedStatement,ResultSet resultSet) {
        boolean flag = true;
        if(resultSet!= null) {
            try {
                resultSet.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                flag = false;
            }
        }

        if(preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                flag = false;
            }
        }
        if(connection!= null)
        {
            try {
                connection.close();
                connection = null;
            } catch (SQLException throwables) {
                flag = false;
                throwables.printStackTrace();
            }
        }
        return flag;
    }
}
```



### 4.4.2 用户操作数据库的基本功能接口：UserDao.class 

```java
package com.qi.dao.user;

import com.qi.pojo.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public interface UserDao {

    //得到登录的用户
    public User getLoginUser(Connection connection, String account) throws SQLException;

    //通过邮箱得到用户
    public User getLoginUserByEmail(Connection connection,String email) throws SQLException;

    //修改当前用户密码
    public int updatePwd(Connection connection,String userID,String password) throws SQLException;

    //根据userID查询旧密码
    public String selectPassword(Connection connection,String userID) throws SQLException;
    
    //添加用户
    public boolean add(Connection connection,String userID,  String userName, String password, String email) throws SQLException;
    
    //获取所有用户的列表
    public ArrayList<User> selectAll(Connection connection) throws SQLException;
    
    //更新用户信息
    public boolean update(Connection connection,String userID, String userName,String password,String email) throws SQLException;
    
    //删除用户
    public boolean delete(Connection connection,String userID) throws SQLException;
    
    //根据用户ID和Name获取用户
    public ArrayList<User> selectByIDName(Connection connection,String userID,String userName) throws SQLException;


}
```



### 4.4.3 实现UserDao接口：UserDaoImpl.class

```java
package com.qi.dao.user;

import com.mysql.cj.util.StringUtils;
import com.qi.dao.BaseDao;
import com.qi.pojo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDaoImpl implements UserDao{

    public User getLoginUser(Connection connection, String userID) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user = null;
        //判断数据库是否连接成功
        if(connection!=null)
        {
            String sql = "select * from users where userID=?";
            Object[] params = {userID};
            //连接成功则执行sql语句并返回结果集
                rs = BaseDao.execute(connection,pstm,rs,sql,params);
                if(rs.next()){
                    user = new User();
                    user.setUserID(rs.getString("userID"));
                    user.setUserName(rs.getString("userName"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                }
                BaseDao.closeRecourse(null,pstm,rs);
        }
        return user;
    }

    public User getLoginUserByEmail(Connection connection,String email) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        User user = null;
        //判断数据库是否连接成功
        if(connection!=null)
        {
            String sql = "select * from users where email=?";
            Object[] params = {email};
            //连接成功则执行sql语句并返回结果集
            rs = BaseDao.execute(connection,pstm,rs,sql,params);
            if(rs.next()){
                user = new User();
                user.setUserID(rs.getString("userID"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
            }
            BaseDao.closeRecourse(null,pstm,rs);
        }
        return user;
    }
    //修改当前用户的密码
    public int updatePwd(Connection connection, String userID, String password) throws SQLException {

        PreparedStatement pstm = null;
        int execute = 0;
        if(connection!=null)
        {
            String sql = "update users set password = ? where userID = ?";
            Object params[] = {password,userID};
            execute = BaseDao.execute(connection,pstm,sql,params);
            BaseDao.closeRecourse(null,pstm,null);
        }
        return execute;

    }

    @Override
    public String selectPassword(Connection connection, String userID) throws SQLException {
        PreparedStatement pstm = null;
        String oldPassword = null;
        ResultSet rs = null;
        if(connection!=null)
        {
            String sql = "select * from users where userID = ?";
            Object params[] = {userID};
            rs = BaseDao.execute(connection,pstm,rs,sql,params);
            if(rs.next()){
                oldPassword = rs.getString("password");
            }

             BaseDao.closeRecourse(null,pstm,rs);
        }
        return oldPassword;
    }



    @Override
    public boolean add(Connection connection, String userID, String userName, String password, String email) throws SQLException {
        PreparedStatement pstm = null;
        int rs ;
        boolean flag = false;
        if(connection!=null){
            String sql = "insert into users values (?,?,?,?)";
            String[] params = {userID,userName,password,email};
            //Connection connection,PreparedStatement preparedStatement,String sql,Object[] params
            rs = BaseDao.execute(connection, pstm,sql, params);
            if(rs != 0){
                flag = true;
            }
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }



    @Override
    public ArrayList<User> selectAll(Connection connection) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<User> userList = new ArrayList<>();
        if(connection!=null){
            String sql = "select * from users";
            String[] params = {};
            rs = BaseDao.execute(connection, pstm, rs, sql, params);
            while(rs.next()){
                User _user = new User();
                _user.setUserID(rs.getString("userID"));
                _user.setPassword(rs.getString("password"));
                _user.setEmail(rs.getString("email"));
                _user.setUserName(rs.getString("userName"));
                userList.add(_user);
            }
            BaseDao.closeRecourse(connection,null,rs);
        }
        return userList;
    }
    @Override
    public ArrayList<User> selectByIDName(Connection connection, String userID,String userName) throws SQLException {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        ArrayList<User> userList = new ArrayList<>();
        String sql = null;
        String[] params = null;
        if(connection!=null){
            if(! StringUtils.isNullOrEmpty(userID) && StringUtils.isNullOrEmpty(userName))
            {
                sql = "select * from users where userID like ?";
                params = new String[]{"%"+userID+"%"};
            }else if(StringUtils.isNullOrEmpty(userID) && !StringUtils.isNullOrEmpty(userName))
            {
                sql = "select * from users where userName like ?";
                params = new String[]{"%"+userName+"%"};
            }else if(!StringUtils.isNullOrEmpty(userID) && !StringUtils.isNullOrEmpty(userName))
            {
                sql = "select * from users where userName like ? and userID like ?";
                params = new String[]{"%"+userName+"%", "%"+userID+"%"};
            }else{
                sql = "select * from users";
                params = new String[]{};
            }
            //Connection connection,PreparedStatement preparedStatement,ResultSet resultSet,String sql,Object[] params
            rs = BaseDao.execute(connection, pstm, rs,sql, params);
            while(rs.next()){
                User _user = new User();
                _user.setUserID(rs.getString("userID"));
                _user.setPassword(rs.getString("password"));
                _user.setEmail(rs.getString("email"));
                _user.setUserName(rs.getString("userName"));
                userList.add(_user);
            }
            BaseDao.closeRecourse(connection,null,rs);
        }
        return userList;
    }
    @Override
    public boolean update(Connection connection, String userID, String userName, String password, String email) throws SQLException {
        PreparedStatement pstm = null;
        boolean flag = false;
        int rs = 0;
        if(connection!=null){
            String sql = "update users set userID = ? , userName = ? , password = ? , email = ? where userID = ?";
            String[] params = {userID,userName,password,email,userID};
            rs = BaseDao.execute(connection, pstm, sql, params);
            if(rs != 0){
                flag = true;
            }
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }

    @Override
    public boolean delete(Connection connection, String userID) throws SQLException {
        PreparedStatement pstm = null;
        int rs;
        boolean flag = false;
        if(connection!=null){
            String sql = "delete from users where userID = ?";
            String[] params = {userID};
            //Connection connection,PreparedStatement preparedStatement,String sql,Object[] params
            rs = BaseDao.execute(connection, pstm,sql, params);
            if(rs != 0){
                flag = true;
            }
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }


}
```



## 4.4 Filter模块

### 将请求和相应的编码格式转换成utf-8：CharacterEncoding.class

```java
package com.qi.filter;


import javax.servlet.*;
import java.io.IOException;

public class CharacterEncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        chain.doFilter(request, response);
    }
    @Override
    public void destroy() {

    }
}
```



## 4.5 pojo模块

### 对应数据库的User表：user.java

```java
package com.qi.pojo;

public class User{
    private String userID;
    private String password;
    private String email;
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
```



## 4.6 service模块

### 4.6.1 用户业务逻辑接口 UserService.class

```java
package com.qi.service;

import com.qi.pojo.User;

import java.util.ArrayList;

public interface UserService {

    //用户登录
    public User login(String account,String password);

    //通过邮箱登录
    public User loginByEmail(String Email);

    //根据用户id修改密码
    public boolean updatePwd(String userId, String password);

    //查找用户密码
    public String selectPassword(String userId);

    //添加用户
    public boolean add(String userID, String userName, String password, String email) ;
    
    //获取所有用户
    public ArrayList<User> selectAll();
    
    //更新用户信息
    public boolean update(String userID, String userName, String password, String email);
    
    //删除用户
    public boolean delete(String userID );
    
    //根据用户ID和name获取用户
    public ArrayList<User> selectByIDName(String userID,String userName);


}
```



### 4.6.2 实现UserService接口：UserServiceImpl.java

```java
package com.qi.service;

import com.qi.dao.BaseDao;
import com.qi.dao.user.UserDao;
import com.qi.dao.user.UserDaoImpl;
import com.qi.pojo.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserServiceImpl implements UserService{
    //业务层都会调用Dao层，所以要引入Dao层
    private UserDao userDao;
    public UserServiceImpl(){
        userDao = new UserDaoImpl();
    }

    @Override
    public User login(String account, String password) {
        Connection connection = null;
        User user = null;
        try {
            connection = BaseDao.getConnection();
            user = userDao.getLoginUser(connection, account);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return user;
    }

    @Override
    public User loginByEmail(String email) {
        Connection connection = null;
        User user = null;
        try {
            connection = BaseDao.getConnection();
            user = userDao.getLoginUserByEmail(connection, email);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return user;
    }



    @Override
    public boolean updatePwd(String userId, String password) {

        boolean flag = false;
        Connection connection = null;
        //修改密码
        try {
            connection = BaseDao.getConnection();
            if(userDao.updatePwd(connection,userId,password) > 0){
                flag = true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }

    @Override
    public String selectPassword(String userId) {

        boolean flag = false;
        Connection connection = null;
        String oldPassword = null;
        //修改密码
        try {
            connection = BaseDao.getConnection();
            oldPassword = userDao.selectPassword(connection, userId) ;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return oldPassword;
    }

    @Override
    public boolean add(String userID, String userName,String password, String email) {
        Connection connection = null;
        boolean flag = false;
        try {
            connection = BaseDao.getConnection();//Connection connection,PreparedStatement preparedStatement,String sql,Object[] params
            flag = userDao.add(connection, userID,userName,password,email);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }

    @Override
    public ArrayList<User> selectAll() {
        Connection connection = null;
        ArrayList<User> userList = new ArrayList<User>();
        try {
            connection = BaseDao.getConnection();
            userList = userDao.selectAll(connection);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }

        return userList;
    }

    @Override
    public boolean update(String userID,String userName,String password, String email) {
        Connection connection = null;
        boolean flag = false;
        try {
            connection = BaseDao.getConnection();
            flag = userDao.update(connection, userID,userName,password,email);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }

    @Override
    public boolean delete(String userID) {
        Connection connection = null;
        boolean flag = false;
        try {
            connection = BaseDao.getConnection();
            flag = userDao.delete(connection, userID);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return flag;
    }

    @Override
    public ArrayList<User> selectByIDName(String userID,String userName) {
        Connection connection = null;
        ArrayList<User> userList = new ArrayList<User>();
        try {
            connection = BaseDao.getConnection();
            userList = userDao.selectByIDName(connection, userID,userName);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            BaseDao.closeRecourse(connection,null,null);
        }
        return userList;
    }
}
```



## 4.7 Servlet模块

### 4.7.1 用通过账户密码登录：Login.java

```java
package com.qi.servlet.user;

import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;
import com.qi.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class LoginServlet extends HttpServlet {

    //Servlet
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Servlet:控制层，调用业务层代码
        System.out.println("LoginServlet--start....");

        //获取用户名和密码
        String userID = req.getParameter("userID");
        String password = req.getParameter("password");

        //和数据库中的密码进行对比
        UserService userService = new UserServiceImpl();
        User user = userService.login(userID, password);
        if (user != null && password.equals(user.getPassword()))
        {
            //查到了这个人
            req.getSession().setAttribute(Constants.USER_SESSION,user);
            if(user.getUserID().equals("admin"))
            {
                resp.sendRedirect("/smbms_war/jsp/CRUDindex.jsp");
            }else{
                resp.sendRedirect("/smbms_war/jsp/successLogin.jsp");
            }
        }else{
            //查不到这个人
            req.setAttribute("message","用户名或密码不正确");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req,resp);
//            resp.sendRedirect("/smbms_war/jsp/login.jsp");
        }
    }
}
```



### 4.7.2 通过邮箱登录：EmailLogin.java

```java
package com.qi.servlet.user;

import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;
import com.qi.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EmailLoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String inputIdentifyCode = req.getParameter("inputIdentifyCode");
        String email = (String) req.getSession().getAttribute("email");

        UserService userService = new UserServiceImpl();
        User user = userService.loginByEmail(email);
        String sessionIdentifyCode = (String) req.getSession().getAttribute("identifyCode");
        if(user != null && inputIdentifyCode.equals(sessionIdentifyCode))
        {
            req.getSession().setAttribute(Constants.USER_SESSION,user);
            resp.sendRedirect("/smbms_war/jsp/successLogin.jsp");
        }else{
            //查不到这个人
            req.setAttribute("message","验证码不正确");
            resp.sendRedirect("/smbms_war/jsp/login.jsp");
        }
    }
}
```



### 4.7.3 获取邮箱登录验证码：GetIndentifyCodeServlet.java

```java
package com.qi.servlet.user;

import com.qi.util.MailJava;
import com.qi.util.MailJavaImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GetIdentifyCodeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.getSession().setAttribute("email", email);

        try {
            MailJava mailJava = new MailJavaImpl();
            String identifyCode = mailJava.sendEmail(email);
            req.getSession().setAttribute("identifyCode",identifyCode);
            resp.sendRedirect("/smbms_war/jsp/login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```



### 4.7.4 忘记密码：ForgetPwdServlet.java

```java
package com.qi.servlet.user;

import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ForgetPwdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String inputID = (String) req.getSession().getAttribute("userID");
        String inputEmail = (String) req.getSession().getAttribute("email2");
        String inputIdentifyCode = req.getParameter("identifyCode");
        String inputPwd = req.getParameter("newPassword");
        String sessionIdentifyCode = (String) req.getSession().getAttribute("identifyCode");

        UserService userService = new UserServiceImpl();
        User user = userService.loginByEmail(inputEmail);

        //用户不为空且输入的ID和email匹配且输入的验证码和生成的验证码匹配，则修改密码
        if(user!=null)
        {
            if(user.getUserID().equals(inputID) )
            {
                if(inputIdentifyCode.equals(sessionIdentifyCode))
                {
                    UserService Service = new UserServiceImpl();
                    Service.updatePwd(inputID,inputPwd);
                    req.setAttribute("message","密码修改成功，请重新登陆");
                    req.getRequestDispatcher("jsp/login.jsp").forward(req,resp);

                }else{
                    req.setAttribute("forgetPwd","验证码错误，请重新输入");
                    req.getRequestDispatcher("/jsp/forgetPwd.jsp").forward(req,resp);
                }
            } else{
                req.setAttribute("forgetPwd","用户名错误，请重新输入");
                req.getRequestDispatcher("/jsp/forgetPwd.jsp").forward(req,resp);
            }
        }
        else{
            req.setAttribute("forgetPwd","邮箱不存在，请重新输入");
            req.getRequestDispatcher("/jsp/forgetPwd.jsp").forward(req,resp);
        }

    }
}
```



### 4.7.5 获取忘记密码的验证码：GetIdentifyCodeServlet2.java

```java
package com.qi.servlet.user;

import com.qi.util.MailJava;
import com.qi.util.MailJavaImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GetIdentifyCodeServlet2 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID = req.getParameter("userID");
        req.getSession().setAttribute("userID", userID);
        String email2 = req.getParameter("email2");
        req.getSession().setAttribute("email2", email2);
        try {
            MailJava mailJava = new MailJavaImpl();
            String identifyCode = mailJava.sendEmail(email2);
            req.getSession().setAttribute("identifyCode",identifyCode);
//            req.getRequestDispatcher("/jsp/forgetPwd.jsp").forward(req,resp);
            resp.sendRedirect("/smbms_war/jsp/forgetPwd.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```



### 4.7.5 修改密码：ChangePwdServlet.java

```java
package com.qi.servlet.user;

import com.mysql.cj.util.StringUtils;
import com.qi.pojo.User;
import com.qi.service.UserServiceImpl;
import com.qi.util.Constants;
import com.qi.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//实现Servlet服用
public class ChangePwdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //从Session里面拿ID
        Object o = req.getSession().getAttribute(Constants.USER_SESSION);

        String newpassword = req.getParameter("newpassword");
        String rnewpassword = req.getParameter("rnewpassword");
        String in_oldpassword = req.getParameter("oldpassword");
        String userID = ((User)o).getUserID();
        UserService userService = new UserServiceImpl();

        String oldpassword = userService.selectPassword(userID);
        System.out.println("oldpassword："+oldpassword);
        boolean flag = false;
        if(StringUtils.isNullOrEmpty(newpassword))
        {
            req.setAttribute("message","旧密码不能为空");
            req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);
        }
        else if(StringUtils.isNullOrEmpty(newpassword))
        {
            req.setAttribute("message","新密码不能为空");
            req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);
        }else if (StringUtils.isNullOrEmpty(rnewpassword))
        {
            req.setAttribute("message","重输新密码不能为空");
            req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);
        }else if(! newpassword.equals(rnewpassword))
        {
            req.setAttribute("message","两次输入的新密码不一致");
            req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);
        }else if(! in_oldpassword.equals(oldpassword)){
            req.setAttribute("message","旧密码输入错误");
            req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);
        }else{
            flag = userService.updatePwd(((User)o).getUserID(),newpassword);
            if(flag){
                req.setAttribute("message","密码修改成功，请重新登陆");
                req.getRequestDispatcher("jsp/login.jsp").forward(req,resp);
            }
            else{
                req.setAttribute("message","系统故障，密码修改失败");
                req.getRequestDispatcher("jsp/changePwd.jsp").forward(req,resp);

            }
        }

    }
}
```



### 4.7.6 增加用户：AddServleet.java

```java
package com.qi.servlet.user;

import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddServlet extends HttpServlet {

    private  static  final  long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("进入了doPost");
        String userID = req.getParameter("userID");
        String userName = req.getParameter("userName");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        UserService userService = new UserServiceImpl();
        boolean flag = userService.add(userID,userName,password,email);
        if (flag) {
            req.setAttribute("message","添加用户成功");
        }else{
            req.setAttribute("message","添加用户失败");
        }

        req.getRequestDispatcher("ShowServlet").forward(req,resp);//内部重定向
    }

}
```



### 4.7.7 删除用户：DeleteServlet.java

```java
package com.qi.servlet.user;

import com.mysql.cj.util.StringUtils;
import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userID = req.getParameter("userID");
        boolean flag = false;
        UserService userService = new UserServiceImpl();
        if(!StringUtils.isNullOrEmpty(userID))
        {
            flag = userService.delete(userID);
        }
        if (flag) {
            req.setAttribute("message","删除用户成功");
        }else{
            req.setAttribute("message","删除用户失败");
        }
        ArrayList<User> userList = userService.selectAll();
        req.setAttribute("userList",userList);
        req.getRequestDispatcher("jsp/CRUDindex.jsp").forward(req,resp);
    }
}
```



### 4.7.8 修改用户信息：UpdateServlet.java

```java
package com.qi.servlet.user;

import com.mysql.cj.util.StringUtils;
import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class UpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID = req.getParameter("userID");
        if(! StringUtils.isNullOrEmpty(userID))
        {
            UserService userService = new UserServiceImpl();
            ArrayList<User> users = userService.selectByIDName(userID, null);
            User user = users.get(0);
            req.setAttribute("user",user);
        }
        req.getRequestDispatcher("jsp/update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
        String new_userID = req.getParameter("userID");
        String new_userName = req.getParameter("userName");
        String new_password = req.getParameter("password");
        String new_sex = req.getParameter("email");
        boolean flag = userService.update(new_userID, new_userName, new_password, new_sex);
        if (flag) {
            req.setAttribute("message","编辑用户成功");
        }else{
            req.setAttribute("message","编辑用户失败");
        }
        req.getRequestDispatcher("ShowServlet").forward(req,resp);//内部重定向

    }
}
```



### 4.7.9 查找用户信息：SearchServlet.java

```java
package com.qi.servlet.user;

import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
        String userID = req.getParameter("userID");
        String userName = req.getParameter("userName");
        ArrayList<User> searchedUserList = userService.selectByIDName(userID, userName);
        req.setAttribute("userList",searchedUserList);
        req.getRequestDispatcher("jsp/CRUDindex.jsp").forward(req,resp);//内部重定向
    }
}
```

### 4.7.10 展示用户信息：ShowServlet.java

```java
package com.qi.servlet.user;

import com.qi.pojo.User;
import com.qi.service.UserService;
import com.qi.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class ShowServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = new UserServiceImpl();
        ArrayList<User> userList = userService.selectAll();
        req.setAttribute("userList",userList);
        req.getRequestDispatcher("jsp/CRUDindex.jsp").forward(req, resp);
    }
}
```



## 4.8 部署Servlet

web.xml:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <servlet>
        <servlet-name>LoginServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.LoginServlet</servlet-class>
    </servlet>
    
    <servlet-mapping>
        <servlet-name>LoginServlet</servlet-name>
        <url-pattern>/login.do</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>getIdentifyCodeServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.GetIdentifyCodeServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>getIdentifyCodeServlet</servlet-name>
        <url-pattern>/getIdentifyCode.do</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>getIdentifyCodeServlet2</servlet-name>
        <servlet-class>com.qi.servlet.user.GetIdentifyCodeServlet2</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>getIdentifyCodeServlet2</servlet-name>
        <url-pattern>/getIdentifyCodeServlet2.do</url-pattern>
    </servlet-mapping>


    <servlet>
        <servlet-name>forgetPwdServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.ForgetPwdServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>forgetPwdServlet</servlet-name>
        <url-pattern>/forgetPwd.do</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>EmailLoginServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.EmailLoginServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>EmailLoginServlet</servlet-name>
        <url-pattern>/emailLogin.do</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>ChangePwdServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.ChangePwdServlet</servlet-class>
    </servlet>

    <servlet-mapping>
        <servlet-name>ChangePwdServlet</servlet-name>
        <url-pattern>/changePwd.do</url-pattern>
    </servlet-mapping>


    <servlet>
        <servlet-name>AddServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.AddServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>AddServlet</servlet-name>
        <url-pattern>/AddServlet</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>DeleteServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.DeleteServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>DeleteServlet</servlet-name>
        <url-pattern>/DeleteServlet</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>UpdateServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.UpdateServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>UpdateServlet</servlet-name>
        <url-pattern>/UpdateServlet</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>ShowServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.ShowServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>ShowServlet</servlet-name>
        <url-pattern>/ShowServlet</url-pattern>
    </servlet-mapping>

    <servlet>
        <servlet-name>SearchServlet</servlet-name>
        <servlet-class>com.qi.servlet.user.SearchServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>SearchServlet</servlet-name>
        <url-pattern>/SearchServlet</url-pattern>
    </servlet-mapping>



<!--    字符编码过滤器-->
    <filter>
        <filter-name>CharacterEncodingFilter</filter-name>
        <filter-class>com.qi.filter.CharacterEncodingFilter</filter-class>
    </filter>

    <filter-mapping>
        <filter-name>CharacterEncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    
<!--    设置欢迎界面-->
    <welcome-file-list>
        <welcome-file>login.jsp</welcome-file>
    </welcome-file-list>


</web-app>
```





# 5.核心操作



## 5.1邮箱登录

![image-20211207154926630](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207154926.png)

## 5.2 账号密码登录

![image-20211207184941954](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207184942.png)



## 5.3 修改密码

![image-20211207191523223](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207191523.png)



## 5.4 忘记密码

![image-20211207190949510](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207190949.png)



## 5.5 查找操作

![image-20211207151025332](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207151025.png)





## 5.6 添加操作

![image-20211207151035907](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207151035.png)



## 5.7 删除操作

![image-20211207151045920](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207151046.png)



## 5.8 修改操作

![image-20211207151055718](https://raw.githubusercontent.com/zhangchenqi123/imgCloud/main/img/20211207151055.png)

# 6.实验收获

1. 在实验开始时，我对本实验要用到的技术一无所知，然后就在网上大量的查阅资料，得知了本实验可以用JavaWeb的相关知识解决。于是在B站学习相关的知识，学习了**Http**、**Maven**、**Servlet**、**JSP**、**Session**、**JSTL标签**、**MVC三层架构**、**JDBC**等相关方面的知识，终于对本实验的大概思路有了较为清晰的认识，然后基于学习过程中做的一些小样例进行了本次的开发。
2. 在前端页面开发的过程中，遇到的最大问题是定位问题，就是每当页面进行重定位的时候，原本页面的CSS代码都失效了，页面布局完全乱了，还有就是在插入图片过程中，虽然路径写对了，但是仍然显示不出来图片。经过在网上查找相关的解决办法，我终于知道了，原来在每次重定位之后，JSP里所有的路径都变成了绝对路径，因此在写的时候不能只写相对路径如`/forgetPwd.do`  、 `img src="/images/slide1.jpg"` ，而应该在相对路径的前面加上`${pageContext.request.contextPath }` ，并且，尤其要注意`$` 不能丢了，有一次检查bug花了两个多小时，最后发现是少加了个`$`  ……
3. 在进行后端开发的过程中，我对MVC三层架构有了比较深刻的认识，MVC三层架构将软件分为View层、Model层、Controller层，其中View是视图层，负责数据展示和用户交互，主要体现在Jsp模块，Model是模型层，其又分为Service层和Dao层，前者主要进行事务的处理，Dao层主要是直接面向数据库，如取得结果集，将结果集封装之后返回给Service层,Controller层是处理用户发送的请求，根据不同的请求调用Service层的不同函数。
4. 在开发过程中，我对Java的debug方法应用的更加熟练了，通过在不同位置设置断点，一步步的往下进行，我能够很快的找到逻辑错误出现在哪里，并且很快的排错。