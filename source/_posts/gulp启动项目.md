---
title: gulp启动项目
date: 2019-05-04 16:48:22
tags:
- gulp
- node
- npm
- cnpm
categories:
- gulp
---

gulp在我们日常开发中，越来越常使用到，这篇就跟大家讲讲怎么安装gulp跟所属依赖，启动项目

---

<!-- more -->
  #### 全局安装nodeJS环境
  下载nodejs,一直点确定安装，去[nodejs官网](https://nodejs.org)下载软件，安装好cmd输入命令：node -v查看版本号是否安装成功,新版的NodeJS已经集成了npm，所以npm也一并安装好了

  #### 全局安装gulp
  cmd-全局安装gulp
  ```bash
  npm install –g gulp 
  ```

  #### 项目本地安装gulp
  ```bash
  npm install gulp –save-dev
  ```

  #### 项目安装gulp依赖
  项目本地安装package.json依赖插件
  ```bash
  cnpm install / npm install
  ```

  #### 启动项目
  gulp
  
  ## 结语

  >对于如何配置gulpFile.js文件，可自行百度搜索gulp进行学习，本章只介绍gulp如何启动一个新项目。以上都是自己个人的总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.