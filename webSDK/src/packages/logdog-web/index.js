import LogFv,{replacer,axiosRequest,axiosError} from './src/index'
if (typeof window !== 'undefined') {
    window.LogFv=LogFv
}
export {replacer,axiosRequest,axiosError}
export default LogFv
