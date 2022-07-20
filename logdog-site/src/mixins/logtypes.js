import _project from "../project";
import {portal} from '@dpark/s2-utils'
export const webLogType ={
    action:"action",
    page:"page",
    network:"network",
    exception:"exception",
    info:"info",
    warn:"warn",
    debug:"debug",
    error:"error"
}

let logtypes  = [
    {
        logType: webLogType.action,
        logTypeName: "操作日志",
        displayColor: "#5193ff",
        gradualColor: "#a6c6ff"
    },
    {
        logType: webLogType.page,
        logTypeName: "路由日志",
        displayColor: "#6dfbdf",
        gradualColor: "#a1ffeb"
    },
    {
        logType: webLogType.network,
        logTypeName: "请求日志",
        displayColor: "#b267f9",
        gradualColor: "#c198fd"
    },
    {
        logType: webLogType.exception,
        logTypeName: "错误日志",
        displayColor: "#fd6fab",
        gradualColor: "#ffa0c7"
    },
    {
        logType: webLogType.info,
        logTypeName: "info日志",
        displayColor: "#c4f86a",
        gradualColor: "#dbff9d"
    },
    {
        logType: webLogType.warn,
        logTypeName: "warn日志",
        displayColor: "#ffae62",
        gradualColor: "#ffc896"
    },
    {
        logType: webLogType.debug,
        logTypeName: "debug日志",
        displayColor: "#fb5eee",
        gradualColor: "#ff9ff8"
    },
    {
        logType: webLogType.error,
        logTypeName: "error日志",
        displayColor: "#fc7b6e",
        gradualColor: "#ffb4a9"
    },
    {
        logType: 'other',
        logTypeName: "其他日志",
        displayColor: "#5acffa",
        gradualColor: "#a6e5ff"
    },
];
let typesFilter = portal.getProject(_project).variable.typesFilter
if(typesFilter){
    logtypes = logtypes.filter(c=>typesFilter.indexOf(c.logType)>-1)
}
export const webLogTypeConfigs = logtypes

export function getNoValue(value,noValue){
    return value||noValue
}
export function getNoValueTooltip(value,noValue){
    return value===noValue?0:value
}

export function getNoValueColor(value,displayColor){
    let colors= ['#c2c2c2','#c9c9c9','#cdcdcd','#d4d4d4','#dfdfdf','#e3e3e3']
    let ri = Math.floor(Math.random()*5)+0
    if(value){
        return displayColor
    }else{
        return colors[ri]
    }
}
