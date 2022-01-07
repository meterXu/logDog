import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import vueAxios from 'vue-axios'
import router from './router'
Vue.config.productionTip = false
Vue.use(vueAxios,axios)
import vueLogFv from './packages/logfv-web-vue/index'

Vue.prototype.axios.interceptors.request.use(config=>{
  console.log(`用户处理request，${new Date()}`)
  return config;
},null)
Vue.prototype.axios.interceptors.response.use(response=>{
  console.log(`用户处理response，${new Date()}`)
  return response;
},null)

Vue.config.errorHandler=function (){
  console.error('用户处理error')
}

Vue.mixin({
  beforeRouteEnter(to,from,next){
    console.log('用户在全局处理route')
    next()
  }
})

axios.get("./config.json").then(res=>{
  Vue.prototype.$uploadUrl = res.data.uploadUrl
  Vue.use(vueLogFv,{
    reportUrl:'http://localhost:8080/logfv-server/logfv/web/upload',
    appId:"test",
    appName:'测试系统',
    console:false,
    enable:true
  })
  new Vue({
    router,
    render: h => h(App),
  }).$mount('#app')


})
