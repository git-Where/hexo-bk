---
title: vue组件之间的通信
date: 2020-03-27 09:59:31
tags:
- vue
- 组件
- 通信
- 组件通信
categories:
- vue
---

组件是 vue.js最强大的功能之一，而组件实例的作用域是相互独立的，这就意味着不同组件之间的数据无法相互引用。针对不同的使用场景，如何选择行之有效的通信方式？本文总结了vue组件间通信的几种方式，希望对看官们有些许帮助。

---

<!-- more -->

## 父子组件之间的通信

{% note info %}
下面我们来介绍一下父子通信的几种方式
{% endnote %}

### props

> `props` 的通信方式，可以说是最常用的父子组件的通信方式了。父组件通过 `props` 的方式向子组件传递，由子组件进行接收，这样我们就可以在子组件中拿到从父组件传递过来的参数了。

```bash
// 父组件
<template>
  <div>
    <el-button type="primary" @click="changeNum">点击修改子组件的值</el-button>
    <chlid :num="num"></chlid>
  </div>
</template>

<script>
import Chlid from './Child'
export default {
  name: 'Parent',
  components: {
    Chlid
  },
  data() {
    return {
      num: 0
    }
  },
  methods: {
    changeNum() {
      this.num += 1
    }
  }
}
</script>
```

```bash
// 子组件
<template style="margin-top: 30px;">
  <div>
    子组件中的num: {{ num }}
  </div>
</template>

<script>
export default {
  name: 'Child',
  props: {
    num: {
      type: Number,
      default: () => 0
    }
  }
}
</script>
```

>上述代码运行效果如下：

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/Video_2020-03-27_103633.gif)

{% note warning %}
使用 `props` 需要注意，不应该在一个子组件内部改变 prop，这样会破坏单向的数据绑定，导致数据流难以理解。如果有这样的需要，可以通过 data 属性接收或使用 computed 属性进行转换。
{% endnote %}

### $emit

>那么，子组件如何向父组件通信呢，这时我们就需要用到 `$emit` 了，通过 `$emit` 发射一个事件，然后由父组件用 `v-on` 接收子组件传递过来的参数，我们把上面的代码稍微改造一下。

```bash
// 子组件
<template>
  <div style="margin-top: 30px;">
    子组件中的num: {{ num }}
    <el-button type="primary" @click="changeParentNum">点击修改父组件的值</el-button>
  </div>
</template>

<script>
export default {
  name: 'Child',
  props: {
    num: {
      type: Number,
      default: () => 0
    }
  },
  methods: {
    // 事件发射
    changeParentNum() {
      const num = this.num + 1
      // 定义一个事件名，并传递参数
      this.$emit('changeParentNum', num)
    }
  }
}
</script>
```

```bash
// 父组件
<template>
  <div>
    <el-button type="primary" @click="changeNum">点击修改子组件的值</el-button>
    <chlid :num="num" @changeParentNum="changeParentNum"></chlid>
  </div>
</template>

<script>
import Chlid from './Child'
export default {
  name: 'Parent',
  components: {
    Chlid
  },
  data() {
    return {
      num: 0
    }
  },
  methods: {
    changeNum() {
      this.num += 1
    },
    // 接收从子组件传递过来的参数
    changeParentNum(val) {
      this.num = val
    }
  }
}
</script>
```

>上述代码运行效果如下：

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/Video_2020-03-27_105652.gif)

{% note info %}
这样我们就通过了 `props` 和 `$emit` 实现了一个简单的数据双向绑定
{% endnote %}

### .sync

>或许我们会觉得这样发射事件过于繁琐了，所以我们再稍微改造一下，使用 `.sync` 修饰符进行子组件向父组件通信并实现数据双向绑定。同样，我们还是改造上面的代码。

```bash
// 子组件
<template>
  <div style="margin-top: 30px;">
    子组件中的num: {{ num }}
    <el-button type="primary" @click="changeParentNum">点击修改父组件的值</el-button>
  </div>
</template>

<script>
export default {
  name: 'Child',
  props: {
    num: {
      type: Number,
      default: () => 0
    }
  },
  methods: {
    // 事件发射
    changeParentNum() {
      const num = this.num + 1
      // 使用 .sync 修饰符，需要使用 update，告诉父组件，我需要更新哪个值
      this.$emit('update:num', num)
    }
  }
}
</script>
```

```bash
// 父组件
<template>
  <div>
    <el-button type="primary" @click="changeNum">点击修改子组件的值</el-button>
    <!-- 使用.sync修饰符进行数据接收并更新 -->
    <chlid :num.sync="num"></chlid>
  </div>
</template>

<script>
import Chlid from './Child'
export default {
  name: 'Parent',
  components: {
    Chlid
  },
  data() {
    return {
      num: 0
    }
  },
  methods: {
    changeNum() {
      this.num += 1
    }
  }
}
</script>
```

>上述代码运行效果如下：

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/Video_2020-03-27_105652.gif)

## 非父子组件之间的通信

{% note info %}
讲完父子组件的几种通信方式，我们来在讲讲非父子组件之间的通信方式。也可以叫做兄弟组件的通信方式
{% endnote %}

### eventBus

>对于比较小型的项目，可以使用 `eventBus`。可以实现任意两个组件间的通信。它的实现思想也很好理解，在要相互通信的两个组件中，都引入同一个新的 `vue` 实例，然后在两个组件中通过分别调用这个实例的事件触发和监听来实现通信。对于 `eventBus` 我们可以自己手动创建，也可以通过引入插件的方式。这里我们主要讲插件的这种方式。

>首先我们需要安装下 `vue-bus` 这个插件

```bash
npm install vue-bus --save
```

>然后在 `main.js` 里面引入，这样我们在任意的 `vue` 实例中都能直接调用了。

```bash
import VueBus from 'vue-bus' // bus总线
Vue.use(VueBus)
```

```bash
// brother1组件
<template>
  <div>
    <el-button type="primary" @click="changeNum">点击修改brother2组件的值</el-button>
  </div>
</template>

<script>
export default {
  name: 'Brother1',
  data() {
    return {
      num: 0
    }
  },
  beforeDestroy() {
    // 组件销毁之前需要清除bus
    this.$bus.$off('changeNum')
  },
  methods: {
    changeNum() {
      this.$bus.$emit('changeNum', this.num += 1)
    }
  }
}
</script>
```

```bash
// brother2组件
<template>
  <div>
    brother1传递过来的值：{{ num }}
  </div>
</template>

<script>
export default {
  name: 'Brother2',
  data() {
    return {
      num: 0
    }
  },
  created() {
    // 声明接收事件
    this.$bus.$on('changeNum', (val) => {
      this.num = val
    })
  }
}
</script>
```

>上述代码运行效果如下：

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/Video_2020-03-27_122023.gif)

{% note warning %}
使用 `eventBus` 需要注意的是在组件销毁的时候，需要关闭接收事件。
{% endnote %}

### vuex

{% note info %}
如果不是特别必要的，可以不引入vuex，所以我们这里也不讲vuex是如何进行组件通信的，有兴趣的可以看官网自行百度。
{% endnote %}

## 嵌套组件之间的通信

{% note info %}
在实际项目中，我们还有可能会遇到过深层次的嵌套组件之间的通信，如果使用 `props` 一直传递接收下去，未免显得太过沉重了，所以我们可以使用以下几个方法进行嵌套组件的通信。
{% endnote %}

### $attrs / $listeners

>可能很多人都对这两个属性不了解，我们来看下官方的解释：

- $attrs

>包含了父作用域中不作为 prop 被识别 (且获取) 的特性绑定 (class 和 style 除外)。当一个组件没有声明任何 prop 时，这里会包含所有父作用域的绑定 (class 和 style 除外)，并且可以通过 v-bind="$attrs" 传入内部组件——在创建高级别的组件时非常有用。

- $listeners

>包含了父作用域中的 (不含 .native 修饰器的) v-on 事件监听器。它可以通过 v-on="$listeners" 传入内部组件——在创建更高层次的组件时非常有用。

>以下例子，我们准备了几个参数传递下去，并且准备了两个方法，一个加了 `native` 原生修饰符，一个是非原生事件，然后看看嵌套组件之间的参数传递结果

```bash
// 父组件
<template>
  <div>
    <child-com-1
      :params1="params1"
      :params2="params2"
      :params3="params3"
      :params4="params4"
      @event1.native="event1"
      @event2="event2"
    ></child-com-1>
  </div>
</template>

<script>
import ChildCom1 from './components/com-3/ChildCom1'
export default {
  name: 'Corresponded',
  components: {
    ChildCom1
  },
  data() {
    return {
      params1: 'javaScript',
      params2: 'html',
      params3: 'css',
      params4: 'vue'
    }
  },
  methods: {
    event1() {
      console.log('我是有native原生事件修饰符的event1事件')
    },
    event2() {
      console.log('我是非原生事件event2')
    }
  }
}
</script>
```

>然后在第一级的子组件里面，用 `props` 来接收一下传递过来的 `params1` 参数

```bash
// 第一级子组件
<template>
  <div>
    <div>嵌套组件传递过来的参数：{{ $attrs }}</div>
    <child-com-2 v-bind="$attrs" v-on="$listeners"></child-com-2>
  </div>
</template>

<script>
import ChildCom2 from './ChildCom2'
export default {
  name: 'ChildCom1',
  components: {
    ChildCom2
  },
  inheritAttrs: false, // 可以关闭自动挂载到组件根元素上的没有在props声明的属性
  // 用props接收params1参数
  props: {
    params1: {
      type: String,
      default: () => ''
    }
  },
  created() {
    console.log(this.$attrs)
    console.log(this.$listeners)
  }
}
</script>
```

>我们可以在 `child-com-1` 组件看到，用 `props` 接收的属性和  `native` 修饰的事件是没有在 `this.$attrs` 和 `this.$listeners` 里面的

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/DA6B1A8E-7DC1-4a64-8E15-D58B7323E183.png)

>之后我们就可以直接使用 `v-bind="$attrs"` 和 ` v-on="$listeners"` 把属性和事件继续传递下去，并且在子组件用 `props` 接收一下 `params2` 这个属性

```bash
// 第二级子组件
<template>
  <div>
    <div>嵌套组件传递过来的参数：{{ $attrs }}</div>
  </div>
</template>

<script>
export default {
  name: 'ChildCom2',
  inheritAttrs: false, // 可以关闭自动挂载到组件根元素上的没有在props声明的属性
  props: {
    params2: {
      type: String,
      default: () => ''
    }
  },
  created() {
    console.log(this.$attrs)
    console.log(this.$listeners)
  }
}
</script>
```

![](https://sanyuanda.oss-cn-hangzhou.aliyuncs.com/imgs/DDEEDE7C-392C-45d9-915F-986C0A755002.png)

>我们也同样可以在 `child-com-2` 组件看到，用 `props` 接收的属性和  `native` 修饰的事件是没有在 `this.$attrs` 和 `this.$listeners` 里面的

{% note info %}
我觉得 `$attrs` 和 `$listeners` 属性像两个收纳箱，一个负责收纳属性，一个负责收纳事件，都是以对象的形式来保存数据。
{% endnote %}

### provide / inject

{% note info %}
很多看官们肯定对这两个属性更加的陌生吧，让我们看来看看官方的解释。
{% endnote %}

> `provide` 和 `inject` 主要为高阶插件/组件库提供用例。并不推荐直接用于应用程序代码中。并且这对选项需要一起使用，以允许一个祖先组件向其所有子孙后代注入一个依赖，不论组件层次有多深，并在起上下游关系成立的时间里始终生效。

>我们可以在根组件定义一下 `provide`

```bash
// 父组件
<template>
  <div>
    <son></son>
  </div>
</template>

<script>
import Son from './components/com-4/Son'
export default {
  name: 'Corresponded',
  components: {
    Son
  },
  provide: {
    params1: 'javaScript',
    params2: 'html',
    params3: 'css',
    params4: 'vue'
  }
}
</script>
```

```bash
// 嵌套组件
<template>
  <div>{{ params1 }}</div>
</template>

<script>
export default {
  name: 'Son',
  inject: ['params1']
}
</script>
```

> 执行上面代码之后，我们就可以发现，只有我们在子组件使用 `jnject` 注入了父组件 `provide` 提供的属性，就可以直接在页面使用了，不管是嵌套多少级组件。我们都可以通过 `jnject` 去拿到我们想要的父组件 `provide` 提供属性值。

## 结语

>以上，就是我自己总结出来的一些组件之间的通信，除了以上这些还有其他办法可以进行组件通信，有兴趣的看官可以自行再去研究一下，我这里就不在多做阐述。本文章只是列出了自己觉得比较有用的组件通信方式。以上都是自己个人的总结，表达能力有限，书写过程如有错误欢迎指正，也请点赞评论鼓励.