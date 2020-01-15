---
title: Hello hexo--从构建到发布
date: 2020-01-15 15:15:15
tags: 
- hexo构建命令
categories: 前端-博客
---
对于开发人员来说, 拥有自己的专属博客是必不可少的, 选用哪款技术来搭建博客对于日后编辑维护显得尤其重要. 今天要跟大家介绍的是基于hexo来搭建的博客，本人才疏学浅，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.

欢迎来到[Hexo](https://hexo.io/)! 这是一篇由构建-->发布到github上的实践操作步骤. 查看[文档](https://hexo.io/docs/)了解更多信息. 如果你在使用hexo时遇到任何问题, 币可以在[故障排除中](https://hexo.io/docs/troubleshooting.html)找到答案，或者你可以在[GitHub](https://github.com/git-Where/hexo-bk/issues)上问我.

## Quick Start

### 建立新文件

``` bash
$ hexo new "文件名称"
```

更多信息: [hexo_Docs](https://hexo.io/docs/writing.html)

### 开启服务（热更新）
<!--more-->
``` bash
$ hexo server/hexo s
```

更多信息: [Server](https://hexo.io/docs/server.html)

### 生成静态文件

``` bash
$ hexo generate/hexo g
```

更多信息: [生成静态文件](https://hexo.io/docs/generating.html)

### 部署到远程站点（github）

``` bash
$ hexo deploy/hexo d
```

更多信息: [部署](https://hexo.io/docs/deployment.html)

EG:
要是从远程站点直接clone下来的，要先安装依赖，安装完依赖后，可直接新建文章进行编辑操作，操作步骤如下：

### 本地安装依赖

``` bash
$ npm install
```
