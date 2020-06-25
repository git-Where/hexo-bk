---
title: vue-cli单页应用中的全局样式以及变量
date: 2020-02-13 16:48:48
tags:
- vue
- vue-cli全局样式
categories: vue
---

这是在项目中遇到的问题。

---

<!-- more -->

#### 问题起源
在vue项目中构建基本完毕，产品要求对现有的页面，将所有字体都放大一点，虽然最终通过覆盖element-UI默认的样式实现效果，但是造成的冗余代码量非常之多。举个例子：

#### 项目中的问题
##### 问题1
项目基于vue-cli 与element UI框架搭建。其中涉及到需要修改el本身默认表格的样式以及其他样式。目前基本上有涉及到表格的路由组件页，都引入一个公共的TablePlulic.less模块样式，以/pages/home中的视图为例，如图：
![image](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/vue-cli.jpg)

分别都引入了相同的模块样式。虽然从开发实现上，并没有什么影响，但是切换路由视图的时候，从资源的加载上，就很明显的能看出代码的冗余程度，在每一次切换路由视图的时候，都会造成tablePublic.less重复加载，如图以tablePublic.less中的类名search-wrap为例。

当我们第一次打开provinceRoom视图时。页面首次加载tablePublic.less样式模块
![image](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/1.jpg)

当我们切换路由视图到provinceCost时，页面再次加载tablePublic.less模块

当再次切换到provinceSupervisor时页面第三次加载tablePublic.less模块

显而易见，在大型的单页项目中，如果公共样式模块在每个视图都引入，那么在切换多少个路由视图，页面就得加载多少次相同的代码
##### 问题2
在产品最终没有确定设计需求最终版本前，随时都有可能改变设计的本身（可能是间距，或者字体大小）我们希望通过一个公用的变量库来控制全局你使用到的一些变量。设定一定的基值，通过基值控制每一个设计上的大小以及间距。

#### 解决方案 ：node-sass+sass-loader+sass-resources-loader替换vue-cli本身的加载机制

##### 安装
```cmd
    cnpm i node-sass sass-loader sass-resources-loader --save-dev
```

##### 修改webpack.config默认配置
找到build/utlis.js

在cssLoaders中添加函数：
```js
function generateSassResourceLoader () {
      var loaders = [
          cssLoader,
          'sass-loader',
          {
              loader: 'sass-resources-loader',
              options: {
                  resources: [
                      path.resolve(__dirname, '../src/assets/tablePublic.scss'),//只是测试全局变量，也可以添加全局样式
                  ]
              }
          }
      ]
      if (options.extract) {
          return ExtractTextPlugin.extract({
              use: loaders,
              fallback: 'vue-style-loader'
          })
      } else {
          return ['vue-style-loader'].concat(loaders)
      }
  }
```

覆盖cssLoaders return 中默认的sass与scss的值：
```js
 return {
    css: generateLoaders(),
    postcss: generateLoaders(),
    less: generateLoaders('less'),
    sass: generateSassResourceLoader(),//新增
    scss: generateSassResourceLoader(),//新增
    // sass: generateLoaders('sass', { indentedSyntax: true }),
    // scss: generateLoaders('sass'),
    stylus: generateLoaders('stylus'),
    styl: generateLoaders('stylus')
  }
```
这样，在每个视图模块中，就无需逐一移入公共样式模块。页面资源也不会切换路由视图的时候，重复加载渲染相同的代码

问题2 亦是如此，将全局的less(scss)变量在resources做配置：
```js
options: {
  resources: [
      path.resolve(__dirname, '../src/assets/tablePublic.scss'),
      path.resolve(__dirname, '../src/assets/vars.scss'),
  ]
}
```
## 结语

>项目中遇到的问题还会很多，这只是其中的一小点，养成记录的习惯，就能事半功倍。以上都是自己个人的总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.