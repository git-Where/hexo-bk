---
title: --基于uniapp开发微信小程序=注意事项--
date: 2019-10-10 15:43:55
tags: 
- vue写法
- 文件上传
- uni-app
categories: 前端-小程序
---
 
  闲暇之余，来跟大家侃侃微信小程序开发中的那些事；今天要说的是基于[uniapp](https://uniapp.dcloud.io/)这款完全使用vue写法开发的微信小程序，相信大家在开发当中或多或少都会遇到一些棘手的怪异问题，下面是自己在项目实战开发当中总结出来的一些事项，希望能帮到大家。本人才疏学浅，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励。

  ---
  <!--more-->
  #### uni-app
  [uni-app官网文档](https://uniapp.dcloud.io/)
  #### 微信小程序
  [微信小程序官方文档](https://developers.weixin.qq.com/miniprogram/dev/framework/config.html)
  ### 细节-Attention

  1.字体图标的使用
  &nbsp;&nbsp;&nbsp;&nbsp;(1)使用远程地址

  ```
  @font-face{
	  font-family:"iconfont";
    src:url("https://..........");
  }
  ```
  &nbsp;&nbsp;&nbsp;&nbsp;(2)使用本地字体文件
  ```
  @font-face{
	  font-family:"iconfont";
    src:url("~@/static/font/iconfont.ttf");
  }
  ```
  2.域名要求
  &nbsp;&nbsp;&nbsp;&nbsp;开发阶段不限制域名格式,正式环境必须使用`https`协议<br>
  3.页面图片处理
  &nbsp;&nbsp;&nbsp;&nbsp;开发阶段可使用本地图片库地址,发布线上环境之后最好使用网络地址图片,其中原因是微信小程序把线上的包大小限制为2M,使得很多静态资源必须使用网络地址，以限制包大小在2M以内。方法可以使用后端存放项目代码的服务器来保管图片,或者放在网络地址上(千牛云...)<br>
  4.微信小程序开发视频全屏后textarea的placeholder浮在最上面解决方法：通过小程序video属性bindfullscreenchange=“” 写监听事件，监听视频是否是全屏还是退出全屏，进而隐藏textarea来解决此问题。<br>
  5.尺寸单位
  &nbsp;&nbsp;&nbsp;&nbsp;rpx（responsive pixel）: 可以根据屏幕宽度进行自适应。规定屏幕宽为750rpx。如在 iPhone6 上，屏幕宽度为375px，共有750个物理像素，则750rpx = 375px = 750物理像素，1rpx = 0.5px = 1物理像素;等于设计稿750像素点，开发时候设计稿多少尺寸就写多少rpx。<br>
  6.当用户点击右上角关闭，或者按了设备Home键离开微信，小程序并没有直接销毁，而是进入了后台;当再次进入微信或再次打开小程序，又会从后台进入前台，只有当小程序进入后台一定时间，或者系统资源占用过高，才会被真正的销毁。<br>
  7.不要在onLaunch周期函数内调用 getCurrentPage()获取页面栈，此时 page 还没有生成。<br>
  8.一个小程序账号只有一个管理员(可修改)，可以绑定10位开发者。<br>
  9.个人开发者无法申请微信小程序;目前微信仅支持企业、政府、媒体、其他组织申请。<br>
  10.微信支付需在第一次审核通过后，才可使用。<br>
  11.你的域名、备案、https需提前准备好(服务器域名需进过ICP备案、新备案域名需24小时候才能配置。域名格式只支持雅文大小写字母、数字及“-”，不支持IP地址及端口号)<br>
  12.代码包大小的优化
  &nbsp;&nbsp;&nbsp;&nbsp;小程序一开始时代码包限制为 1MB，但我们收到了很多反馈说代码包大小不够用，经过评估后我们放开了这个限制，增加到 2MB 。代码包上限的增加对于开发者来说，能够实现更丰富的功能，但对于用户来说，也增加了下载流量和本地空间的占用。开发者在实现业务逻辑同时也有必要尽量减少代码包的大小，因为代码包大小直接影响到下载速度，从而影响用户的首次打开体验。除了代码自身的重构优化外，还可以从这两方面着手优化代码大小：<br>
  控制代码包内图片资源<br>
  &nbsp;&nbsp;&nbsp;&nbsp;小程序代码包经过编译后，会放在微信的 CDN 上供用户下载，CDN 开启了 GZIP 压缩，所以用户下载的是压缩后的 GZIP 包，其大小比代码包原体积会更小。 但我们分析数据发现，不同小程序之间的代码包压缩比差异也挺大的，部分可以达到 30%，而部分只有 80%，而造成这部分差异的一个原因，就是图片资源的使用。GZIP 对基于文本资源的压缩效果最好，在压缩较大文件时往往可高达 70%-80% 的压缩率，而如果对已经压缩的资源（例如大多数的图片格式）则效果甚微。<br>
  及时清理没有使用到的代码和资源<br>
  &nbsp;&nbsp;&nbsp;&nbsp;在日常开发的时候，我们可能引入了一些新的库文件，而过了一段时间后，由于各种原因又不再使用这个库了，我们常常会只是去掉了代码里的引用，而忘记删掉这类库文件了。目前小程序打包是会将工程下所有文件都打入代码包内，也就是说，这些没有被实际使用到的库文件和资源也会被打入到代码包里，从而影响到整体代码包的大小。<br>
  13.图片资源
  &nbsp;&nbsp;&nbsp;&nbsp;目前图片资源的主要性能问题在于大图片和长列表图片上，这两种情况都有可能导致 iOS 客户端内存占用上升，从而触发系统回收小程序页面。<br>
  图片对内存的影响<br>
  &nbsp;&nbsp;&nbsp;&nbsp;在 iOS 上，小程序的页面是由多个 WKWebView 组成的，在系统内存紧张时，会回收掉一部分 WKWebView。从过去我们分析的案例来看，大图片和长列表图片的使用会引起 WKWebView 的回收。<br>
  图片对页面切换的影响<br>
  &nbsp;&nbsp;&nbsp;&nbsp;除了内存问题外，大图片也会造成页面切换的卡顿。我们分析过的案例中，有一部分小程序会在页面中引用大图片，在页面后退切换中会出现掉帧卡顿的情况。当前我们建议开发者尽量减少使用大图片资源。<br>
  14.关于setData
  setData 是小程序开发中使用最频繁的接口，也是最容易引发性能问题的接口。在介绍常见的错误用法前，先简单介绍一下 setData 背后的工作原理。<br>
  工作原理<br>
  &nbsp;&nbsp;&nbsp;&nbsp;小程序的视图层目前使用 WebView 作为渲染载体，而逻辑层是由独立的 JavascriptCore 作为运行环境。在架构上，WebView 和 JavascriptCore 都是独立的模块，并不具备数据直接共享的通道。当前，视图层和逻辑层的数据传输，实际上通过两边提供的 evaluateJavascript 所实现。即用户传输的数据，需要将其转换为字符串形式传递，同时把转换后的数据内容拼接成一份 JS 脚本，再通过执行 JS 脚本的形式传递到两边独立环境。而 evaluateJavascript 的执行会受很多方面的影响，数据到达视图层并不是实时的。<br>
  常见的 setData 操作错误:
  ##### 1. 频繁的去 setData
  在我们分析过的一些案例里，部分小程序会非常频繁（毫秒级）的去setData，其导致了两个后果：
  1. Android 下用户在滑动时会感觉到卡顿，操作反馈延迟严重，因为 JS 线程一直在编译执行渲染，未能及时将用户操作事件传递到逻辑层，逻辑层亦无法及时将操作处理结果及时传递到视图层；
  2. 渲染有出现延时，由于 WebView 的 JS 线程一直处于忙碌状态，逻辑层到页面层的通信耗时上升，视图层收到的数据消息时距离发出时间已经过去了几百毫秒，渲染的结果并不实时


  ##### 2. 每次 setData 都传递大量新数据
  由setData的底层实现可知，我们的数据传输实际是一次 evaluateJavascript 脚本过程，当数据量过大时会增加脚本的编译执行时间，占用 WebView JS 线程，
  ##### 3. 后台态页面进行 setData
  当页面进入后台态（用户不可见），不应该继续去进行setData，后台态页面的渲染用户是无法感受的，另外后台态页面去setData也会抢占前台页面的执行。

  ## 结语
  >以上都是自己个人的总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.