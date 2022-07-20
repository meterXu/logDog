import LogDog,{replacer,axiosRequest,axiosError} from './src/index'
const install = function (Vue,config) {
    let logdog = new LogDog()
    logdog.frameError=function (){
        function _errDealWith(err, vm, info) {
            let content = {
                message:err.message,
                stack:err.stack,
                info:info
            }
            logdog.log(JSON.stringify(content,replacer),'exception')
        }
        if(Vue.config.errorHandler){
            const _userErrorHandler=Vue.config.errorHandler
            Vue.config.errorHandler = function (err, vm, info){
                _errDealWith(err, vm, info)
                _userErrorHandler(err, vm, info)
            }
        }else{
            Vue.config.errorHandler = function (err, vm, info){
                _errDealWith(err, vm, info)
                throw err
            }
        }
    }
    logdog.frameNetwork=function (){
        if(Vue.prototype.axios){
            Vue.prototype.axios.interceptors.request.use(config=>{
                axiosRequest(logdog,config)
                return config;
            },err=>{
                axiosError(logdog,err)
                return Promise.reject(err);
            })
            Vue.prototype.axios.interceptors.response.use((response)=>response,(err)=>{
                axiosError(logdog,err)
                return Promise.reject(err)
            })
        }
    }
    logdog.framePageview = function (){
        Vue.mixin({
            beforeRouteEnter(to,from,next){
                let content = {
                    to:{
                        fullPath:to.fullPath,
                        hash:to.hash,
                        meta:to.meta,
                        name:to.name,
                        params:to.params,
                        query:to.query
                    },
                    from:{
                        fullPath:from.fullPath,
                        hash:from.hash,
                        meta:from.meta,
                        name:from.name,
                        params:from.params,
                        query:from.query
                    },
                }
                logdog.log(JSON.stringify(content,replacer),'page')
                next()
            }
        })
    }
    logdog.initConfig(config)
    Vue.prototype.$logdog = logdog
}
if (typeof window !== 'undefined' && window.Vue) {
    install(window.Vue)
}
export {LogDog,replacer,axiosRequest,axiosError}
export default install
