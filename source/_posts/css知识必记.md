---
title: css知识必记
date: 2017-10-25 17:24:21
tags:
- css
---

整理一些日常开发中常用到的css，以及在开发中遇到的奇葩问题解决方案（手机端、pc）

---

<!-- more -->

## 文本超出显示省略号

```bash
white-space:nowrap;
overflow:hidden;
text-overflow:ellipsis;
display:block;
```

+ 超出几行文本显示为省略号
```bash
display: -webkit-box;
-webkit-box-orient: vertical;
overflow: hidden;
text-overflow: ellipsis;
-webkit-line-clamp: 2;
```
+ 一般的文字截断（适用于内联与块）
```bash
display: block;
word-break: keep-all; /*不换行*/
word-space: nowrap; /*不换行*/
overflow: hidden;
text-overflow: ellipsis; /*当对象内文本溢出时显示省略标记（...）,需与overflow:hidden;一起使用*/
```
+ 对于表格，定义有点不一样
```bash
table{
    width:100%;
    table-layout:fixed; /*还有定义了表格的布局算法为fixes,下面的td定义才能起作用*/
}
td{
    width:100%;
    word-break:keep-all; /*不换行*/
    word-space: nowrap; /*不换行*/
    overflow: hidden;
    text-overflow: ellipsis; /*当对象内文本溢出时显示省略标记（...）,需与overflow:hidden;一起使用*/
}
```
>这个只对单行的文字有效，如果你想把它用在多行上，也只有第一行有作用的。这个写法只有ie会有“...”,其他的浏览器文本超出制定宽度时会隐藏。tabel里设置table-layout:fixed;td设置如上这样表格里设置宽度超出就可以以省略号标记。

## 单选框实现单选选中
```
<input type=”radio” name="aihao">要实现单选的话，要在每个input加同一个name
```
## text-align作用
>text-align只对图片跟文字起作用，只对非块类元素起作用（span、em、i、）
## 通配符*
>样式后面加*为通配符
```bash
.search *{
    /*表示#search下的所有的子元素*/
}
```
## 解决移动端点击出现黑色闪背景
```bash
-webkit-tap-highlight-color:transparent;
```
## 解决输入框点击光标变大
```bash
line-height:initial;
```
## 解决苹果手机页面内容滑动卡顿
```bash
-webkit-overflow-scrolling:touch;
```
## 表格td加边框重复问题
>在表格tabel里加上`border-collapse:collapse;`,在td内设置border边框，td与td之间遇到的border边框会`相叠`在一起
## 容器定死高度滑动
>一个容器内定死高度加上底下两句，超出的内容会以滚动条的方式滚动：
```bash
-webkit-overflow-scrolling:touch;
overflow-y:scroll;
```
## 滤镜效果（安卓不支持，火狐、谷歌、360、ie8都能很好兼容）
```bash
filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
-webkit-filter: grayscale(100%);
-moz-filter: grayscale(100%);
-ms-filter: grayscale(100%);
-o-filter: grayscale(100%);
filter: grayscale(100%);
filter: gray;
```
## 动画
```bash
@keyframes name{
    animation:  name (名称,自定义)
                1s(动画几秒完成)
                ease(动画完成曲线，ease低速开始，变快，在变慢结束；ease-in低速开始；ease-out低速结束；ease-in-out低速开始跟结束；linear重头到尾速度都是一样.);
                1s(进入动画前的延迟)
                Normal(动画正常播放；alternate动画轮流方向播放, forwards动画停在最后一帧，infinite永久循环)
    transition-timing-function:cubic-bezier();(贝塞尔曲线)自己设置运动轨迹相当于ease  ease-in  ease-in-out
}
```
## 停止冒泡事件与阻止默认行为
>停止冒泡时间：(停止事件冒泡可以阻止事件中其他对象的事件处理函数被执行):event.stopPropagation();或 者return false;
>阻止默认行为：(单击超链接后会跳转、单击"提交"按钮后表单会提交)event.preventDefault();或者return false;
## 页面的最小宽度
>最小宽度`min-width`在ie下不被识别，可以把一个<div> 放到 <body> 标签下，然后为div指定一个类：
```bash
#container{ min-width: 600px; width:expression(document.body.clientWidth < 600? "600px": "auto" );}
```
## 在ie10下输入框默认会有一个叉叉
>加上如下代码即可避免
```bash
input::-ms-clear{ display:none;}
```
## 日期格式在手机上的兼容（ios）
>苹果只认2018/09/12格式，要是存在2018-09-12需作转换；安卓两种格式都能正常读取
```bash
var Time = '2018-09-12'
Time.replace(/-/g,'/')
```
## css3设置字体镂空
```bash
-webkit-text-fill-color:white;  -webkit-text-stroke: 2px red;
```
## 文本平分间距
>设置固定宽度下，加一下两句代码：
```bash
text-align-last:justify;
text-align:justify;
```
## 去除输入框的黄色背景
```bash
input:-webkit-autofill{
    -webkit-box-shadow:0 0 0 1000px #fff inset
}
```
## 移除html5上input框type="number"时的上下小箭头（pc端的也可以用）
>在chrome下：
```bash
input::-webkit-outer-spin-button,
 input::-webkit-inner-spin-button{
    -webkit-appearance: none !important;
    margin: 0;
}
```
>在Firefox下：
```bash
input[type="number"]{-moz-appearance:textfield;}
```
>第二种方案：将type="number"改为type="tel"，同样是数字键盘，但是没有箭头。
## 刚进入页面刷新，把某块内容置顶
```bash
$("html, body").scrollTop(0).animate({scrollTop: $(".ui-today").offset().top});
```
## Android 4.2.x 背景色溢出
>测试发现，在 `Android 4.2.x` 系统自带浏览器中，同时设置`border-radius`，`border`和`背景色`的时候，背景色会溢出到圆角以外部分，可以使用背景剪裁`background-clip: padding-box;`来修复，但是如果border-color为半透明时，背景直角部分依然会露出来（参见图一）。
## 结语

{% note info %}
以上都是自己的一些个人总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.
{% endnote %}