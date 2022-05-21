[> Back](../README.md#网络安全)

# 邮件中继

Created: November 18, 2021
Sort: Security

> 简单邮件传输协议（Simple Mail Transfer Protocol，SMTP）：一个在互联网上传输电子邮件的标准。
—— From Wiki
> 

## 邮件中继的作用

> 邮件中继（SMTP Relay Service）：在不改变用户邮件地址（发件人）的前提下，将用户邮件通过多链路SMTP邮件转发服务器投递到收件人邮件服务器。
> 

邮件中继主要是为了解决邮件外发退信问题：

- 主要针对自建邮件系统；
- 利用系统本身具备的邮件中继功能，通过其他邮件主机转发的形式，解决邮件退信问题。

## 恶意邮件中继方式

- 群发邮件；
- 滥订邮件列表；
- Zip邮件炸弹；
- ......

## Reference

电邮炸弹：[https://zh.wikipedia.org/wiki/电邮炸弹](https://zh.wikipedia.org/wiki/%E7%94%B5%E9%82%AE%E7%82%B8%E5%BC%B9)

邮件中继：[https://baike.baidu.com/item/邮件中继/8266088](https://baike.baidu.com/item/%E9%82%AE%E4%BB%B6%E4%B8%AD%E7%BB%A7/8266088)