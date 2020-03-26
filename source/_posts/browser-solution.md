---
title: 浏览器兼容性问题解决方案 · 总结
date: 2018-10-14 15:08:18
tags:
- 浏览器兼容
- 问题总结
categories: 前端-跨浏览器兼容总结篇
---
  不管是刚从事前端的小白，还是从事有几年经验的前端大佬，对于浏览器兼容性问题要是一经时间的推移没去复习巩固，可能就会渐渐被淡忘在脑海深处；所以，利用闲暇片段时间对这块内容进行又一次的梳理，贴到博客上，希望能帮助到有需要的伙伴~~~本人才疏学浅，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励。
  
  ---

  #### 浏览器兼容问题一：不同浏览器的标签默认的margin和padding不同
  问题根源：页面上随便写几个标签，不加样式控制的情况下，各自的margin 和padding差异较大。
  遇到几率：100%
  解决方案：
  可以使用Normalize来清除默认样式，具体可参考文章：[让我们谈一谈Normalize.css](https://jerryzou.com/posts/aboutNormalizeCss/)
  也可以使用如下代码：
  ```
  body,h1,h2,h3,ul,li,input,div,span,a,form …… { margin:0; padding:0; } OR *{margin:0; padding:0;}
  ```
<!--more-->
  #### 浏览器兼容问题二：块属性标签float后，又有横行的margin情况下，在IE6显示margin比设置的大
  问题根源：常见问题是IE6中后面的一块被顶到下一行
  遇到几率：85%以上(稍微复杂点的页面都会碰到，float布局最常见的浏览器兼容问题)
  解决方案：在float的标签样式控制中加入 display:inline;将其转化为行内属性 
  NOTE---我们最常用的就是div+CSS布局了，而div就是一个典型的块属性标签，横向布局的时候我们通常都是用div float实现的，横向的间距设置如果用margin实现，这就是一个必然会碰到的兼容性问题。

  #### 浏览器兼容问题三：设置较小高度标签（一般小于10px），在IE6，IE7，遨游浏览器中高度超出自己设置高度
  问题根源：IE6、7和遨游里这个标签的高度不受控制，超出自己设置的高度
  遇到几率：60%
  解决方案：给超出高度的标签设置overflow:hidden;或者设置行高line-height 小于你设置的高度。
  NOTE---这种情况一般出现在我们设置小圆角背景的标签里。出现这个问题的原因是IE8之前的浏览器都会给标签一个最小默认的行高的高度。即使你的标签是空的，这个标签的高度还是会达到默认的行高。

  #### 浏览器兼容问题四：行内属性标签，设置display:block后采用float布局，又有横行的margin的情况，IE6间距bug
  问题根源：IE6里的间距比超过设置的间距 
  遇到几率：20%
  解决方案：在display:block;后面加入display:inline;display:table; 
  NOTE---行内属性标签，为了设置宽高，我们需要设置display:block;(除了input/img标签比较特殊)。在用float布局并有横向的margin后，在IE6下，他就具有了块属性float后的横向margin的bug。不过因为它本身就是行内属性标签，所以我们再加上display:inline的话，它的高宽就不可设了。这时候我们还需要在display:inline后面加入display:talbe。

  #### 浏览器兼容问题五：图片默认有间距
  问题根源：几个img标签放在一起的时候，有些浏览器会有默认的间距，通配符清除间距也不起作用。
  遇到几率：20% 
  解决方案：使用float属性为img布局
  NOTE---因为img标签是行内属性标签，所以只要不超出容器宽度，img标签都会排在一行里，但是部分浏览器的img标签之间会有个间距。去掉这个间距使用float是正道。(也可使用负margin，虽然能解决，但负margin本身就是容易引起浏览器兼容问题的用法，所以尽量不要使用)

  #### 浏览器兼容问题六：标签最低高度设置min-height不兼容
  问题根源：因为min-height本身就是一个不兼容的CSS属性，所以设置min-height时不能很好的被各个浏览器兼容
  遇到几率：5%
  解决方案：如果我们要设置一个标签的最小高度200px，需要进行的设置为：{min-height:200px; height:auto !important; height:200px; overflow:visible;}
  NOTE---在B/S系统前端开发时，有很多情况下我们有这种需求。当内容小于一个值（如300px）时。容器的高度为300px；当内容高度大于这个值时，容器高度被撑高，而不是出现滚动条。这时候我们就会面临这个兼容性问题。

  #### 浏览器兼容问题七：清除浮动
  ```
  .clearfix::after {
    content: "";
    display: table;
    clear: both;
  }
  .clearfix {
    *zoom: 1;
  }
  ```
  或者在float的标签后面加上
  ```
  <div class="clear"></div>
  .clear{
    clear: both;
  }
  ```

  #### 浏览器兼容问题八：盒模型
  ```
  Element {
    box-sizing: border-box;
    /*box-sizing: content-box;*/
  }
  ```
  #### 浏览器兼容问题九：CSS hack
  在布局页面的时候，尽量写ie兼容的代码(有需要兼容ie的情况下)，避免去写很多hack。当然，hack也是非常好用，使用hack可以把浏览器分为三类：IE6,IE7,遨游浏览器；其他(IE8 chrome FF safari opera等)
  ##### IE6下的hack：_和*
  ##### IE7跟遨游浏览器下的hack：*
  比如这样写：
  ```
  div { height: 300px; *height: 200px; _height:100px; }
  ```
  IE6浏览器在读到height:300px的时候会认为高时300px；继续往下读，他也认识*heihgt， 所以当IE6读到*height:200px的时候会覆盖掉前一条的相冲突设置，认为高度是200px。继续往下读，IE6还认识_height,所以他又会覆盖掉200px高的设置，把高度设置为100px；
  IE7和遨游也是一样的从高度300px的设置往下读。当它们读到*height200px的时候就停下了，因为它们不认识_height。所以它们会把高度解析为200px，剩下的浏览器只认识第一个height:300px;所以他们会把高度解析为300px。因为优先级相同且想冲突的属性设置后一个会覆盖掉前一个，所以书写的次序是很重要的。 

  #### 浏览器兼容问题十：IE9以下浏览器不能使用opacity
  解决方案：
  ```
  div{
    opacity: 0.5;
    filter: alpha(opacity = 50);
    filter: progid:DXImageTransform.Microsoft.Alpha(style = 0, opacity = 50);
  }
  ```

  #### 浏览器兼容问题十一：边距重叠问题：当相邻两个元素都设置了margin 边距时，margin 将取最大值，舍弃最小值；
  解决方案：为了不让边重叠，可以给子元素增加一个父级元素，并设置父级元素为overflow:hidden；

  #### 浏览器兼容问题十二：两个块级元素，父元素设置了overflow:auto；子元素设置了position:relative ;且高度大于父元素，在IE6、IE7会被隐藏而不是溢出；
  解决方案：父级元素设置position:relative

  #### 浏览器兼容问题十三：web标准中设置IE浏览器滚动条颜色
  解决方案：
  ```
  <style type="text/css"> 
    html{ scrollbar-face-color:#f6f6f6; scrollbar-highlight-color:#fff; scrollbar-shadow-color:#eeeeee; scrollbar-3dlight-color:#eeeeee; scrollbar-arrow-color:#000; scrollbar-track-color:#fff; scrollbar-darkshadow-color:#fff;}
  </style>
  ```

  #### 浏览器兼容问题十四：firefox浏览器中嵌套div标签的居中问题的解决方法
  假如有如下情况：
  ```
  <div id="a"> 
    <div id="b"> </div> 
  </div>
  ```
  如果要实现b在a中居中放置，一般只需用CSS设置a的text-align属性为center。这样的方法在IE里看起来一切正常；但是在Firefox中b却会是居左的。
  解决方案：设置b的横向margin为auto。例如设置b的CSS样式为：margin: 0 auto;

  #### 浏览器兼容问题十五：透明png图片会带背景色
  问题根源：在ie6下透明的png图片会带一个背景色
  解决方案：
  ```
  div{
    background-image: url(icon_home.png);/* 其他浏览器 */
    background-repeat: no-repeat;
    _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='icon_home.png');/* IE6 */
    _background-image: none; /* IE6 */
  }
  ```

  #### 浏览器兼容问题十六：td自动换行的问题
  问题根源：Table宽度固定，td自动换行
  解决方案：设置Table的table-layout:fixed，td的word-wrap:break-word

  #### 浏览器兼容问题十七：ul浮动后，margin变大
  问题根源：ul设置 float后，在ie中margin将变大
  解决方案：设置ul的display:inline，li的list-style-position:outside

  #### 浏览器兼容问题十八：li浮动后，margin变大
  问题根源：li设置 float后，在ie中margin将变大
  解决方案：设置li的display:inline

  #### 浏览器兼容问题十九：嵌套使用ul、li的问题
  问题根源：ie的bug，嵌套使用ul、li时，里层的li设置float以后，外层li不设置float, 里面的ul顶部和它外面的li总是有一段间距
  解决方案：设置里面的ul的zoom:1

  #### 浏览器兼容问题二十：IE6 列表背景颜色失效的问题
  问题根源：当父元素设置position:relative;时，在ie6中第一个ul、ol、dl的背景颜色失效
  解决方案：ul、ol、dl 都设置为position:relative;

  #### 浏览器兼容问题二十一：IE6-7 列表背景颜色失效的问题2
  问题根源：做横向导航栏时，ul设置为float且有背景色，li设置为float。ie6-7背景颜色失效
  解决方案：很多ie的bug都可以通过触发layout来解决 ul添加属性
  ```
    height:1%;
    float:left;
    zoom:1;
  ```

  #### 浏览器兼容问题二十二：li中的内容以省略号显示
  问题根源：li中内容超过长度时，想以省略号显示， 此方法适用于ie6-7-8、opera、safari浏览器、ff浏览器不支持
  解决方案：
  ```
    li{
      width:200px;
      white-space:nowrap;
      text-overflow:ellipsis;
      -o-text-overflow:ellipsis; 
      overflow: hidden;
    }
  ```

  #### 浏览器兼容问题二十三：禁用中文输入法的问题
  问题根源：不能在输入框中输入汉字
  解决方案：
  只在ie系列和ff中有效
  ```
  ime-mode:disabled    (但可以粘贴)
  ```
  禁用粘贴：
  ```
  οnpaste="return false"
  ```

  #### 浏览器兼容问题二十四：除去滚动条的问题
  问题根源：隐藏滚动条
  解决方案：只有ie6-7支持<bodyscroll="no">
  除ie6-7不支持 body{overflow:hidden}
  所有浏览器 html{overflow:hidden}

  #### 浏览器兼容问题二十五：css滤镜的问题
  问题根源：css滤镜只在ie中有效，Firefox, Safari(WebKit), Opera只能够设置透明，它们不支持滤镜filter，无法实现图片切换中间变换的效果，只能通过透明度来设置。
  解决方案：ff中设置透明度-moz-opacity:0.10; opacity:0.6;ie中只设置filter:alpha(opacity=50); 时，ie6-7失效，还要设置zoom:1;  2、width:100%;

  #### 浏览器兼容问题二十六：解决 Placeholder在IE下显示的问题
  问题根源：Placeholder在IE下无法显示
  解决方案：
  ```
  <input type="text" value="Name *" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Name *';}">
  ```



  ---
  做兼容页面的方法时：每写一小段代码（布局中的一行或者一块）我们都要在不同的浏览器中看是否兼容，当然熟练到一定的程度就没这么麻烦了。建议经常会碰到兼容性问题的新手使用。很多兼容性问题都是因为浏览器对标签的默认属性解析不同造成的，只要我们稍加设置都能轻松地解决这些兼容问题。如果我们熟悉标签的默认属性的话，就能很好的理解为什么会出现兼容问题以及怎么去解决这些兼容问题。
  实战是解决问题的最佳途径，也是遇到问题的唯一途径，大家多多亲自制作才能更快更好的成长，另外多去借鉴别人的经验也是进步的捷径。
   