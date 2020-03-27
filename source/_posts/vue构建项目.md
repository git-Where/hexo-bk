---
title: vue构建项目
date: 2018-05-24 12:19:41
tags:
- vue
- vue/cli
- npm
- node
categories:
- vue
- node
---

vue构建一个新项目，跟启动一个新项目；在进行如下构建的时候，记得你本地已经安装好node跟npm。

---

<!-- more -->
  ### 用@vue/cli3构建项目：

  #### cmd全局安装vue
  ```bash
  npm install -g @vue/cli
  ```

  #### cmd运行vue项目管理器
  ```bash
  vue ui
  ```

  #### 在vue项目管理器上构建项目
  ![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/clipboard1.png)
  ![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/clipboard2.png)
  ![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/clipboard3.png)
  上图的proxy是配置跨域访问的问题；在服务端没解决接口跨域前，打包好的文件已是生产环境不可使用代理，所以打包项目必须放在跟接口同源目录下，否则页面接口会报错；

  ### 电脑重新启动vue-webpack项目
   
  #### 全局安装webpack
  ```bash
  npm i -g webpack
  ```

  #### 本地项目文件夹下安装webpack
  ```bash
  npm i -D webpack
  ```

  #### 安装依赖
  ```bash
  npm install / cnpm install / yarn install
  ```

  #### 启动本地项目
  ```bash
  npm run dev / npm start / npm run serve...
  ```

  #### 打包上线
  ```bash
  npm run build / yarn build
  ```

  ## 结语

  >以上都是自己的一些个人总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.