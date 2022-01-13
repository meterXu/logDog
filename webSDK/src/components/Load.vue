<template>
  <div>
    <h1>页面加载成功</h1>
    <p>{{ objLength }}个日志对象，每{{ time }}秒各记录{{ actionCount }}次日志</p>
    <p>{{ objLength }}个日志上报线程，每{{ time }}秒并发上报日志。</p>
    <p>开始运行时间：{{ startTime && startTime.toLocaleString() }}</p>
    <p>结束运行时间：{{ endTime && endTime.toLocaleString() }}</p>
    <div class="mydiv">看我卡不卡</div>
    <div>
      <textarea v-model="context" style="width: 300px;height: 100px"/>
      <button @click="addCon">向文本框中追加内容</button>
    </div>
    日志对象个数: <input :disabled="objLengthDisable" type="number" v-model="objLength"><br/>
    日志记录频率：<input :disabled="objLengthDisable" type="number" v-model="time"><br/>
    日志上报频率：<input :disabled="objLengthDisable" type="number" v-model="interval">
    <button @click="yace" disabled="disabled">{{runText}}</button>
  </div>
</template>

<script>
import {LogFv} from '../packages/logfv-web-vue/index'

export default {
  name: "Test.vue",
  data() {
    return {
      runText: '未运行',
      logfvObjs: [],
      objLength: 1,
      intervalObj: null,
      time: 1,
      interval:3600,
      objLengthDisable: false,
      logActionArray: ['info', 'warn', 'debug', 'error'],
      actionCount: 1,
      startTime: null,
      endTime: null,
      context: null
    }
  },
  methods: {
    yace() {
      if (!this.intervalObj) {
        this.objLengthDisable = true
        this.initLogObj()
        this.startTime = new Date()
        this.runText = '运行中'
        this.timeoutExec();
      } else {
        this.logfvObjs = []
        this.objLengthDisable = false
        this.endTime = new Date()
        this.runText = '未运行'
        window.clearInterval(this.intervalObj)
        this.intervalObj = null
      }
    },
    timeoutExec(){
      this.execLog()
      window.clearTimeout(this.intervalObj)
      this.intervalObj=setTimeout(  ()=>{
        this.timeoutExec()
      },this.time*1000)
    },
    execLog(){
      for (let i = 0; i < this.logfvObjs.length; i++) {
        let as = this.getRandomArrayElements(this.logActionArray, this.actionCount)
        for (let j = 0; j < as.length; j++)
          switch (as[j]) {
            case 'info': {
              this.logfvObjs[i].info('info')
            }
              break;
            case 'warn': {
              this.logfvObjs[i].warn('warn')
            }
              break;
            case 'debug': {
              this.logfvObjs[i].debug('debug')
            }
              break;
            case 'error': {
              this.logfvObjs[i].error('error')
            }
              break;
          }
      }
    },
    addCon() {
      this.context += new Date().toLocaleString() + '\r\n'
    },
    getRandomArrayElements(arr, count) {
      let shuffled = arr.slice(0), i = arr.length, min = i - count, temp, index;
      while (i-- > min) {
        index = Math.floor((i + 1) * Math.random());
        temp = shuffled[index];
        shuffled[index] = shuffled[i];
        shuffled[i] = temp;
      }
      return shuffled.slice(min);
    },
    initLogObj() {
      for (let i = 0; i < this.objLength; i++) {
        let lf = new LogFv({
          reportUrl: this.$uploadUrl,
          appId: `test${i + 1}`,
          appName: `测试系统${i+1}`,
          console: true,
          enable: true,
          reportConfig: {
            interval: this.interval
          }
        })
        this.logfvObjs.push(lf)
      }
    }
  },
  created() {
    this.objLength = this.$route.query.objLength||1
    this.time = this.$route.query.time||1
    this.interval = this.$route.query.interval||3600
    this.yace()
  }
}
</script>

<style scoped>
.mydiv {
  width: 100px;
  height: 100px;
  background: red;
  position: relative;
  animation: myfirst 5s linear 2s infinite alternate;
  /* Firefox: */
  -moz-animation: myfirst 5s linear 2s infinite alternate;
  /* Safari and Chrome: */
  -webkit-animation: myfirst 5s linear 2s infinite alternate;
  /* Opera: */
  -o-animation: myfirst 5s linear 2s infinite alternate;
}

@keyframes myfirst {
  0% {
    background: red;
    left: 0px;
    top: 0px;
  }
  25% {
    background: yellow;
    left: 200px;
    top: 0px;
  }
  50% {
    background: blue;
    left: 200px;
    top: 200px;
  }
  75% {
    background: green;
    left: 0px;
    top: 200px;
  }
  100% {
    background: red;
    left: 0px;
    top: 0px;
  }
}

@-moz-keyframes myfirst /* Firefox */
{
  0% {
    background: red;
    left: 0px;
    top: 0px;
  }
  25% {
    background: yellow;
    left: 200px;
    top: 0px;
  }
  50% {
    background: blue;
    left: 200px;
    top: 200px;
  }
  75% {
    background: green;
    left: 0px;
    top: 200px;
  }
  100% {
    background: red;
    left: 0px;
    top: 0px;
  }
}

@-webkit-keyframes myfirst /* Safari and Chrome */
{
  0% {
    background: red;
    left: 0px;
    top: 0px;
  }
  25% {
    background: yellow;
    left: 200px;
    top: 0px;
  }
  50% {
    background: blue;
    left: 200px;
    top: 200px;
  }
  75% {
    background: green;
    left: 0px;
    top: 200px;
  }
  100% {
    background: red;
    left: 0px;
    top: 0px;
  }
}

@-o-keyframes myfirst /* Opera */
{
  0% {
    background: red;
    left: 0px;
    top: 0px;
  }
  25% {
    background: yellow;
    left: 200px;
    top: 0px;
  }
  50% {
    background: blue;
    left: 200px;
    top: 200px;
  }
  75% {
    background: green;
    left: 0px;
    top: 200px;
  }
  100% {
    background: red;
    left: 0px;
    top: 0px;
  }
}
</style>
