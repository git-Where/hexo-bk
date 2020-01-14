---
title: --基于uniapp开发微信小程序=注意事项--
date: 2020-01-09 15:43:55
tags: 
- vue写法
- 文件上传
- uni-app
categories: 前端-小程序
---
 
  闲暇之余，来跟大家侃侃微信小程序开发中的那些事；今天要说的是基于[uniapp](https://uniapp.dcloud.io/)这款完全使用vue写法开发的微信小程序，相信大家在开发当中或多或少都会遇到一些棘手的怪异问题，下面是自己在项目实战开发当中总结出来的一些事项，希望能帮到大家。本人才疏学浅，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励。
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
  11.你的域名、备案、https需提前准备好(服务器域名需进过ICP备案、新备案域名需24小时候才能配置。域名格式只支持雅文大小写字母、数字及“-”，不支持IP地址及端口号)