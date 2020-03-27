---
title: nvm安装node环境
date: 2019-04-17 17:06:34
tags:
- nvm
- node
categories:
- nvm
- node
---

在我们日常开发当中，为了提升开发效率，必当借助一些工具，比如node，gulp，webpack等，接下来就谈谈node环境的安装版本如何进行切换。

---

<!-- more -->
  #### 全局安装nvm
  全局安装[nvm](https://github.com/coreybutler/nvm-windows/releases)，记住安装目录不可包含<font color=#f00 face="黑体">中文名称</font>
  ![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/clipboard.png)

  #### 用nvm安装node
  安装好node版本，npm也会一并安装，要是npm没安装成功，需要进行[配置项](https://www.cnblogs.com/beileixinqing/p/6775620.htm)操作
  ```bash
  nvm -v    查看nvm版本 
  nvm ls    查看当前使用的node版本
  nvm install 9.7.1   安装9.7.1版本 ( 默认安装64位 )
  nvm install 9.7.1 32    安装32位的9.7.1版本
  nvm uninstall 9.7.1    卸载9.7.1版本
  nvm use 9.7.1    切换node版本至9.7.1
  ```

  #### npm切换成cnpm
  ```bash
  npm install -g cnpm --registry=https://registry.npm.taobao.org
  ```

  ## 结语

  >nvm在我们日常开发中使用到的node版本管理非常有用，so，记得安装nvm来管理node环境。以上都是自己个人的总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.