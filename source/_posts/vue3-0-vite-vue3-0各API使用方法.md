---
title: vue3.0+vite vue3.0各API使用方法
date: 2020-10-31 18:28:30
tags:
- vue3.0
- API使用
- 周期函数
categories:
- vue3.0
---

我们终于迎来了尤大大vue3.0的发布，但是周边一些ui框架([AntDesign](https://ant.design/docs/react/introduce-cn)等)还得等他们完善，竟然如此，我们先来用vite搭建一下[vue3.0](https://www.vue3js.cn/docs/zh/)项目，好好玩一玩vue3.0新API的使用方法，为后面vue2.0改版升级vue3.0做填坑准备吧。[vue3.0中文api地址](https://www.vue3js.cn/docs/zh/)

---

<!-- more -->

### vue3.0+vite搭建
```bash
yarn create vite-app <project-name>  // 创建项目
cd <project-name>   // 进入项目目录下
yarn  // 安装依赖
yarn dev   // 编译项目跑起来
---
集成typescript（vue-router@next axios）
yarn add --dev typescript
---
集成sass
yarn add sass
```
{% note info %}
安装sass时，要是遇到控制台报错，解决办法：
{% endnote %}
```bash
打开package.json
把dependencies里的sass这一行，移到devDependencies
重新运行yarn install
```

### vite是什么？
{% note info %}
vite是面向现代浏览器，基于原生模块系统ESModule实现了按需编译的Web开发构建工具，在生产环境下基于Rollup打包。但目前vite并不太成熟，在编译打包阶段可能会造成文件丢失，可以先用比较成熟的webpack进行编译打包。
{% endnote %}
优点：
```bash
快速冷启动服务器
即时热模块更换（HMR）
真正的按需编译
```
缺点：
```bash
不太稳定就是缺点之一，需要自己安装vue-router,vuex(记得都要安装4.0版本，安装的时候还容易出错，大家还是自己上手试一下，好用肯定是好用的，不然尤大大也不会去开发这个工具啦)'vue-router'：'^4.0.0-alpha.6','vuex':'^4.0.0-alpha.1'
```
### 变化一 main.js
main.js文件里的变了  多了createApp方法
```bash
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import './App.scss'

const app = createApp(App)
app.use(router).use(store).mount('#app');

```
由于这里用了`import {createApp} from 'vue'`;而不是`import Vue from 'vue'`，所以使用一些ui框架以及第三方的包都会报以下的错误：
![报错](https://hexo-img-url.oss-cn-beijing.aliyuncs.com/hexo_img/11.jpg)
遇到这个报错问题，基本上就说明你用的这个插件不支持vue3.0了。
### 变化二Vue-router,Vuex
在vue3.0中的路由使用，模板中还是可以使用router-link，但是在组件中setup函数中使用有所不同：
```bash
<script>
//首先的从vue-router中导入useRouter
import { useRouter } from "vue-router";
export default {
  setup() {
    //实例化路由
    const router = useRouter();
    router.push("/");
  }
};
</script>
```
在vue3.0中vuex的使用同vue-router类似：
```bash
<script>
import { reactive,toRefs } from 'vue';
import { useStore } from 'vuex';
export default {
  setup() {
    const state = reactive({
      name:''
    })

    const store = useStore()

    state.name = store.state.Name
     return {
       ...toRefs(state)
     }
  }
};
</script>
```
### 变化三 在vue2.0里，template模板里只能有一个根标签，在vue3.0中允许可以使用多个标签
```bash
<template>
  <div></div>
  <div></div>
</template>
```
### 变化四 Composition Api
在vue2.0中我们都把.vue文件里的js部分叫做Function API，而在vue3.0里变为Composition API，这里变化最大的地方：
```bash
<template>
    <h1>{{ msg }}</h1>
    <button @click="count++">count is: {{ count }} </button>
    <p>Editc <code>components/HelloWorld.vue</code> to test hot module replacement.</p>
    <button @click="change">按钮</button>
    <div>
      toRefs获取对象的值：{{supNum+',,,'+arrt}}
    </div>
    <div>
      计算属性的值（computed）：{{num}}
    </div>
</template>

<script>
import { ref,reactive,toRefs,computed, watchEffect, watch, onBeforeMount } from 'vue'
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  setup(props) {
    let count = ref(10) //响应式单个值

    let state = reactive({ //响应式对象数据
      supNum:100,
      arrt:[1,2,3]
    })

    function change(){  //方法
      state.supNum++
      state.arrt.push(4)
      x.value++
      y.value++
    }

    onMounted(async () => { //dom元素渲染完成

    })

    let num = computed(() => { // 计算属性
      return state.supNum+'0000'
    })

    watchEffect(() => { // 监听依赖变化-第一次的值会监听，以后每次改变也都会执行
      console.log(state.supNum+',watchEffect')
    })

    watch(
      () => state.supNum, // 可以监听到state对象中的某个值，（另外一种写法：state监听对象中的所有属性值）
      () => { // 跟vue2.0的watch一模一样，属于懒执行，第一次数值不会监听，以后每次变化都执行
        console.log(state.supNum+',watch')
      }
    )

    let x = ref(0);
    let y = ref(0);
    watch([x,y],([x,y],[prevX,prevY]) => { // 能够监听多个值中某个值的改变，prevX旧值
      console.log(x,prevX)
      console.log(x,prevY)
    })

    // 在第一次渲染组件之前，从服务器获取数据
    onBeforeMount(() => {

    })

    return {
      ...toRefs(state), //把state对象里的每一项转变成ref格式，即模板中直接使用supNum获取值
      count,
      // state, // 模板中要state.supNum获取数据
      change,
      num
    }
  }
}
</script>

```
#### 看到这里是不是觉得vue3.0的写法越来越趋近与react的写法了，没错，这只是他的改变之一，重点，vue3.0新特性来了。
### Composition API是什么
#### setup函数
##### setup函数是一个新的vue特性，是Composition Api入口
```bash
<template>
</template>
<script>
import { setup } from 'vue'
export default {
   setup(props, context) {
       //这里的props大家应该知道是啥吧，父组件传的值
       // context是什么？
       //在setup()里我们不能用this
       //所以vue2.0里的 this.$emit, this.$psrent, this.$refs在这里都不能用了。
       //context就是对这些参数的集合
       //context.attrs
       //context.slots
       //context.parent 相当于2.0里 this.$psrent
       //context.root 相当于2.0里 this
       //context.emit 相当于2.0里 this.$emit
       //context.refs 相当于2.0里 this.$refs
       ...
   }
}
</script>
<style>
</style>

```
#### ref() 声明单一基础数据类型时使用
##### 注意： 定义的变量，函数都要 return 出来
```bash
 <template>
  <div>{{count}}</div>
</template>
<script>
 import { setup， ref } from 'vue'
 export default {
    setup(props, context) {
      let count = ref(0)
      console.log(count.value) //0 ，  内部获取时需要用.value来获取
      console.log(isRef(count)) //true   //isRef() 用来判断是不是ref对象
      return {
        count  // ref返回的是一个响应式的对象
      }
    }
 }
</script>
<style>
</style>
```

#### Reactive() 声明单一对象时使用
```bash
<template>
 <div>{{data1}}</div>
</template>
<script>
import { setup, Reactive } from 'vue'
export default {
   setup(props, context) {
      const obj = reactive({
        data1: '123',
        data2: {}
      })
    
      return {
        ...toRefs(obj)// 把obj转为响应式的ref，不然template里获取不到,在template里可以直接data1获取值
      }
    }
}
</script>
<style>
</style>

```
#### watchEffect() 监听props
```bash
// 父组件.vue
<template>
   <Comp val:'1'/>
</template>
<script>

import Comp from './Comp.vue'
export default {
  components： {
      Comp
  }, //components方法也是和2.0相同
  setup(props, context) {
      
  }
}
</script>
-------------------------------------- 
//子组件Comp.vue
<template>
 <div>{{obj.data1}}</div>
</template>
<script>
import { Reactive } from 'vue'
export default {
  props: ['val'], //这里获取props和 2.0 一样,也可以用对象形式
  setup(props, context) {
     watchEffect(() => {  //首次和props改变才会执行这里面的代码
         console.log(props.val) //获取props里的值
     })
  }
}
</script>
<style>
</style>

```
#### watch() 监听器
##### 监听单个数据
```bash
<template>
<div>{{count}}</div>
</template>
<script>
import { Reactive } from 'vue'
export default {
  setup(props, context) {
   let count1 = ref(0)
   let state = reactive({
      count2: 0
   )
    //监听reactive类型
   watch(
    () => state.count2， //这里是你要监听的数据
    (count， preCount) => { //count新值， preCount旧值
        console.log('') //这里是监听数据变化后执行的函数
   }, {lazy： false}//在第一次创建不监听)
   
    //监听ref类型
    watch(count1，(count， preCount) => { //count新值， preCount旧值
      console.log('') //这里是监听数据变化后执行的函数
    })
   
   return {
      count
      ...toRefs(state)
   }
  }
}
</script>
<style>
</style>

```
##### 监听多个数据
```bash
<template>
<div>{{count}}</div>
</template>
<script>
import { setup, Reactive } from 'vue'
export default {
  setup(props, context) {
    let count1 = ref(0)
    let name1 = ref(0)
    let state = reactive({
      count2: 0，
      name2： 'yangy'
    )
    //监听多个reactive类型
    watch(
       [() => state.count2, () => state.name2]
       ([count， name], [preCount， preName]) => { //count新值， preCount旧值
           console.log('') //这里是监听数据变化后执行的函数
       }, 
       {
          lazy： false
    })//在第一次创建不监听
   
    //监听ref类型
    watch(
       [count2, name2]
       ([count， name], [preCount， preName]) => { //count新值， preCount旧值
           console.log('') //这里是监听数据变化后执行的函数
    }, {lazy： false}//在第一次创建不监听)
   
   return {
      count，
      ...toRefs(state)
   }
  }
}
</script>
<style>
</style>

```
#### computed() 计算属性 可创建只读，和可读可写两种
```bash
<template>
<div>{{addCount}}</div>
<div>{{addCount2}}</div>
</template>
<script>
import { setup, Ref } from 'vue'
export default {
  setup(props, context) {
   
    const count = ref(0)
    const addCount = computed(() => count.value + 1) //只读 ，count.value变化后执行加1
    
    const addCount2 = computed({
        get:() => count.value + 1,
        set: (value) => count.value = value 
    })    
    // addCount2.value = 10   //赋值方法
      
    return {
      count,
      addCount,
      addCount2
    }
  }
}
</script>
<style>
</style>

```
### 总结
这是用Vue3.demo, 新的语法基本上都涉及了, 以后还会去优化.虽然只是个dome,也希望你给我点个星星鼓励一下.

{% note info %}
今天就先说到这里吧，后面在花点时间去写写关于生命周期函数的使用方法，以及其他vue3.0新增的Api属性，以上都是自己的一些理解，如有不对之处还请指出，也可在下方留言，一起讨论。
{% endnote %}