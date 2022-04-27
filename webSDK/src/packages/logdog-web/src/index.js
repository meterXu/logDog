import Logan from './sdk/index';
import LogWorker from './log.worker';
window.logdogList = window.logdogList||[]
function checkParams(globalConfig) {
    if (!globalConfig.appId) {
        console.error('appId未配置')
        return false
    }
    if (!globalConfig.appName) {
        console.warn('appName未配置')
        return false
    }
    return true
}

export const runTask = function (id, interval) {
    let logWorker = new LogWorker()
    logWorker.postMessage({command: 'exec', id, interval})
    logWorker.onmessage = (e) => {
        switch (e.data.command) {
            case 'report': {
                let logdogModel = logdogList.find(c => c.id === id)
                if (logdogModel) {
                    logdogModel.logdog.report()
                }
            }
                break;
            default:
                break;
        }
    }
}

function validateInit(config) {
    if (logdogList.find(c => c.id === config.appId) && config.enable) {
        return true
    } else {
        return false
    }
}

function timeFormat2Day(date) {
    let Y = date.getFullYear();
    let M = date.getMonth() + 1;
    let D = date.getDate();
    return (
        Y +
        '-' +
        (M < 10 ? '0' + M : M) +
        '-' +
        (D < 10 ? '0' + D : D)
    );
}

function generateDates(days) {
    let now = new Date();
    let sevenDaysAgo = new Date(+now - (days - 1) * 24 * 3600 * 1000);
    return {
        fromDayString: timeFormat2Day(sevenDaysAgo),
        toDayString: timeFormat2Day(now)
    }
}

export function replacer(key, value) {
    if (value instanceof Object && Object.keys(value).length === 0) {
        return undefined;
    } else if (value instanceof Array && value.length === 0) {
        return undefined
    } else if (!value) {
        return undefined
    } else {
        return value;
    }
}

export function axiosRequest(LogDog, config) {
    if (!config) {
        config = {}
    }
    let content = {
        url: `${config.baseURL ?? ''}${config.url}`,
        method: config.method,
        params: config.params,
        headers: config.headers,
        data: config.data,
        timeout: config.timeout
    }
    LogDog.log(JSON.stringify(content, replacer), 'network')
}

export function axiosError(LogDog, err) {
    if (!err) {
        err = {
            config: {}
        }
    } else if (!err.config) {
        err.config = {}
    }
    let content = {
        message: err.message,
        stack: err.stack,
        config: {
            url: `${err.config.baseURL ?? ''}${err.config.url}`,
            method: err.config.method,
            params: err.config.params,
            headers: err.config.headers,
            data: err.config.data,
            timeout: err.config.timeout
        }
    }
    LogDog.log(JSON.stringify(content, replacer), 'exception')
}

function LogDog(config) {
    this.logan = null
    this.globalConfig = {
        enable: true,
        console: false,
        reportUrl: '',
        objType:1,
        publicKey:
            '-----BEGIN PUBLIC KEY-----\n' +
            'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgG2m5VVtZ4mHml3FB9foDRpDW7Pw\n' +
            'Foa+1eYN777rNmIdnmezQqHWIRVcnTRVjrgGt2ndP2cYT7MgmWpvr8IjgN0PZ6ng\n' +
            'MmKYGpapMqkxsnS/6Q8UZO4PQNlnsK2hSPoIDeJcHxDvo6Nelg+mRHEpD6K+1FIq\n' +
            'zvdwVPCcgK7UbZElAgMBAAE=\n' +
            '-----END PUBLIC KEY-----',
        frameConfig: {
            global: true,
            error: true,
            pageview: true,
            userview: true,
            network: true
        }
    }
    this.reportConfig = {
        deviceId: null,
        days: 1,
        interval: 3600,
        fromDayString: null,
        toDayString: null,
        webSource: () => {
            return 'browser'
        },
        environment: () => {
            return navigator.userAgent
        },
        customInfo: null,
        incrementalReport: true
    }
    this.initConfig = function (config) {
        if (checkParams(config)) {
            this.globalConfig = Object.assign(this.globalConfig, config)
            this.globalConfig.dbName = this.globalConfig.dbName || 'logdog-db-' + this.globalConfig.appId
            this.reportConfig = Object.assign(this.reportConfig, config.reportConfig)
            this.reportConfig.deviceId = this.globalConfig.appId
            this.reportConfig.appName = this.globalConfig.appName
            this.reportConfig.objType = this.globalConfig.objType
            if (!this.reportConfig.fromDayString && !this.reportConfig.toDayString && this.reportConfig.days) {
                let dates = generateDates(this.reportConfig.days)
                this.reportConfig = Object.assign(this.reportConfig, dates)
            }
            this.globalConfig.reportConfig = this.reportConfig
            if(!this.logan){
                this.logan = new Logan()
            }
            this.logan.initConfig(this.globalConfig)
            this.bindFrame(this.globalConfig.appId, this.globalConfig.frameConfig)
            let logdogModel = logdogList.find(c => c.id === this.globalConfig.appId)
            if (!logdogModel) {
                logdogModel = {
                    id: this.globalConfig.appId,
                    logdog: this,
                    task: false
                }
                logdogList.push(logdogModel)
            }
            if(!logdogModel.task){
                logdogModel.task = true
                runTask(this.globalConfig.appId, this.globalConfig.reportConfig.interval)
            }
        }
    }
    this.report = function () {
        let that = this
        return new Promise((resolve, reject) => {
            if (validateInit(that.globalConfig)) {
                that.logan.report(that.reportConfig).then(res => {
                    if (that.globalConfig.console) {
                        console.log(res)
                    }
                    resolve(res)
                }).catch(ex => {
                    if (that.globalConfig.console) {
                        console.error(ex)
                    }
                    reject(ex)
                })
            } else {
                resolve(null)
            }
        })
    }
    this.log = function (content, type) {
        if (validateInit(this.globalConfig)) {
            this.logan.log(content, type)
            if (this.globalConfig.console) {
                console.log({content, type})
            }
        }
    }
    this.logWithEncryption = function (content, type) {
        if (validateInit(this.globalConfig)) {
            this.logan.logWithEncryption(content, type)
            if (this.globalConfig.console) {
                console.log({content, type})
            }
        }
    }
    this.info = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.log(content, 'info')
            if (this.globalConfig.console) {
                console.log({content, type: 'info'})
            }
        }
    }
    this.error = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.log(content, 'error')
            if (this.globalConfig.console) {
                console.log({content, type: 'error'})
            }
        }
    }
    this.warn = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.log(content, 'warn')
            if (this.globalConfig.console) {
                console.log({content, type: 'warn'})
            }
        }
    }
    this.debug = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.log(content, 'debug')
            if (this.globalConfig.console) {
                console.log({content, type: 'debug'})
            }
        }
    }
    this.infoWithEncryption = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.logWithEncryption(content, 'info')
            if (this.globalConfig.console) {
                console.log({content, type: 'info'})
            }
        }
    }
    this.errorWithEncryption = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.logWithEncryption(content, 'error')
            if (this.globalConfig.console) {
                console.log({content, type: 'error'})
            }
        }
    }
    this.warnWithEncryption = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.logWithEncryption(content, 'warn')
            if (this.globalConfig.console) {
                console.log({content, type: 'warn'})
            }
        }
    }
    this.debugWithEncryption = function (content) {
        if (validateInit(this.globalConfig)) {
            this.logan.logWithEncryption(content, 'debug')
            if (this.globalConfig.console) {
                console.log({content, type: 'debug'})
            }
        }
    }

    this.bindFrame = function (appId, frameConfig) {
        if (frameConfig.error) {
            this.frameError()
        }
        if (frameConfig.global) {
            this.frameGlobal()
        }
        if (frameConfig.pageview) {
            this.framePageview()
        }
        if (frameConfig.network) {
            this.frameNetwork()
        }
        if (frameConfig.userview) {
            this.frameUserview()
        }
    }
    this.frameGlobal = function () {

    }
    this.frameNetwork = function () {

    }
    this.frameError = function () {
    }
    this.framePageview = function () {

    }
    this.frameUserview = function () {

    }
    if (config) {
        let logdogModel = logdogList.find(c=>c.id===config.appId)
        if(logdogModel){
            logdogModel.logdog.initConfig(config)
            return logdogModel.logdog
        }else{
            this.initConfig(config)
        }
    }
}

export default LogDog
