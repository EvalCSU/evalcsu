[> Back](../README.md#网络安全)

# DNS 服务

Created: November 18, 2021
Sort: Security

> 域名系统（Domain Name System，DNS）是互联网的一项服务，使用 TCP 和 UDP 端口 53。
—— From Wiki
> 

## DNS 缓存的作用

> DNS 解析器：为客户端提供与域名关联的 IP 地址，将域名转换为计算机可读的 IP 地址。
> 

DNS 作为将域名和 IP 地址相互映射的一个分布式数据库，能够使人更方便地访问互联网。

DNS 未缓存响应：

<embed alt="dns-uncached-response.svg" src="https://www.cloudflare.com/img/learning/dns/dns-cache-poisoning/dns-uncached-response.svg"/>

DNS 已缓存响应：

<embed alt="dns-cached-response.svg" src="https://www.cloudflare.com/img/learning/dns/dns-cache-poisoning/dns-cached-response.svg"/>

# **DNS 缓存中毒**

> DNS 服务器使用 UDP 而非 TCP，并且当前没有对 DNS 信息的验证
> 

攻击者可通过假冒 DNS 域名服务器，向 DNS 解析器发出请求，然后在 DNS 解析器查询域名服务器时伪造答复，使 DNS 缓存中毒。

DNS 缓存中毒过程：

<embed alt="dns-cache-poisoning-attack.svg" src="https://www.cloudflare.com/img/learning/dns/dns-cache-poisoning/dns-cache-poisoning-attack.svg"/>

中毒的 DNS 缓存：

<embed alt="dns-cache-poisoned.svg" src="https://www.cloudflare.com/img/learning/dns/dns-cache-poisoning/dns-cache-poisoned.svg"/>

## DNS 攻击预防策略

- 随机 DNS 解析器的端口；
- 将 DNS 请求封装于安全连接内，以保护 DNS 请求中的数据不被中间传输设备篡改；
- 为 DNS 解析服务提供了解析数据验证机制；
- ......

## Reference

CLOUDFLARE：[https://www.cloudflare.com/zh-cn/learning/dns/dns-cache-poisoning/](https://www.cloudflare.com/zh-cn/learning/dns/dns-cache-poisoning/)

Wiki：[https://zh.wikipedia.org/wiki/域名服务器缓存污染](https://zh.wikipedia.org/wiki/%E5%9F%9F%E5%90%8D%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%BC%93%E5%AD%98%E6%B1%A1%E6%9F%93)