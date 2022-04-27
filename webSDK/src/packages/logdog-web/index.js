import LogDog,{replacer,axiosRequest,axiosError} from './src/index'
if (typeof window !== 'undefined') {
    window.LogDog=LogDog
}
export {replacer,axiosRequest,axiosError}
export default LogDog
