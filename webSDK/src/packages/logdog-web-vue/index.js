import LogFv,{replacer,axiosRequest,axiosError} from './src/index'
const install = function (Vue,config) {
    let logfv = new LogFv()
    logfv.frameError=function (){
        function _errDealWith(err, vm, info) {
            let content = {
                message:err.message,
                stack:err.stack,
                info:info
            }
            logfv.log(JSON.stringify(content,replacer),'exception')
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
    logfv.frameNetwork=function (){
        if(Vue.prototype.axios){
            Vue.prototype.axios.interceptors.request.use(config=>{
                axiosRequest(logfv,config)
                return config;
            },err=>{
                axiosError(logfv,err)
                return Promise.reject(err);
            })
            Vue.prototype.axios.interceptors.response.use((response)=>response,(err)=>{
                axiosError(logfv,err)
                return Promise.reject(err)
            })
        }
    }
    logfv.framePageview = function (){
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
                logfv.log(JSON.stringify(content,replacer),'page')
                next()
            }
        })
    }
    logfv.initConfig(config)
    Vue.prototype.$logfv = logfv
}
if (typeof window !== 'undefined' && window.Vue) {
    install(window.Vue)
}
export {LogFv,replacer,axiosRequest,axiosError}
export default install
