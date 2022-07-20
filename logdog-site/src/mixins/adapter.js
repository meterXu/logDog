import {webLogType,webLogTypeConfigs} from "./logtypes";
const customer = "other"
export const convertToMinimap = (data, type) => {
    let ret = [];
    let webLogTypes= [...webLogTypeConfigs]
    webLogTypes.pop()
    for (let d of data) {
        let logType = getDisplay(d.log_type)
        if(logType){
            ret.push({
                id: d.id,
                time: d.log_time,
                logType: {
                    type: logType.logType,
                    logTypeName: logType.logTypeName,
                    displayColor: logType.displayColor
                }
            })
            if(!webLogTypes.find(c=>c.logType===logType.logType)){
                webLogTypes.push(logType)
            }
        }
    }
    return {ret,webLogTypes};
};
export const getDisplay=function (type){
    if(Object.keys(webLogType).find(c=>c===type)){
        let ss =  webLogTypeConfigs.find(c => c.logType === type);
        if(ss){
            return Object.assign({},ss)
        }else{
            return null
        }
    }else if(webLogTypeConfigs.find(c=>c.logType==='other')){
        let ss= webLogTypeConfigs.find(c => c.logType === customer);
        ss = Object.assign({},ss)
        ss.logType=type
        ss.logTypeName=type
        return ss;
    }else{
        return null
    }
}
