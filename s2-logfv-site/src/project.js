const project_logfvSite = {
  namespace: "logfvSite",
  mainSys:true,
  index:20,
  variable: {
    development: {
      ssoApi: "<请配置>",
      baseApi: "http://192.168.253.128:9191/dpark-dataway-api/api",
      tokenKey:'X-Access-Token',
      accessTokenTime: 3600 * 1000,
      logfv:{
        enable:false,
        console:false,
        reportUrl:'http://58.210.9.133/iplatform/logfv-server/logfv/web/upload'
      }
    },
    production: {
      ssoApi: "<请配置>",
      baseApi: "BASE_API/dpark-dataway-api/api",
      tokenKey:'X-Access-Token',
      accessTokenTime: 3600 * 1000,
      logfv:{
        enable:false,
        console:false,
        reportUrl:'http://58.210.9.133/iplatform/logfv-server/logfv/web/upload'
      }
    },
    proxy:{
      ssoApi: "<请配置>",
      baseApi: "http://58.210.9.133/iplatform/dpark-dataway-api/api",
      tokenKey:'X-Access-Token',
      accessTokenTime: 3600 * 1000,
      logfv:{
        enable:false,
        console:false,
        reportUrl:'http://58.210.9.133/iplatform/logfv-server/logfv/web/upload'
      }
    }
  },
  redirect: {
    //放开即可覆盖默认登录页面 login: '/logfvSite/login',
    index: '/logfvSite/dashboard/index'
  },
  style: {
    theme: 'light',
    color: '#1890FF',
    layout: 'topmenu',
    multipage: false,
    colorWeak: false,
    fixedHeader: false,
    fixSiderbar: false,
    autoHideHeader: false,
  },
  config: {
    "logo": "./static/logfvSite/img/logo_sipsd.png",
    "darkLogo": "./static/logfvSite/img/logo_sipsd_white.png",
    "favicon": "./static/logfvSite/img/logo_sipsd_favicon.png",
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
        "show": true,
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
      "chrome": 65,
      "firefox": 53
    }
  }
}

if (!window.project) {
  window.project = {}
  window.project[project_logfvSite.namespace] = project_logfvSite
} else if (!window.project[project_logfvSite.namespace]) {
  window.project[project_logfvSite.namespace] = project_logfvSite
}


export default project_logfvSite
