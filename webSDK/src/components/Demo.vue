<template>
  <div class="hello">
    <h1>Demo</h1>
    <div>
      <div class="demo-item">
        <textarea v-model="text" style="width: 300px;height: 60px"/>
      </div>
      <div class="demo-item btns">
        <button @click="info">info</button>
        <button @click="warn">warn</button>
        <button @click="debug">debug</button>
        <button @click="error">error</button>
        <button @click="log">log</button>
      </div>
      <div class="demo-item btns">
        <button @click="infoWithEncryption">infoWithEncryption</button>
        <button @click="warnWithEncryption">warnWithEncryption</button>
        <button @click="debugWithEncryption">debugWithEncryption</button>
        <button @click="errorWithEncryption">errorWithEncryption</button>
        <button @click="logWithEncryption">logWithEncryption</button>
      </div>
      <div class="demo-item btns">
        <button @click="autolog">autolog</button>
      </div>
      <div class="demo-item btns">
        <button @click="generateError">onerror</button>
      </div>
      <div class="demo-item btns">
        <button @click="getUserList">axios</button>
      </div>
      <div class="demo-item">
        <button @click="report">report</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Demo",
  data() {
    return {
      text: 'hello logdog'
    }
  },
  beforeRouteEnter(to,from,next){
    console.log('用户在组件内处理route')
    next()
  },
  methods: {
    info() {
      this.$logdog.info(this.text)
    },
    warn() {
      this.$logdog.warn(this.text)
    },
    debug() {
      this.$logdog.debug(this.text)
    },
    error() {
      this.$logdog.error(this.text)
    },
    log() {
      this.$logdog.log(this.text,'custom-type')
    },
    infoWithEncryption() {
      this.$logdog.infoWithEncryption(this.text)
    },
    warnWithEncryption() {
      this.$logdog.warnWithEncryption(this.text)
    },
    errorWithEncryption() {
      this.$logdog.errorWithEncryption(this.text)
    },
    debugWithEncryption() {
      this.$logdog.debugWithEncryption(this.text)
    },
    logWithEncryption() {
      this.$logdog.logWithEncryption(this.text,'custom-encryption-type')
    },
    autolog(){
      let itemNum = 2000;
      for (let i = 0; i < itemNum; i++) {
        let logString =`${this.text}:${i}`;
        this.$logdog.warn(logString);
      }
      console.log('记录成功')
    },
    generateError(){
      throw new Error('xxx')
    },
    getUserList(){
      this.axios.get('/v3/a921c736-284f-4ea3-a821-948c5affa971').then(c=>{
        console.log(c)
      }).catch(err=>{
        console.log(`用户抓取错误，${new Date()}`)
      })
    },
    async report() {
      try {
        let res = await this.$logdog.report()
        console.log(res)
      } catch (err) {
        console.error(err)
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
.demo-item{
  margin: 5px 0;
}
.btns button {
  margin: 0 2px;
}
</style>
