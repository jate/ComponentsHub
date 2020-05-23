# ComponentsHub

在各种业务与组件不断增长的时候，他们之间的各种依赖关系显得尤其复杂。

且使用Cocoapods或Carthage等管理使得各个模块趋于独立化。如果一个静态库被多个模块依赖，会导致这个静态库被多次包含在可执行文件中，增加了App包的体积。而大量使用动态库会导致App在冷启动时，加载动态库时间越来越长。

同时为了组件满足DRY原则，那么就很有必要做 **组件通信**。

同时也为了App支持URL Router。

## 一、美团的技术解决方案（OC版）
[相关链接](https://juejin.im/post/5be4f3eaf265da614b117e81)

[Github代码Demo](https://github.com/dsxNiubility/WMScheduler)

### 业界四大方向
* DI 依赖注入，通用做法 protocol-class
* SPI机制，Service Provider Interface		(效率优)
* 通知中心
* objc_msgSend	(效率优，可读性差)

### 美团的技术方案（基于SPI机制）
* Category + NSInvocation
* CategoryCoverOrigin方式

### Category治理
linkmap tools 主要防止category的重复实现。

## 二、TinyPart库 方法
核心基于protocol-class方式。类似蘑菇街、RN等架构设计。


## 三、我自己的Swift方案

基础库定义业务protocol，并支持注册闭包、获取、删除等操作。这样闭包可以理解为带输入输出的管道。例如，某App根据protocol获取闭包，然后传入参数（或者为空），返回值即支持protocol的实例对象，最后App就可以方便使用了。

模块库 依赖基础库，并提供initializeXXModule方法，该方法向基础库注册闭包，实现闭包，返回业务实现类实例，这里的类实例 就是基础库定义的protocol实现。


