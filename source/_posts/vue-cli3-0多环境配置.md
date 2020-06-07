---
title: vue-cli3.0多环境配置
date: 2020-04-07 12:36:32
tags:
- vue
- vue-cli3.0多环境配置
categories: vue
---

在日常开发中，通常都会遇到不同环境的发包，所以在这里记录一下如何进行多环境配置。

---

<!-- more -->

## 新建环境配置文件

{% note info %}
我们需要在项目的根目录下新建环境配置文件，在这里我们以 `development` 开发环境、 `production` 生产环境 `test` 测试环境为例
{% endnote %}

![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/vue-cli3-1.png)

{% note info %}
之后我们在每个文件中添加以下代码
{% endnote %}

## 开发环境-development

```bash
NODE_ENV = 'development'
VUE_APP_CURENV = 'dev'
```

## 生产环境-production

```bash
NODE_ENV = 'production'
VUE_APP_CURENV = 'pro'
```

## 测试环境-test

```bash
NODE_ENV = 'test'
VUE_APP_CURENV = 'test'
```

{% note info %}
配置完多环境文件之后，具体需要进行什么操作由各位看官们根据项目自行决定，这里不做过多的阐述。接下来我们还需要在 package.json 进行修改
{% endnote %}

## 修改 package.json 文件

![](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/vue-cli3-2.png)

{% note info %}
以上修改为多环境的打包命令，如果需要发包 `测试环境` 只需执行以下命令：
{% endnote %}

```bash
npm run test
```

{% note info %}
其他环境同理，如果嫌一个个输入命令比较麻烦，可以像我一样，使用 npm run all 进行三个环境的打包。
{% endnote %}

## 不同环境的包名

{% note info %}
因为默认打包都是 `dist` 包名，所以不是很好区分是哪个环境的包，所以我们在 `vue.config.js` 里面进行配置
{% endnote %}

```bash
outputDir: `dist-${process.env.VUE_APP_CURENV}-${formatTime(new Date(), 'yyyyMMddHHmmss')}`,
```

{% note info %}
可根据自己的实际情况进行修改设置，这里只提供一个例子。这样，我们每次打包出来，就很好的区分了是哪个环境的包了。
{% endnote %}

## 结语

>在日常开发中，多环境配置还是很实用的，有兴趣的可以去实践一下。