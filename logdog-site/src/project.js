const project_logdogSite = {
  namespace: "logdogSite",
  mainSys:true,
  index:20,
  variable: {
    development: {
      ssoApi: "<请配置>",
      baseApi: "http://192.168.253.128:9191/dataway-api/api",
      tokenKey:'X-Access-Token',
      accessTokenTime: 3600 * 1000,
      logdog:{
        enable:false,
        console:false,
        reportUrl:'http://192.168.253.128:9999/logdog-server/logdog/web/upload'
      }
    },
    production: {
      ssoApi: "<请配置>",
      baseApi: "BASE_API/dataway-api/api",
      tokenKey:'Authorization',
      accessTokenTime: 3600 * 1000,
      logdog:{
        enable:false,
        console:false,
        reportUrl:'http://58.210.9.133/iplatform/logdog-server/logdog/web/upload'
      }
    },
    proxy:{
      ssoApi: "<请配置>",
      baseApi: "http://58.210.9.133/iplatform/logdog-api/dataway-api/api",
      tokenKey:'X-Access-Token',
      accessTokenTime: 3600 * 1000,
      logdog:{
        enable:false,
        console:false,
        reportUrl:'http://localhost:8080/logdog-server/logdog/web/upload'
      }
    }
  },
  redirect: {
    //放开即可覆盖默认登录页面 login: '/logdogSite/login',
    index: '/logdogSite/dashboard/index'
  },
  style: {
    theme: 'dark-vue-admin',
    color: '#1890FF',
    layout: 'topmenu',
    multipage: true,
    colorWeak: false,
    fixedHeader: false,
    fixSiderbar: false,
    autoHideHeader: false,
  },
  config: {
    "logo": "./static/logdogSite/img/logo_sipsd_white.png",
    "darkLogo": "./static/logdogSite/img/logo_sipsd_white.png",
    "favicon": "./static/logdogSite/img/logo_sipsd_favicon.png",
    "title": "前端日志",
    "login": {
      "title": "前端日志",
      "desc": "用数据驱动产品优化！"
    },
    "head": {
      "title": {
        "desktop": "欢迎使用前端日志！",
        "mobile": ""
      },
      "searchMenu": {
        "show": true
      },
      "helper": {
        "show": false,
        "href": "http://192.168.126.25/iplatform/pldoc/",
        "target": "_blank"
      }
    },
    "sideMenu": {
      "title": "前端日志"
    },
    "footer": {
    },
    "plugins": {
      "changeSystem": {
        "enable": false
      }
    },
    "browserFilter": {
      "enable":false,
      "chrome": 65,
      "firefox": 53
    }
  }
}

if (!window.project) {
  window.project = {}
  window.project[project_logdogSite.namespace] = project_logdogSite
} else if (!window.project[project_logdogSite.namespace]) {
  window.project[project_logdogSite.namespace] = project_logdogSite
}


export default project_logdogSite
