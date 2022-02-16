[> Back](../README.md#网络安全)

# BGP 路由劫持

Created: November 8, 2021
Sort: Security

> BGP（Border Gateway Protocol）：边界网关协议，是 Internet 的去中心化自治路由协议。 —— Wiki 百科
> 

## 1. BGP

BGP 是一个路由协议：
- 每个 BGP 路由器都拥有一个路由表，路由表中记录着 AS （自治系统）之间的最佳路由。

BGP 是一个矢量路由协议：
- 矢量提供了方向，以便流量尽可能高效地在 IP 地址间传输。BGP 总是倾向于 AS 之间的最短路径，通过尽可能少的路由来到达 IP 地址。

BGP 是一个去中心自治路由协议：
- 由于 AS 会不断广播其所拥有的 IP 地址前缀，因此 BGP 路由器几乎需要不断地更新这些内容。

*IP 地址前缀的意义在于表示其 IP 地址的范围*

如果 DNS 是互联网的地址簿，那么 BGP 就是互联网的路线图。

## 2. AS

AS（自治系统）的本质是一个或多个实体管辖下的所有 IP 地址前缀的大型网络，并且内部具有单一和清晰定义的路由政策。（译自 [RFC 1930](https://datatracker.ietf.org/doc/html/rfc1930)）

- 内部 BGP：AS 可以采用 BGP 协议来路由内部的子网，这种 BGP 协议被成为 iBGP；
- 外部 BGP：AS 之间采用路由 BGP 协议来路由 AS，这种 BGP 协议被成为 eBGP。

Internet 是由数十万个 AS 组成的网络，但对互联网来说，它只能看到 AS 的外部路由策略，所以 AS 必须具有一个公开且唯一的编号 ASN。

ASN 是区别整个相互连接的网络中的各个网络的唯一标识，但只有 eBGP 需要 ASN。

## 3. BGP 劫持

BGP 劫持：

1. 利用 BGP 协议始终支持所需 IP 地址前缀的最短路径的特征；
2. 欺骗 AS 广播一个不受其控制，且距离比其它 AS 都要短的 IP 地址前缀；
3. 欺骗 BGP 路由器将假的 IP 地址前缀加入到其路由表中；
4. 结果导致一个或多个 AS 的流量全引流向该虚假 IP。

---

- [x]  修正维基百科词条：[https://zh.wikipedia.org/w/index.php?title=自治系统&oldid=68632742](https://zh.wikipedia.org/w/index.php?title=%E8%87%AA%E6%B2%BB%E7%B3%BB%E7%BB%9F&oldid=68632742)